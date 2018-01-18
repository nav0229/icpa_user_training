global with sharing class GLXY_BC_QueryLocatorAggregatorStepRent implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
			
	global GLXY_BC_QueryLocatorAggregatorStepRent() { 
		pageindex = 0; 
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		Integer intCurrentFY2 = intCurrentFY + 2;
		
		string query =   'Select LeaseNumber__r.Name LeaseNumber, Max(LeaseNumber__r.RegionCD__c) Region, Max(LeaseNumber__r.ExpirationDateofLease__c) LeaseExpirationDate, Max(LeaseNumber__r.IAConverstionFY__c) IANOAConversionDate, Max(LeaseNumber__r.TeamCode__c) TeamCode, FISCAL_YEAR(ProcessedDate__c) FiscalYear, StatusCode__c StatusCode, Sum(Amount__c) AnnualAmount, ' +
						 '		 Sum(IA_Sq_Ft__c) IASqFt, Sum(NOA_Sq_Ft__c) NOASqFt, ' +
						 '       Sum(JAN_IA__c) JANIA, Sum(FEB_IA__c) FEBIA, Sum(MAR_IA__c) MARIA, Sum(APR_IA__c) APRIA, Sum(MAY_IA__c) MAYIA, Sum(JUN_IA__c) JUNIA, Sum(JUL_IA__c) JULIA, Sum(AUG_IA__c) AUGIA, Sum(SEP_IA__c) SEPIA, Sum(OCT_IA__c) OCTIA, Sum(NOV_IA__c) NOVIA, Sum(DEC_IA__c) DECIA, ' +
                		 '       Sum(JAN_NOA__c) JANNOA, Sum(FEB_NOA__c) FEBNOA, Sum(MAR_NOA__c) MARNOA, Sum(APR_NOA__c) APRNOA, Sum(MAY_NOA__c) MAYNOA, Sum(JUN_NOA__c) JUNNOA, Sum(JUL_NOA__c) JULNOA, Sum(AUG_NOA__c) AUGNOA, Sum(SEP_NOA__c) SEPNOA, Sum(OCT_NOA__c) OCTNOA, Sum(NOV_NOA__c) NOVNOA, Sum(DEC_NOA__c) DECNOA ' + 
               			 'From   Glxy_StepRent__c ' +
 	 					 'Where  BDGFlag__c = true ' + 
 	 					 //'And 	 LeaseNumber__r.StatusCode__c = \'Active\' ' + 
                         //'And    LeaseNumber__r.Next_FY_Leases__c = False ' +
                         'AND    FISCAL_YEAR(ProcessedDate__c) >= :intCurrentFY ' +
                         'AND    FISCAL_YEAR(ProcessedDate__c) <= :intCurrentFY2 ' +
 	 					 'Group by LeaseNumber__r.Name, FISCAL_YEAR(ProcessedDate__c), StatusCode__c ' +
 	 					 'ORDER BY LeaseNumber__r.Name, FISCAL_YEAR(ProcessedDate__c), StatusCode__c ';
		DataPage = Database.query(query);             
	}
	
	global boolean hasNext(){  
		return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
	}
	
	global AggregateResult next(){
		return DataPage[pageindex++];
	}
	
}