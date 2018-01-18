global with sharing class GLXY_BC_QueryLocatorProject implements Iterator<AggregateResult> {
	
	AggregateResult [] DataPage {get;set;} 
	Integer pageindex {get; set;}  
			
	global GLXY_BC_QueryLocatorProject() { 
		pageindex = 0; 
		Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
		Integer intCurrentFY2 = intCurrentFY + 2;
		
		string query =   'Select NewLease__c LeaseNumber, Name, Max(RegionCD__c) Region, Max(eEorA__c) ProjectStatus, Max(TeamCode__c) TeamCode, DelegatedReturn__c DelegatedReturn, FISCAL_YEAR(IAConversionDate__c) IANOAConversionFY, ' + 
						 '       FISCAL_YEAR(ProcessedDate__c) FiscalYear, Sum(ChangeinNOASQFt__c) ChangeinNOASqFt, Sum(ChangeinIASQFt__c) ChangeinIASqFt, ' +
						 '       Sum(JAN_IA__c) JANIA, Sum(FEB_IA__c) FEBIA, Sum(MAR_IA__c) MARIA, Sum(APR_IA__c) APRIA, Sum(MAY_IA__c) MAYIA, Sum(JUN_IA__c) JUNIA, Sum(JUL_IA__c) JULIA, Sum(AUG_IA__c) AUGIA, Sum(SEP_IA__c) SEPIA, Sum(OCT_IA__c) OCTIA, Sum(NOV_IA__c) NOVIA, Sum(DEC_IA__c) DECIA, ' +
                		 '       Sum(JAN_NOA__c) JANNOA, Sum(FEB_NOA__c) FEBNOA, Sum(MAR_NOA__c) MARNOA, Sum(APR_NOA__c) APRNOA, Sum(MAY_NOA__c) MAYNOA, Sum(JUN_NOA__c) JUNNOA, Sum(JUL_NOA__c) JULNOA, Sum(AUG_NOA__c) AUGNOA, Sum(SEP_NOA__c) SEPNOA, Sum(OCT_NOA__c) OCTNOA, Sum(NOV_NOA__c) NOVNOA, Sum(DEC_NOA__c) DECNOA, ' + 
               			 '		 Sum(CancelARentIA__c) CancelAnnualRentIA, Sum(CancelARentNOA__c) CancelAnnualRentNOA, ' +
						 '		 Sum(CancelPYCostIA__c) CancelPartYearRentIA, Sum(CancelPYCostNOA__c) CancelPartYearRentNOA, ' +
						 '		 Sum(CancelSqFtIA__c) CancelSqFtIA, Sum(CancelSqFtNOA__c) CancelSqFtNOA, ' +
						 ' 		 Sum(EscalARentIA__c) EscalAnnualRentIA, Sum(EscalARentNOA__c) EscalAnnualRentNOA, ' + 
						 '		 Sum(EscalPYCostIA__c) EscalPartYearRentIA, Sum(EscalPYCostNOA__c) EscalPartYearRentNOA, ' +
						 '		 Sum(EscalSqFtIA__c) EscalSqFtIA, Sum(EscalSqFtNOA__c) EscalSqFtNOA, ' +
						 '		 Sum(ExpanARentIA__c) ExpanAnnualRentIA, Sum(ExpanARentNOA__c) ExpanAnnualRentNOA, ' +
						 '		 Sum(ExpanPYCostIA__c) ExpanPartYearRentIA, Sum(ExpanPYCostNOA__c) ExpanPartYearRentNOA, ' +
						 '		 Sum(ExpanSqFtIA__c) ExpanSqFtRentIA, Sum(ExpanSqFtNOA__c) ExpanSqFtRentNOA ' + 
               			 'From   Glxy_LeaseProjects__c ' +
 	 					 'Where  BDGFlag__c = true ' + 
 	 					 'And    ProjectStatus__c <> \'Cancelled\' ' +
 	 					 'And    eEorA__c in (\'Estimate\', \'Actual\') ' +
 	 					 'And    CheckCOApproval__c = false ' + 
 	 					 'AND    FISCAL_YEAR(ProcessedDate__c) >= :intCurrentFY ' +
                         'AND    FISCAL_YEAR(ProcessedDate__c) <= :intCurrentFY2 ' +
 	 					 'Group by NewLease__c, Name, FISCAL_YEAR(ProcessedDate__c), FISCAL_YEAR(IAConversionDate__c), DelegatedReturn__c ' +
 	 					 'ORDER BY NewLease__c, Name, FISCAL_YEAR(ProcessedDate__c), FISCAL_YEAR(IAConversionDate__c), DelegatedReturn__c ';
		DataPage = Database.query(query);             
	}
	
	global boolean hasNext(){  
		return DataPage != null && !DataPage.isEmpty() && pageindex < DataPage.size();  
	}
	
	global AggregateResult next(){
		return DataPage[pageindex++];
	}
	
}