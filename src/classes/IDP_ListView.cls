public with sharing class IDP_ListView{
        public List<IDP__c> lstSupIDPs {get; set;}
        public List<IDP__c> lstOthIDPs {get; set;}
        public String userId = userInfo.getUserId();
        
    public IDP_ListView(){
        getIDPsBySupervisor();
        getIDPsByOtherViewer();
    }

    public List<IDP__c> getIDPsBySupervisor() {                       
             List<IDP__c> supervisorIDPs = new List<IDP__c>();
             lstSupIDPs = new List<IDP__c>();

             supervisorIDPs = [SELECT Id, Name, IDP_Names__c, IDP_Status__c, Create_Date__c, Fiscal_Year_pick__c, 
             Supervisor__c FROM IDP__c WHERE Supervisor__c = :userInfo.getUserId() Order By Create_Date__c DESC limit 999];                                   
            //system.debug('List of IDPs for Supervisor ' + lstSupIDPs);

            set<Id> existingApprovalsSet = new set<Id>();

            list<ProcessInstance> existingApprovals = [SELECT Id, TargetObjectId, Status
                                                        FROM ProcessInstance 
                                                        WHERE (Status = 'Pending' or Status = 'Approved') and 
                                                            TargetObjectId IN :supervisorIDPs];

            if(existingApprovals.size() != 0){
                            for(ProcessInstance e : existingApprovals){
                                existingApprovalsSet.add(e.TargetObjectId);
                            }
                        }

            for(IDP__c idp : supervisorIDPs){
                            if(existingApprovalsSet.contains(idp.Id)){
                                lstSupIDPs.add(idp);
                            }
                        }
            
            return lstSupIDPs;            
    }        
    public List<IDP__c> getIDPsByOtherViewer() {                       
             lstOthIDPs = [SELECT Id, Name, IDP_Names__c, IDP_Status__c, Create_Date__c, Fiscal_Year_pick__c, 
             Supervisor__c FROM IDP__c WHERE Supervisor__c != :userInfo.getUserId() Order By Create_Date__c DESC limit 999];                                              
            return lstOthIDPs;            
    }  
}