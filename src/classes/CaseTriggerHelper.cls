/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Checks for the Resolution type in custom settings and bring those values and updates in case
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  srinivas         09/09/2015    1.0       Initial version.
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/

public class CaseTriggerHelper{

        
        public static void onBeforeUpdate(List<Case> triggerNew, Map<Id, Case> triggerOldMap) {
         List<String> stringparts = new List<String>();
         List<Case> UpdatedCase = new List<Case>();
         List<ID> AppModuleId = New List<ID>();
         Set<String> restype = new Set<String>();
         String s;
         Boolean flag;
         Map<String, Caseset__c> mapCA = new Map<String, Caseset__c>();
         Boolean devMngr = False;
         Boolean solArch = False;
         Boolean securityPkg = False;
         Boolean securityRvw = False;
         String Tiernum = '0';
         Set<Id> appModId = new Set<Id>();
         Map<String, Application_Support__c> mapAS = new Map<String, Application_Support__c>();
         Set<String> queueName = new Set<String>();
         Map<String, QueueSobject> mapQ = new Map<String, QueueSobject>();
         
         for(Case casecus: triggerNew){
            
            flag = false;
                s = (casecus.resolution_type__c != null)? casecus.resolution_type__c: null;
                
                appModId.add(casecus.Application_Module__c);
                
                    // Tier 0 cannot select the resolution type
                    if(casecus.Tier__c == '0' && s != null){
                          casecus.adderror('Tier 0 cannot select Resolution Type');                                   
                    }
                    
                    // No resolution type and tier not zero
                    if (s == null && casecus.Tier__c != '0'){
                          casecus.Tier__c = '1';
                          casecus.Need_Dev_Mgr_Approval__c = false;
                          casecus.Need_Sol_Arch_Approval__c= false;
                          casecus.Need_Security_Pkg__c = false;
                          casecus.Need_Security_Review__c = false;
                    }
                    
                    // checks for the semicolan 
                    if(s != null && s.contains(';')) {
                         flag = true;
                         Integer count = 0;
                         count = s.countMatches(';');
                         stringparts = s.split(';',count+1);
                         system.debug('count of res'+count);
                         system.debug('String '+stringparts);        
                    }
                    
                    if (s != null && (!s.contains(';'))) {
                         flag = false;
                         stringparts.add(casecus.resolution_type__c);
                         system.debug('Single RT ' + stringparts);
                                
                    }                                                                        
                    
         } // End of For loop
         
         //Caseset__c casesettings = Caseset__c.getValues(stringparts); 
         Map<String, Caseset__c> casesettings = Caseset__c.getAll();
         //system.debug('This is Case Settings ' + casesettings);
         
         for(Caseset__c ca : casesettings.values()){
            mapCA.put(ca.Resolution_Types__c, ca);
         }
         
              for(String st : stringparts){
                String rt = mapCA.get(st).Resolution_Types__c;
                String ti = mapCA.get(st).Tiers__c;
                Boolean dm = mapCA.get(st).Need_Dev_Mgr_Approvals__c;
                Boolean sa = mapCA.get(st).Need_Sol_Arch_Approvals__c;
                Boolean sr = mapCA.get(st).Need_Security_Review__c;
                Boolean sp = mapCA.get(st).Need_Security_Package__c;
                system.debug(' >>>> RT ' + rt + ' === Dev Mgr Approvals ' + mapCA.get(st).Need_Dev_Mgr_Approvals__c + '<<<<<< ' + mapCA.get(st).Tiers__c);
                        
                    if(ti > Tiernum){
                        Tiernum = mapCA.get(st).Tiers__c;
                    }                       
                    //if(dm != devMngr) {
                      if(!devMngr && dm){ 
                        devMngr = mapCA.get(st).Need_Dev_Mgr_Approvals__c;
                    }   
                    //if(sa != solArch) {
                    if(!solArch && sa){
                        solArch = mapCA.get(st).Need_Sol_Arch_Approvals__c;
                    }  
                    if(!securityPkg && sp){
                    securityPkg = mapCA.get(st).Need_Security_Package__c;
                    }
                    if(!securityRvw && sr){
                    securityRvw = mapCA.get(st).Need_Security_Review__c;
                    }
             }
            
         //system.debug('This is Tier Num ' + Tiernum + ' === Dev Mgr ' + devMngr + '=== Sol Arc ' + solArch  + '=== Security Review' + securityRvw + '=== Security Package' + securityPkg);
         
         //Application module information
         
         List<Application_Support__c> lstAM = [Select Id,Name,Affiliated_Organization__c,App_Owner__c,Secondary_Owner__c,Secondary_Owner_2__c,Secondary_Owner_3__c,Secondary_Owner_4__c,Dedicated_Team_Tier_1__c,Dedicated_Team_Tier_2__c,Dedicated_Team_Tier_3__c,caseapplication__c FROM Application_Support__c WHERE Id IN :appModId];
            
            if(!lstAM.isEmpty()){
                for(Application_Support__c appS : lstAM){
                    mapAS.put(appS.Id, appS);
                    queueName.add(appS.Dedicated_Team_Tier_1__c);
                    queueName.add(appS.Dedicated_Team_Tier_2__c);
                    queueName.add(appS.Dedicated_Team_Tier_3__c);
                }
            }
         
         List<QueueSobject> lstQueues = [SELECT Id,queue.Name, QueueId FROM QueueSobject WHERE SobjectType = 'Case'and queue.Name IN :queueName];
         if(!lstQueues.isEmpty()){
                for(QueueSobject q : lstQueues){
                    mapQ.put(q.queue.Name, q);
                }
         }
         
         // Case Update
         for(Case casecus: triggerNew){
            if(casecus.Resolution_Type__c != null){
                casecus.Tier__c = Tiernum;
            }
             casecus.Need_Dev_Mgr_Approval__c = devMngr;
             casecus.Need_Sol_Arch_Approval__c = solArch;
             casecus.Need_Security_Pkg__c = securityPkg;
             casecus.Need_Security_Review__c = securityRvw;   
             String tier = casecus.Tier__c; 
             String appId = casecus.Application_Module__c;
             String qName;
                if(casecus.Resolution_Type__c != triggerOldMap.get(casecus.Id).Resolution_Type__c){
                    casecus.Received_Dev_Mgr_Approval__c = false;
                    casecus.Received_Sol_Arch_Approval__c = false;
                    casecus.Received_Security_Pkg__c = false;
                    casecus.Received_Security_Review__c = false;
                    casecus.Current_State__c = 'Resolution Type Assignment';
                }
              
               if(tier.equals('1')){  
                    qName = mapAs.get(appId).Dedicated_Team_Tier_1__c;
               }
               if(tier.equals('2')){  
                    qName = mapAs.get(appId).Dedicated_Team_Tier_2__c;
               }
               if(tier.equals('3')){  
                    qName = mapAs.get(appId).Dedicated_Team_Tier_3__c;
               }
               
                if(appId != null){
                         casecus.App_Owner__c = mapAs.get(appId).App_Owner__c;
                         casecus.Secondary_Owner__c = mapAs.get(appId).Secondary_Owner__c;  
                         casecus.Secondary_Owner_2__c = mapAs.get(appId).Secondary_Owner_2__c;
                         casecus.Secondary_Owner_3__c = mapAs.get(appId).Secondary_Owner_3__c;
                         casecus.Secondary_Owner_4__c = mapAs.get(appId).Secondary_Owner_4__c;
                }  
              system.debug('This is Tier ' + tier);
              system.debug('Queue Map ' +mapQ);
                if(casecus.Current_State__c != 'New'){
               if(tier != triggerOldMap.get(casecus.Id).Tier__c){
                   casecus.OwnerId = mapQ.get(qName).QueueId;        
                   
               }              
              }                   
         }         
         
      }
    
    //Smitha 10/5/2015: Method to return OCIO Task Tracking Records
    public static Map<Id, Case> getOcioTaskTrackingRecords(Map<Id, Case> triggerMap){
        Id recType=Schema.SObjectType.Case.getRecordTypeInfosByName().get('OCIO Task Tracking').getRecordTypeId();
        Map<Id, Case> ocioCaseMap = new Map<Id, Case>();
        if(triggerMap.size() != 0){
            for(Id caseId:triggerMap.keySet()){
                Case currCase = triggerMap.get(caseId);
                if(currCase.RecordTypeId == recType){
                    System.debug('RecordType for ' + currcase.RecordTypeId);
                    ocioCaseMap.put(currCase.Id,currCase);    
                }
            }
        }
        return  ocioCaseMap;  
    }
}