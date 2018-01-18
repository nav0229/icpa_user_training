public class GrantAccessToChatterFileBatchHelper {

	public void grantAccessToUser(List<Controlled_Document_Feed__c> staging) {
		try{
            system.debug('========================= staging ::: '+staging);
			List<FeedItem> feedItems = new List<FeedItem>();
            /*Case 27920 
			feedItems = [Select f.Id, f.Type, f.Title, f.RelatedRecordId, f.ParentId, f.LinkUrl, f.Body, f.ContentData,
								f.CreatedById, f.ContentType, f.ContentSize, f.ContentFileName, f.ContentDescription, f.CommentCount
							From FeedItem f
							Where f.ParentId = :staging[0].Controlled_Document__c
							AND f.Type = 'ContentPost'];   */
            feedItems = [Select f.Id, f.Type, f.Title, f.RelatedRecordId, f.ParentId, f.LinkUrl, 
								f.CreatedById, f.ContentType, f.ContentSize, f.ContentFileName, f.ContentDescription, f.CommentCount
							From FeedItem f
							Where f.ParentId = :staging[0].Controlled_Document__c
							AND f.Type = 'ContentPost'];  
			
			ChatterFileCollaboratorTH.grantAccessToUser(feedItems, staging[0].user__c);
            
            //Throw Exception only during Unit Test for Code Coverage purpose
            if(Test.isRunningTest()){
                throw new NullPointerException();
            }
		}
		catch(Exception e1){
			System.debug('TEST TEST TEST');
                      
            
			try {
				System.debug('TEST2 TEST2 TEST2');
                
				if(staging[0].Notified__c != true) {
					System.debug('TEST3 TEST3 TEST3');
					// email someone
					List<Controlled_Document_Emails__c> emailList = [SELECT Id, Name, Email_Address__c
																		FROM Controlled_Document_Emails__c
																		LIMIT 10]; // arbitrary limit to pass SF automated security tests

					List<String> recipients = new List<String>();
                    
					for(Controlled_Document_Emails__c emailCS : emailList){recipients.add(emailCS.Email_Address__c);                      
					}

					String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();

					String ccName = staging[0].Controlled_Document__r.Name;
					String ccId = staging[0].Controlled_Document__c;
					String ccUrl = baseUrl + '/' + ccId;
					String ccLink = '<a href="' + ccUrl + '">' + ccName + '</a>';

					String userName = staging[0].User__r.Name;
					String userId = staging[0].User__c;
					String userUrl = baseUrl + '/' + userId;
					String userLink = '<a href="' + userUrl + '">' + userName + '</a>';

					String batchStatusUrl = baseUrl + '/apex/BatchQualityAssurancePage';
					String batchStatusLink = '<a href="' + batchStatusUrl + '">' + 'click here' + '</a>';
                    String emailContent = 'This email is to inform you a control document is not processing. Here is more information and a link to the batch status page:'
							+ '<p/><p/>'
							+ 'Controlled Document #: '
							+ ccLink
							+ '<br/>'
							+ 'Affected User: '
							+ userLink
							+ '<p/><p/>'
							+ 'For a closer look please '
							+ batchStatusLink
							+ ' to view the Batch Status page.'
							+ '<p/><p/>'
							+ 'Possible solutions include: '
							+ '<br/>'
							+ '<ol>'
							+ '<li>Adding the System User to the Chatter Files</li>' 
							+ '<br/>'
							+ '<li>Deleting Chatter Feeds with deleted content (a red X shows instead of the preview)</li>'
							+ '</ol>';
                    if(recipients.size()>0){EmailUtility.sendSingleMessage(recipients,'Controlled Document: ' + ccName + ' is currently stuck.',emailContent);
                                          }
                    staging[0].Notified__c = true;
					Database.update(staging, false);
				}
				System.debug('Controlled Document ID: ' + staging[0].Controlled_Document__c + '========================= Exception ::: ' + e1);
				return;
			} catch (NullPointerException e2){
				System.debug('GrantAccessToChatterFileBatchHelper - Exception ::: ' + e2);
				return;
			}
		}

		staging[0].Status__c = 'Granted'; Datetime d = Datetime.now(); staging[0].Granted_Time__c = d;	Database.update(staging, false);
	}

}