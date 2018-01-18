trigger GLXY_CPITrigger on Glxy_ConsumerPriceIndex__c (before delete, before insert, before update) {

     if (Trigger.isDelete) {
        List<string> profileNamelist= new list<string>();
        profileNamelist.add('GSA System Administrator');
        profileNamelist.add('System Administrator');
        Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
        string adminUser= [select id from user where name='CastIron User'].id;
        system.debug(adminUser);
        system.debug(adminProfileMap);
        string RexusRecordType=Schema.SObjectType.Glxy_ConsumerPriceIndex__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
        system.debug(RexusRecordType);
        for(Glxy_ConsumerPriceIndex__c pi:trigger.old )
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
        // Get a collection of Lease IDs associated with 
        // the records that are in Trigger.new 
        Set<Id> leaseIds = new Set<Id>();
    
        for(Glxy_ConsumerPriceIndex__c c: trigger.new) {
            leaseIds.add(c.LeaseNumber__c);
        }
        
        // Get the Parking Only, Structured and Surface Parking,
        // IA Conversion Date, Total IA and NOA fields from the 
        // Lease object
        Map<Id,Glxy_Lease__c> leases = new Map<Id,Glxy_Lease__c> ([Select id,
                                      ParkingOnly__c,
                                      BaseStructuredParkingSpaces__c,
                                      BaseSurfaceParkingSpaces__c,
                                      IAConverstionDate__c,
                                      Total_NOA_Sq_feet__c,
                                      Total_IA_Sq_feet__c
                                      from Glxy_Lease__c where id IN :leaseIds]);
        
        //Bulkify calculations
        for (Glxy_ConsumerPriceIndex__c curObject: trigger.new) {
            // Ensure EffectiveDate is populated
            if (curObject.EffectiveDate__c != null) {
                
                //Declarations A - Z
                Date calcYearEnd;
                Date calcYearEndEDate;
                Decimal monIA;
                Decimal monNOA;
                Decimal noaOrParkSqFt;
                Decimal iaSqFt;
                Glxy_Lease__c lease;
                Integer calcDayDiff;
                Integer CalDayDiffAcrual;
                Integer calcDaysInMonth;
                Integer calcMonthDiff;
                Integer compareMonths;
                
                //Initializations A - Z
                Date calcEdate = curObject.EffectiveDate__c;
                Date today = datetime.now().date(); //Using this for Accrual Amount
                Integer calcFiscalYr = calcEdate.year();
                Integer calcFiscalYrEDate;
                Integer calcFiscalYrPDate;
                
                // Determine the Effective Date Fiscal Year
                if(calcEdate.month() > 9) {
                    calcFiscalYr = calcFiscalYr + 1;
                }
                calcFiscalYrEDate = calcFiscalYr;
                calcYearEndEDate = date.newInstance(calcFiscalYrEDate, 9, 30);
                
                if(curObject.ProcessedDateFY__c != null) {
                    if(calcFiscalYr < integer.valueOf(curObject.ProcessedDateFY__c)) {
                        calcFiscalYr = integer.valueOf(curObject.ProcessedDateFY__c);
                        calcEdate = date.newInstance(calcFiscalYr-1, 10, 1);
                        calcFiscalYrPDate = calcFiscalYr;
                    }
                }
                
                Integer dayEffective = calcEdate.day();
                Integer monthEffective = calcEdate.month();
                Integer yearEffective = calcEdate.year();
                
                // Calculate the Year End
                calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);
                
                // Calculate the Days in the Effective Date Month
                calcDaysInMonth = date.daysInMonth(yearEffective, monthEffective);
                
                // Calculate the month different between Effective Date and Year End
                calcMonthDiff = calcEdate.monthsBetween(calcYearEnd)+1;
                
                //Calculate the remaining days in the Effective month
                calcDayDiff = calcEdate.daysBetween(date.newInstance(yearEffective, monthEffective, calcDaysInMonth))+1;
                CalDayDiffAcrual = curObject.EffectiveDate__c.DaysBetween(date.newInstance(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month(), date.daysInMonth(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month()))) + 1;
               
               // Determine Parking-Only lease
                
                // Get the current Lump Sum's lease
                /*for(Glxy_Lease__c l: leases) {
                    if(l.id == curObject.LeaseNumber__c)
                        lease = l;
                }*/
                
                
            
                if(leases.containsKey(curObject.LeaseNumber__c)) {
                    
                    lease = leases.get(curObject.LeaseNumber__c);
                    
                    if(trigger.isInsert) {
                        curObject.NOA_Sq_Ft__c = lease.Total_NOA_Sq_feet__c;
                        curObject.IA_Sq_Ft__c = lease.Total_IA_Sq_feet__c;
                    }
                    
                    // For Parking-Only leases use NOA fields
                    if (lease.ParkingOnly__c != null && lease.ParkingOnly__c.equalsIgnoreCase('Yes')) {
                        curObject.NOA_Sq_Ft__c = lease.BaseStructuredParkingSpaces__c+ lease.BaseSurfaceParkingSpaces__c;
                    }
                    
                }
                
                noaOrParkSqFt = curObject.NOA_Sq_Ft__c;
                iaSqFt = curObject.IA_Sq_Ft__c;
                
                //Initializing to zero for new calculations
                curObject.FY_Obligation__c = 0;
                curObject.FY_Obligation_IA__c = 0;
                curObject.FY_Obligation_NOA__c = 0;
                
                if (noaOrParkSqFt == null)
                    noaOrParkSqFt = 0;
                    
                if (iaSqFt == null)
                    iaSqFt = 0; 
                
                if ((noaOrParkSqFt + iaSqFt) == 0) {
                    monIA = 0;
                    monNOA = curObject.AnnualAmount__c/12;
                } else if (noaOrParkSqFt == 0) {
                    monNOA = 0;
                    monIA = (curObject.AnnualAmount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt)/12;
                } else if (iaSqFt == 0 ) {
                    monIA = 0;
                    monNOA = (curObject.AnnualAmount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt)/12;
                } else {
                    monIA = (curObject.AnnualAmount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt)/12;
                    monNOA = (curObject.AnnualAmount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt)/12;
                }
                
                if (lease.IAConverstionDate__c != null && lease.IAConverstionDate__c < calcEdate) {
                    monNOA = monNOA + monIA;
                    monIA = 0;
                    curObject.NOA_Sq_Ft__c = noaOrParkSqFt + iaSqFt;
                    curObject.IA_Sq_Ft__c = 0;
                }
                
                // fYear for creating a date to compare against the Expiration Date
                Map<Boolean,Integer> fYear = new Map<Boolean, Integer> {true => calcFiscalYr - 1, false => calcFiscalYr};
                
                Map<Integer,String> monthlyNOAFields = new Map<Integer,String> 
                {1 => 'JAN_NOA__c', 2 => 'FEB_NOA__c', 3 => 'MAR_NOA__c', 4 => 'APR_NOA__c', 5 => 'MAY_NOA__c', 6 => 'JUN_NOA__c', 
                7 => 'JUL_NOA__c', 8 => 'AUG_NOA__c', 9 => 'SEP_NOA__c', 10 => 'OCT_NOA__c', 11 => 'NOV_NOA__c', 12 => 'DEC_NOA__c'};
                
                Map<Integer,String> monthlyIAFields = new Map<Integer,String> 
                {1 => 'JAN_IA__c', 2 => 'FEB_IA__c', 3 => 'MAR_IA__c', 4 => 'APR_IA__c', 5 => 'MAY_IA__c', 6 => 'JUN_IA__c', 
                7 => 'JUL_IA__c', 8 => 'AUG_IA__c', 9 => 'SEP_IA__c', 10 => 'OCT_IA__c', 11 => 'NOV_IA__c', 12 => 'DEC_IA__c'};
                
                for (Integer i=1; i<=12; i++) { 
                   
                    // Is the month part of Effective Date, Year End or between?
                    compareMonths = date.newInstance(fYear.get(i>9), i, 1).monthsBetween(calcYearEnd)+1;
    
                    // If it is, assign monthly values
                    if (compareMonths <= calcMonthDiff && compareMonths > 0) {
                        
                        if (i == monthEffective) {
                            curObject.put(monthlyNOAFields.get(i), (monNOA/calcDaysInMonth) * calcDayDiff);
                            curObject.put(monthlyIAFields.get(i), (monIA/calcDaysInMonth) * calcDayDiff);
                        } else {
                            curObject.put(monthlyNOAFields.get(i), monNOA);
                            curObject.put(monthlyIAFields.get(i), monIA);
                        }
                       
                    } else {
                        curObject.put(monthlyNOAFields.get(i), 0);
                        curObject.put(monthlyIAFields.get(i), 0);
                    }
                    
                    //FY Obligation IA
                    curObject.FY_Obligation__c = curObject.FY_Obligation__c + (Decimal)curObject.get(monthlyNOAFields.get(i)) + (Decimal)curObject.get(monthlyIAFields.get(i));
                    curObject.FY_Obligation_IA__c = curObject.FY_Obligation_IA__c + (Decimal)curObject.get(monthlyIAFields.get(i));
                    curObject.FY_Obligation_NOA__c = curObject.FY_Obligation_NOA__c + (Decimal)curObject.get(monthlyNOAFields.get(i));
                       
                }
                
                //Accrual Amount
                
                // Set default to 0
                curObject.AccrualAmount__c = 0;
    
                Glxy_ConsumerPriceIndex__c beforeUpdate;
                Boolean calcAccural = false;
                
                // Get the previous values of the current object            
                if (trigger.isUpdate) {
                    beforeUpdate = System.Trigger.oldMap.get(curObject.Id);
                }
    
                // Calculate Accural only if Effective date is in Previous Fiscal Year or before.
                // Calculate it only till the Year End Date
                System.debug('MyDebug - calcFiscalYrPDate =' + calcFiscalYrPDate);
                System.debug('MyDebug - calcFiscalYrEDate =' + calcFiscalYrEDate);
                
                if(calcFiscalYrPDate > calcFiscalYrEDate && curObject.StatusCD__c != null) {
                    calcAccural = true;
                    /*if(beforeUpdate == null) {
                        if(curObject.StatusCD__c.equalsIgnoreCase('Estimate')) {
                            calcAccural = true;    
                        }
                     } else {
                         if(curObject.StatusCD__c.equalsIgnoreCase('Estimate') || beforeUpdate.StatusCd__c.equalsIgnoreCase('Estimate')) {
                             calcAccural = true;
                         }
                     }*/
                 }
                 
                 System.debug('MyDebug - calcAccural =' + calcAccural);
                 if (calcAccural) {
                    //System.debug('MyDebug - calcEdate =' + calcEdate);
                    //System.debug('MyDebug - calcYearEndEDate =' + calcYearEndEDate);
                    //System.debug('MyDebug - curObject.EffectiveDate__c.monthsBetween(calcYearEndEDate) =' + curObject.EffectiveDate__c.monthsBetween(calcYearEndEDate));
                    //System.debug('MyDebug - monNOA + monIA =' + monNOA + monIA);
                    //System.debug('MyDebug - calcFiscalYrEDate =' + calcFiscalYrEDate);
                    //System.debug('MyDebug - CalDayDiffAcrual =' + CalDayDiffAcrual);
                    //curObject.AccrualAmount__c = (curObject.EffectiveDate__c.monthsBetween(calcYearEndEDate)) * (monNOA + monIA) + ((monNOA+monIA)/calcDaysInMonth) * CalDayDiffAcrual;
                    curObject.AccrualAmount__c = 
                 		curObject.EffectiveDate__c.monthsBetween(calcYearEndEDate) * (monNOA + monIA) 
                 		+
                 		(monNOA+monIA) * CalDayDiffAcrual/(date.daysInMonth(curObject.EffectiveDate__c.Year(), curObject.EffectiveDate__c.Month()));
                 }
                 curObject.AccrualAmountEffectiveMonthRate__c = (curObject.AnnualAmount__c/12) / Date.daysInMonth(curObject.EffectiveDate__c.year(), curObject.EffectiveDate__c.month()); //Galaxy Release 2.3

            }
        }
        
        
     }
     
}