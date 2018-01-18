public with sharing class VMO_AccountTriggerHelper {
    
    
    public static boolean run = true;
    public static boolean runOnce(){
        if(run){
         run=false;
         return true;
        }else{
            return run;
        }
    }
    public static void beforeUpdate(list<Account> triggerNew, map<ID, Account> triggerOldMap, 
                                        map <ID, Account> triggerNewMap) {
                                            
        map<string, decimal> mapStratScore = VMO_AccountTriggerHelper.stratScoreContTaskOrder(triggerNew);
        for (Account acct : triggerNew) {
            if (!String.isBlank(acct.Stratification_Value_Override__c)) {
                if(acct.Stratification_Value__c != acct.Stratification_Value_Override__c){
                    acct.Stratification_Value__c = acct.Stratification_Value_Override__c;
                }
            }else if (mapStratScore != null && mapStratScore.size() > 0) {
                decimal stratScore = mapStratScore.get(acct.id);
                
                if (stratScore > 25 && stratScore <= 50) {
                    acct.Stratification_Value__c = 'Sustaining';
                }else if (stratScore > 50 && stratScore <= 75) {
                    acct.Stratification_Value__c = 'Critical';
                }else if (stratScore > 75 && stratScore <= 100) {
                    acct.Stratification_Value__c = 'Strategic';
                }else {
                    acct.Stratification_Value__c = 'Standard';
                }
                System.debug('** StratValue: ' + stratScore);
            }else{
                acct.Stratification_Value__c='';
            }
        }
    }
    
    public static void beforeInsert(list<Account> triggerNew, map<ID, Account> triggerOldMap, 
                                        map <ID, Account> triggerNewMap) {
        for (Account acct : triggerNew) {
            if (!String.isBlank(acct.Stratification_Value_Override__c)) {
                if(acct.Stratification_Value__c != acct.Stratification_Value_Override__c){
                    acct.Stratification_Value__c = acct.Stratification_Value_Override__c;
                }
            }
        }                               
    }
    
    public static map<string, decimal> stratScoreContTaskOrder(list<Account> triggerNew){
        string contRecID = Schema.SObjectType.Contract__c.getRecordTypeInfosByName().get('Inactive').getRecordTypeId();
        
        map<string, decimal> mapStratScore = new map<string, decimal>();        
        for (Contract__c contTOList : [Select id, Vendor__c, Stratification_Score__c 
                                            from Contract__c where RecordTypeId !=:contRecID and Stratification_Score__c != null
                                            and Vendor__c in : triggerNew order By Stratification_Score__c desc limit 1]){
            if (mapStratScore.containsKey(contTOList.Vendor__c)){
                decimal stratScore = mapStratScore.get(contTOList.Vendor__c);
                if (contTOList.Stratification_Score__c > stratScore){
                    mapStratScore.put(contTOList.Vendor__c, contTOList.Stratification_Score__c);
                    system.debug('mapStratScoreContif22if::=='+mapStratScore);
                }   
            }else{ 
                mapStratScore.put(contTOList.Vendor__c, contTOList.Stratification_Score__c);
                system.debug('mapStratScoreCont11else::=='+mapStratScore);
             }                                           
        }
        system.debug('mapStratScore::Cont=='+mapStratScore);
        
        string toRecId = Schema.SObjectType.Task_Order__c.getRecordTypeInfosByName().get('Inactive').getRecordTypeId();
        for(Task_Order__c toBPAList : [Select id, Vendor__c, Stratification_Score__c 
                                                from Task_Order__c where RecordTypeId !=: toRecId and Stratification_Score__c != null
                                                 and Vendor__c in : triggerNew order By Stratification_Score__c desc limit 1]){
            if (mapStratScore.containsKey(toBPAList.Vendor__c)){
                decimal stratScore = mapStratScore.get(toBPAList.Vendor__c);
                if (toBPAList.Stratification_Score__c > stratScore){
                    mapStratScore.put(toBPAList.Vendor__c, toBPAList.Stratification_Score__c);
                    system.debug('mapStratScoreBPAif22if::=='+mapStratScore);
                }   
            }else{ 
                mapStratScore.put(toBPAList.Vendor__c, toBPAList.Stratification_Score__c);
                system.debug('mapStratScoreBPA11else::=='+mapStratScore);
             }                                          
        }
        system.debug('mapStratScore::BPA=='+mapStratScore);  
                                                      
        string bpaRecID = Schema.SObjectType.BPA_Call__c.getRecordTypeInfosByName().get('Inactive').getRecordTypeId();
        string bpaCallRecId = Schema.SObjectType.BPA__c.getRecordTypeInfosByName().get('Inactive').getRecordTypeId();
        
        for (BPA__c bpaList : [Select Id, Vendor__c,
                                (Select id, Stratification_Score__c 
                                    from BPA_Calls__r where RecordTypeId !=: toRecId  and Stratification_Score__c != null
                                    order By Stratification_Score__c desc limit 1)
                                From BPA__c Where RecordTypeId !=:contRecID and Vendor__c in : triggerNew]){
            if (mapStratScore.containsKey(bpaList.Vendor__c)){
                decimal stratScore = mapStratScore.get(bpaList.Vendor__c);
                if (bpaList.BPA_Calls__r != null && bpaList.BPA_Calls__r.size() > 0){  
                    system.debug('bpaCallScoreif22if::=='+mapStratScore);
                        if (bpaList.BPA_Calls__r[0].Stratification_Score__c > stratScore){
                        mapStratScore.put(bpaList.Vendor__c, bpaList.BPA_Calls__r[0].Stratification_Score__c);
                        system.debug('mapStratScoreif22ifif::=='+mapStratScore);
                    }
                }
            }else {
                if (bpaList.BPA_Calls__r != null && bpaList.BPA_Calls__r.size() > 0){  
                    mapStratScore.put(bpaList.Vendor__c, bpaList.BPA_Calls__r[0].Stratification_Score__c);
                    system.debug('bpaCallScoreelse22if::=='+mapStratScore);
                }
            }
        }
        system.debug('mapStratScore::BPA=='+mapStratScore);
        return mapStratScore;
    }
}