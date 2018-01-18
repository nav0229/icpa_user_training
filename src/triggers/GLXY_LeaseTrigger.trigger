trigger GLXY_LeaseTrigger on Glxy_Lease__c (after update, after insert) {

    if(GLXY_Utility.hasUpdated() != true) {
        
        Map<Id,Glxy_AssociatedLeases__c> assocLease = 
            new Map<Id,Glxy_AssociatedLeases__c> ([
                SELECT Id, Lease__c, Project__c, Termination_Date__c, Project__r.Project_Type__c 
                FROM Glxy_AssociatedLeases__c 
                WHERE Lease__c IN :Trigger.newMap.keySet()
            ]);
        
        Glxy_OldIAAndNOAForProject.calculateOldIANOA(assocLease.keySet(), Trigger.isInsert, 'Lease', new Set<Id> ()); 
    
    }
    
if(Trigger.isAfter && Trigger.isUpdate)
{

 Set<string> modifiedLeaseObjs=new Set<string>(); 
    modifiedLeaseObjs.clear();
    Glxy_Lease__c oldLeaseObj=null;
    Map<string,Glxy_Lease__c> LeaseMap= new map<string,Glxy_Lease__c>();
    for (Glxy_Lease__c  lease: Trigger.new) 
    {
        oldLeaseObj=Trigger.oldMap.get(lease.id);
        if( oldLeaseObj.Total_IA_Sq_feet__c!=lease.Total_IA_Sq_feet__c || oldLeaseObj.Total_NOA_Sq_feet__c!=lease.Total_NOA_Sq_feet__c || oldLeaseObj.IAConverstionDate__c!=lease.IAConverstionDate__c)
        {
        LeaseMap.put(lease.id,lease);
         modifiedLeaseObjs.add(lease.id);
        }
    }
    List<Glxy_IntraBudgetActivityAuthorization__c> ibaaList=new list<Glxy_IntraBudgetActivityAuthorization__c>();
    List<Glxy_ConsumerPriceIndex__c> cpiList=new list<Glxy_ConsumerPriceIndex__c>();
    List<Glxy_LumpSum__c> lsList=new list<Glxy_LumpSum__c>();
    List<Glxy_ReimbursableWorkAuthorization__c> rwaList=new list<Glxy_ReimbursableWorkAuthorization__c>();
    List<Glxy_StepRent__c> srList=new list<Glxy_StepRent__c>();
    
   if(modifiedLeaseObjs.size()>0)
   {
        ibaaList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c,LeaseNumber__c  from Glxy_IntraBudgetActivityAuthorization__c where  LeaseNumber__c in :modifiedLeaseObjs]; 
        cpiList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c ,LeaseNumber__c from Glxy_ConsumerPriceIndex__c where  LeaseNumber__c in :modifiedLeaseObjs];
        lsList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c ,LeaseNumber__c from Glxy_LumpSum__c where  LeaseNumber__c in :modifiedLeaseObjs];
        rwaList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c,LeaseNumber__c  from Glxy_ReimbursableWorkAuthorization__c where  LeaseNumber__c in :modifiedLeaseObjs];
        srList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c,LeaseNumber__c  from Glxy_StepRent__c where  LeaseNumber__c in :modifiedLeaseObjs];
   }
   oldLeaseObj=null;
   
   if(ibaaList.size()>0)
   {
            for(Glxy_IntraBudgetActivityAuthorization__c auth:ibaaList)
            {
                   oldLeaseObj=LeaseMap.get(auth.LeaseNumber__c );
                   auth.IA_Sq_Ft__c= oldLeaseObj.Total_IA_Sq_feet__c ;
                   auth.NOA_Sq_Ft__c=oldLeaseObj.Total_NOA_Sq_feet__c;
            }   
        update ibaaList;
   }
   
   
   if(cpiList.size()>0)
   {
            for(Glxy_ConsumerPriceIndex__c auth:cpiList)
            {    
                  oldLeaseObj=LeaseMap.get(auth.LeaseNumber__c );
                  auth.IA_Sq_Ft__c= oldLeaseObj.Total_IA_Sq_feet__c ;
                  auth.NOA_Sq_Ft__c=oldLeaseObj.Total_NOA_Sq_feet__c;
            }   
        update cpiList;
   }
   
   
   if(lsList.size()>0)
   {
            for(Glxy_LumpSum__c auth:lsList)
            {                        
                    oldLeaseObj=LeaseMap.get(auth.LeaseNumber__c );
                    auth.IA_Sq_Ft__c= oldLeaseObj.Total_IA_Sq_feet__c ;
                    auth.NOA_Sq_Ft__c=oldLeaseObj.Total_NOA_Sq_feet__c;
            }   
        update lsList;
   }
   
   
   if(rwaList.size()>0)
   {
            for(Glxy_ReimbursableWorkAuthorization__c auth:rwaList)
            {
                    oldLeaseObj=LeaseMap.get(auth.LeaseNumber__c );
                    auth.IA_Sq_Ft__c= oldLeaseObj.Total_IA_Sq_feet__c ;
                    auth.NOA_Sq_Ft__c=oldLeaseObj.Total_NOA_Sq_feet__c;
            }   
        update rwaList;
   }
   
   
   if(srList.size()>0)
   {
            for(Glxy_StepRent__c auth:srList)
            {            
                    oldLeaseObj=LeaseMap.get(auth.LeaseNumber__c );
                    auth.IA_Sq_Ft__c= oldLeaseObj.Total_IA_Sq_feet__c;
                    auth.NOA_Sq_Ft__c= oldLeaseObj.Total_NOA_Sq_feet__c;
            }   
        update srList;
   }
}
}