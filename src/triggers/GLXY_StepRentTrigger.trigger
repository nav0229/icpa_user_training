trigger GLXY_StepRentTrigger on Glxy_StepRent__c (before delete, before insert, before update) {

	if (Trigger.isDelete) {
	 	List<string> profileNamelist= new list<string>();
		profileNamelist.add('GSA System Administrator');
		profileNamelist.add('System Administrator');
		Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
		string adminUser= [select id from user where name='CastIron User'].id;
		system.debug(adminUser);
		system.debug(adminProfileMap);
		string RexusRecordType=Schema.SObjectType.Glxy_StepRent__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		system.debug(RexusRecordType);
		for(Glxy_StepRent__c pi:trigger.old )
		{
		  
		 if(pi.RecordTypeid==RexusRecordType)
		 {
		 
		  if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null)
		  {
		   continue;
		  
		  }
		   pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');
		  
		 
		  }
		}

	}else{
	 	Set<Id> leaseIds = new Set<Id>();

	    for(Glxy_StepRent__c sr: trigger.new) {
	        leaseIds.add(sr.LeaseNumber__c);
	    }
	    
	    Map<Id,Glxy_Lease__c> leases =  new Map<Id,Glxy_Lease__c> ([Select id,
	                                  ParkingOnly__c,
	                                  BaseStructuredParkingSpaces__c,
	                                  BaseSurfaceParkingSpaces__c,
	                                  IAConverstionDate__c,
	                                  Total_NOA_Sq_feet__c,
	                                  Total_IA_Sq_feet__c
	                                  from Glxy_Lease__c where id IN :leaseIds]);
    
	    //Bulkify calculations
	    for (Glxy_StepRent__c curObject: trigger.new) {
	        // Ensure EffectiveDate is populated
	        if (curObject.EffectiveDate__c != null) {
	            
	            //Declarations A - Z
	            Date calcYearEnd;
	            Decimal noaOrParkSqFt;
	            Decimal iaSqFt;
	            Glxy_Lease__c lease;
	            Integer calcDayDiff;
	            Integer calcDaysInMonth;
            
	            Integer calcMonthDiff;
	            
	            //Initializations A - Z
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
	            
	            //Parking-Only
	                   
	            if(leases.containsKey(curObject.LeaseNumber__c)) {
	                
	                lease = leases.get(curObject.LeaseNumber__c);
	                
	                // For Parking-Only leases use NOA fields
	                if (lease.ParkingOnly__c != null && lease.ParkingOnly__c.equalsIgnoreCase('Yes')) {
	                    curObject.NOA_Sq_Ft__c = lease.BaseStructuredParkingSpaces__c+ lease.BaseSurfaceParkingSpaces__c;
	                } else {
	                    if(trigger.isInsert) {
	                        curObject.NOA_Sq_Ft__c = lease.Total_NOA_Sq_feet__c;
	                    }
	                    
	                }
	                if(trigger.isInsert) {
	                    curObject.IA_Sq_Ft__c = lease.Total_IA_Sq_feet__c;
	                }
	            }
	            
	            noaOrParkSqFt = curObject.NOA_Sq_Ft__c;
	            iaSqFt = curObject.IA_Sq_Ft__c;
	            
	            //resetting to zero for new calculations
	            curObject.FY_Obligation__c = 0;
	            
	            Integer compareMonths;
	            List<Decimal> monthlyNOA = new Decimal[12];
	            List<Decimal> monthlyIA = new Decimal[12];
	            
	            if (noaOrParkSqFt == null)
	                noaOrParkSqFt = 0;
	                
	            if (iaSqFt == null)
	                iaSqFt = 0; 
	            
	            
	            Decimal monIA;
	            Decimal monNOA;
	            
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
	            
	             // If Effective Date is less that IA Conversion date, combine IA and NOA in NOA
	            if (leases.containsKey(curObject.LeaseNumber__c) && lease.IAConverstionDate__c != null && lease.IAConverstionDate__c < calcEdate) {
	                monNOA = monNOA + monIA;
	                monIA = 0;
	                curObject.NOA_Sq_Ft__c = noaOrParkSqFt + iaSqFt;
                    curObject.IA_Sq_Ft__c = 0;
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
	            
	            curObject.AccrualAmountEffectiveMonthRate__c = (curObject.Amount__c/12) / Date.daysInMonth(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month()); //Galaxy Release 2.3  
	        }
	    }
	 		
	 	
	}
}