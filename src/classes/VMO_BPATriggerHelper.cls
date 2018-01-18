public with sharing class VMO_BPATriggerHelper {
    
    public static void afterInsert(List<BPA__c> triggerNew, Map<ID, BPA__c> triggerOldMap, 
                                        Map <ID, BPA__c> triggerNewMap, string dmlType) {

        set<string> setAcctId = new set<string>();
        for(BPA__c bpaList : triggerNew){
            setAcctId.add(bpaList.Vendor__c);
        }   
        
        if(setAcctId != null && setAcctId.size() > 0){
            list<Account> acctList = [Select Id,Total_Spend__c,
                                        (Select Id,Total_Value_of_BPA_Calls__c from BPA__r) 
                                        from Account where id IN : setAcctId];
            if(acctList != null && acctList.size() > 0){
                for (Account acct : acctList) {
                    if(acct.Total_Spend__c == null){
                        acct.Total_Spend__c = 0;
                    }
                    //Handle Total Spend on Contract Insert
                    if(!string.isblank(dmlType) && dmlType == 'insert'){
                        system.debug('==EnteredInsert==');
                        if(acct.BPA__r != null && acct.BPA__r.size()>0){
                            for(BPA__c obj : acct.BPA__r){
                                if(triggerNewMap.containskey(obj.ID)){
                                    if(obj.Total_Value_of_BPA_Calls__c != null){
                                        acct.Total_Spend__c += obj.Total_Value_of_BPA_Calls__c ;
                                    }
                                }
                            }
                        }
                    }
                    
                    //Handle Total Spent on Contract Update
                    else if(!string.isblank(dmlType) && dmlType == 'update'){
                        system.debug('==EnteredUpdate==');
                        if(acct.BPA__r != null && acct.BPA__r.size()>0){
                            for(BPA__c obj : acct.BPA__r){
                                if(triggerOldMap.containskey(obj.ID)){
                                    if(triggerOldMap.get(obj.ID).Total_Value_of_BPA_Calls__c != null){
                                        acct.Total_Spend__c -= triggerOldMap.get(obj.ID).Total_Value_of_BPA_Calls__c ;
                                    }
                                    if(obj.Total_Value_of_BPA_Calls__c != null){
                                        acct.Total_Spend__c += obj.Total_Value_of_BPA_Calls__c ;
                                    }
                                }
                            }
                        }
                    }
                    
                    if(acct.BPA__r != null && acct.BPA__r.size() > 0){
                        acct.Total_No_of_BPA__c = acct.BPA__r.size();
                    }else{
                        acct.Total_No_of_BPA__c = 0;
                    }
                }   
                update acctList;
            }
        }            
    }
    
    public static void afterDelete(List<BPA__c> triggerNew, Map<ID, BPA__c> triggerOldMap, 
                                        Map <ID, BPA__c> triggerNewMap) {
        
        set<string> setAcctId = new set<string>();
        map<string,decimal> mapoldTOVal = new map<string,decimal>();
        for(BPA__c bpaList : triggerNew){
            setAcctId.add(bpaList.Vendor__c);
            if(triggerOldMap.get(bpaList.ID).Total_Value_of_BPA_Calls__c != null){
                decimal dOldVal = 0;
                if(mapoldTOVal.containsKey(bpaList.Vendor__c)){
                    dOldVal = mapoldTOVal.get(bpaList.Vendor__c);
                    dOldVal += triggerOldMap.get(bpaList.ID).Total_Value_of_BPA_Calls__c ;
                    mapoldTOVal.put(bpaList.Vendor__c,dOldVal);
                }else{
                    dOldVal = triggerOldMap.get(bpaList.ID).Total_Value_of_BPA_Calls__c ;
                    mapoldTOVal.put(bpaList.Vendor__c,dOldVal);
                }
            }
        }   
        
        if(setAcctId != null && setAcctId.size() > 0){
            list<Account> acctList = [Select Id,Total_Spend__c,Total_No_of_BPACalls__c,Stratification_Value_Override__c,Stratification_Value__c,
                                        (Select Id,Total_Number_of_BPA_Calls__c  from BPA__r) 
                                        from Account where id IN : setAcctId];
            if(acctList != null && acctList.size() > 0){
                map<string, decimal> mapStratScore = VMO_AccountTriggerHelper.stratScoreContTaskOrder(acctList);
                list<Account> lstAcct = new list<Account>();
                for (Account acct : acctList) {
                    Account acctObj = new Account();
                    acctObj.Id = acct.Id;
                    if(acct.Total_Spend__c == null){
                        acct.Total_Spend__c = 0;
                    }
                    acctObj.Total_Spend__c = acct.Total_Spend__c - mapoldTOVal.get(acct.Id);
                    
                    system.debug('acct.BPA__r===='+acct.BPA__r);
                    if(acct.BPA__r != null && acct.BPA__r.size() > 0){
                        acctObj.Total_No_of_BPA__c = acct.BPA__r.size();
                        //system.debug('acct.BPA__r[0].Total_Number_of_BPA_Calls__c===='+acct.BPA__r[0].Total_Number_of_BPA_Calls__c);
                        if(acct.BPA__r[0].Total_Number_of_BPA_Calls__c != null){
                            acctObj.Total_No_of_BPACalls__c = acct.BPA__r[0].Total_Number_of_BPA_Calls__c;
                        }
                    }else{
                        acctObj.Total_No_of_BPA__c = 0;
                        acctObj.Total_No_of_BPACalls__c = 0;
                    }
                    system.debug('acctObj.Total_No_of_BPA__c:::'+acctObj.Total_No_of_BPA__c);
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
}