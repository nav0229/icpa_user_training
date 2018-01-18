public with sharing class GLXY_FundApprover {
	
	public String strBA53Approver       {get; set;}
    public String strApprovedDate    	{get; set;}
    public String strApprovalComments   {get; set;}
    public String strTransactionID      {get; set;}
    public String strTransactionName    {get; set;}
    public String strObjectID      		{get; set;}
    public String strFieldID      		{get; set;}
    public String strRecordID      		{get; set;}
    
    public GLXY_FundApprover(){
    }
    
    public void getFundApproverDetails(){
    	
    	Integer intPaymentID;
    	If (strRecordID == Null){
    		strRecordID = ApexPages.CurrentPage().getparameters().get('id');	
    	}
    	
    	List<SObject> objResults = Database.query('SELECT ' + strFieldID + ' FROM '  + strObjectID + ' Where ID = :strRecordID');
    	if (objResults.size() > 0){
    		intPaymentID = Integer.ValueOf(objResults[0].get(strFieldID));
    	}
    	
    	List<Glxy_LeasePayment__c> objLeasePayment;
     	objLeasePayment = [
     	 	Select 	Name, LeaseDigest__r.Transaction__r.TransactionProcessedDate__c, 
					LeaseDigest__r.Transaction__r.BA53Approver__c, 
					LeaseDigest__r.Transaction__r.Comments__c,
					LeaseDigest__r.Transaction__r.Name,
					LeaseDigest__r.Transaction__c  
			From 	Glxy_LeasePayment__c 
			Where 	ResultingPaymentID__c = :intPaymentID Limit 1];
		
		if (objLeasePayment.size() > 0){
			strBA53Approver = objLeasePayment[0].LeaseDigest__r.Transaction__r.BA53Approver__c;
			strApprovedDate = String.ValueOf(objLeasePayment[0].LeaseDigest__r.Transaction__r.TransactionProcessedDate__c);
			strApprovalComments = objLeasePayment[0].LeaseDigest__r.Transaction__r.Comments__c;
			strTransactionID = objLeasePayment[0].LeaseDigest__r.Transaction__c;
			strTransactionName = objLeasePayment[0].LeaseDigest__r.Transaction__r.Name;
		}
     	
    }
    
    public void getFundApproverDetailsProj(){
    	
    	string strProjectID;
    	If (strRecordID == Null){
    		strRecordID = ApexPages.CurrentPage().getparameters().get('id');	
    	}
    	
    	List<SObject> objResults = Database.query('SELECT Name FROM Glxy_LeaseProjects__c Where ID = :strRecordID');
    	if (objResults.size() > 0){
    		strProjectID = string.ValueOf(objResults[0].get('Name'));
    	}
    	
    	List<Glxy_LeaseDigest__c> objLeaseDigest;
     	objLeaseDigest = [
     	 	Select 	Name, Transaction__r.TransactionProcessedDate__c, 
					Transaction__r.BA53Approver__c, 
					Transaction__r.Comments__c,
					Transaction__r.Name,
					Transaction__c  
			From 	Glxy_LeaseDigest__c 
			Where 	ProjectNumber__c = :strProjectID Limit 1];
		
		if (objLeaseDigest.size() > 0){
			strBA53Approver = objLeaseDigest[0].Transaction__r.BA53Approver__c;
			strApprovedDate = String.ValueOf(objLeaseDigest[0].Transaction__r.TransactionProcessedDate__c);
			strApprovalComments = objLeaseDigest[0].Transaction__r.Comments__c;
			strTransactionID = objLeaseDigest[0].Transaction__c;
			strTransactionName = objLeaseDigest[0].Transaction__r.Name;
		}
     	
    }
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    @isTest(SeeAllData=false) Static void  testGLXY_FundApprover() {
    	Glxy_Lease__c ObjLease = new Glxy_Lease__c();
	       	ObjLease.StatusCode__c='Active';
	       	Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	       	Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
	       	ObjLease.BaseLeaseEffectiveDate__c = myDate;
	       	ObjLease.ExpirationDateofLease__c = myDate1;
	       	ObjLease.RegionCD__c = '1';
	       	ObjLease.Name = 'LVA0001';
	       	ObjLease.Total_NOA_Sq_feet__c=4444;
	       	ObjLease.Total_IA_Sq_feet__c=3333333;
	       	ObjLease.BaseAnnualRent__c = 1200;
	    insert ObjLease;
		System.Assert(ObjLease!=NULL);
		
		Glxy_StepRent__c objSR = new Glxy_StepRent__c (
            LeaseNumber__c = objLease.id,
            EffectiveDate__c = myDate,
            ProcessedDate__c = myDate.addyears(+1),
            IA_Sq_Ft__c =  0,
            NOA_Sq_Ft__c = 0,
            PaymentID__c = 12345678          
        );
       	insert objSR;
               		
		Glxy_Transaction__c objTest2 = new Glxy_Transaction__c (
            LeaseNumber__c = ObjLease.id,  
            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Lease Action').getRecordTypeId(), 
            BA53_User__c = 'test',
            Region__c = '01', 
            Name = 'T001',
            BA53Approver__c = 'TestUser@gsa.gov',
            TransactionProcessedDate__c = date.newinstance(Datetime.Now().Date().Year(), 2, 17)
        );
	    
	    insert objTest2;
        System.Assert(objTest2!=NULL);
        	
    	Glxy_LeaseDigest__c objTest3 = new Glxy_LeaseDigest__c (
        	Transaction__c = objTest2.ID,
        	Include_Accrual__c = 'YES',
        	ProjectNumber__c = 'P123456'
        );
        insert objTest3;
    	System.Assert(objTest3!=NULL);
    	
    	Glxy_LeasePayment__c objTest4 = new Glxy_LeasePayment__c(
    		Annual_Amount__c = 100,
    		Digest_ID__c = 10,
    		LeaseDigest__c = objTest3.ID,
    		PaymentID__c = 12345678,
    		WithHoldMonths__c = 1,
    		Name = '12345678'
    	);
    	Insert objTest4;
    	         	
    	GLXY_FundApprover objTest = new GLXY_FundApprover();
    	objtest.strFieldID = 'PaymentID__c';
    	objtest.strObjectID = 'Glxy_StepRent__c';
    	objtest.strRecordID = objSR.ID;
    	objTest.getFundApproverDetails();
    	
    	System.Debug (objTest.strBA53Approver);
    	System.Debug (objTest.strApprovedDate);
    	System.Debug (objTest.strApprovalComments);
    	System.Debug (objTest.strTransactionID);
    	
    	Glxy_LeaseProjects__c objProj = new Glxy_LeaseProjects__c (
			ProjectID__c = 'P123456',
			Name = 'P123456',
            EffectiveDate__c = myDate,
            AnnualRent__c=100        
        );
        insert objProj;
            
    	objtest.strRecordID = objProj.ID;
    	objTest.getFundApproverDetailsProj();
    }
    
}