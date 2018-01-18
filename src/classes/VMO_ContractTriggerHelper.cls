public with sharing class VMO_ContractTriggerHelper {
    public static void onUpdate(List<Contract__c> triggerNew, Map<ID, Contract__c> triggerOldMap, 
                                                  Map <ID, Contract__c> triggerNewMap, string dmlType) {
                                                                    
        set<string> setAcctId = new set<string>();
        map<string,decimal> mapoldCntrVal = new map<string,decimal>();  
        for(Contract__c contList : triggerNew){
            setAcctId.add(contList.Vendor__c);
            if(!string.isblank(dmlType) && dmlType == 'delete'){
                if(triggerOldMap.get(contList.ID).Base_and_All_Options__c!= null){
                    decimal dOldVal = 0;
                    if(mapoldCntrVal.containsKey(contList.Vendor__c)){
                        dOldVal = mapoldCntrVal.get(contList.Vendor__c);
                        dOldVal += triggerOldMap.get(contList.ID).Base_and_All_Options__c;
                        mapoldCntrVal.put(contList.Vendor__c,dOldVal);
                    }else{
                        dOldVal = triggerOldMap.get(contList.ID).Base_and_All_Options__c;
                        mapoldCntrVal.put(contList.Vendor__c,dOldVal);
                    }
                }
            }
        }             
        
        if(setAcctId != null && setAcctId.size() > 0){
            list<Account> acctList = [Select Id,Total_Spend__c,Stratification_Value__c,Stratification_Value_Override__c,
                                        (Select Id,Base_and_All_Options__c from Contracts__r) 
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
                    //Handle Total Spend on Contract Insert
                    if(!string.isblank(dmlType) && dmlType == 'insert'){
                        if(acct.Contracts__r != null && acct.Contracts__r.size()>0){
                            for(Contract__c obj : acct.Contracts__r){
                                if(triggerNewMap.containskey(obj.ID)){
                                    if(obj.Base_and_All_Options__c != null){
                                        acct.Total_Spend__c += obj.Base_and_All_Options__c;
                                    }
                                }
                            }
                        }
                    }
                    
                    //Handle Total Spent on Contract Update
                    else if(!string.isblank(dmlType) && dmlType == 'update'){
                        system.debug('==EnteredUpdate==');
                        if(acct.Contracts__r != null && acct.Contracts__r.size()>0){
                            for(Contract__c obj : acct.Contracts__r){
                                if(triggerOldMap.containskey(obj.ID)){
                                    if(triggerOldMap.get(obj.ID).Base_and_All_Options__c != null){
                                        acct.Total_Spend__c -= triggerOldMap.get(obj.ID).Base_and_All_Options__c;
                                    }
                                    if(obj.Base_and_All_Options__c != null){
                                        acct.Total_Spend__c += obj.Base_and_All_Options__c;
                                    }
                                }
                            }
                        }
                    }
                    
                    //Handle Total Spent on ContractDelete
                    else if(!string.isblank(dmlType) && dmlType == 'delete'){
                        system.debug('==EnteredDelete==');
                        acct.Total_Spend__c -= mapoldCntrVal.get(acct.Id);
                    }
                    acctObj.Total_Spend__c = acct.Total_Spend__c;
                    system.debug('acct.Contracts__r=='+acct.Contracts__r.size());
                    if (acct.Contracts__r != null && acct.Contracts__r.size() > 0){
                        acctObj.Total_No_of_Contracts__c = acct.Contracts__r.size();
                    }else {
                        acctObj.Total_No_of_Contracts__c = 0;
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
                if (lstAcct != null && lstAcct.size() > 0) {
                    update lstAcct;
                }
            }
        }            
    }
}