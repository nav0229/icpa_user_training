public with sharing class RT_TechnologyRequestFormController{

    public user currentuser{get;set;}
    Public string MyRequestsURL{get;set;}
    Request_Tracker__c newReq = new Request_Tracker__c();
    ID recordTypID =Schema.SObjectType.Request_Tracker__c.getRecordTypeInfosByName().get('IT Standard Request').getRecordTypeId();
    public Request_Tracker__c reqTracker {
        get {
            if (reqTracker == null)
                reqTracker = new Request_Tracker__c();
            return reqTracker;
        }
        set; }
    public RT_TechnologyRequestFormController() {
        RequestsURL();
        currentuser=new user();
        currentuser=[Select Id,Name,Email from User where Id=:userinfo.getuserId()];
        reqTracker.OCIO_Requester__c = currentuser.id;
        
    }
    public void validateform(){
        if(reqTracker.TechnologyToolIdentified__c == 'Yes'){
            reqTracker.pilot_initiative__c = '';
            reqTracker.T_C__c = false;
            reqTracker.Technology_Tool_Name__c = '';
            reqTracker.Company_Name__c = '';
            reqTracker.Customer_Support_Email__c = '';
            reqTracker.VPAT__c = '';
            reqTracker.type_of_technology__c = '';
            reqTracker.Tech_other__c = '';
            reqTracker.CategoryOther__c = '';
            reqTracker.Category__c = '';
        
        }
    
    }
    public void RequestsURL(){
        String ProjectPrefix = Request_Tracker__c.SObjectType.getDescribe().getKeyPrefix();
        MyRequestsURL = '/'+ProjectPrefix+'/o';
    }
    public pagereference submit(){
        
        newReq.RecordTypeId =  recordTypID;
        newReq.SpokenWithGSAIT__c = reqTracker.SpokenWithGSAIT__c;
        if(reqTracker.SpokenWithGSAIT__c != 'Yes'){
            //reqTracker.Org_Email__c = '';
            //reqTracker.Org_Contact_Name__c = null;
            reqTracker.GSA_IT_Contact__c = null;
        }
        else{
            //newReq.Org_Contact_Name__c = reqTracker.Org_Contact_Name__c;
            newReq.GSA_IT_Contact__c = reqTracker.GSA_IT_Contact__c;
        }
        newReq.OCIO_Requester__c = reqTracker.OCIO_Requester__c;
        newReq.Input__c = 'Web';
        /*if(reqTracker.Org_Contact_Name__c!=null)
            newReq.Org_Email__c=[select email from User where id=:reqTracker.Org_Contact_Name__c].email;
        if(reqTracker.Requesting_For__c !=null)
            newReq.Requesting_For__c = reqTracker.Requesting_For__c; */
        if(reqTracker.RequestingFor__c !=null)
            newReq.RequestingFor__c = reqTracker.RequestingFor__c;
        newReq.BusinessJustification__c = reqTracker.BusinessJustification__c;
        if(reqTracker.TechnologyToolIdentified__c == 'Yes'){
            newReq.TechnologyToolIdentified__c = reqTracker.TechnologyToolIdentified__c;
            if(reqTracker.pilot_initiative__c == 'Yes'){
                newReq.pilot_initiative__c = reqTracker.pilot_initiative__c;
                newReq.T_C__c = reqTracker.T_C__c;
                newReq.VPAT__c = null;
            }
            else{
                newReq.pilot_initiative__c = reqTracker.pilot_initiative__c;
                newReq.T_C__c = false;
                newReq.VPAT__c = reqTracker.VPAT__c;
            }
            newReq.Technology_Tool_Name__c = reqTracker.Technology_Tool_Name__c;
            newReq.Company_Name__c = reqTracker.Company_Name__c;
            newReq.Customer_Support_Email__c = reqTracker.Customer_Support_Email__c;
            //newReq.VPAT__c = reqTracker.VPAT__c;
            newReq.type_of_technology__c = reqTracker.type_of_technology__c;
            if(reqTracker.type_of_technology__c == 'Other')
                newReq.Tech_other__c = reqTracker.Tech_other__c;
            else 
                newReq.Tech_other__c = '';
            newReq.Category__c = reqTracker.Category__c;
            if(reqTracker.Category__c == 'Other')
                newReq.CategoryOther__c = reqTracker.CategoryOther__c;
            else
                newReq.CategoryOther__c = '';

            //newReq.Cost__c = reqTracker.Cost__c;
        
        }
        else {
            newReq.TechnologyToolIdentified__c = reqTracker.TechnologyToolIdentified__c;
            newReq.pilot_initiative__c = '';
            newReq.T_C__c = false;
            newReq.Technology_Tool_Name__c = '';
            newReq.Company_Name__c = '';
            newReq.Customer_Support_Email__c = '';
            newReq.VPAT__c = '';
            newReq.type_of_technology__c = '';
            newReq.Tech_other__c = '';
            newReq.CategoryOther__c = '';
            newReq.Category__c = '';
        }
        system.debug('newReq is:'+newreq);
        try{
            insert newReq;
        }
        catch(DMLException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error inserting a new request.'+e));
        }
        if(newReq.Id != null){
            Request_Tracker__c insertedrec = [select id,name,OCIO_Requester__c from Request_Tracker__c  where id= :newReq.id];
            pagereference pr = new pagereference('/apex/TechReqForm_ThankYou');
            pr.getParameters().put('Recname', insertedrec.name);
            pr.getParameters().put('RequestId', insertedrec.id);
            pr.getParameters().put('Requester', insertedrec.OCIO_Requester__c);
            system.debug('pr: '+pr);
            return pr;
        }
        return null;
    }
}