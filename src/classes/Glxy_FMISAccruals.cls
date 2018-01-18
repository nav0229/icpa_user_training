public with sharing class Glxy_FMISAccruals {
	
	Public List<Glxy_FMISVATObligation__c> PDNRecords {get;set;}
    private final Glxy_Transaction__c ObjTransaction;
    Public String strLeaseNumber {get; set;}
    Public String strMessage {get; set;}
    Public String strRegion {get; set;}
    Public String strFMISLeaseNumber {get; set;}
    
    public Glxy_FMISAccruals(ApexPages.StandardController controller) {
        ObjTransaction = (Glxy_Transaction__c)controller.getRecord();
        strLeaseNumber = [Select LeaseNumber__c From Glxy_Transaction__c where ID = :ObjTransaction.ID Limit 1].LeaseNumber__c;
        strRegion = [Select RegionCD__c From Glxy_Lease__c where ID = :strLeaseNumber].RegionCD__c;
        strLeaseNumber = [Select Name From Glxy_Lease__c where ID = :strLeaseNumber].Name;
        if (strRegion.length() == 1){strRegion = '0' + strRegion;}
        strFMISLeaseNumber = strRegion + 'B' + strLeaseNumber.Right(5); //Convert to FMIS Lease Number
    }
    
    Public Glxy_FMISVATObligation__c[] GetPDNForlease() {
       String strType1 = 'LY%';
       String strType2 = 'LR%';
       String strType3 = 'LU%';
       PDNRecords = Database.query('select ACTG_PERIOD__c, AMT__c, BUDGET_ACTVTY_CD__c, DESCRIPTION__c, FUNC_CD__c, Function_Name__c, FUND_CD__c, PEG_DOC_NUM__c, REGION_CD__c, SEQ_NO__c, TITLE__c, TT__c, DTYP__c from Glxy_FMISVATObligation__c Where LEASE_NO__c = :strFMISLeaseNumber And (PEG_DOC_NUM__c Like :strType1 OR PEG_DOC_NUM__c Like :strType2 OR PEG_DOC_NUM__c Like :strType3)');
        if (PDNRecords.size() > 0){
            strMessage = 'The accruals shown below have been established in FMIS for Lease ' + strLeaseNumber + '.';
            Return PDNRecords;
            //return null;
         }else{
            strMessage = 'There are no accruals established in FMIS for Lease ' + strLeaseNumber + '.';
            return null;
         }
    }
    
    @isTest(SeeAllData=false) Static void  TestGlxy_FMISAccruals() {
			Glxy_Lease__c ObjLease = new Glxy_Lease__c();
	       	ObjLease.StatusCode__c='Active';
	       	Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	       	Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
	       	ObjLease.BaseLeaseEffectiveDate__c=myDate ;
	       	ObjLease.ExpirationDateofLease__c=myDate1 ;
	       	ObjLease.RegionCD__c = '1';
	       	ObjLease.Name = 'LVA0001';
	       	ObjLease.Total_NOA_Sq_feet__c=4444;
	       	ObjLease.Total_IA_Sq_feet__c=3333333;
	       	ObjLease.BaseAnnualRent__c = 1200;
	       	insert ObjLease;
			System.Assert(ObjLease!=NULL);
			
			Glxy_Transaction__c objTest2 = new Glxy_Transaction__c (
	            LeaseNumber__c = ObjLease.id,  
	            RecordTypeId = Schema.SObjectType.Glxy_Transaction__c.getRecordTypeInfosByName().get('Lease Action').getRecordTypeId(), 
	            BA53_User__c = 'test',
	            Region__c = '01'
	        );
	        insert objTest2;
        	System.Assert(objTest2!=NULL);
        	
	        Glxy_LeaseDigest__c objTest3 = new Glxy_LeaseDigest__c (
	        	Transaction__c = objTest2.ID,
	        	Include_Accrual__c = 'YES'
	        );
	        insert objTest3;
        	System.Assert(objTest3!=NULL);
        	
        	Glxy_LeaseDigest__c objTest4 = new Glxy_LeaseDigest__c (
	        	Transaction__c = objTest2.ID,
	        	Include_Accrual__c = 'YES'
	        );
	        insert objTest4;
        	System.Assert(objTest4!=NULL);
        	
         	List<Glxy_LeaseAccrual__c> objLeaseAccrualRecords = New List<Glxy_LeaseAccrual__c>();
        	 
	        Glxy_LeaseAccrual__c objTest31 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest3.id,
	        	PDN__C = 'PDN'
	        );
	        objLeaseAccrualRecords.Add(objTest31);
	        
	         Glxy_LeaseAccrual__c objTest32 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest3.id,
	        	PDN__C = 'PDN2'
	        );
	        objLeaseAccrualRecords.Add(objTest32);

	        Glxy_LeaseAccrual__c objTest41 = New Glxy_LeaseAccrual__c(
	        	LeaseDigest__c = objTest4.id,
	        	PDN__C = 'PDN'
	        );
	        objLeaseAccrualRecords.Add(objTest41);
	        
	        Insert objLeaseAccrualRecords;
	        
	        Glxy_FMISVATObligation__c objVat = New Glxy_FMISVATObligation__c(
	        	TITLE__c = 'LVA0001',
	        	LEASE_NO__c = '01B0001',
	        	PEG_DOC_NUM__c = 'LY1000',
	        	AMT__C = 100
	        );
	        
	        Insert objVat;
	        
	        ApexPages.StandardController con = new ApexPages.StandardController(objTest2);
	        Glxy_FMISAccruals objTesta = new Glxy_FMISAccruals(con);
	        objTesta.GetPDNForlease();
	        
	        Delete objVat;
	        objTesta.GetPDNForlease();
		}
    
}