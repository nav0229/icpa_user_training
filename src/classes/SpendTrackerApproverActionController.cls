public with sharing class SpendTrackerApproverActionController {

public String processId;
    public String leadId;
    public ProcessInstance objProcessInstance;
    public Items__c objLead {get; set;}
    public PageReference redirectPage;
    public SpendTrackerApproverActionController(){
    
        processId = ApexPages.currentPage().getParameters().get('id');
        leadId = ApexPages.currentPage().getParameters().get('leadId');
        objLead = [select Name,Comments__c,Approval_Status__c,Total_Cost__c,Spend_Request_Number__r.Lock_Spend_Request__c,Spend_Request_Number__r.Name,Spend_Request_Number__c  FROM Items__c where id =:leadId];
        objLead.Comments__c = '';
        redirectPage = new PageReference('/'+leadId);
        
    }
   
    public PageReference Approve(){
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        if(objLead.Spend_Request_Number__r.Lock_Spend_Request__c== True){
        req.setComments(objLead.Comments__c);
        req.setAction('Approve');
        req.setWorkitemId(processId);
        update objLead;
        Approval.ProcessResult result =  Approval.process(req);
        return redirectPage ;
        }else{
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The Spend Request must be locked before taking any action. Please check the Locked Spend Request checkbox before proceeding.'));
           
            return null;
        }
   }
    public PageReference Reject(){
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        System.debug('==> ' + objLead.Comments__c);
        if(objLead.Comments__c==null || objLead.Comments__c.trim() == ''){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter rejection comments.'));
          
        }else{
            if(objLead.Spend_Request_Number__r.Lock_Spend_Request__c== false){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The Spend Request must be locked before taking any action. Please check the Locked Spend Request checkbox before proceeding.'));
               
            }
            else {
                req.setComments(objLead.Comments__c);
                req.setAction('Reject');
                req.setWorkitemId(processId);
                update objLead;
                Approval.ProcessResult result =  Approval.process(req);
                return redirectPage ; 
            }
       }  
        return null;   
    }
   
     public PageReference Cancel(){
     return redirectPage ;
    }

   
}