/*
    UserToChatterMessage.cls
    Makes new users follow certain groups/documents, sends an email,
    and has 'chatty' post on their wall.
    -------------------------------------------------------------------
    Author                 Date       Version  Description
    -------------------------------------------------------------------
    Damien Phillippi       ??/??/2011  1.00    Creation
*/
public with sharing class UserToChatterMessage
{
    @future
    public static void followUser(Set<Id> userIds)
    {
        //Get the Id of Chatty
        Id chattyId = [SELECT Id FROM User WHERE (Alias = 'chatty' and communityNickName = 'chatty') LIMIT 1].Id;
        
        //default group related variables
        ////As per the case 00028422: Refactored the code. 
        //boolean isGroupChatterSupportExists = isUserDefaultGroupExists('Chatter Support and Training');
        Id howToChatterGroupId;
        Map<Id, Id> chatterGroupMap = new Map<Id, Id>();
        List<CollaborationGroupMember> members = new List<CollaborationGroupMember>();
        boolean isGroupChatterSupportExists = false;

        //Get the Ids of the Chatter Groups
        List<CollaborationGroup> howToChatterGroup = [SELECT Id FROM CollaborationGroup WHERE Name = 'Chatter Support and Training'];
        if(howToChatterGroup != null && !howToChatterGroup.isEmpty())
        {
            howToChatterGroupId = howToChatterGroup[0].Id;
            isGroupChatterSupportExists = true;
            //howToChatterGroupId = [SELECT Id FROM CollaborationGroup WHERE Name = 'Chatter Support and Training' LIMIT 1].Id;
            for (CollaborationGroupMember groupMember: [SELECT MemberID FROM CollaborationGroupMember WHERE MemberID IN: userIds AND CollaborationGroupId =: howToChatterGroupId])
            {
                chatterGroupMap.put(groupMember.MemberID, groupMember.Id);
            }
        }
        //Modified as per the case 00028422: Refactored the code. Commented as it is not used any where
        //Id oneGSAGroupId = [SELECT Id FROM CollaborationGroup WHERE Name = 'GSA Central' LIMIT 1].Id;
        
        //Get the Id of the document to follow
        //Id trainingDocFollow = [SELECT Id FROM ContentDocument WHERE Title = 'Chatter - Getting Started'].Id;
        
        //Id trainingDoc = [Select c.Title, c.IsLatest, c.Id From ContentVersion c WHERE Title = 'Chatter - Getting Started' and isLatest=true].id;

        //Set the message that the user will receive from Chatty
        //String messageBody = 'Welcome to GSA\'s Chatter! Please take a look at the training-lite document on how to use Chatter to help you work that I put together. Get started by updating your profile with a picture and your background information. Next, find colleagues to follow and stay informed on their posts and comments. Have questions or best practices? Share them in the “Chatter Support and Training” group. Have fun learning about all that Chatter can do! The link to the Training document is https://cs1.salesforce.com/069S0000000D1tX';
        
        // Pointing to DEV's Training Document
        // String messageBody = 'Welcome to Chatter! This tool allows you to find experts, collaborate on documents, get questions answered, and connect with employees across GSA. Now that you’re in, start by updating your profile, search for employees to follow and join groups to stay informed. As you have questions, check out our training materials to get up to speed quickly (https://cs1.salesforce.com/069S0000000D1tX)';

          // Pointing to UAT's Training Document. Uncomment the line # 33 below and comment line # 31 above, 36 below prior to UAT deployment.
         //String messageBody = 'Welcome to Chatter! This tool allows you to find experts, collaborate on documents, get questions answered, and connect with employees across GSA. Now that you’re in, start by updating your profile, search for employees to follow and join groups to stay informed. As you have questions, check out our training materials to get up to speed quickly (https://gsa--uat.cs1.my.salesforce.com/0693000000199lp)';
         
         // Pointing to Prod's Training Document. Uncomment the line # 36 below and comment line # 31, 33 above prior to Production deployment.
      //   String messageBody = 'Welcome to Chatter! This tool allows you to find experts, collaborate on documents, get questions answered, and connect with employees across GSA. Now that you’re in, start by updating your profile, search for employees to follow and join groups to stay informed. As you have questions, check out our training materials to get up to speed quickly (https://gsa.my.salesforce.com/0693000000199lp)';
        String messageBody = 'Welcome to Chatter! This tool allows you to get questions answered, work with your colleagues from anywhere, find information, and connect with employees from across GSA. Now that you’re in, start by updating your profile, search for employees to follow and join groups to stay informed. Please take a few minutes to review GSA’s Chatter Rules of the Road (https://gsa.my.salesforce.com/06930000001mIlV). We’ve put together some training videos to get you up and going in no time (https://insite.gsa.gov/portal/content/639370)! If you have questions, check out the Chatter Training and Support Group (https://gsa.my.salesforce.com/_ui/core/chatter/groups/GroupProfilePage?g=0F9300000000oPx).';

        
        List<EntitySubscription> subscribes = new List<EntitySubscription>();
        //List<FeedPost> feeds = new List<FeedPost>();
        List<FeedItem> feedItems = new List<FeedItem>();
        
        Id templateId = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'New_User_Email_Trigger'].Id;
        List<EmailUtility> emails = new List<EmailUtility>();
        
        List<EntitySubscription> entities;// = ;
        Map<Id, Id> chattyMap = new Map<Id, Id>();
        for (EntitySubscription entity: [SELECT SubscriberID FROM EntitySubscription WHERE isDeleted = false AND SubscriberID IN: userIds AND Parentid =: chattyId])
        {
            chattyMap.put(entity.subscriberId, entity.Id);
        }
        
        //Map<Id, Id> trainingDocMap = new Map<Id, Id>();
        //for (EntitySubscription entity: [SELECT SubscriberID FROM EntitySubscription WHERE isDeleted = false AND SubscriberID IN: userIds AND Parentid =: trainingDocFollow])
        //{
        //    trainingDocMap.put(entity.subscriberId, entity.Id);
        //}
        
        
        
        /*
         * Modified as per the case 00028422: Refactored the code. User is no longer added automatically to GSA Central Chatter 
         * Hence commenting this portion of the code
         * 
        Map<Id, Id> gsaGroupMap = new Map<Id, Id>();
        for (CollaborationGroupMember groupMember: [SELECT MemberID FROM CollaborationGroupMember WHERE MemberID IN: userIds AND CollaborationGroupId =: oneGSAGroupId])
        {
            chatterGroupMap.put(groupMember.MemberID, groupMember.Id);
        }
		*/
        
        Id orgWideId;
        for(OrgWideEmailAddress owa: [SELECT id, Address, DisplayName FROM OrgWideEmailAddress where DisplayName = 'Chatty'])
        {
            if(owa.Address.contains('chatty'))
                orgWideId = owa.id;
        }
        
        for (Id curr: userIds)
        {
            //Make the user follow 'Chatty' 
            if (chattyMap.get(curr) == null)
            {
                subscribes.add(new EntitySubscription(ParentId = chattyId, SubscriberId = curr));
                //subscribes.add(new EntitySubscription(ParentId = curr, SubscriberId = chattyId));
            }
            //if (trainingDocMap.get(curr) == null)
            //{
            //    //Make User auto follow document
            //    subscribes.add(new EntitySubscription(ParentId = trainingDocFollow, SubscriberId = curr));
            //}
            if(isGroupChatterSupportExists)
        	{
            	if (chatterGroupMap.get(curr) == null)
            	{
                	members.add(new CollaborationGroupMember(CollaborationGroupId = howToChatterGroupId, MemberId = curr));
            	}
            }
         //   if (gsaGroupMap.get(curr) == null)
         //   {
         //       members.add(new CollaborationGroupMember(CollaborationGroupId = oneGSAGroupId, MemberId = curr));
         //   }
            
            //Make 'Chatty' post a default message to their wall
            feedItems.add(new FeedItem(CreatedById = chattyId, ParentId = curr, type = 'TextPost', body = messageBody));
            //feedItems.add(new FeedItem(CreatedById = chattyId, ParentId = curr, type = 'ContentPost', body = messageBody, RelatedRecordId = trainingDoc));
            //feedItems.add(new FeedItem(CreatedById = chattyId, ParentId = curr, type='ContentPost', RelatedRecordId = trainingDoc));

            SingleEmailUtility util = new SingleEmailUtility();
            util.setTemplateId(templateId);
            util.setTargetObjectId(curr);
            util.setSaveAsActivity(false);
            util.setReplyTo('chatty@gsa.gov');
            //util.setSenderDisplayName('Chatty');
            util.setOrgWideEmailAddressId(orgWideId);
            emails.add(util);
        }
        
        System.debug('org wide id = ' + orgWideId);
        System.debug('User ids = ' + userIds);
        try
        {
            //insert the follows into the database.
            insert subscribes;
            //insert feeds;
            insert feedItems;
        
           //As per the case 00028422: Refactored the code.
        	if(isGroupChatterSupportExists)
        		insert members;
  
			EmailUtility.sendBulkMessages(emails);
        }catch (Exception e)
        {
            //EmailUtility.sendSingleMessage(new String[]{'dphillippi@acumensolutions.com', 'sdurairaj@acumensolutions.com'}, 'noreplay@salesforce.com', 'No Reply', 'Chatter Error', e.getMessage());
            System.debug('Following a Chatter Item failed: ' + e);
        }
    }
    /*
    public static boolean isUserDefaultGroupExists(String groupName)
    {
        boolean blnReturnValue = false;
        default_chatter_groups_for_user__c grpRecord = default_chatter_groups_for_user__c.getValues(groupName);
		if(grpRecord != null && grpRecord.Name.equals(groupName))
        {
			blnReturnValue = true;
        }
        return blnReturnValue;
    }
	*/
}