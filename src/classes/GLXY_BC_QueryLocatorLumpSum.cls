global with sharing class GLXY_BC_QueryLocatorLumpSum implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
			
	global GLXY_BC_QueryLocatorLumpSum() { 
		pageindex = 0; 
		Integer IntCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		string strCurrentFY = String.ValueOf(IntCurrentFY);
		string strCurrentFY2 = String.ValueOf(intCurrentFY + 2);
		
		string query =   'Select LumpSum__r.LeaseNumber__r.Name LeaseNumber, Max(LumpSum__r.LeaseNumber__r.RegionCD__c) Region, Max(LumpSum__r.LeaseNumber__r.ExpirationDateofLease__c) LeaseExpirationDate, Max(LumpSum__r.LeaseNumber__r.TeamCode__c) TeamCode, FiscalYear__c FiscalYear, LumpSum__r.StatusCd__c StatusCode, Sum(FY_Obligation__c) AnnualAmount, Sum(FY_Obligation_IA__c) AnnualAmountIA, Sum(FY_Obligation_NOA__c) AnnualAmountNOA, ' +
						 '       Sum(JAN_IA__c) JANIA, Sum(FEB_IA__c) FEBIA, Sum(MAR_IA__c) MARIA, Sum(APR_IA__c) APRIA, Sum(MAY_IA__c) MAYIA, Sum(JUN_IA__c) JUNIA, Sum(JUL_IA__c) JULIA, Sum(AUG_IA__c) AUGIA, Sum(SEP_IA__c) SEPIA, Sum(OCT_IA__c) OCTIA, Sum(NOV_IA__c) NOVIA, Sum(DEC_IA__c) DECIA, ' +
                		 '       Sum(JAN_NOA__c) JANNOA, Sum(FEB_NOA__c) FEBNOA, Sum(MAR_NOA__c) MARNOA, Sum(APR_NOA__c) APRNOA, Sum(MAY_NOA__c) MAYNOA, Sum(JUN_NOA__c) JUNNOA, Sum(JUL_NOA__c) JULNOA, Sum(AUG_NOA__c) AUGNOA, Sum(SEP_NOA__c) SEPNOA, Sum(OCT_NOA__c) OCTNOA, Sum(NOV_NOA__c) NOVNOA, Sum(DEC_NOA__c) DECNOA ' + 
               			 'From   Glxy_LumpSumObligations__c ' +
 	 					 'Where  LumpSum__r.BDGFlag__c = true ' + 
 	 					 'And 	 LumpSum__r.LumSumType__c Not in (\'Tax Escalation\', \'Bid Tax\') ' + 
 	 					 //'And 	 LumpSum__r.LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                         //'And    LumpSum__r.LeaseNumber__r.Next_FY_Leases__c = False ' +
                         'AND    FiscalYear__c >= :strCurrentFY ' +
                         'AND    FiscalYear__c <= :strCurrentFY2 ' +
 	 					 'Group by  LumpSum__r.LeaseNumber__r.Name, FiscalYear__c, LumpSum__r.StatusCd__c ' +
 	 					 'ORDER BY  LumpSum__r.LeaseNumber__r.Name, FiscalYear__c, LumpSum__r.StatusCd__c ';
		System.debug('MyDebug = ' + query);
		DataPage = Database.query(query);             
	}
	
	global boolean hasNext(){  
		return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
	}
	
	global AggregateResult next(){
		return DataPage[pageindex++];
	}
	
}