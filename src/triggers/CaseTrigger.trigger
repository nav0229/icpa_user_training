/*
    This Trigger 
    (1)automatically Assigns the Web-to-Case Cases to an owner, for FTRD cases
    (2)Pulls the App owner email address from selected Application and assign it 
       to AppOwnerEmail custom field. 
*/

trigger CaseTrigger on Case (before insert, before update) {
    System.debug('In the Trigger');
 if(Trigger.isInsert) {
  Id Account_RECORDTYPE = [SELECT Id FROM RecordType WHERE DeveloperName = 'Account' AND SObjectType = 'Account'].Id;
  Set<String> agencyNames = new Set<String>();
  for (Case curr: trigger.new)
  {
     if (curr.Agency__c != '' && curr.Agency__c != null && curr.Agency__c != 'Other')
     {
       agencyNames.add(curr.Agency__c);
     }
  }
  if(Trigger.isBefore && Trigger.isInsert){
     for (Case curr: trigger.new){
       curr.Status = 'Not Applicable';
     }
  }
   
   
  /*      if(Trigger.isAfter && Trigger.isInsert){
           for (Case curr: trigger.new){
          //Case CNum = [SELECT caseNumber from case WHERE Id =:c.Id LIMIT 1];
           system.debug('number>>>>>'+curr.CaseNumber);
           }
         }  */
     
     
    
  
  //Gets a list of accounts and put into a map according to their name.
  List<Account> accounts = [SELECT Id, Name, (SELECT Id, Email FROM Contacts where FTRD_Is_FTRD_Contact__c = true limit 1) FROM Account WHERE Name IN: agencyNames and FTRD_Is_FTRD_Account__c = true and recordtypeId = :Account_RECORDTYPE];
  //List<Account> accounts = [SELECT Id, Name, (SELECT Id, Email FROM Contacts) FROM Account WHERE Name IN: agencyNames and recordtypeId = :Account_RECORDTYPE limit 1];
  Map<String, Account> accMap = new Map<String, Account>();
  for (Account acc: accounts)
    accMap.put(acc.Name, acc);
  
  for (Case curr: trigger.new)
  {
    Account acc = accMap.get(curr.Agency__c);
    if (acc != null)
    {
      if (acc.Contacts.size() > 0)
      {
        curr.ContactId = acc.Contacts[0].Id;
      }
      curr.AccountId = acc.Id;
    }
  }
 } 
 //srini
 if(Trigger.isBefore && Trigger.isUpdate) {
        List<Case> newTriggerList = CaseTriggerHelper.getOcioTaskTrackingRecords(Trigger.newMap).values();
     	Map<Id,Case> oldTriggerMap = CaseTriggerHelper.getOcioTaskTrackingRecords(Trigger.oldMap);
     	CaseTriggerHelper.onBeforeUpdate(newTriggerList, oldTriggerMap);
     // smitha - Query the Case Number and Id to pass it to the confirmation page. Case #00021779. This is required only
     // when a case is created from the ASR form, not relevant for data load. 
  		List<Case> CNum = [SELECT Id, caseNumber from case WHERE Id in: Trigger.newMap.keySet() LIMIT 1];
     	if(!CNum.isEmpty()){
        	ApplicationRequestController.newCaseCreated = CNum.get(0);
        	system.debug('newCaseCreated>>>>>'+ApplicationRequestController.newCaseCreated.CaseNumber); 
     	}
        
    } 
    
  

}