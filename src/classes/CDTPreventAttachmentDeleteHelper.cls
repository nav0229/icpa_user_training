/*-------------------------------------------------------------------------------------------------*
Helper Class for  CDTPreventAttachmentDeleteHelper
*--------------------------------------------------------------------------------------------------*
Author           | Date        | Version | Description
*--------------------------------------------------------------------------------------------------*
Ramesh Dugar       03/28/2017    1.0       Trigger Created for Case#29763
*--------------------------------------------------------------------------------------------------*/
public class CDTPreventAttachmentDeleteHelper {
    public static void preventDeletemethod(List<ContentDocument> contentDocs){
        //test 
        List<Controlled_Document__c> conDoc = [SELECT Id,Reason_File_Deletion__c FROM Controlled_Document__c];
    	 Map<Id,String> cdIdMap = new Map<Id, String>();
         Set<Id> cdId = new Set<Id>();
           
        for(Controlled_Document__c cd : conDoc){
             cdIdMap.put(cd.Id,cd.Reason_File_Deletion__c);
             cdId.add(cd.Id);
         }
        List<ContentDocumentLink> clink = [Select Id,ContentDocumentId,LinkedEntityId from ContentDocumentLink Where LinkedEntityId IN:cdID];
        set<Id> AttId = new Set<Id>();
        Map<ID,ID> CDMap = new Map<ID,ID>();
        for(ContentDocumentLink cd : clink){
            AttId.add(cd.ContentDocumentId);
           // contentDocumentReasonMap.put(cd.contentDocumentID,cdIdMap.get(cd.LinkedEntityId));
           CDMap.put(cd.contentDocumentID,cd.LinkedEntityId);
        }
        system.debug('**'+AttId);
        List<CDT_Deletion_Log__c> logList = new List<CDT_Deletion_Log__c>();
        String reasonForDeletion;
        ID controlDocumentID;
        Set<ID> controlDocumentIDset = new Set<ID>();
        for(ContentDocument c : contentDocs){
            if(AttId.contains(c.Id)){
                controlDocumentID = CDMap.get(c.ID);
                reasonForDeletion = cdIdMap.get(controlDocumentID);
                controlDocumentIDset.add(controlDocumentID);
                if(String.isBlank(reasonForDeletion))
                   c.addError('You cannot delete this attachment. Please Enter the reason for deletion.',FALSE);
                else {
                       CDT_Deletion_Log__c log = new CDT_Deletion_Log__c();
                    	log.Contolled_Document__c = controlDocumentID;
                    	log.File_Name__c= c.Title;
                    	log.DeletionDate__c = Date.Today();
                    	log.Reason__c = reasonForDeletion;
                    	log.User_Name__c = UserInfo.getName();
                    	logList.add(log);
                    	
                }
            	
            }
            
    	}
        Insert(logList);
		List<Controlled_Document__c> Cdlist = [Select ID,Reason_File_Deletion__c from Controlled_Document__c where id in :controlDocumentIDset];
        for(Controlled_Document__c record : cdlist){
            record.Reason_File_Deletion__c ='';
        }
        Update(Cdlist);
    }
}