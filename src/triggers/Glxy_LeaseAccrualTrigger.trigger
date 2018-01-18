trigger Glxy_LeaseAccrualTrigger on Glxy_LeaseAccrual__c (after insert, after update) {
	
	Set<Id> DigestIDs = new Set<Id>();	
	List<Glxy_LeaseDigest__c> objDigestsToBeUpdated = New List<Glxy_LeaseDigest__c>();
    string strLoopPreviousDigest = '-';
    string strLoopCurrentDigest = '';
    Boolean blnHasData = false;
    string strPDNs = '';
    
	for (Glxy_LeaseAccrual__c  Accrual: Trigger.new) {
	 	 DigestIDs.add(Accrual.LeaseDigest__c);
	}
	
	List<Glxy_LeaseAccrual__c> LeaseAccruals = ([
        SELECT 	LeaseDigest__c, PDN__c 
        FROM 	Glxy_LeaseAccrual__c 
        WHERE 	LeaseDigest__c IN :DigestIDs
        AND 	PDN__c != Null
        ORDER BY LeaseDigest__c, CreatedDate
    ]);
    
    //Loop the Accruals ...
    for (Glxy_LeaseAccrual__c objAccrual: LeaseAccruals) {
    	strLoopCurrentDigest = objAccrual.LeaseDigest__c;
    	blnHasData = true;
    	if ((strLoopCurrentDigest <> strLoopPreviousDigest) && (strLoopPreviousDigest <> '-')){
    		//Update Digest
    		objDigestsToBeUpdated.Add(New Glxy_LeaseDigest__c(
    			ID = strLoopPreviousDigest,
                PDNsForDigest__c = strPDNs
    		));
    		strPDNs = '';
    	}
    	strPDNs = strPDNs + objAccrual.PDN__c + '  ';
    	strLoopPreviousDigest = strLoopCurrentDigest;
    }
    
    // Run one last time, for the last record ...
    if (blnHasData){ 
    	objDigestsToBeUpdated.Add(New Glxy_LeaseDigest__c(
    			ID = strLoopCurrentDigest,
                PDNsForDigest__c = strPDNs
    		));
    }
    
	try{    
        Database.Update(objDigestsToBeUpdated);
    }catch (DmlException e){
     	System.debug('Glxy_LeaseAccrualTrigger - Data Update error - ' + e.getMessage());
    }
    
}