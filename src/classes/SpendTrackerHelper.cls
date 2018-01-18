global class SpendTrackerHelper{
  public static Id Professional_Services_Item_RecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Professional_Services_Item' AND SObjectType = 'Items__c'].Id;
  public static List<Id> workItemIds = new List<Id>();
    
    webservice static Integer getEligibleItemsCountForApproval(Id localId){
      List<Approval.ProcessSubmitRequest> requests =  getEligibleItemsForApproval(localId, false);
      system.debug('getEligibleItemsCount : ' + requests.size());
      return requests.size();
  }
   

    webservice static void submitAllEligibleItems(Id localId)
    { 
 
         List<Spend_Request__c> parentObj = [SELECT Id,Lock_Spend_Request__c,Submit_for_Approval_Date__c,Total_Planned_Cost__c FROM Spend_Request__c WHERE Id = :localId];
 
         List<Approval.ProcessSubmitRequest> requests =  getEligibleItemsForApproval(localId, true);
                      
             system.debug('Number of items to submit: ' + requests.size());   
                List<Approval.ProcessResult> requestResult = Approval.process(requests);
            if(!requestResult.isEmpty()) {
                workItemIds = requestResult.get(0).getNewWorkitemIds();
            }
                if (!requests.isEmpty()){
                    //To bypass locked checkbox validation rule
                    parentObj[0].Lock_Spend_Request__c = false;
                    parentObj[0].Submit_for_Approval_Date__c = date.Today();
                    //Bypassing locked checkbox validation rule
                    update parentObj[0];
                    
                    //Lock the record back 
                    parentObj[0].Lock_Spend_Request__c = true;
                    update parentObj[0];
                }
    }
    
    //
    // Passing updateStatus = false will bypass programmatically updating the Item Status.
    //
    public static List<Approval.ProcessSubmitRequest> getEligibleItemsForApproval(Id localId, boolean updateStatus) {
         List<Spend_Request__c> parentList = [SELECT Id,Lock_Spend_Request__c,Submit_for_Approval_Date__c,Total_Planned_Cost__c,Service_Staff_Office__c FROM Spend_Request__c WHERE Id = :localId];
        Spend_Request__c parent = new Spend_Request__c();
        if(!parentList.isEmpty()) {
            parent = parentList.get(0);
        }
        List<Items__c> childObj = [SELECT Id,Approval_Status__c,Re_Submit_Denied_Items_for_Approval__c,Spend_Request_Number__r.Lock_Spend_Request__c,Spend_Request_Number__r.Submit_for_Approval_Date__c,Total_Cost__c,RecordTypeId FROM Items__c WHERE Spend_Request_Number__c= :localId];
        System.debug('This is child Object values' + childObj);
        List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest> ();
        List<Items__c> eligibleItems = new List<Items__c>();
        System.debug('Total_Planned_Cost__c : ' + parent.Total_Planned_Cost__c );
        for(Items__c co : childObj){
           if((co.Approval_Status__c=='Not Submitted')|| (co.Approval_Status__c=='Denied'&& co.Re_Submit_Denied_Items_for_Approval__c ==True)){
               if(updateStatus && co.RecordTypeId == SpendTrackerHelper.Professional_Services_Item_RecordType
                    && parent.Total_Planned_Cost__c >= 150000 
                    ) {
                    co.Approval_Status__c = getApprovalStatus(parent, co);
               }
               eligibleItems.add(co);
           }
        
            if(updateStatus && co.RecordTypeId == SpendTrackerHelper.Professional_Services_Item_RecordType
                    && parent.Total_Planned_Cost__c >= 150000) {
                upsert(eligibleItems);
            }
        }
        
        for(Items__c co : eligibleItems){
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submitted for Approval');
                //req1.setObjectId(childObj[i].Id);
                req1.setObjectId(co.Id);
                requests.add(req1);
                
                    system.debug('Elegible IDs: ' + req1 );
          }
          return  requests;
    }
    
    public static String getApprovalStatus(Spend_Request__c parent, Items__c item){
        String status = '';
        System.debug('SSO : ' + parent.Service_Staff_Office__c);
        System.debug('Total_Cost__c : ' + item.Total_Cost__c);
        if(parent.Total_Planned_Cost__c >= 150000 
            && item.Total_Cost__c < 150000 
           && item.RecordTypeId == SpendTrackerHelper.Professional_Services_Item_RecordType) {
               status = 'Under SRB Review';
        }
        else if(item.Total_Cost__c >= 150000) {
            if(parent.Service_Staff_Office__c == 'P - Public Buildings Service') {
                status = 'Under PBS Review';
            }
            else if(parent.Service_Staff_Office__c == 'Q - Federal Acquisition Service') {
                status = 'Under FAS Review';
                
            } 
            else if(parent.Service_Staff_Office__c == 'B - Office of the Chief Financial Officer') {
                status = 'Under OCFO Review';
            }
            else {
                status = 'Under SRB Review';
            }
        }
        
        return status;
        
    }
    webservice static Integer getEligibleItemsCountForRecall(Id localId){
      List<Approval.ProcessWorkitemRequest> requests =  getEligibleItemsForRecall(localId, false);
      system.debug('getEligibleItemsCount : ' + requests.size());
      return requests.size();
  }

    
    webservice static void recallAllEligibleItems(Id localId)
    { 
        System.debug('==> ' + localId);
 
         List<Approval.ProcessWorkitemRequest > requests =  getEligibleItemsForRecall(localId, true);
             System.debug('==> requests ==> ' + requests);         
        if(!requests.isEmpty()) {
                List<Approval.ProcessResult> requestResult = Approval.process(requests);
        }
            resetAllItems(localId);
                
    }
    
    public static void resetAllItems(Id localId) {
        List<Items__c> cObj = New List<Items__c>();
        List<Items__c> childObj = [SELECT Id,Approval_Status__c,Re_Submit_Denied_Items_for_Approval__c,Spend_Request_Number__r.Lock_Spend_Request__c,Spend_Request_Number__r.Submit_for_Approval_Date__c,Total_Cost__c,RecordTypeId FROM Items__c WHERE Spend_Request_Number__c= :localId];
        for(Items__c co : childObj){
            co.Approval_Status__c = 'Not Submitted';
            cObj.add(co);
        }
        update cObj;
        List<Spend_Request__c> parentObj = [SELECT Id,Lock_Spend_Request__c,Submit_for_Approval_Date__c,Total_Planned_Cost__c FROM Spend_Request__c WHERE Id = :localId LIMIT 1];
        for (Spend_Request__c spendRequest : parentObj ){
            spendRequest.Lock_Spend_Request__c = false;
        }
        
           Update parentObj;
    }
    
    //
    // Passing updateStatus = false will bypass programmatically updating the Item Status.
    //
    public static List<Approval.ProcessWorkitemRequest> getEligibleItemsForRecall(Id localId, boolean updateStatus) {
         List<Spend_Request__c> parentList = [SELECT Id,Lock_Spend_Request__c,Submit_for_Approval_Date__c,Total_Planned_Cost__c, Service_Staff_Office__c FROM Spend_Request__c WHERE Id = :localId];
        Spend_Request__c parent = new Spend_Request__c();
        if(!parentList.isEmpty()) {
            parent = parentList.get(0);
        }
        List<Items__c> childObj = [SELECT Id,Approval_Status__c,Re_Submit_Denied_Items_for_Approval__c,Spend_Request_Number__r.Lock_Spend_Request__c,Spend_Request_Number__r.Submit_for_Approval_Date__c,Total_Cost__c,RecordTypeId FROM Items__c WHERE Spend_Request_Number__c= :localId];
        System.debug('This is child Object values' + childObj);
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest> ();
        List<Items__c> eligibleItemsForRecall = new List<Items__c>();
        for(Items__c co : childObj){
           if((co.Approval_Status__c=='Under SRB Review')|| (co.Approval_Status__c=='Under OCFO Review')||(co.Approval_Status__c=='Under FAS Review')||(co.Approval_Status__c=='Under PBS Review')){
               
               eligibleItemsForRecall.add(co);
           }
        
            }
        
        for(Items__c co : eligibleItemsForRecall){
        List<ProcessInstanceWorkitem> piwi = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: co.Id];
            Approval.ProcessWorkitemRequest req1 = new Approval.ProcessWorkitemRequest();   
            //Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            if(updateStatus){
            req1.setComments('Recall Approval');
            req1.setAction('Removed');        
            req1.setWorkitemId(piwi.get(0).Id);
   
            
                
             }  
                requests.add(req1);
                
                    system.debug('Elegible IDs: ' + req1 );
          }
          return  requests;
    }
    
  }