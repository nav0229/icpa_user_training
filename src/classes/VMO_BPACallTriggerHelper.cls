public with sharing class VMO_BPACallTriggerHelper {
    
    public static void afterUpdate(List<BPA_Call__c> triggerNew, Map<ID, BPA_Call__c> triggerOldMap, 
                                        Map <ID, BPA_Call__c> triggerNewMap) {
        
        set<string> setBPAId = new set<string>();
        system.debug('toBPAList==='+triggerNew);
        for(BPA_Call__c toBPAList : triggerNew){
            setBPAId.add(toBPAList.BPA_Name__c);
        }
        
        set<string> setAcctId = new set<string>();
        if(setBPAId != null && setBPAId.size() > 0){
            list<BPA__c> lstBPA = new list<BPA__c>();
            for(BPA__c bpaList :[Select Id,Vendor__c
                                 from BPA__c where Id IN: setBPAId]){
                setAcctId.add(bpaList.Vendor__c);
            }
        } 
        
        map<string, decimal> mapAcctBPACalls = new map<string, decimal>();
        for(BPA__c objBPA : [Select Vendor__c, (Select id from BPA_Calls__r) from BPA__c where Vendor__c IN : setAcctId]){
            system.debug(objBPA.BPA_Calls__r.size()+'****'+objBPA.BPA_Calls__r);
            if(mapAcctBPACalls.containsKey(objBPA.Vendor__c)){
                decimal totCalls = mapAcctBPACalls.get(objBPA.Vendor__c);
                if(objBPA.BPA_Calls__r != null && objBPA.BPA_Calls__r.size() > 0){
                    totCalls += objBPA.BPA_Calls__r.size();
                }
                mapAcctBPACalls.put(objBPA.Vendor__c, totCalls);
            }else{
                if(objBPA.BPA_Calls__r != null && objBPA.BPA_Calls__r.size() > 0){
                    mapAcctBPACalls.put(objBPA.Vendor__c,objBPA.BPA_Calls__r.size());
                }else{
                    mapAcctBPACalls.put(objBPA.Vendor__c,0);
                }
            }
        }
          
        system.debug(mapAcctBPACalls+'setAcctId==='+setAcctId);                             
        if(setAcctId != null && setAcctId.size() > 0){
            list<Account> acctList = [Select Id,Stratification_Value__c,Stratification_Value_Override__c 
                                        from Account where id IN : setAcctId];
            map<string, decimal> mapStratScore = VMO_AccountTriggerHelper.stratScoreContTaskOrder(acctList);
            list<Account> lstAcct = new list<Account>();
            for (Account acct : acctList) {
                Account acctObj = new Account();
                acctObj.Id = acct.Id;
                decimal totBPACalls = mapAcctBPACalls.get(acct.Id);
                system.debug('totBPACalls=='+totBPACalls);
                if(totBPACalls != null ){
                    acctObj.Total_No_of_BPACalls__c = totBPACalls;
                }
                if (!String.isBlank(acct.Stratification_Value_Override__c)) {
                    if(acct.Stratification_Value__c != acct.Stratification_Value_Override__c){
                        acctObj.Stratification_Value__c = acct.Stratification_Value_Override__c;
                    }
                }else if (mapStratScore != null && mapStratScore.size() > 0) {
                    decimal stratScore = mapStratScore.get(acct.id);
                    
                    if (stratScore > 25 && stratScore <= 50) {
                        acctObj.Stratification_Value__c = 'Sustaining';
                    }else if (stratScore > 50 && stratScore <= 75) {
                        acctObj.Stratification_Value__c = 'Critical';
                    }else if (stratScore > 75 && stratScore <= 100) {
                        acctObj.Stratification_Value__c = 'Strategic';
                    }else {
                        acctObj.Stratification_Value__c = 'Standard';
                    }
                    System.debug('** StratValue: ' + stratScore);
                }else{
                    acctObj.Stratification_Value__c = '';
                }
                lstAcct.add(acctObj);
            }
            system.debug('lstAcct==='+lstAcct);
            if (lstAcct != null && lstAcct.size() > 0) {
                update lstAcct;
            }
        }
    }
}