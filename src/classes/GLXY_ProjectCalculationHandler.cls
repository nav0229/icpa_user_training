public with sharing class GLXY_ProjectCalculationHandler {

   public static void calculateFields(Map<Id,Glxy_LeaseProjects__c> newProjectValues, Map<Id,Glxy_LeaseProjects__c> oldProjectValues, boolean updateAction) {

        // Bulkify calculations
        Map<Id,Glxy_LeaseProjects__c> projectsWillBeUpdated = new Map<Id,Glxy_LeaseProjects__c>();
        
        for (Glxy_LeaseProjects__c curObject : newProjectValues.values()) {
            
            String strProjectType = curObject.Project_Type__c;
            //Declarations A - Z
            
           Map<String,Decimal> calcFields = new Map<String, Decimal> {
                    'EscalSqFtNOA__c' => 0, 'EscalARentNOA__c' => 0, 'EscalPYCostNOA__c' => 0, 
                    'EscalSqFtIA__c' => 0, 'EscalARentIA__c' => 0, 'EscalPYCostIA__c' => 0, 
                    'CancelSqFtNOA__c' => 0, 'CancelARentNOA__c' => 0, 'CancelPYCostNOA__c' => 0, 
                    'CancelSqFtIA__c' => 0, 'CancelARentIA__c' => 0, 'CancelPYCostIA__c' => 0, 
                    'ExpanSqFtNOA__c' => 0, 'ExpanARentNOA__c' => 0, 'ExpanPYCostNOA__c' => 0, 
                    'ExpanSqFtIA__c' => 0, 'ExpanARentIA__c' => 0, 'ExpanPYCostIA__c' => 0, 
                    'Total_IA_PYC__c' => 0, 'Total_NOA_PYC__c' => 0, 'CY_Obligation_IA__c' => 0, 
                    'CY_Obligation_NOA__c' => 0, 'ExpanPYCostTotal__c' => 0, 'Total_Impact_on_Total_year_Obligation__c' => 0, 
                    'AccrualAmt__c' => 0, 'Old_Square_Feet__c' => 0, 'OldRate__c' => 0,
                    'SquareFeet__c' => 0, 'NewRate__c' => 0, 'AccrualAmountEffectiveMonthRate__c' => 0};
            Decimal newNOAOrParkSqFt = 0;
            Decimal oldNOAOrParkSqFt = 0;
            Decimal newIAOrParkSqFt = 0;
            Decimal oldIAOrParkSqFt = 0;
            Decimal newParking = 0;
            Decimal oldParking = 0;
            Decimal newAntenna = 0;
            Decimal oldAntenna = 0;
            Decimal newLand = 0;
            Decimal oldLand = 0;
            
            Map<String, Integer> dateCalcs = new Map<String,Integer> {'calcDayDiff' => 0, 'calcDaysInMonth' => 0};
            Integer numEffectiveMonth;
               
            //Initializations A - Z
            String ParkingOnly = 'No';
            String AntennaOnly = 'No';
            String LandOnly = 'No';

            //Parking-Only, Antenna, Land Only
            newParking = curObject.BaseStructParkSpaces__c + curObject.BaseSurfParkSpaces__c;
            newAntenna = curObject.Antennas__c;
            newLand = curObject.AnnualRent__c;
           	
           	oldParking = curObject.OBaseStructParkSpaces__c + curObject.OBaseSurfParkSpaces__c;
            oldAntenna = curObject.OAntennas__c;
            oldLand = curObject.Old_Annual_Rent__c;
            
            System.Debug('MyDebug - Project ID = ' + curObject.ProjectID__c);
            System.Debug('MyDebug - newParking = ' + newParking);
			System.Debug('MyDebug - oldParking = ' + oldParking);
			
            /* A Lease is a Parking Only Lease if:
            New Lease --> New Parking > 0, New Sqft = 0, Old Parking = 0, Old Sqft = 0
            Change in Lease --> New Parking > 0, New Sqft = 0, Old Parking > 0, Old Sqft = 0
            Terminating Lease --> New Parking = 0, New Sqft = 0, Old Parking > 0, Old Sqft = 0
            */
        	If (curObject.SquareFeet__c > 0 || curObject.NOASquareFeet__c > 0 || curObject.OldNOASqFt__c > 0 || curObject.IASquareFeet__c > 0 || curObject.OldIASqFt__c > 0){
     			//Sq. Ft. Lease Project
     			newNOAOrParkSqFt = curObject.NOASquareFeet__c;
                oldNOAOrParkSqFt = curObject.OldNOASqFt__c;
                newIAOrParkSqFt = curObject.IASquareFeet__c;
                oldIAOrParkSqFt = curObject.OldIASqFt__c;
                calcFields.put('Old_Square_Feet__c', curObject.OldIASqFt__c + curObject.OldNOASqFt__c);
                calcFields.put('SquareFeet__c', curObject.SquareFeet__c);
                if (curObject.SquareFeet__c == 0){
                    calcFields.put('SquareFeet__c', curObject.IASquareFeet__c + curObject.NOASquareFeet__c); //G2 Release 2.2; do not auto-calculate.
                }
        	} else If(newParking > 0 || oldParking > 0 ){
              	//Parking Only Lease Project
                ParkingOnly = 'Yes';
                If (newParking >= OldParking){
	            	newNOAOrParkSqFt = curObject.OBaseStructParkSpaces__c + curObject.OBaseSurfParkSpaces__c;
		            oldNOAOrParkSqFt = curObject.OBaseStructParkSpaces__c + curObject.OBaseSurfParkSpaces__c;
		            newIAOrParkSqFt = (curObject.BaseStructParkSpaces__c + curObject.BaseSurfParkSpaces__c) - (curObject.OBaseStructParkSpaces__c + curObject.OBaseSurfParkSpaces__c);
		            oldIAOrParkSqFt = 0;
	            }else{
	            	newNOAOrParkSqFt = curObject.BaseStructParkSpaces__c + curObject.BaseSurfParkSpaces__c;
		            oldNOAOrParkSqFt = curObject.OBaseStructParkSpaces__c + curObject.OBaseSurfParkSpaces__c;
		            newIAOrParkSqFt = 0;
		            oldIAOrParkSqFt = 0;	
	            } 
	            calcFields.put('Old_Square_Feet__c', oldParking);
	            calcFields.put('SquareFeet__c', NewParking);
	        } else If(newAntenna > 0 || oldAntenna > 0 ){
	        	//Antenna Only Lease Project
				AntennaOnly = 'Yes';
	            If (newAntenna >= oldAntenna){
	            	newNOAOrParkSqFt = curObject.OAntennas__c;
		            oldNOAOrParkSqFt = curObject.OAntennas__c;
		            newIAOrParkSqFt = (curObject.Antennas__c - curObject.OAntennas__c);
		            oldIAOrParkSqFt = 0;
	            }else{
	            	newNOAOrParkSqFt = curObject.Antennas__c;
		            oldNOAOrParkSqFt = curObject.OAntennas__c;
		            newIAOrParkSqFt = 0;
		            oldIAOrParkSqFt = 0;	
	            }  
	            calcFields.put('Old_Square_Feet__c', oldAntenna);
	            calcFields.put('SquareFeet__c', NewAntenna);
             } else If(newLand > 0 || oldLand > 0 ){
               // Land Only Lease Project
				LandOnly = 'Yes';
	            If (newLand >= oldLand){
	            	newNOAOrParkSqFt = 1;
		            oldNOAOrParkSqFt = 1;
		            newIAOrParkSqFt = (curObject.AnnualRent__c - curObject.Old_Annual_Rent__c)/(curObject.Old_Annual_Rent__c == 0 ? 1 : curObject.Old_Annual_Rent__c);
		            oldIAOrParkSqFt = 0;
		            calcFields.put('Old_Square_Feet__c', 1);
		            calcFields.put('SquareFeet__c', (1 + newIAOrParkSqFt));
	            }else{
	            	newNOAOrParkSqFt = (curObject.Old_Annual_Rent__c - curObject.AnnualRent__c)/(curObject.Old_Annual_Rent__c == 0 ? 1 : curObject.Old_Annual_Rent__c);
		            oldNOAOrParkSqFt = 1;
		            newIAOrParkSqFt = 0;
		            oldIAOrParkSqFt = 0;
		            calcFields.put('Old_Square_Feet__c', 1);
		            calcFields.put('SquareFeet__c', newNOAOrParkSqFt);	
	            }  
            }
            
            /*//Old Rate        
            if(parkingOnly.equalsIgnoreCase('No')) {
                if(calcFields.get('Old_Square_Feet__c') > 0) {
                    calcFields.put('OldRate__c', curObject.Old_Annual_Rent__c/calcFields.get('Old_Square_Feet__c'));
                }
            } else {
                calcFields.put('OldRate__c', curObject.Old_Annual_Rent__c * (calcFields.get('Old_Square_Feet__c') > -1 ? 1 : -1) / (calcFields.get('Old_Square_Feet__c') == 0 ? 1 : calcFields.get('Old_Square_Feet__c')));
           	}*/
            
            //Old Rate
            calcFields.put('OldRate__c', curObject.Old_Annual_Rent__c * (calcFields.get('Old_Square_Feet__c') > -1 ? 1 : -1) / (calcFields.get('Old_Square_Feet__c') == 0 ? 1 : calcFields.get('Old_Square_Feet__c')));
            //New rate
            calcFields.put('NewRate__c', curObject.AnnualRent__c * (calcFields.get('SquareFeet__c') > -1 ? 1 : -1) / (calcFields.get('SquareFeet__c') == 0 ? 1 : calcFields.get('SquareFeet__c')));
            
            Decimal diffRate = calcFields.get('NewRate__c') - calcFields.get('OldRate__c');
            
            //Escalation Sq Ft NOA
            calcFields.put('EscalSqFtNOA__c', oldNOAOrParkSqFt <= newnoaOrParkSqFt? oldNOAOrParkSqFt : newnoaOrParkSqFt);
            
            //Escalation Annual Rent NOA
            calcFields.put('EscalARentNOA__c', calcFields.get('EscalSqFtNOA__c') * diffRate);
            
            //Escalation Sq Ft IA
            //calcFields.put('EscalSqFtIA__c', curObject.OldIASqFt__c <= curObject.IASquareFeet__c ? curObject.OldIASqFt__c : curObject.IASquareFeet__c);
            calcFields.put('EscalSqFtIA__c', oldIAOrParkSqFt <= newIAOrParkSqFt? oldIAOrParkSqFt : newIAOrParkSqFt);
            
            //Escalation Annual Rent IA
            calcFields.put('EscalARentIA__c', calcFields.get('EscalSqFtIA__c') * diffRate);
            
            //Cancellation Sq Ft NOA
            calcFields.put('CancelSqFtNOA__c',  newnoaOrParkSqFt < oldNOAOrParkSqFt ? newnoaOrParkSqFt - oldNOAOrParkSqFt : 0);
            
            //Cancellation Annual Rent NOA
            calcFields.put('CancelARentNOA__c', calcFields.get('CancelSqFtNOA__c') * calcFields.get('OldRate__c'));
            
            //Cancellation Sq Ft IA
            //calcFields.put('CancelSqFtIA__c',  curObject.IASquareFeet__c < curObject.OldIASqFt__c ? (curObject.IASquareFeet__c - curObject.OldIASqFt__c) : 0);
            calcFields.put('CancelSqFtIA__c',  newIAOrParkSqFt < oldIAOrParkSqFt ? newIAOrParkSqFt - oldIAOrParkSqFt : 0);
            
            //Cancellation Annual Rent IA
            calcFields.put('CancelARentIA__c', calcFields.get('CancelSqFtIA__c') * calcFields.get('OldRate__c'));
            
            //Expansion Sq Ft NOA
            calcFields.put('ExpanSqFtNOA__c', newnoaOrParkSqFt > oldNOAOrParkSqFt ? newnoaOrParkSqFt  - oldNOAOrParkSqFt : 0);
            
            //Expansion Annual Rent NOA
            calcFields.put('ExpanARentNOA__c', calcFields.get('ExpanSqFtNOA__c') * calcFields.get('NewRate__c'));
            
            //Expansion Sq Ft IA
            //calcFields.put('ExpanSqFtIA__c', curObject.IASquareFeet__c > curObject.OldIASqFt__c ? (curObject.IASquareFeet__c - curObject.OldIASqFt__c) : 0);
            calcFields.put('ExpanSqFtIA__c', newIAOrParkSqFt > oldIAOrParkSqFt ? newIAOrParkSqFt  - oldIAOrParkSqFt : 0);
            
            //Expansion Annual Rent IA
            calcFields.put('ExpanARentIA__c', calcFields.get('ExpanSqFtIA__c') * calcFields.get('NewRate__c'));
            
            
            Map<Integer,Decimal> monthlyNOA = new Map<Integer,Decimal>{1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11=> 0, 12 => 0};
            Map<Integer,Decimal> monthlyIA = new Map<Integer,Decimal>{1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11=> 0, 12 => 0};
            
            
            // Ensure EffectiveDate is populated for the below calculations
            if (curObject.EffectiveDate__c != null){
            
                Date calcEdate = curObject.EffectiveDate__c;
                Integer dayEffective = calcEdate.day();
                Integer monthEffective = calcEdate.month();
                Integer calcFiscalYr = (monthEffective > 9) ? (calcEdate.year() + 1) : calcEdate.year();
                //Galaxy 1.1 - Accrual Calculations -  Find remaining days in Month
                Integer calcDaysInMonth = date.daysInMonth(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month());
                Integer calcDayDiff = curObject.EffectiveDate__c.daysBetween(date.newInstance(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month(), calcDaysInMonth)) + 1;
                //Galaxy 1.1 - Accrual Calculations -  Find remaining days in Month
                Boolean blnProcessedDateReset = false;
                    
                if(curObject.ProcessedDateFY__c != null) {
                    if(calcFiscalYr < integer.valueOf(curObject.ProcessedDateFY__c)) {
                        calcFiscalYr = integer.valueOf(curObject.ProcessedDateFY__c);
                        dayEffective = 1;
                        monthEffective = 10;
                        calcEdate = date.newInstance(calcFiscalYr-1, 10, 1);
                        blnProcessedDateReset = true;
                    }
                }
                
                Date today = datetime.now().date();
                
                
                Integer todayFY = (today.month() > 9) ? (today.year() + 1) : today.year();
                Date calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);
                
                dateCalcs.put('calcDaysInMonth', date.daysInMonth(calcEdate.year(), monthEffective));
                dateCalcs.put('calcDayDiff', calcEdate.daysBetween(date.newInstance(calcEdate.year(), monthEffective, dateCalcs.get('calcDaysInMonth')))+1);
                
                numEffectiveMonth = calcEdate.monthsBetween(calcYearEnd);
                
                //Escalation PY Cost NOA
                calcFields.put('EscalPYCostNOA__c', (calcFields.get('EscalARentNOA__c')/12) * numEffectiveMonth + ((calcFields.get('EscalARentNOA__c')/12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
                
                //Escalation PY Cost IA
                calcFields.put('EscalPYCostIA__c', (calcFields.get('EscalARentIA__c')/12) * numEffectiveMonth + ((calcFields.get('EscalARentIA__c')/12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
            
                //Cancellation Past Year Cost NOA
                if(strProjectType != null && strProjectType.equalsIgnoreCase('Termination') && !blnProcessedDateReset) {
                    calcFields.put('CancelPYCostNOA__c', (calcFields.get('CancelARentNOA__c') / 12) * numEffectiveMonth + ((calcFields.get('CancelARentNOA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*(dateCalcs.get('calcDayDiff')-1));
                } else {
                    calcFields.put('CancelPYCostNOA__c', (calcFields.get('CancelARentNOA__c') / 12) * numEffectiveMonth + ((calcFields.get('CancelARentNOA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
                }
                
                //Cancellation Past Year Cost IA
                if(strProjectType != null && strProjectType.equalsIgnoreCase('Termination') && !blnProcessedDateReset) {
                    calcFields.put('CancelPYCostIA__c', (calcFields.get('CancelARentIA__c') / 12) * numEffectiveMonth + ((calcFields.get('CancelARentIA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*(dateCalcs.get('calcDayDiff')-1));                 
                } else {
                    calcFields.put('CancelPYCostIA__c', (calcFields.get('CancelARentIA__c') / 12) * numEffectiveMonth + ((calcFields.get('CancelARentIA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff')); 
                }
                            
                //Expansion Past Year Cost NOA
                calcFields.put('ExpanPYCostNOA__c', (calcFields.get('ExpanARentNOA__c') / 12) * numEffectiveMonth + ((calcFields.get('ExpanARentNOA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
            
                //Expansion Past Year Cost IA
                calcFields.put('ExpanPYCostIA__c', (calcFields.get('ExpanARentIA__c') / 12) * numEffectiveMonth + ((calcFields.get('ExpanARentIA__c') / 12)/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
                
                //Total IA PYC
                calcFields.put('Total_IA_PYC__c', calcFields.get('ExpanPYCostIA__c') + calcFields.get('EscalPYCostIA__c') + calcFields.get('CancelPYCostIA__c'));
                
                //Total NOA PYC
                calcFields.put('Total_NOA_PYC__c', calcFields.get('ExpanPYCostNOA__c') + calcFields.get('EscalPYCostNOA__c') + calcFields.get('CancelPYCostNOA__c'));
                
                //Expansion Part Year Cost Total
                calcFields.put('ExpanPYCostTotal__c', calcFields.get('ExpanPYCostNOA__c') + calcFields.get('ExpanPYCostIA__c'));
                
                //Effective Month Accrual Rate
                calcFields.put('AccrualAmountEffectiveMonthRate__c', ((calcFields.get('EscalARentNOA__c') + calcFields.get('EscalARentIA__c') + calcFields.get('CancelARentNOA__c') + calcFields.get('CancelARentIA__c') + calcFields.get('ExpanARentNOA__c') + calcFields.get('ExpanARentIA__c'))/12)/Date.daysInMonth(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month()));
                
                Map<Integer, Integer> compareMonths = 
                    new Map<Integer, Integer> {
                        1 => date.newInstance(calcFiscalYr, 1, 1).monthsBetween(calcYearEnd)+1,
                        2 => date.newInstance(calcFiscalYr, 2, 1).monthsBetween(calcYearEnd)+1,
                        3 => date.newInstance(calcFiscalYr, 3, 1).monthsBetween(calcYearEnd)+1,
                        4 => date.newInstance(calcFiscalYr, 4, 1).monthsBetween(calcYearEnd)+1,
                        5 => date.newInstance(calcFiscalYr, 5, 1).monthsBetween(calcYearEnd)+1,
                        6 => date.newInstance(calcFiscalYr, 6, 1).monthsBetween(calcYearEnd)+1,
                        7 => date.newInstance(calcFiscalYr, 7, 1).monthsBetween(calcYearEnd)+1,
                        8 => date.newInstance(calcFiscalYr, 8, 1).monthsBetween(calcYearEnd)+1,
                        9 => date.newInstance(calcFiscalYr, 9, 1).monthsBetween(calcYearEnd)+1,
                        10 => date.newInstance(calcFiscalYr - 1, 10, 1).monthsBetween(calcYearEnd)+1,
                        11 => date.newInstance(calcFiscalYr - 1, 11, 1).monthsBetween(calcYearEnd)+1,
                        12 => date.newInstance(calcFiscalYr - 1, 12, 1).monthsBetween(calcYearEnd)+1
                    };
                
                Decimal monIA = (calcFields.get('EscalARentIA__c') + calcFields.get('CancelARentIA__c') + calcFields.get('ExpanARentIA__c')) / 12;
                Decimal monNOA = (calcFields.get('EscalARentNOA__c') + calcFields.get('CancelARentNOA__c') + calcFields.get('ExpanARentNOA__c')) / 12;
                
                
                for (Integer i=1; i<=12; i++) {
                   
                    //system.debug('**********   i =' + i + ', compareMonths = ' + compareMonths.get(i) + ', numEffectiveMonth = ' + numEffectiveMonth); 
                    if (compareMonths.get(i) <= numEffectiveMonth+1 && compareMonths.get(i) > 0) {
                        if (i == monthEffective) {
                            if(strProjectType != null && strProjectType.equalsIgnoreCase('Termination') && !blnProcessedDateReset) {
                                monthlyNOA.put(i, (monNOA/dateCalcs.get('calcDaysInMonth'))*(dateCalcs.get('calcDayDiff') - 1));
                                monthlyIA.put(i, (monIA/dateCalcs.get('calcDaysInMonth'))*(dateCalcs.get('calcDayDiff') - 1));
                            } else {
                                monthlyNOA.put(i, (monNOA/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
                                monthlyIA.put(i, (monIA/dateCalcs.get('calcDaysInMonth'))*dateCalcs.get('calcDayDiff'));
                            }   
                        } else {
                            monthlyNOA.put(i, monNOA);
                            monthlyIA.put(i, monIA);
                        }     
                        
                    }
                    
                    //CY Obligation IA
                    calcFields.put('CY_Obligation_IA__c', calcFields.get('CY_Obligation_IA__c') + monthlyIA.get(i));
                    
                    //CY Obligation NOA
                    calcFields.put('CY_Obligation_NOA__c', calcFields.get('CY_Obligation_NOA__c') + monthlyNOA.get(i));
                       
                }
                
                //Total Impact on Total year Obligation
                calcFields.put('Total_Impact_on_Total_year_Obligation__c', calcFields.get('CY_Obligation_NOA__c') + calcFields.get('CY_Obligation_IA__c') + curObject.DoubleRent__c);
                
                //Accrual Amount
                
                Glxy_LeaseProjects__c beforeUpdate;
                Boolean calcAccural = false;
                
                if (updateAction) {
                    beforeUpdate = oldProjectValues.get(curObject.Id);
                }
                
                //Galaxy Release 1.0
                //if(todayFY != calcFiscalYr && todayFY > calcFiscalYr) {
                //Galaxy Release 1.1
               if(curObject.ProcessedDateFY__c != curObject.EffectiveDateFY__c && curObject.ProcessedDateFY__c > curObject.EffectiveDateFY__c) {
                     calcAccural = true;   
                    /*if(beforeUpdate == null) {
                        if(curObject.eEorA__c.equalsIgnoreCase('Estimate')) {
                            calcAccural = true;    
                        }
                     } else {
                        if(curObject.eEorA__c.equalsIgnoreCase('Estimate') || beforeUpdate.eEorA__c.equalsIgnoreCase('Estimate')) {
                            calcAccural = true;
                        }
                    }*/
                }
                
                if (calcAccural) {
                     // Release 1.0
                     //calcFields.put('AccrualAmt__c', (curObject.EffectiveDate__c.monthsBetween(date.newInstance(todayFY-1, 9, 30))) * (monNOA + monIA) 
                     //                                       + ((monNOA+monIA)/dateCalcs.get('calcDaysInMonth')) * dateCalcs.get('calcDayDiff'));
                     //Release 1.1
                     calcFields.put('AccrualAmt__c', (curObject.EffectiveDate__c.monthsBetween(date.newInstance(Integer.valueOf(curObject.EffectiveDateFY__c), 9, 30))) * (monNOA + monIA) 
                                    + ((monNOA + monIA)/calcDaysInMonth) * calcDayDiff);
                }
            }
            
            If (ParkingOnly == 'Yes' || AntennaOnly == 'Yes' || LandOnly == 'Yes'){
            	// re-assign all the Sq Ft to 0. they dont apply other than for calculations. To debug, comment this entire if block.
            	calcFields.put('EscalSqFtNOA__c', 0);
				calcFields.put('EscalSqFtIA__c', 0);
				calcFields.put('CancelSqFtNOA__c', 0);
				calcFields.put('CancelSqFtIA__c', 0);
				calcFields.put('ExpanSqFtNOA__c', 0);
				calcFields.put('ExpanSqFtIA__c', 0);
				calcFields.put('SquareFeet__c', 0);
				calcFields.put('Old_Square_Feet__c', 0);
            }
            
            projectsWillBeUpdated.put(curObject.Id, 
                new Glxy_LeaseProjects__c(
                    Id = curObject.Id,
                    Old_Square_Feet__c = calcFields.get('Old_Square_Feet__c'),
                    OldRate__c = calcFields.get('OldRate__c'),
                    SquareFeet__c = calcFields.get('SquareFeet__c'),
                    NewRate__c = calcFields.get('NewRate__c'),
                    ParkingOnly__c = parkingOnly, 
                    EscalSqFtNOA__c = calcFields.get('EscalSqFtNOA__c'), 
                    EscalARentNOA__c = calcFields.get('EscalARentNOA__c'), 
                    EscalPYCostNOA__c = calcFields.get('EscalPYCostNOA__c'), 
                    EscalSqFtIA__c = calcFields.get('EscalSqFtIA__c'), 
                    EscalARentIA__c = calcFields.get('EscalARentIA__c'), 
                    EscalPYCostIA__c = calcFields.get('EscalPYCostIA__c'), 
                    CancelSqFtNOA__c = calcFields.get('CancelSqFtNOA__c'), 
                    CancelARentNOA__c = calcFields.get('CancelARentNOA__c'), 
                    CancelPYCostNOA__c = calcFields.get('CancelPYCostNOA__c'), 
                    CancelSqFtIA__c = calcFields.get('CancelSqFtIA__c'), 
                    CancelARentIA__c = calcFields.get('CancelARentIA__c'), 
                    CancelPYCostIA__c = calcFields.get('CancelPYCostIA__c'), 
                    ExpanSqFtNOA__c = calcFields.get('ExpanSqFtNOA__c'), 
                    ExpanARentNOA__c = calcFields.get('ExpanARentNOA__c'), 
                    ExpanPYCostNOA__c = calcFields.get('ExpanPYCostNOA__c'), 
                    ExpanSqFtIA__c = calcFields.get('ExpanSqFtIA__c'), 
                    ExpanARentIA__c = calcFields.get('ExpanARentIA__c'), 
                    ExpanPYCostIA__c = calcFields.get('ExpanPYCostIA__c'), 
                    Total_IA_PYC__c = calcFields.get('Total_IA_PYC__c'), 
                    Total_NOA_PYC__c = calcFields.get('Total_NOA_PYC__c'), 
                    CY_Obligation_IA__c = calcFields.get('CY_Obligation_IA__c'), 
                    CY_Obligation_NOA__c = calcFields.get('CY_Obligation_NOA__c'), 
                    ExpanPYCostTotal__c = calcFields.get('ExpanPYCostTotal__c'), 
                    Total_Impact_on_Total_year_Obligation__c = calcFields.get('Total_Impact_on_Total_year_Obligation__c'), 
                    AccrualAmt__c = calcFields.get('AccrualAmt__c'), 
                    AccrualAmountEffectiveMonthRate__c =calcFields.get('AccrualAmountEffectiveMonthRate__c') ,
                    OCT_NOA__c = monthlyNOA.get(10), 
                    NOV_NOA__c = monthlyNOA.get(11), 
                    DEC_NOA__c = monthlyNOA.get(12), 
                    JAN_NOA__c = monthlyNOA.get(1), 
                    FEB_NOA__c = monthlyNOA.get(2), 
                    MAR_NOA__c = monthlyNOA.get(3), 
                    APR_NOA__c = monthlyNOA.get(4), 
                    MAY_NOA__c = monthlyNOA.get(5), 
                    JUN_NOA__c = monthlyNOA.get(6), 
                    JUL_NOA__c = monthlyNOA.get(7), 
                    AUG_NOA__c = monthlyNOA.get(8), 
                    SEP_NOA__c = monthlyNOA.get(9), 
                    OCT_IA__c = monthlyIA.get(10), 
                    NOV_IA__c = monthlyIA.get(11), 
                    DEC_IA__c = monthlyIA.get(12), 
                    JAN_IA__c = monthlyIA.get(1), 
                    FEB_IA__c = monthlyIA.get(2), 
                    MAR_IA__c = monthlyIA.get(3), 
                    APR_IA__c = monthlyIA.get(4), 
                    MAY_IA__c = monthlyIA.get(5), 
                    JUN_IA__c = monthlyIA.get(6), 
                    JUL_IA__c = monthlyIA.get(7), 
                    AUG_IA__c = monthlyIA.get(8), 
                    SEP_IA__c = monthlyIA.get(9)
                )
            );
        }
        System.Debug('****************projectsWillBeUpdated.size() is ' + projectsWillBeUpdated.size());
        // Update projects if we have any
        if (projectsWillBeUpdated.size() > 0 ) {
            
            // Set a static variable to avoid recursive trigger
            GLXY_Utility.setCalcUpdating();
            
            // Update all values and skip records that have an error
            // Do not fail for records that have an error.
            Database.update(projectsWillBeUpdated.values(), false); 
        }
    }
    
}