public without sharing class ChatterFileCollaboratorTH {
    public static final String GRANT_UPDATE_ACCESS_EMAIL_SUBJECT = 'You have been granted access to a Controlled Document Record';

    public static void updateCollaborators(Map<id, Controlled_Document__c> oldDocMap, List<Controlled_Document__c> newDocs){

        if(getCollaborationTriggerControlStatus()){
            return;
        }

        //syncCollaborators(extractControlDocumentIds(filterRelevantControlledDocuments(oldDocMap, newDocs)));

        // Above line commented and below code is written to show only the error message which is meaningful to the user. - santosh guni
        // When the above line of code gets exception then message shown as below:
        // Error: Apex trigger ControlledDocumentTrigger caused an unexpected exception, contact your administrator: ControlledDocumentTrigger:
        // execution of AfterUpdate caused by: ChatterFileCollaboratorTH.ChatterFileShareException: You cannot perform this action because you do not have
        // proper permission to the related Chatter files. Press "Grant Access to Chatter Files" first.: Class.ChatterFileCollaboratorTH: line 178, column 1

        for( Controlled_Document__c doc : newDocs){
            if(doc.OwnerId != oldDocMap.get(doc.id).OwnerId){
                Set<Id> controlDocumentIds = new Set<Id>();
                controlDocumentIds.add(doc.Id);
                try{
                    syncCollaborators(controlDocumentIds);
                }
                catch(Exception ex){
                    doc.adderror(ex.getMessage());
                }
            }
        }

    }

    public static void createCollaborators(List<FeedItem> feedItems){
        if(getCollaborationTriggerControlStatus()){
            return;
        }

        List<FeedItem> relevantFeedItems = filterControlDocFiles(feedItems);
        Map<Id, List<ContentDocument>> objectIdToContentDocumentMap = getContentDocumentMap(relevantFeedItems);
        publicUserGroupHandler.disableGroupMemberRecalculation = true;
        createContentDocumentLinks(getCollaboratorMap(relevantFeedItems), objectIdToContentDocumentMap);
        createContentDocumentLinksForAdmin(relevantFeedItems, objectIdToContentDocumentMap);
    }

    public static void createCollaborators(List<Approval_Step__c> approvalSteps){ //For Insert/Undelete Aprroval Step Triggers
        if(getCollaborationTriggerControlStatus()){
            return;
        }

        syncCollaborators(extractControlDocumentIds(approvalSteps));
    }

    public static void updateCollaborators(Map<Id, Approval_Step__c> oldSteps, Map<Id, Approval_Step__c> newSteps){ //For Update Approval Step Trigger
        if(getCollaborationTriggerControlStatus()){
            return;
        }

        List<Approval_Step__c> changedApprovalSteps = new List<Approval_Step__c>();
        for(Approval_Step__c newStep : newSteps.values()){
            if(newStep.Assigned_Approver__c != oldSteps.get(newStep.id).Assigned_Approver__c){
                changedApprovalSteps.add(newStep);
            }
        }

        Set<Id> controlledDocumentIds = extractControlDocumentIds(changedApprovalSteps);

        syncCollaborators(controlledDocumentIds);
    }

    public static void syncCollaborators(Set<Id> controlDocumentIds){
        List<FeedItem> relevantFeedItems = getControlDocumentFeedItems(controlDocumentIds);
        Map<Id, List<ContentDocument>> objectIdToContentDocumentMap = getContentDocumentMap(relevantFeedItems);
        Map<Id, List<User>> objectIdToCollaboratorsMap = getCollaboratorMap(relevantFeedItems);
        Map<Id, Set<Id>> existingContentDocumentLinksMap = getExistingContentDocumentLinkMap(extractDocuments(objectIdToContentDocumentMap));

        createContentDocumentLinks(objectIdToCollaboratorsMap, objectIdToContentDocumentMap, existingContentDocumentLinksMap);
    }

    private static List<ContentDocument> extractDocuments(Map<Id, List<ContentDocument>> objectIdToContentDocumentMap){
        List<ContentDocument> relevantContentDocuments = new List<ContentDocument>();

        for(List<ContentDocument> documents : objectIdToContentDocumentMap.values()){
            relevantContentDocuments.addAll(documents);
        }

        return relevantContentDocuments;
    }

    public static Map<Id, Set<Id>> getExistingContentDocumentLinkMap(List<ContentDocument> relevantContentDocuments){
        Map<Id, Set<Id>> userToContactDocumentLinksMap = new Map<Id, Set<Id>>();

        for(ContentDocument document : getContentDocumentsWithLinks(relevantContentDocuments)){
            for(ContentDocumentLink link : document.ContentDocumentLinks){
                if(!userToContactDocumentLinksMap.containsKey(link.LinkedEntityId)){
                    userToContactDocumentLinksMap.put(link.LinkedEntityId, new  Set<Id>());
                }
                userToContactDocumentLinksMap.get(link.LinkedEntityId).add(link.contentDocumentId);
            }
        }

        return userToContactDocumentLinksMap;
    }

    public static void createContentDocumentLinks(Map<Id, List<User>> objectIdToCollaboratorsMap, Map<Id, List<ContentDocument>> objectIdToContentDocumentMap){
        createContentDocumentLinks(objectIdToCollaboratorsMap, objectIdToContentDocumentMap, new Map<Id, Set<Id>>());
    }

    public static void createContentDocumentLinks(Map<Id, List<User>> objectIdToCollaboratorsMap, Map<Id, List<ContentDocument>> objectIdToContentDocumentMap,  Map<Id, Set<Id>> existingContentDocumentLinksMap) {
        Set<ContentDocumentLink> newCollaborators = new Set<ContentDocumentLink>();
        List<User> usersToUpdate = new List<User>();
        Map<Id, List<String>> controlDocumentToRecipientMap = new Map<Id, List<String>>();

        for(Id controlDocKey : objectIdToContentDocumentMap.keySet()){
            for(ContentDocument contentDocument : objectIdToContentDocumentMap.get(controlDocKey)){
                for(User u : objectIdToCollaboratorsMap.get(controlDocKey)){
                    if(contentDocument.ownerId != u.Id && UserInfo.getUserId() != u.Id && u.isActive){
                        if(existingContentDocumentLinksMap.get(u.id) == null || !existingContentDocumentLinksMap.get(u.id).contains(contentDocument.id)){
                            newCollaborators.add(createContentDocumentLink(contentDocument.Id, u.Id));
                        }
                        if(u.UserPreferencesDisableMessageEmail == false) {
                            u.UserPreferencesDisableMessageEmail = true;
                            usersToUpdate.add(u);
                        }
                    }
                }
            }
        }

        publicUserGroupHandler.disableGroupMemberRecalculation = true;
        update usersToUpdate;

        List<ContentDocumentLink> newCollabList = new List<ContentDocumentLink>();
        newCollabList.addAll(newCollaborators);

        try{
            insert newCollabList;

            for(User u : usersToUpdate){
                u.UserPreferencesDisableMessageEmail = false;
            }
            update usersToUpdate;
        } catch (Exception e){
            if(e.getMessage().contains('INSUFFICIENT_ACCESS_OR_READONLY')){
                throw new ChatterFileShareException(ControlledDocumentConstants.CHATTER_FILE_SHARE_ERROR_MESSAGE);
            }
            throw new ChatterFileShareException(e.getMessage());
        }

    }

    public static void createContentDocumentLinksForAdmin(List<FeedItem> feedItems, Map<Id, List<ContentDocument>> objectIdToContentDocumentMap) {
        Map<Id, List<User>> objectIdToCollaboratorsMap = getCollaboratorMapForAdminUser(feedItems);
        Set<ContentDocumentLink> newCollaborators = new Set<ContentDocumentLink>();
        List<User> usersToUpdate = new List<User>();
        Map<Id, List<String>> controlDocumentToRecipientMap = new Map<Id, List<String>>();

        for(Id controlDocKey : objectIdToContentDocumentMap.keySet()){
            for(ContentDocument contentDocument : objectIdToContentDocumentMap.get(controlDocKey)){
                for(User u : objectIdToCollaboratorsMap.get(controlDocKey)){
                    if(contentDocument.ownerId != u.Id && UserInfo.getUserId() != u.Id && u.isActive){
                        newCollaborators.add(createContentDocumentLink(contentDocument.Id, u.Id));
                    }
                }
            }
        }

        List<ContentDocumentLink> newCollabList = new List<ContentDocumentLink>();
        newCollabList.addAll(newCollaborators);

        try{
            insert newCollabList;
        } catch (Exception e){
            if(e.getMessage().contains('INSUFFICIENT_ACCESS_OR_READONLY')){
                throw new ChatterFileShareException(ControlledDocumentConstants.CHATTER_FILE_SHARE_ERROR_MESSAGE);
            }
            throw new ChatterFileShareException(e.getMessage());
        }

    }

    private static Map<Id,List<ContentDocument>> getContentDocumentMap(List<FeedItem> feedItems){
        Map<Id,List<ContentDocument>> objectIdToContentDocumentMap = new Map<Id,List<ContentDocument>>();
        Map<Id,ContentVersion> contentVersionMap = new Map<Id,ContentVersion>();

        for(FeedItem item : feedItems){
            // Case# 24713 -added if condition for preventing batch stuck when the file was deleted without post deletion
            if(item.RelatedRecordId != null) {
                contentVersionMap.put(item.RelatedRecordId, null);
                objectIdToContentDocumentMap.put(item.ParentId, new List<ContentDocument>());
            }
        }

        contentVersionMap = getContentVersionMap(contentVersionMap.keySet());

        for(FeedItem item : feedItems){
            // Case# 24713 - added if condition for preventing batch stuck when the file was deleted without post deletion
            if(item.RelatedRecordId != null) {
            if(contentversionMap.get(item.RelatedRecordId) == null){
                throw new ChatterFileShareException(ControlledDocumentConstants.CHATTER_FILE_SHARE_ERROR_MESSAGE);
            }
            objectIdToContentDocumentMap.get(item.ParentId).add(contentVersionMap.get(item.RelatedRecordId).ContentDocument);
            }
        }

        return objectIdToContentDocumentMap;
    }

    private static Map<Id, List<User>> getCollaboratorMapForAdminUser(List<FeedItem> feedItems){
        Map<Id, List<User>> collaboratorMap = new Map<Id, List<User>>();
        Controlled_Document_Admin__c cda = Controlled_Document_Admin__c.getInstance('ADMINUSER');

        List<User> userList = [Select Id, isActive, username, Email, UserPreferencesDisableMessageEmail from user where username=:cda.UserName__c];
        for(FeedItem item : feedItems){
            collaboratorMap.put(item.ParentId, userList);
        }
        return collaboratorMap;
    }

    // this is where we get a map of controlled document ids to the list of users that should have access
    private static Map<Id, List<User>> getCollaboratorMap(List<FeedItem> feedItems){
        Map<Id, List<User>> collaboratorMap = new Map<Id, List<User>>();

        for(FeedItem item : feedItems){
            collaboratorMap.put(item.ParentId, new List<User>());
        }

        List<Controlled_Document__c> cdocList = getControlDocuments(collaboratorMap.keySet());
        List<Supplementary_Access_User__c> supplementaryUsers = getSupplementaryAccessUsers(collaboratorMap.keySet());

        for(Controlled_Document__c doc : cdocList){
            collaboratorMap.get(doc.id).add(new User(Id = doc.Owner.Id, isActive = doc.Owner.isActive, UserPreferencesDisableMessageEmail = true, Email = doc.Owner.Email));
            for(Approval_Step__c step : doc.Approval_Steps__r){
                if(step.Assigned_Approver__c != null){
                    collaboratorMap.get(doc.id).add(step.Assigned_Approver__r);
                }
            }
            for(Supplementary_Access_User__c supplement : supplementaryUsers){
                // TODO: make this more readable
                User u = new User();
                u.Id = supplement.User__c;
                u.isActive = supplement.User__r.isActive;
                u.UserPreferencesDisableMessageEmail = supplement.User__r.UserPreferencesDisableMessageEmail;
                u.Email = supplement.User__r.Email;

                boolean exists = false;
                for(User ui : collaboratorMap.get(doc.Id)){
                    if(ui.Id == u.Id) exists = true;                    
                }

                if(exists) continue;
                collaboratorMap.get(doc.id).add(u);
                // TODO: end
            }
        }

        for(FeedItem item : feedItems){ //Remove the owner of the file, if present
            for(Integer i = 0; i < collaboratorMap.get(item.ParentId).size(); i++){
                if(item.CreatedById == collaboratorMap.get(item.ParentId).get(i).Id){
                    collaboratorMap.get(item.ParentId).remove(i);
                    i--;
                }
            }
        }

        return collaboratorMap;
    }

    private static List<FeedItem> filterControlDocFiles(List<FeedItem> feedItems){
        List<FeedItem> filePosts = new List<FeedItem>();
        for(FeedItem item : feedItems){
            if(item.Type == 'ContentPost' && item.ParentId.getSObjectType().getDescribe().getName() == 'Controlled_Document__c'){
                filePosts.add(item);
            }
        }
        return filePosts;
    }

    private static Set<Id> extractControlDocumentIds(List<Approval_Step__c> approvalSteps){
        Set<Id> controlDocumentIds = new Set<Id>();
        for(Approval_Step__c step : approvalSteps){
            controlDocumentIds.add(step.Correspondence_Document__c);
        }
        return controlDocumentIds;
    }

    private static Boolean getCollaborationTriggerControlStatus(){ //Custon setting used to disable this trigger helper for Data Loads
        List<Collaboration_Trigger_Control__c> controls = Collaboration_Trigger_Control__c.getall().values();
        if(controls.size() == 1){
            return controls.get(0).Disable_Collaboration_Triggers__c;
        }
        return false;
    }

    private static ContentDocumentLink createContentDocumentLink(Id contentDocumentId, Id userId){
        return new ContentDocumentLink(ShareType = 'C', //C for Collaborator
                                       LinkedEntityId = userId,
                                       ContentDocumentId = contentDocumentId);
    }

    private static Map<Id,ContentVersion> getContentVersionMap(Set<Id> contentVersionIds){
        return new Map<Id,ContentVersion>([SELECT ContentDocument.OwnerId, ContentDocument.Title
                                           FROM   ContentVersion
                                           WHERE  Id IN: contentVersionIds]);
    }

    private static List<Controlled_Document__c> getControlDocuments(Set<Id> controlDocumentIds){
        // TODO: CLC ---- are we going to only include approval steps that are active?
        return [SELECT OwnerId, Owner.isActive, Owner.Email,
                       (SELECT Assigned_Approver__c, Assigned_Approver__r.isActive, Assigned_Approver__r.UserPreferencesDisableMessageEmail, Assigned_Approver__r.Email, Marked_for_Deletion__c
                        FROM   Approval_Steps__r WHERE Marked_for_Deletion__c = false)
                FROM   Controlled_Document__c
                WHERE  Id IN: controlDocumentIds];
    }

    private static List<Supplementary_Access_User__c> getSupplementaryAccessUsers(Set<Id> controlledDocumentIds){
        return [SELECT Id, Active__c, Controlled_Document__c, User__c, User__r.isActive, User__r.UserPreferencesDisableMessageEmail, User__r.Email
                FROM Supplementary_Access_User__c 
                WHERE Controlled_Document__c IN :controlledDocumentIds
                    AND Active__c = true
                    AND User__r.isActive = true];
    }

    private static List<FeedItem> getControlDocumentFeedItems(Set<Id> controlDocumentIds){
        return [SELECT RelatedRecordId, ParentId, CreatedById
                FROM   FeedItem
                WHERE ParentId IN: controlDocumentIds AND
                      Type = 'ContentPost'];
    }

    private static List<ContentDocument> getContentDocumentsWithLinks(List<ContentDocument> contentDocuments){
        return [SELECT (SELECT ShareType, LinkedEntityId, ContentDocumentId
                        FROM   ContentDocumentLinks)
                FROM    ContentDocument
                WHERE   id IN: contentDocuments];
    }

    private static List<ContentDocument> getContentDocumentsWithLinks(Set<Id> contentDocuments){
        return [SELECT (SELECT ShareType, LinkedEntityId, ContentDocumentId
                        FROM   ContentDocumentLinks)
                FROM    ContentDocument
                WHERE   id IN: contentDocuments];
    }

    public class ChatterFileShareException extends Exception{}

    public static void grantAccessToUser(List<FeedItem> feedItems, Id userId){
        List<FeedItem> relevantFeedItems = filterControlDocFiles(feedItems);
        Map<Id, List<ContentDocument>> objectIdToContentDocumentMap = getContentDocumentMap(relevantFeedItems);
        Map<Id, Set<Id>> existingContentDocumentLinksMap = getExistingContentDocumentLinkMap(extractDocuments(objectIdToContentDocumentMap));
        Map<Id, List<User>> objectIdToCollaboratorsMap = getCollaboratorMapForBatchUser(feedItems,userId);
        List<ContentDocumentLink> newCollaborators = new List<ContentDocumentLink>();
        List<User> usersToUpdate = new List<User>();
        Map<Id, List<User>> controlDocumentToRecipientMap = new Map<Id, List<User>>();

        for(Id controlDocKey : objectIdToContentDocumentMap.keySet()){
            for(ContentDocument contentDocument : objectIdToContentDocumentMap.get(controlDocKey)){
                for(User u : objectIdToCollaboratorsMap.get(controlDocKey)){
                    if(contentDocument.ownerId != u.Id && UserInfo.getUserId() != u.Id && u.isActive){
                        if(existingContentDocumentLinksMap.get(u.id) == null || !existingContentDocumentLinksMap.get(u.id).contains(contentDocument.id)){
                            newCollaborators.add(createContentDocumentLink(contentDocument.Id, u.Id));
                            if(u.UserPreferencesDisableMessageEmail == false) {
                                u.UserPreferencesDisableMessageEmail = true;
                                usersToUpdate.add(u);
                            }
                            if(!controlDocumentToRecipientMap.containsKey(controlDocKey)){
                                List<User> recipientList = new List<User>();
                                recipientList.add(u);
                                controlDocumentToRecipientMap.put(controlDocKey, recipientList);
                            } else {
                                controlDocumentToRecipientMap.get(controlDocKey).add(u);
                            }
                        }
                    }
                }
            }
        }

        publicUserGroupHandler.disableGroupMemberRecalculation = true;
        
        update usersToUpdate;

        try{
            insert newCollaborators;

            for(User u : usersToUpdate){
                u.UserPreferencesDisableMessageEmail = false;
            }

            update usersToUpdate;

            sendEmailToNewCollaborators(controlDocumentToRecipientMap);

            // adds an approval step for the user clicking the button
            //batchAddApprovalStep(feedItems, userId);
        } catch (Exception e){
            if(e.getMessage().contains('INSUFFICIENT_ACCESS_OR_READONLY')){ throw new ChatterFileShareException(ControlledDocumentConstants.CHATTER_FILE_SHARE_ERROR_MESSAGE);}
            throw new ChatterFileShareException(e.getMessage());
        }
    }

    private static Map<Id, List<User>> getCollaboratorMapForBatchUser(List<FeedItem> feedItems, Id userId){
        Map<Id, List<User>> collaboratorMap = new Map<Id, List<User>>();

        List<User> userList = [Select Id, Name, isActive, username, Email, UserPreferencesDisableMessageEmail from user where Id=:userId];
        for(FeedItem item : feedItems){
            collaboratorMap.put(item.ParentId, userList);
        }
        return collaboratorMap;
    }

    /*
        YOU DO NOT RECEIVE A NOTIFICATION VIA EMAIL NOR DO YOU SEE AN ENTRY IN THE LIST OF NOTIFICATIONS
        IF YOU DO NOT ACTUALLY RECEIVE ACCESS TO A FILE I.E. THERE ARE NO FILES, YOU ARE ALREADY A COLLABORATOR, ETC.
    */
    private static void sendEmailToNewCollaborators(Map<Id, List<User>> controlDocumentToRecipientMap) {
        System.debug('sendEmailToNewCollaborators-aaa');
        NotificationItemCreationHandler.createApprovalStepNotifications(controlDocumentToRecipientMap);
        List<String> recipients = new List<String>();
        String currentOrgUrl = URL.getSalesforceBaseUrl().toExternalForm();

        Set<Id> controlDocSet = controlDocumentToRecipientMap.keySet();

        Map<Id, Controlled_Document__c> cdocMap = new Map<Id, Controlled_Document__c>([SELECT Id, Title__c, Name FROM Controlled_Document__c WHERE Id IN :controlDocSet]);

        for(Id controlDocId : controlDocumentToRecipientMap.keySet()){
            System.debug('sendEmailToNewCollaborators-bbb');
            Controlled_Document__c cd = cdocMap.get(controlDocId);
            for(User recipient : controlDocumentToRecipientMap.get(controlDocId)){
                System.debug('sendEmailToNewCollaborators-ccc');
                if(recipient == null) continue;
                recipients.add(recipient.Email);
            }
            EmailUtility.sendSingleMessage(
                recipients,
                GRANT_UPDATE_ACCESS_EMAIL_SUBJECT,
                'You have been granted access to the Controlled Document Record, \''
                + cd.Name + '\'. Click here to access the Controlled Document Record: '
                + currentOrgUrl + '/' + cd.Id
            );
        }
    }

}