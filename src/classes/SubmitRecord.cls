global class SubmitRecord{
    webservice static String processDetails(string Id){
       
        RAP_Survey__c  ops = [Select Id,Survey_Status__c,Pre_trip_meeting__c,Interest_in_other_Opportunity__c,Why__c,Why_do_you__c,
                              IOA_Information_Seeking__c,Recommend_RAP__c,Experience_for_Job_Performance__c,Future_RAP_Opportunities__c,
                              Locations_and_Logistics__c,IOA_Role__c,Survey_Completed_Date__c,RecordTypeId, PCO_Name__c from RAP_Survey__c
                              where Id =:Id ];
        ops.Survey_Status__c = 'Completed';
        ops.Survey_Completed_Date__c = system.today();
        try{
            if(ops.Pre_trip_meeting__c != null && ops.Locations_and_Logistics__c != null && ops.IOA_Role__c != null && ops.Experience_for_Job_Performance__c != null 
               && ops.Future_RAP_Opportunities__c != null && ops.Recommend_RAP__c != null && ops.IOA_Information_Seeking__c != null && ops.Interest_in_other_Opportunity__c != null
               && ops.Why__c != null && ops.Why_do_you__c != null){
                update ops;
                            
                RAP_Survey__Share PCOShr = new RAP_Survey__Share();
                PCOShr.ParentID = ops.Id;
                PCOShr.UserOrGroupId = ops.PCO_Name__c;
                PCOShr.AccessLevel= 'Read';
                PCOShr.RowCause = Schema.RAP_Survey__Share.RowCause.PCO_Name__c;
                Database.SaveResult sr = Database.insert(PCOShr, false); 
            }else{
                return 'Please fill all the answers and submit';  
            }} catch(Exception e){ return e.getMessage();} 
        return 'yes';
    } 
}