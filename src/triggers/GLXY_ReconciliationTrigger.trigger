trigger GLXY_ReconciliationTrigger on Glxy_Reconciliation__c (after update) {
	
	if(userinfo.getName() == 'CastIron User'){
    
	    list<Glxy_Reconciliation__c> objReconcupdateList = new List<Glxy_Reconciliation__c>();
	    Set<string> LeaseIDS = New Set<string>();

	    for(Glxy_Reconciliation__c glxreconc : Trigger.new) {
	        LeaseIDS.add(glxreconc.Leasenumber__c);
	    }
    
	    AggregateResult[] aggResult = [Select   Leasenumber__c, Sum(RexusTotalMonthlyPayment__c) RexusMonthlyPayment
	                                   From     Glxy_Reconciliation__c
	                                   Where    Leasenumber__c = :LeaseIDS
	                                   And      LastModifiedBy.Name = 'CastIron User'
	                                   Group by Leasenumber__c ];
    	Map<String,String> resultMap = new Map<String,String>();                                                                                                         
    
	    for(AggregateResult ar:aggResult){
	        resultMap.put(String.valueof(ar.get('Leasenumber__c')),String.valueof(ar.get('RexusMonthlyPayment')));
	    }
	    if(resultMap.values().size() > 0) {
	        for(Glxy_Reconciliation__c glxreconc1 : Trigger.new) {  
	            if(glxreconc1.RexusTotalMonthlyPayment__c != trigger.oldMap.get(glxreconc1.id).RexusTotalMonthlyPayment__c) {
	                
	                Glxy_Reconciliation__c objreconc = new Glxy_Reconciliation__c();
	                objreconc.id = glxreconc1.id;
	                objreconc.RexusYearToDate__c = decimal.valueof(resultMap.get(glxreconc1.Leasenumber__c));
	                objReconcupdateList.add(objreconc);
	            }
	        }
	        update objReconcupdateList;
	    }
	}
}