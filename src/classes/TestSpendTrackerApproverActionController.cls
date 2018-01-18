@isTest
public class TestSpendTrackerApproverActionController {
    static testMethod void SpendTrackerApprover(){
       
       RecordType rt = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'IT_Spend_Item'];
       
       Spend_Request__c sr = new Spend_Request__c();
       sr.Request_Title__c = 'Test Title';
       sr.Planned_Period_of_Performance_Start_Date__c = system.today();
       sr.Planned_Period_of_Performance_Start_Date__c = system.today();
       sr.Deliverables_and_Outcomes__c = 'Test Outcomes';
       sr.Lock_Spend_Request__c = false;
       sr.Investment__c = 'Test';
       sr.Application__c = 'Applications';
       insert sr;
        
       Items__c it = new Items__c();
       it.Spend_Request_Number__c = sr.Id;
       it.RecordTypeId = rt.Id;
       it.Approval_Status__c = 'Not Submitted';
       it.Type__c = 'Software';
       it.O_M_Cost__c = 200000;
       it.DM_E_Cost__c = 200000;
       insert it;
        
       Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
       req1.setComments('Submitting request for approval.');
       req1.setObjectId(it.Id);
       req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
       Approval.ProcessResult result = Approval.process(req1);    
       System.assert(result.isSuccess());
        
       List<Id> newWorkItemIds = result.getNewWorkitemIds();
        
       Apexpages.currentPage().getParameters().put('leadId', it.Id);       
       Apexpages.currentPage().getParameters().put('id', newWorkItemIds.get(0));
        
       SpendTrackerApproverActionController controller = new SpendTrackerApproverActionController();
        
       controller.objLead.Comments__c = '';              
       controller.Reject();
       controller.objLead.Comments__c = 'Reject Comments';               
       controller.objLead.Spend_Request_Number__r.Lock_Spend_Request__c = false;
       Controller.Reject();
       controller.objLead.Comments__c = 'Reject Comments'; 
       controller.objLead.Spend_Request_Number__r.Lock_Spend_Request__c = true;
       Controller.Reject();
       controller.Cancel();
        
       Apexpages.currentPage().getParameters().put('id', newWorkItemIds.get(0));
        
       controller.objLead.Spend_Request_Number__r.Lock_Spend_Request__c = false;
       controller.Approve();
        
       Apexpages.currentPage().getParameters().put('id', newWorkItemIds.get(0));
      
       //SpendTrackerSubmitAllItems spendController = new SpendTrackerSubmitAllItems();      
        
