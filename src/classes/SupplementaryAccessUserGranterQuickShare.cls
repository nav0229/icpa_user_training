// called by Multiselect
public without sharing class SupplementaryAccessUserGranterQuickShare {

	public static void addShareForQuickShareUser(Id controlledDocument, Id originatingUser, Set<Id> usersThatShouldBeGrantedAccess, boolean isExecSecOrOwner){

		List<Supplementary_Access_User__c> oldSupplements;

		if(isExecSecOrOwner == true) {

			oldSupplements = [
						SELECT Id, Active__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Quick Share'
						AND User__c IN :usersThatShouldBeGrantedAccess
					];

		} else {

			oldSupplements = [
						SELECT Id, Active__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Quick Share'
						AND Originating_User__c = :originatingUser
						AND User__c IN :usersThatShouldBeGrantedAccess
					];

		}

		List<Supplementary_Access_User__c> supplementsToAdd = new List<Supplementary_Access_User__c>();

		for(Id user : usersThatShouldBeGrantedAccess) {

			boolean existed = false;

			for(Supplementary_Access_User__c supplement : oldSupplements){

				if(user == supplement.User__c) {
					
					existed = true;

				}

			}

			if(!existed){

				Supplementary_Access_User__c newSupplementaryAccessUser = new Supplementary_Access_User__c();
				newSupplementaryAccessUser.Active__c = true;
				newSupplementaryAccessUser.Controlled_Document__c = controlledDocument;
				newSupplementaryAccessUser.Origin__c = 'Quick Share';
				newSupplementaryAccessUser.Originating_User__c = originatingUser;
				newSupplementaryAccessUser.User__c = user;
				supplementsToAdd.add(newSupplementaryAccessUser);

			}

		}

		insert supplementsToAdd;

		giveAccessToChatterFiles(controlledDocument, supplementsToAdd);

		addCommonSupplementaryUsers(originatingUser, supplementsToAdd);

		addShareForQuickShareDelegateUser(controlledDocument, supplementsToAdd); //, supplementsToEnable); // giveAccessToChatterFiles is also called in here for the delegates

	}

	private static void addShareForQuickShareDelegateUser(Id controlledDocument, List<Supplementary_Access_User__c> newSupplements){
		
		Set<Id> originatingUserIds = new Set<Id>();
		for(Supplementary_Access_User__c supplement : newSupplements){
			originatingUserIds.add(supplement.User__c);
		}
		Map<Id, User> originatingUsersToDelegate = new Map<Id, User>([
													SELECT Id, DelegatedApproverId
													FROM User
													WHERE Id = :originatingUserIds
												]);

		List<Id> delegateIds = new List<Id>();
		for(Id originatingUser : originatingUsersToDelegate.keySet()){
			delegateIds.add(originatingUsersToDelegate.get(originatingUser).DelegatedApproverId);
		}

		List<Supplementary_Access_User__c> oldSupplements = [
													SELECT Id, Active__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c
													FROM Supplementary_Access_User__c
													WHERE Controlled_Document__c = :controlledDocument
													AND Origin__c = 'Delegate'
													AND Originating_User__c = :originatingUserIds
													AND User__c IN :delegateIds
												];

		List<Supplementary_Access_User__c> supplementsToAdd = new List<Supplementary_Access_User__c>();

			for(Id originatingUserId : originatingUserIds){

				User originatingUser = originatingUsersToDelegate.get(originatingUserId);
				if(originatingUser == null) continue;
				Id delegateId = originatingUser.DelegatedApproverId;
				if(delegateId == null) continue;

				Supplementary_Access_User__c newSupplementaryAccessUser = new Supplementary_Access_User__c();
				newSupplementaryAccessUser.Active__c = true;
				newSupplementaryAccessUser.Controlled_Document__c = controlledDocument;
				newSupplementaryAccessUser.Origin__c = 'Delegate';
				newSupplementaryAccessUser.Originating_User__c = originatingUserId;
				newSupplementaryAccessUser.User__c = delegateId;
				supplementsToAdd.add(newSupplementaryAccessUser);

			}

		insert supplementsToAdd;

		giveAccessToChatterFiles(controlledDocument, supplementsToAdd);

	}

	private static void addCommonSupplementaryUsers(Id originatingUser, List<Supplementary_Access_User__c> supplementsToAdd){
		
		List<Id> usersToAddAsCommonSupplementaryUsers = new List<Id>();

		if(!supplementsToAdd.isEmpty()) {
			for(Supplementary_Access_User__c supplement : supplementsToAdd){

				usersToAddAsCommonSupplementaryUsers.add(supplement.User__c);

			}

		}

		List<Common_Supplementary_User__c> existingCommonSupplements = [
																	SELECT Id, Group_Member__c, CreatedById, Frequency__c 
																	FROM Common_Supplementary_User__c
																	WHERE Group_Member__c IN :usersToAddAsCommonSupplementaryUsers
																	AND CreatedById = :originatingUser
																];

		List<Common_Supplementary_User__c> commonSupplementsToUpdate = new List<Common_Supplementary_User__c>();
		List<Common_Supplementary_User__c> commonSupplementsToAdd = new List<Common_Supplementary_User__c>();
		for(Id user : usersToAddAsCommonSupplementaryUsers){

			boolean existed = false;
			for(Common_Supplementary_User__c commonSupplement : existingCommonSupplements){

				if(user == commonSupplement.Group_Member__c) {

					existed = true;
					commonSupplement.Frequency__c++;
					commonSupplementsToUpdate.add(commonSupplement);

				}

			}
			if(existed) {


				continue; 

			}
			Common_Supplementary_User__c newCommonSupplement = new Common_Supplementary_User__c();
			newCommonSupplement.Group_Member__c = user;
			newCommonSupplement.Frequency__c = 1;
			commonSupplementsToAdd.add(newCommonSupplement);

		}

		update commonSupplementsToUpdate;
		insert commonSupplementsToAdd;

	}

	// we attempt to give access to Chatter files on the fly, but if this person doesn't have access to do so we add a batch item
	// in order for historical record keeping we are adding a batch item anyways
	private static void giveAccessToChatterFiles(Id controlledDocument, List<Supplementary_Access_User__c> supplementList){

		boolean hasCollaborator = grantAccessToChatterFiles(controlledDocument, supplementList);

		if(hasCollaborator) System.debug('~~~ This person has collaborator status! ~~~');
		else System.debug('~~~ BATCH IS REQUIRED ~~~');

		List<Controlled_Document_Feed__c> batchItemsToAdd = new List<Controlled_Document_Feed__c>();
		for(Supplementary_Access_User__c supplement : supplementList){

			Controlled_Document_Feed__c batchItem = new Controlled_Document_Feed__c();
			batchItem.Controlled_Document__c = controlledDocument;
			batchItem.Status__c = 'Pending';
			batchItem.User__c = supplement.User__c;
			batchItem.Quick_Share_Origin__c = true;
			batchItemsToAdd.add(batchItem);

		}
		insert batchItemsToAdd;

	}

	public static void disableShareForQuickShareUser(Id controlledDocument, Id originatingUser, Set<Id> usersThatShouldStillHaveAccess, boolean isExecSecOrOwner){

		List<Supplementary_Access_User__c> oldSupplements;

		if(isExecSecOrOwner) {

			oldSupplements = [
						SELECT Id, Active__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c, User__r.UserPreferencesDisableMessageEmail
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Quick Share'
						AND User__c NOT IN :usersThatShouldStillHaveAccess
					];

		} else {

			oldSupplements = [
						SELECT Id, Active__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c, User__r.UserPreferencesDisableMessageEmail
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Quick Share'
						AND Originating_User__c = :originatingUser
						AND User__c NOT IN :usersThatShouldStillHaveAccess
					];

		}

		List<Supplementary_Access_User__c> supplementsToDisable = new List<Supplementary_Access_User__c>();

		for(Supplementary_Access_User__c supplement : oldSupplements){

			supplement.Active__c = false;
			supplement.Inactivated_By__c = UserInfo.getUserId();
			supplement.Inactivation_Date__c = System.now();
			supplementsToDisable.add(supplement);
		
		}

		update supplementsToDisable;

		disableShareForQuickShareDelegateUser(controlledDocument, originatingUser, supplementsToDisable, isExecSecOrOwner); // only need originatingUser to show who disabled the delegate quick shares

		ControlledDocumentAccessDeterminer.syncAccessToChatterFiles(supplementsToDisable);

	}

	private static void disableShareForQuickShareDelegateUser(Id controlledDocument, Id originatingUser, List<Supplementary_Access_User__c> disabledSupplements, boolean isExecSecOrOwner){

		Set<Id> originatingUserIds = new Set<Id>();
		for(Supplementary_Access_User__c supplement : disabledSupplements){
			originatingUserIds.add(supplement.User__c);
		}

		Map<Id, User> originatingUsersToDelegate = new Map<Id, User>([
													SELECT Id, DelegatedApproverId
													FROM User
													WHERE Id = :originatingUserIds
												]);

		List<Id> delegateIds = new List<Id>();
		for(Id user : originatingUsersToDelegate.keySet()){
			delegateIds.add(originatingUsersToDelegate.get(user).DelegatedApproverId);
		}

		List<Supplementary_Access_User__c> oldSupplements;

		if(isExecSecOrOwner) {

			oldSupplements = [
						SELECT Id, Active__c, Approval_Step__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c, User__r.UserPreferencesDisableMessageEmail
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Approval_Step__c = null
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Delegate'
						AND User__c IN :delegateIds
					];
		} else {

			oldSupplements = [
						SELECT Id, Active__c, Approval_Step__c, Controlled_Document__c, Inactivated_By__c, Inactivation_Date__c, Origin__c, Originating_User__c, User__c, User__r.UserPreferencesDisableMessageEmail
						FROM Supplementary_Access_User__c
						WHERE Active__c = true
						AND Approval_Step__c = null
						AND Controlled_Document__c = :controlledDocument
						AND Origin__c = 'Delegate'
						AND Originating_User__c IN :originatingUserIds
						AND User__c IN :delegateIds
					];

		}

		List<Supplementary_Access_User__c> supplementsToDisable = new List<Supplementary_Access_User__c>();

		for(Supplementary_Access_User__c old : oldSupplements){

			Id originatingUserIdOld = old.Originating_User__c;
			Id userOld = old.User__c;
			
			for(Supplementary_Access_User__c disabled : disabledSupplements) {

				Id originatingUserIdDisabled = disabled.User__c; // the originating user of the delegate supplements is the user in the parent supplements
				Id userDisabled = originatingUsersToDelegate.get(originatingUserIdDisabled).DelegatedApproverId;

				if(userOld == userDisabled && originatingUserIdOld == originatingUserIdDisabled){

					old.Active__c = false;
					old.Inactivated_By__c = originatingUser;
					old.Inactivation_Date__c = System.now();
					supplementsToDisable.add(old);

				}

			}

		}

		update supplementsToDisable;

	}

	public static boolean grantAccessToChatterFiles(Id controlledDocument, List<Supplementary_Access_User__c> supplementList){

		List<FeedItem> relevantFeedItems = getFeedItems(controlledDocument);

		Set<Id> contentVersionIdSet = new Set<Id>();
		for(FeedItem item : relevantFeedItems){
			contentVersionIdSet.add(item.RelatedRecordId);
		}

		Map<Id, ContentVersion> contentVersionMap = getContentVersionMap(contentVersionIdSet);

		boolean isCollaborator = checkCollaboratorStatus(relevantFeedItems, contentVersionMap);
		if(!isCollaborator) return false;

		Set<Id> contentDocumentIdList = new Set<Id>();
		for(ContentVersion contentVersion : contentVersionMap.values()){
			contentDocumentIdList.add(contentVersion.ContentDocumentId);
		}

		List<User> usersToDisableEmailsFor = new List<User>();
		List<ContentDocumentLink> contentDocumentLinksToAdd = new List<ContentDocumentLink>();
		for(Supplementary_Access_User__c supplement : supplementList){
			for(Id contentDocument : contentDocumentIdList){
				ContentDocumentLink newContentDocumentLink = new ContentDocumentLink();
				newContentDocumentLink.ShareType = 'C';
				newContentDocumentLink.LinkedEntityId = supplement.User__c;
				newContentDocumentLink.ContentDocumentId = contentDocument;

				////////////////// getting users to disable email for //////////////////
				User user = new User();
				user.Id = supplement.User__c;
				user.UserPreferencesDisableMessageEmail = supplement.User__r.UserPreferencesDisableMessageEmail;
				if(user.UserPreferencesDisableMessageEmail == false){
					user.UserPreferencesDisableMessageEmail = true;

					boolean found = false;
					for(User u : usersToDisableEmailsFor){
						if(u.Id == user.Id) found = true;
					}
					if(!found) usersToDisableEmailsFor.add(user);
				}
				////////////////////////////////////////////////////////////////////////

				contentDocumentLinksToAdd.add(newContentDocumentLink);
			}
		}

		// disable emails
		publicUserGroupHandler.disableGroupMemberRecalculation = true;
		Database.update(usersToDisableEmailsFor, false);

		// adding new links to Chatter files!
		Database.update(contentDocumentLinksToAdd, false); // an insert of duplicates fails on a regular insert, so rather than querying existing CDLs we can just do this

		// reenable emails
		for(User user : usersToDisableEmailsFor){
			user.UserPreferencesDisableMessageEmail = false;
		}
		Database.update(usersToDisableEmailsFor, false);

		return true;

	}

	private static boolean checkCollaboratorStatus(List<FeedItem> feedItems, Map<Id, ContentVersion> contentVersionMap){

		// this is a check to see 
		for(FeedItem item : feedItems){
			if(contentversionMap.get(item.RelatedRecordId) == null){
				return false;
			}
		}

		return true;

	}

	private static List<FeedItem> getFeedItems(Id controlledDocumentId){

		return [
			SELECT Id, Type, Title, RelatedRecordId, ParentId, LinkUrl, 
            // commented for case# 23872
            //Body, ContentData, 
            CreatedById, ContentType, ContentSize, ContentFileName, 
            // commented for case# 23872
            //ContentDescription, 
            CommentCount
			FROM FeedItem
			WHERE ParentId = :controlledDocumentId
			AND Type = 'ContentPost'
		];

	}

	private static Map<Id, ContentVersion> getContentVersionMap(Set<Id> contentVersionIdSet){

		return new Map<Id, ContentVersion>([
										SELECT Id, ContentDocumentId, ContentDocument.OwnerId, ContentDocument.Title 
										FROM ContentVersion 
										WHERE Id IN :contentVersionIdSet
									]);

	}

}