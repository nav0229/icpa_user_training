trigger GLXY_ValidateLeaseNumber on Glxy_Transaction__c (before insert,before update) {

    string leaseNumber = '';
    boolean isValid = false;
    Map<string, boolean> leaseMap= new map<string, boolean>();
    set<string> leaseset = new set<string>();
    
    //G2 Release 2.4
    Set<Id> TransactionIDs = new Set<Id>();
    List<string> ProjectIDs = new List<string>();
    List<Glxy_LPLumpSum__c> LPLSList = new List<Glxy_LPLumpSum__c>();
    List<Glxy_LPStepRent__c> LPSRList = new List<Glxy_LPStepRent__c>();
    //G2 Release 2.4
    
    for(Glxy_Transaction__c  trx:Trigger.new) {
    	//G2 Release 2.4
    	if(trx.Record_Type_Lookup__c == 'Lease Action' && trx.Status__c == 'Accepted by REXUS' && trx.Rejection_Remarks__c == Null){
    		TransactionIDs.add(trx.ID);	
    	}
		//G2 Release 2.4
		
    	if(trx.Record_Type_Lookup__c!='Project Final Certification'){
      		continue;
      	}
      	leaseset.add(trx.New_Lease_Number__c);
    }
    
    if(leaseset.size()>0){
    	List<Glxy_Lease__c> listLease = [select name from Glxy_Lease__c where name in:leaseset];
    	for(Glxy_Lease__c lease:listLease){
      		leaseMap.put(lease.name,true);
    	}
    }
    
    for(Glxy_Transaction__c  trx:Trigger.new){
     	
     	leaseNumber = trx.New_Lease_Number__c;
      	system.debug(trx.Record_Type_Lookup__c);
	    if(!(trx.Record_Type_Lookup__c=='Project Final Certification' && (trx.Lease_Action__c=='New'||trx.Lease_Action__c=='Superseding'||trx.Lease_Action__c=='New/Replacing'||   trx.Lease_Action__c=='Succeeding' ))){
      		continue;
      	}
      
      	if(leaseNumber==null|| leaseNumber==''){
      		//trx.addError('Please fill the New Lease number value.');
         	continue;
      	}else{
         	if(leaseNumber.length() == 8 && leaseNumber.startsWith('L') && (Label.State_Codes.contains('$'+leaseNumber.substring(1,3)+'$')) && (leaseNumber.substring(3,8)).isNumeric() == true ){
	         	/*
	         	if(leaseMap.get(leaseNumber)!=null){
	         		trx.addError('Lease number already exists in the Galaxy system. Please choose another one');
				}
	           	trx.addError('test');
	         	*/
         	} else {
         		trx.addError('Invalid input,the Lease Number should start with L ,followed by a valid 2 character state code and 5 digit number');
        	}
    	}
    }
    
    //G2 Release 2.4
    try{	
		if(TransactionIDs.size() > 0){
	    	List <Glxy_LeaseDigest__c> lstDigests = [Select ProjectNumber__c from Glxy_LeaseDigest__c Where Transaction__c in :TransactionIDs];
	    	for (Glxy_LeaseDigest__c Digest:lstDigests){
	    		if (Digest.ProjectNumber__c != Null){
	      			ProjectIDs.Add(Digest.ProjectNumber__c);
	    		}
	    	}
	    }
    
	    if(ProjectIDs.size() > 0) {
	   		LPLSList = [Select ID from Glxy_LPLumpSum__c where  ProjectNumber__r.Name in :ProjectIDs];
	   		LPSRList = [Select ID from Glxy_LPStepRent__c where  ProjectNumber__r.Name in :ProjectIDs];
	   		
	   		//Delete LPLSList;
	   		//Delete LPLSList;
	   		
	   		if(LPLSList.size()>0){
				for(Glxy_LPLumpSum__c LS:LPLSList){
					LS.BDGFlag__c = false;
	                LS.Budget_Exclusion_Reason__c = 'This payment line was associated with a Project that was used on a digest (lease action transaction), and therefore the system excluded it from budget.';
	            }   
        		update LPLSList;
   			}
   
	   		if(LPSRList.size()>0){
				for(Glxy_LPStepRent__c SR:LPSRList){
					SR.BDGFlag__c = false;
	                SR.Budget_Exclusion_Reason__c = 'This payment line was associated with a Project that was used on a digest (lease action transaction), and therefore the system excluded it from budget.';
	            }   
        		update LPSRList;
   			}
	   	}
 	
 	}catch (Exception e){
    	System.debug('GLXY_ValidateLeaseNumber error - ' + e.getMessage());
	}

    //G2 Release 2.4
}