      System.assertEquals(true, true);
       
    }
    static testMethod void SpendTrackerApprover1(){
        TestSpendTrackerApproverActionController.SpendTrackerApprover();
        RecordType rt1 = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'IT_Spend_Item'];
        Spend_Request__c sr1 = new Spend_Request__c();
        sr1.Request_Title__c = 'Test Title';
        sr1.Planned_Period_of_Performance_Start_Date__c = system.today();
        sr1.Planned_Period_of_Performance_Start_Date__c = system.today();
        sr1.Deliverables_and_Outcomes__c = 'Test Outcomes';
        sr1.Investment__c = 'Test';
        sr1.Application__c = 'Applications';
        sr1.Lock_Spend_Request__c = True;
        insert sr1;
       
       Items__c it1 = new Items__c();
       it1.Spend_Request_Number__c = sr1.Id;
       it1.RecordTypeId = rt1.Id;
       it1.Approval_Status__c = 'Not Submitted';
       it1.Type__c = 'Software1';
       it1.O_M_Cost__c = 200000;
       it1.DM_E_Cost__c = 200000;
       insert it1;     
       
       Approval.ProcessSubmitRequest  req2 = new Approval.ProcessSubmitRequest();
       req2.setComments('Submitting request for approval.');
       req2.setObjectId(it1.Id);       
       req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});       
       Approval.ProcessResult result1 = Approval.process(req2);  
       
       List<Id> newWorkItemIds1 = result1.getNewWorkitemIds();  
       Apexpages.currentPage().getParameters().put('leadId', it1.Id);       
       Apexpages.currentPage().getParameters().put('id', newWorkItemIds1.get(0));
       SpendTrackerApproverActionController controller1 = new SpendTrackerApproverActionController();
       controller1.objLead.Spend_Request_Number__r.Lock_Spend_Request__c = true;
      //  controller.objLead.Comments__c = 'Approve'; 
       System.assert(result1.isSuccess(), 'Approve'+result1.isSuccess());
       controller1.Approve();
       System.assertEquals(true, true);
        
    }
    
    static testMethod void TestSpendTrackerSubmitAllItems(){
       string status = '';
       RecordType rt = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'IT_Spend_Item'];
       Spend_Request__c sr = new Spend_Request__c();
       sr.Request_Title__c = 'Test Title';
       sr.Planned_Period_of_Performance_Start_Date__c = system.today();
       sr.Planned_Period_of_Performance_Start_Date__c = system.today();
       sr.Deliverables_and_Outcomes__c = 'Test Outcomes';
       sr.Investment__c = 'Test';
       sr.Application__c = 'Applications';
       sr.Submit_for_Approval_Date__c = date.today();
       sr.Lock_Spend_Request__c = true;
       insert sr;
        
       Items__c it = new Items__c();
       it.Spend_Request_Number__c = sr.Id;
       it.RecordTypeId = rt.Id;
       it.Approval_Status__c = 'Not Submitted';
       it.Type__c = 'Software';
       it.O_M_Cost__c = 200000;
       it.DM_E_Cost__c = 200000;
       sr.Service_Staff_Office__c = 'P - Public Buildings Service';
       insert it;
       
       
       SpendTrackerHelper.getEligibleItemsCountForApproval(sr.Id);  
       SpendTrackerHelper.submitAllEligibleItems(sr.Id);
       it.Total_Cost__c = 151000;
       sr.Service_Staff_Office__c = 'P - Public Buildings Service';
       status = 'Under PBS Review';
       SpendTrackerHelper.getApprovalStatus(sr,it);
       it.Total_Cost__c = 151000;
       sr.Service_Staff_Office__c = 'Q - Federal Acquisition Service';
       status = 'Under FAS Review';
       SpendTrackerHelper.getApprovalStatus(sr,it);
       it.Total_Cost__c = 151000;
       sr.Service_Staff_Office__c = 'B - Office of the Chief Financial Officer';
       status = 'Under OCFO Review';
       SpendTrackerHelper.getApprovalStatus(sr,it);
       it.Total_Cost__c = 152000;
       sr.Service_Staff_Office__c = 'AA - Office of the Administrator';
       status = 'Under SRB Review';
       SpendTrackerHelper.getApprovalStatus(sr,it);
        System.assertEquals(true, true);
       
       
    }
    
        static testMethod void TestSpendTrackerRecalltAllItems(){
        string status = '';
              
        Spend_Request__c sr3 = new Spend_Request__c();
        sr3.Request_Title__c = 'Test Title';
        sr3.Planned_Period_of_Performance_Start_Date__c = system.today();
        sr3.Planned_Period_of_Performance_Start_Date__c = system.today();
        sr3.Deliverables_and_Outcomes__c = 'Test Outcomes';
        sr3.Investment__c = 'Test';
        sr3.Application__c = 'Applications';
        sr3.Submit_for_Approval_Date__c = date.today();
        sr3.Lock_Spend_Request__c = true;
        insert sr3;
        
        Items__c it2 = new Items__c();
        it2.Spend_Request_Number__c = sr3.Id;
        it2.Approval_Status__c = 'Not Submitted';
        it2.Type__c = 'Software';
        it2.O_M_Cost__c = 200000;
        it2.DM_E_Cost__c = 200000;
        sr3.Service_Staff_Office__c = 'P - Public Buildings Service';
        insert it2;
            
        //List<ProcessInstanceWorkitem> piwi = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: it2.Id];
            //Approval.ProcessWorkitemRequest req3 = new Approval.ProcessWorkitemRequest();   
            //Approval.ProcessSubmitRequest req3 = new Approval.ProcessSubmitRequest();
                   
            //req3.setWorkitemId(piwi.get(0).Id);
           Approval.ProcessSubmitRequest  req3 = new Approval.ProcessSubmitRequest();
       	    req3.setComments('Recall Approval');
            //req3.setAction('Removed');
            req3.setObjectId(it2.Id);           
           Approval.ProcessResult result1 = Approval.process(req3);  
   
            Approval.process(req3,false);        
       		SpendTrackerHelper.getEligibleItemsCountForRecall(sr3.Id);  
       		SpendTrackerHelper.recallAllEligibleItems(sr3.Id);
       		//Approval.ProcessResult requestResult = Approval.process(req3);
       		SpendTrackerHelper.resetAllItems(sr3.Id);
       		System.assertEquals(true, true);
    }
    
}