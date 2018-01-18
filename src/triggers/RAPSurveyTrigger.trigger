trigger RAPSurveyTrigger on RAP_Survey__c (after insert, before Update) {
    List<RAP_Survey__Share> rsShrs = new List<RAP_Survey__Share>();                     
    List<EntitySubscription> entSubs = new List<EntitySubscription>();
    RAP_Survey__Share PCOShr;
    RAP_Survey__Share IOAShr;
    RAP_Survey__Share SIOAShr;    
    if (Trigger.isAfter && Trigger.isInsert)
    {
        
        for(RAP_Survey__c rsRecord:trigger.New)
        { 
          if(rsRecord.PCO_Name__c != null){
              PCOShr = new RAP_Survey__Share();
              PCOShr.ParentID = rsRecord.Id;
              PCOShr.UserOrGroupId = rsRecord.PCO_Name__c;
              PCOShr.AccessLevel= 'Edit';               
              PCOShr.RowCause = Schema.RAP_Survey__Share.RowCause.PCO_Name__c;
              rsShrs.add(PCOShr);
          }
          
          if(rsRecord.IOA_Name__c != null){
              IOAShr = new RAP_Survey__Share();
              IOAShr.ParentID = rsRecord.Id;
              IOAShr.UserOrGroupId = rsRecord.IOA_Name__c;
              IOAShr.AccessLevel= 'Read';               
              IOAShr.RowCause = Schema.RAP_Survey__Share.RowCause.IOA_Name__c;
              rsShrs.add(IOAShr);
              
          }
          
          if(rsRecord.SIOA_Name__c != null){
              SIOAShr = new RAP_Survey__Share();
              SIOAShr.ParentID = rsRecord.Id;
              SIOAShr.UserOrGroupId = rsRecord.SIOA_Name__c;
              SIOAShr.AccessLevel= 'Read';               
              SIOAShr.RowCause = Schema.RAP_Survey__Share.RowCause.SIOA_Name__c;
              rsShrs.add(SIOAShr);             
          }
         
        }
        if(rsShrs.size()>0)
           insert rsShrs; 
            
    }
    
}