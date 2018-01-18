trigger GLXY_LPStepRentTrigger on Glxy_LPStepRent__c (before delete, before insert, before update) {
	
	if(Trigger.isDelete){
		/*List<string> profileNameList = new List<string>();
		profileNamelist.add('GSA System Administrator');
        profileNamelist.add('System Administrator');
        
		Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
		string adminUser= [select id from user where name='CastIron User'].id;
		string RexusRecordType=Schema.SObjectType.Glxy_LPStepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		
        system.debug(adminUser);
        system.debug(adminProfileMap);        
        system.debug(RexusRecordType);
		
		for(Glxy_LPStepRent__c pi:trigger.old ){
			if(pi.RecordTypeid==RexusRecordType){
				if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null){continue;}
           		pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');
           	}
        }*/
	}else{
		
		Set<Id> projectIds = new Set<Id>();
		for(Glxy_LPStepRent__c sr: trigger.new) {
			projectIds.add(sr.ProjectNumber__c);
        }
		
		Map<Id,Glxy_LeaseProjects__c> projects =  new Map<Id,Glxy_LeaseProjects__c> ([Select id,
                                      ParkingOnly__c,
                                      BaseStructParkSpaces__c,
                                      BaseSurfParkSpaces__c,
                                      IAConversionDate__c,
                                      ProcessedDate__c,
                                      NOASquareFeet__c,// RexusNewNOASqFt__c,
                                      IASquareFeet__c  //RexusNewIASqFt__c
                                      from Glxy_LeaseProjects__c where id IN :projectIds]);
                                      
                                      
		for (Glxy_LPStepRent__c curObject: trigger.new) {
			// Ensure EffectiveDate is populated
            if (curObject.EffectiveDate__c != null) {
            	Date calcYearEnd;
                Decimal noaOrParkSqFt;
                Decimal iaSqFt;
                Glxy_LeaseProjects__c project;
                Integer calcDayDiff;
                Integer calcDaysInMonth;
                Integer calcMonthDiff;
                Integer compareMonths;
                List<Decimal> monthlyNOA = new Decimal[12];
                List<Decimal> monthlyIA = new Decimal[12];            	
                Decimal monIA;
                Decimal monNOA;

                Date calcEdate = curObject.EffectiveDate__c;
                Integer calcFiscalYr = (calcEdate.month() > 9) ? (calcEdate.year() + 1) : calcEdate.year();
                if(curObject.ProcessedDateFY__c != null) {
                    if(calcFiscalYr < integer.valueOf(curObject.ProcessedDateFY__c)) {
                        calcFiscalYr = integer.valueOf(curObject.ProcessedDateFY__c);
                        calcEdate = date.newInstance(calcFiscalYr-1, 10, 1);
                    }
                }
                calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);
                calcDaysInMonth = date.daysInMonth(calcEdate.year(), calcEdate.month());
                calcMonthDiff = calcEdate.monthsBetween(calcYearEnd)+1;
                calcDayDiff = calcEdate.daysBetween(date.newInstance(calcEdate.year(), calcEdate.month(), calcDaysInMonth))+1;
            	
            	//Parking-Only   Check for validity                    
                if(projects.containsKey(curObject.ProjectNumber__c)) {                    
                    project = projects.get(curObject.ProjectNumber__c);                    
                    // For Parking-Only leases use NOA fields
                    if (project.ParkingOnly__c != null && project.ParkingOnly__c.equalsIgnoreCase('Yes')) {
                        curObject.NOA_Sq_Ft__c = project.BaseStructParkSpaces__c+ project.BaseSurfParkSpaces__c;
                    } else {
                        if(trigger.isInsert) {
                            curObject.NOA_Sq_Ft__c = project.NOASquareFeet__c; //check if its to be total noa sq feet
                        }                        
                    }
                    if(trigger.isInsert) {
                        curObject.IA_Sq_Ft__c = project.IASquareFeet__c;
                    }
                } 
            	            	
            	noaOrParkSqFt = curObject.NOA_Sq_Ft__c;
                iaSqFt = curObject.IA_Sq_Ft__c;
            	
                if ((noaOrParkSqFt + iaSqFt) == 0) {
                    monIA = 0;
                    monNOA = curObject.Amount__c/12;
                } else if (noaOrParkSqFt == 0) {
                    monNOA = 0;
                    monIA = (curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt)/12;
                } else if (iaSqFt == 0 ) {
                    monIA = 0;
                    monNOA = (curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt)/12;
                } else {
                    monIA = (curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt)/12;
                    monNOA = (curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt)/12;
                }
                
                if (projects.containsKey(curObject.ProjectNumber__c) && project.IAConversionDate__c != null && project.IAConversionDate__c < calcEdate) {
                    monNOA = monNOA + monIA;
                    monIA = 0;
                    curObject.NOA_Sq_Ft__c = noaOrParkSqFt + iaSqFt;
                    curObject.IA_Sq_Ft__c = 0;
                }
                
                if(Trigger.isInsert){
	                //Krishna - If Effective Date is less than IA Conversion date, combine IA and NOA in NOA
	                if( projects.containsKey(curObject.ProjectNumber__c) && project.IAConversionDate__c != null  && project.IAConversionDate__c <= curObject.EffectiveDate__c   ){
	                	curObject.NOA_Sq_Ft__c = project.IASquareFeet__c + project.NOASquareFeet__c;
	                	curObject.IA_Sq_Ft__c = 0;
	                }else if( projects.containsKey(curObject.ProjectNumber__c) && project.IAConversionDate__c != null  && project.IAConversionDate__c > curObject.EffectiveDate__c  ){
	                	curObject.NOA_Sq_Ft__c = project.NOASquareFeet__c;
	                	curObject.IA_Sq_Ft__c = project.IASquareFeet__c;
	                }
	                
	                // If current process Date is less than project process date, replace it with project process date 
	                if (projects.containsKey(curObject.ProjectNumber__c) && project.ProcessedDate__c != null && project.ProcessedDate__c >=  curObject.EffectiveDate__c ) {
	                    curObject.ProcessedDate__c = project.ProcessedDate__c;
	                }else if (projects.containsKey(curObject.ProjectNumber__c) && project.ProcessedDate__c != null && project.ProcessedDate__c < curObject.EffectiveDate__c ) {
	                    curObject.ProcessedDate__c = curObject.EffectiveDate__c;
	                }
	                
	                //Release 2.3 post fix 5
	                if (curObject.ProcessedDate__c.year() > curObject.EffectiveDate__c.year()){
	                	calcFiscalYr = (curObject.ProcessedDate__c.month() > 9) ? curObject.ProcessedDate__c.year() : (curObject.ProcessedDate__c.year() - 1);
	                    calcEdate = date.newInstance(calcFiscalYr, 10, 1);
	                    calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);
	                    calcMonthDiff = 12;
	                    calcDayDiff = calcEdate.daysBetween(date.newInstance(calcEdate.year(), calcEdate.month(), calcDaysInMonth))+1;
	                }
                }
                
                Integer fYear = calcFiscalYr;
                curObject.FY_Obligation__c = 0;
                curObject.FY_Obligation_IA__c = 0;
                curObject.FY_Obligation_NOA__c = 0;
                
                for (Integer i=0; i<12; i++) {                   
                    if (i == 9) {
                        fYear = fYear - 1;
                    }                    
                    compareMonths = date.newInstance(fYear, i+1, 1).monthsBetween(calcYearEnd)+1;
                    if (compareMonths <= calcMonthDiff && compareMonths > 0) {                       
                        monthlyNOA.add(i, monNOA);
                        monthlyIA.add(i, monIA);                        
                        if (i+1 == calcEdate.month()) {
                            monthlyNOA.add(i, (monNOA/calcDaysInMonth) * calcDayDiff);
                            monthlyIA.add(i, (monIA/calcDaysInMonth) * calcDayDiff);
                       }                       
                    } else {
                        monthlyNOA.add(i, 0);
                        monthlyIA.add(i, 0);
                    }                    
                    //FY Obligation IA
                    curObject.FY_Obligation__c = curObject.FY_Obligation__c + monthlyIA.get(i) + monthlyNOA.get(i);
                    curObject.FY_Obligation_IA__c = curObject.FY_Obligation_IA__c + monthlyIA.get(i);
                    curObject.FY_Obligation_NOA__c = curObject.FY_Obligation_NOA__c + monthlyNOA.get(i);
                       
                }
                
                curObject.OCT_NOA__c = monthlyNOA.get(9);
                curObject.NOV_NOA__c = monthlyNOA.get(10);
                curObject.DEC_NOA__c = monthlyNOA.get(11);
                curObject.JAN_NOA__c = monthlyNOA.get(0);
                curObject.FEB_NOA__c = monthlyNOA.get(1);
                curObject.MAR_NOA__c = monthlyNOA.get(2);
                curObject.APR_NOA__c = monthlyNOA.get(3);
                curObject.MAY_NOA__c = monthlyNOA.get(4);
                curObject.JUN_NOA__c = monthlyNOA.get(5);
                curObject.JUL_NOA__c = monthlyNOA.get(6);
                curObject.AUG_NOA__c = monthlyNOA.get(7);
                curObject.SEP_NOA__c = monthlyNOA.get(8);
                
                curObject.OCT_IA__c = monthlyIA.get(9);
                curObject.NOV_IA__c = monthlyIA.get(10);
                curObject.DEC_IA__c = monthlyIA.get(11);
                curObject.JAN_IA__c = monthlyIA.get(0);
                curObject.FEB_IA__c = monthlyIA.get(1);
                curObject.MAR_IA__c = monthlyIA.get(2);
                curObject.APR_IA__c = monthlyIA.get(3);
                curObject.MAY_IA__c = monthlyIA.get(4);
                curObject.JUN_IA__c = monthlyIA.get(5);
                curObject.JUL_IA__c = monthlyIA.get(6);
                curObject.AUG_IA__c = monthlyIA.get(7);
                curObject.SEP_IA__c = monthlyIA.get(8);
                            
            }
			
		}
		
	}

}