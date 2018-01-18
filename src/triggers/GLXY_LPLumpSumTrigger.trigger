trigger GLXY_LPLumpSumTrigger on Glxy_LPLumpSum__c (before delete, before insert, after insert, before update) {
	
	List<GLXY_LPLumpSumObligations__c> objLSObligationsByFY = New List<GLXY_LPLumpSumObligations__c>();
	List<Glxy_LPLumpSum__c> objUpdateComments = New List<Glxy_LPLumpSum__c>();
	
	if(Trigger.isBefore){
		if (Trigger.isDelete) {
		 	/*List<string> profileNamelist= new list<string>();
			profileNamelist.add('GSA System Administrator');
			profileNamelist.add('System Administrator');
			Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
			string adminUser= [select id from user where name='CastIron User'].id;
			system.debug(adminUser);
			system.debug(adminProfileMap);
			string RexusRecordType=Schema.SObjectType.Glxy_LPLumpSum__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
			system.debug(RexusRecordType);
			for(Glxy_LPLumpSum__c pi:trigger.old ){
				if(pi.RecordTypeid==RexusRecordType){
					if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null){
			   			continue;
					}
			   	pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');
				}
			}*/
	
		}else{
			
		 	// Get a collection of Lease IDs associated with 
		    // the records that are in Trigger.new 
		    Set<Id> projectIds = new Set<Id>();
		    Set<Id> UpdatedOrNewRecordIDs = new Set<Id>();
			for(Glxy_LPLumpSum__c ls: trigger.new){
	           projectIds.add(ls.ProjectNumber__c);
	           UpdatedOrNewRecordIDs.add (ls.ID);
	        }
		    // Get the Parking Only, Structured and Surface Parking,
		    // IA Conversion Date, Total IA and NOA fields from the 
		    // Lease object
		   Map<Id,Glxy_LeaseProjects__c> projects = new Map<Id,Glxy_LeaseProjects__c> ([Select id,
	                                      ParkingOnly__c, IAConverstionFY__c, 
	                                      BaseStructParkSpaces__c,
	                                      BaseSurfParkSpaces__c,
	                                      IAConversionDate__c,
	                                      ProcessedDate__c,
	                                      AnnualRent__c, EffectiveDate__c,
	                                      NOASquareFeet__c,// RexusNewNOASqFt__c,
	                                      IASquareFeet__c  //RexusNewIASqFt__c
	                                      from Glxy_LeaseProjects__c where id IN :projectIds]); 
		    
		    //Bulkify calculations
		     for (Glxy_LPLumpSum__c curObject: trigger.new) {
		        // Ensure EffectiveDate and Expiration Date are populated
		        if (curObject.EffectiveDate__c != null && curObject.ExpirationDate__c != null) {
		            //Declarations A - Z
		            Decimal monIA;
		            Decimal monNOA;
		            Decimal noaOrParkSqFt;
		            Decimal iaSqFt;
		            Glxy_LeaseProjects__c project;
		            Integer calcMonthDiff;
		            Integer compareMonths;
		            Integer fYear;
		            Integer TotalMonthsRentFree;
		            
		            //Initializations A - Z
		            Date calcEdate = curObject.EffectiveDate__c;
		            Date expiryEdate = curObject.ExpirationDate__c;
		            Date expiryEdateOriginal = curObject.ExpirationDate__c;
		            Date today = datetime.now().date();  //Using this for Accrual Amount
		            Integer calcFiscalYr = calcEdate.month() > 9? calcEdate.year()+1 : calcEdate.year();
		            Integer dayEffective = calcEdate.day();
		            Integer expiryFY = expiryEdate.month() > 9? expiryEdate.year()+1 : expiryEdate.year();
		            Integer monthEffective = calcEdate.month();
		            Integer totalMonths = calcEdate.monthsBetween(expiryEdate)+1; //Find total months between Effective Date and Expiration month.
		            Integer yearEffective = calcFiscalYr;
		            Integer AccrualMultiplyFactorRentFree;
		            Integer AccrualMultiplyFactor;
					Date calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);// Calculate the Year End
					Integer calcDaysInMonth = date.daysInMonth(calcEdate.year(), calcEdate.month());// Calculate the Days in the Effective Date Month
					Integer calcDayDiff = calcEdate.daysBetween(date.newInstance(calcEdate.year(), calcEdate.month(), calcDaysInMonth)) + 1;//Calculate the remaining days in the Effective month
		            Decimal IATotalsToDate = 0;
		            Decimal NOATotalsToDate = 0;
		            Integer IANOAConversionFY;
		            
		            Integer DaysinLeaseEffectiveMonth;
		            Integer DaysProratedEffectiveMonth;
		            Decimal MonthlyRentEffectiveMonth = 0;
		            Decimal MonthlyRentOtherMonths = 0;
		            Integer MonthLeaseEffective;
		            Integer YearLeaseEffective;
		            
					Boolean blnCurrentYearLoaded = false;
					Decimal YearlyObligations;
					Decimal YearlyObligationsIA;
					Decimal YearlyObligationsNOA;
					
					Decimal BCCMoveForwardAmount = 0.0;
					Decimal BCCMoveForwardAmountNOA = 0.0;
					Decimal BCCMoveForwardAmountIA = 0.0;
			
					Decimal BCCAmountMonthNOA = 0.0;
					Decimal BCCAmountMonthIA = 0.0;
					
					Decimal BCCEffectiveMonthTemp;
					Boolean blnProRatedFirstMonthBCC = false;
					Integer intForwardToMultiplier;
					Integer intLoopEndYear;
					
					Integer ProcessDateFY;
		            Integer ProcessDateMonth;
		            Date ProcessDate = curObject.EffectiveDate__c; // Default Process Date to Effective Date
		            
		            Map<Integer,Decimal> monthlyNOA = new Map<Integer,Decimal> {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0};
		            Map<Integer,Decimal> monthlyIA = new Map<Integer,Decimal> {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0};
		            calcMonthDiff = calcEdate.monthsBetween(expiryEdate) + 1;
	
		            if(projects.containsKey(curObject.ProjectNumber__c)) {
		               project = projects.get(curObject.ProjectNumber__c);
	                    IANOAConversionFY = Integer.valueOf(project.IAConverstionFY__c);
		                // For Parking-Only leases use NOA fields
		                if (project.ParkingOnly__c != null && project.ParkingOnly__c.equalsIgnoreCase('Yes')){
	                        curObject.NOA_Sq_Ft__c = project.BaseStructParkSpaces__c+ project.BaseSurfParkSpaces__c;
		                }else{
		                    if(trigger.isInsert){
		                         curObject.NOA_Sq_Ft__c = project.NOASquareFeet__c; //check if its to be total noa sq feet
		                    }
		                }
		                if(trigger.isInsert){
		                    curObject.IA_Sq_Ft__c = project.IASquareFeet__c;
		                }
		                MonthlyRentOtherMonths = project.AnnualRent__c/12;
		                MonthLeaseEffective  = project.EffectiveDate__c.month();
		                YearLeaseEffective = project.EffectiveDate__c.Month() > 9? project.EffectiveDate__c.Year()+ 1 : project.EffectiveDate__c.Year();
		                DaysinLeaseEffectiveMonth = date.daysInMonth(project.EffectiveDate__c.year(), project.EffectiveDate__c.month());
		                DaysProratedEffectiveMonth = project.EffectiveDate__c.daysBetween(date.newInstance(project.EffectiveDate__c.year(), project.EffectiveDate__c.month(), DaysinLeaseEffectiveMonth)) + 1;
		                MonthlyRentEffectiveMonth = (MonthlyRentOtherMonths * DaysProratedEffectiveMonth)/DaysinLeaseEffectiveMonth;
		                If (curObject.Amount__c < 0){// -ve BCC
							MonthlyRentEffectiveMonth = -MonthlyRentEffectiveMonth; 
							MonthlyRentOtherMonths = -MonthlyRentOtherMonths;
						}	
		            }
		            
		            noaOrParkSqFt = curObject.NOA_Sq_Ft__c;
		            iaSqFt = curObject.IA_Sq_Ft__c;
		            
		            if (noaOrParkSqFt == null)
		                noaOrParkSqFt = 0;
		            if (iaSqFt == null)
		                iaSqFt = 0; 
		            
		            if ((noaOrParkSqFt + iaSqFt) == 0) {
		                monIA = 0;
		                noaOrParkSqFt = 1; // Galaxy R2 - Treat all amount as NOA
		                monNOA = curObject.Amount__c;
		            } else if (noaOrParkSqFt == 0) {
		                monNOA = 0;
		                monIA = curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt;
		            } else if (iaSqFt == 0 ) {
		                monIA = 0;
		                monNOA = curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt;
		            } else {
		                monIA = curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt;
		                monNOA = curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt;
		            }
		            
		           	if (project.IAConversionDate__c != null && project.IAConversionDate__c < curObject.EffectiveDate__c) {
	                    curObject.NOA_Sq_Ft__c = noaOrParkSqFt + iaSqFt;
	                    curObject.IA_Sq_Ft__c = 0;
                	}
                	
		           	// If current process Date is less than project process date, replace it with project process date 
		           	if(Trigger.isInsert){ 
		                if (projects.containsKey(curObject.ProjectNumber__c) && project.ProcessedDate__c != null && project.ProcessedDate__c >=  curObject.EffectiveDate__c ) {
		                    curObject.ProcessedDate__c = project.ProcessedDate__c;
		                }else if (projects.containsKey(curObject.ProjectNumber__c) && project.ProcessedDate__c != null && project.ProcessedDate__c <  curObject.EffectiveDate__c ) {
		                    curObject.ProcessedDate__c = curObject.EffectiveDate__c;
		                }
		            }
	    	   		
		            if (curObject.ProcessedDate__c != Null){
		            	//ProcessDateFY = curObject.ProcessedDate__c.month() > 9? curObject.ProcessedDate__c.Year() + 1 : curObject.ProcessedDate__c.Year();
		            	ProcessDateFY = curObject.ProcessedDate__c.Year();
			            ProcessDateMonth = curObject.ProcessedDate__c.month();
			            ProcessDate = Date.newInstance(ProcessDateFY, ProcessDateMonth, 1);
		            }	
					
					/* Release 2.2 - BCC and Rent Free Period - Logic reverted back -  Amount/(Expiration - Effective Month) or Amount/Withhold Months
	 						So the code below has been commented. 
					// 03/24/2014 - For Rent Free Period not starting on the first of the month, move the expiration by a month. The date should be set to -1 day of the effective month day.
		            if (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period') && calcEdate.Day() <> 1){
		            	curObject.ExpirationDate__c = curObject.ExpirationDate__c.AddMonths(1);
		            	curObject.ExpirationDate__c = date.newInstance(curObject.ExpirationDate__c.Year(), curObject.ExpirationDate__c.Month(), calcEdate.Day() - 1);
		            	expiryEdate = curObject.ExpirationDate__c;
		            	expiryFY = expiryEdate.month() > 9? expiryEdate.year()+1 : expiryEdate.year();
		            }
		            */
		            
		            If ((ProcessDate > Date.newInstance(curObject.ExpirationDate__c.Year(), curObject.ExpirationDate__c.Month(), 1)) && (curObject.LumSumType__c != null) && !curObject.LumSumType__c.equalsIgnoreCase('Broker Commission Credit') && !curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period')){
						intLoopEndYear = ProcessDate.Month() > 9? ProcessDate.Year() + 1 : ProcessDate.Year();
					} else {
						intLoopEndYear = curObject.ExpirationDate__c.Month() > 9? curObject.ExpirationDate__c.Year() + 1 : curObject.ExpirationDate__c.Year();
					}
		     
		            for (Integer intLoopFY = calcFiscalYr; intLoopFY <= intLoopEndYear; intLoopFY ++){ //FY Loop Starts here
		           		//IA NOA Conversion Movement ...
	               		If (IANOAConversionFY <= intLoopFY) {
	                    	monNOA = monNOA + monIA;
	                    	monIA = 0;
	                    	noaOrParkSqFt = noaOrParkSqFt + iaSqFt;
	                    	iaSqFt = 0;
	               		}
	               		
		            	monthlyNOA.putAll(new Map<Integer,Decimal> {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0});
		            	monthlyIA.putAll(new Map<Integer,Decimal> {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0, 11 => 0, 12 => 0});
		            	
		            	fYear = intLoopFY;
			            YearlyObligations = 0;
			            YearlyObligationsIA = 0;
			            YearlyObligationsNOA = 0;
			            
			            for (Integer i=1; i<=12; i++) { //Month Loop Starts here
			              	if (i == 10) {
			                    fYear = fYear - 1;
			                } 
			               	System.Debug ('MyDebug - i = ' + i);
			                System.Debug ('MyDebug - fYear = ' + fYear);
			                If ((ProcessDate > Date.newInstance(curObject.ExpirationDate__c.Year(), curObject.ExpirationDate__c.Month(), 1)) && (curObject.LumSumType__c != null) && !curObject.LumSumType__c.equalsIgnoreCase('Broker Commission Credit') && !curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period')){
			                	compareMonths = date.newInstance(fYear, i, 1).monthsBetween(ProcessDate) + 1;
			                } else {
			                	compareMonths = date.newInstance(fYear, i, 1).monthsBetween(curObject.ExpirationDate__c) + 1;
			                }
	
							if (compareMonths <= calcMonthDiff && compareMonths > 0) {
								// Rent Free Period
			                	if (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period') && totalMonths >= 1){
			                		monthlyNOA.put(i, monNOA/(totalMonths));
		                    		monthlyIA.put(i, monIA/(totalMonths));
			                	// Broker Commission Credit
			                	} else if (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Broker Commission Credit') && totalMonths >= 1){
			                		monthlyNOA.put(i, monNOA/totalMonths);
		                    		monthlyIA.put(i, monIA/totalMonths);	
			                	// All other Lump Sum Types
			                	} else {
			                		System.Debug ('MyDebug - Loop Date = ' + date.newInstance(fYear, i, 1));
			                		System.Debug ('MyDebug - ProcessDate = ' + ProcessDate);
			                		If (date.newInstance(fYear, i, 1) < ProcessDate) {
			                			System.Debug ('MyDebug - Condition 1');
			                			monthlyNOA.put(i, 0.0);
		                    			monthlyIA.put(i, 0.0);
			                		} else if (date.newInstance(fYear, i, 1).DaysBetween(ProcessDate) == 0 ) {
			                			System.Debug ('MyDebug - Condition 2');
			                			intForwardToMultiplier = calcEdate.MonthsBetween(ProcessDate) + 1;
			                			//If Process Date is greater than Effective Date (monthwise), then you only go to the effective Date to get the Total amount right ...
			                			If (calcEdate.MonthsBetween(ProcessDate) > calcEdate.MonthsBetween(expiryEdate)){
			                				intForwardToMultiplier = totalMonths;
			                			}
										monthlyNOA.put(i, monNOA/totalMonths * intForwardToMultiplier);
	                    				monthlyIA.put(i, monIA/totalMonths * intForwardToMultiplier);
			                		} else {
			                			System.Debug ('MyDebug - Condition 3');
			                			monthlyNOA.put(i, monNOA/totalMonths);
		                    			monthlyIA.put(i, monIA/totalMonths);
			                		}
			                	}
			                }
	 						
	 						/* Release 2.2 - BCC and Rent Free Period - Logic reverted back -  Amount/(Expiration - Effective Month) or Amount/Withhold Months
	 						So the code below has been commented. 
	 						//Broker Commission Credit ...
	 						If (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Broker Commission Credit')){
	 							// Months between ...	
	 							If (compareMonths <= calcMonthDiff && compareMonths > 0) {
	 								If ((Math.Abs(((monNOA + monIA)/TotalMonths)) + BCCMoveForwardAmount)  > Math.Abs(MonthlyRentOtherMonths)){
			                			If (i == expiryEdate.month() && intLoopFY == expiryFY && compareMonths <= calcMonthDiff && compareMonths > 0){ // Do not load for Expiration month
			                			} else {	
				                			BCCMoveForwardAmount = (Math.Abs(((monNOA + monIA)/totalMonths)) + BCCMoveForwardAmount) - Math.Abs(MonthlyRentOtherMonths);
											BCCMoveForwardAmountIA = BCCMoveForwardAmount/(noaOrParkSqFt + iaSqFt) * iaSqFt;
											BCCMoveForwardAmountNOA = BCCMoveForwardAmount/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt;
											monthlyNOA.put(i, MonthlyRentOtherMonths/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt);
					                 		monthlyIA.put(i, MonthlyRentOtherMonths/(noaOrParkSqFt + iaSqFt ) * iaSqFt);
			                			}	
			                		}
		                		}	
			                	// Effective Month ...
			                	If (i == monthEffective && intLoopFY == calcFiscalYr && i == MonthLeaseEffective && intLoopFY == YearLeaseEffective){
			                		If (Math.Abs(((monNOA + monIA)/TotalMonths)) > Math.Abs(MonthlyRentEffectiveMonth)){
			                			BCCMoveForwardAmount = Math.Abs(((monNOA + monIA)/totalMonths)) - Math.Abs(MonthlyRentEffectiveMonth);
			                			BCCMoveForwardAmountIA = BCCMoveForwardAmount/(noaOrParkSqFt + iaSqFt) * iaSqFt;
										BCCMoveForwardAmountNOA = BCCMoveForwardAmount/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt;
										monthlyNOA.put(i, MonthlyRentEffectiveMonth/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt);
				                 		monthlyIA.put(i, MonthlyRentEffectiveMonth/(noaOrParkSqFt + iaSqFt ) * iaSqFt);
				                 		blnProRatedFirstMonthBCC = true;
			                		}
			                	} 
			                	// Expiration Month ... 
			                	If (i == expiryEdate.month() && intLoopFY == expiryFY && compareMonths <= calcMonthDiff && compareMonths > 0){
			                		If (expiryEdate.month() == monthEffective && calcFiscalYr == expiryFY){ // Expiration Month = Effective Month, put all amount in one month
			                			monthlyNOA.put(i, monNOA);
				                 		monthlyIA.put(i, monIA);
			                		} else {
			                			//Effective Month
			                			If (blnProRatedFirstMonthBCC){
			                				If (Math.Abs(((monNOA + monIA)/TotalMonths)) > Math.Abs(MonthlyRentEffectiveMonth)){
				                				BCCEffectiveMonthTemp =  MonthlyRentEffectiveMonth;
				                			}  else {
				                				BCCEffectiveMonthTemp = (monNOA + monIA)/totalMonths;
				                			}	
			                			} else {
			                				If (Math.Abs(((monNOA + monIA)/TotalMonths)) > Math.Abs(MonthlyRentOtherMonths)){
				                				BCCEffectiveMonthTemp =  MonthlyRentOtherMonths;
				                			}  else {
				                				BCCEffectiveMonthTemp = (monNOA + monIA)/totalMonths;
				                			}	
			                			}
			                			//Months Inbetween
			                			if (totalMonths > 2){
			                				If (Math.Abs(((monNOA + monIA)/TotalMonths)) > Math.Abs(MonthlyRentOtherMonths)){
				                				BCCEffectiveMonthTemp +=  MonthlyRentOtherMonths * (totalMonths - 2);
				                			} else {
				                				BCCEffectiveMonthTemp += ((monNOA + monIA)/totalMonths) * (totalMonths - 2);
				                			}
			                			}
			                			//Total - (Effective Month + Months Inbetween)
			                			BCCEffectiveMonthTemp = curObject.Amount__c - BCCEffectiveMonthTemp;
			                			System.Debug ('MyDebug - BCCEffectiveMonthTemp3 = ' + BCCEffectiveMonthTemp);
			                			monthlyNOA.put(i, BCCEffectiveMonthTemp/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt);
				                 		monthlyIA.put(i, BCCEffectiveMonthTemp/(noaOrParkSqFt + iaSqFt ) * iaSqFt);
			                		}
			                	}
			                }
			                
			                //Rent Free Period ...
			                if (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period')){
			                	//TotalMonthsRentFree = (totalMonths - 1) == 0? 1 : (totalMonths - 1);
			                	TotalMonthsRentFree = totalMonths;
			                	if (i == monthEffective && intLoopFY == calcFiscalYr){
			                		monthlyNOA.put(i, ((monNOA/TotalMonthsRentFree) * calcDayDiff) /  calcDaysInMonth);
			                 		monthlyIA.put(i, ((monIA/TotalMonthsRentFree) * calcDayDiff) / calcDaysInMonth);
			                	}
			                	if (i == expiryEdate.month() && intLoopFY == expiryFY){
			                		If (expiryEdate.month() == monthEffective && calcFiscalYr == expiryFY){ // Expiration Month = Effective Month, put all amount in one month
			                			monthlyNOA.put(i, curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt);
				                 		monthlyIA.put(i, curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt);
			                		} else {
			                			if (curObject.LumSumType__c != null && curObject.LumSumType__c.equalsIgnoreCase('Rent Free Period') && calcEdate.Day() <> 1){
			                				NOATotalsToDate  = ((monNOA/TotalMonthsRentFree) * (TotalMonthsRentFree - 1)) + (((monNOA/TotalMonthsRentFree) * calcDayDiff) / calcDaysInMonth);
				                			IATotalsToDate  = ((monIA/TotalMonthsRentFree) * (TotalMonthsRentFree - 1)) + (((monIA/TotalMonthsRentFree) * calcDayDiff) / calcDaysInMonth);
			                			} else {
			                				NOATotalsToDate  = ((monNOA/TotalMonthsRentFree) * (TotalMonthsRentFree - 2)) + (((monNOA/TotalMonthsRentFree) * calcDayDiff) / calcDaysInMonth);
				                			IATotalsToDate  = ((monIA/TotalMonthsRentFree) * (TotalMonthsRentFree - 2)) + (((monIA/TotalMonthsRentFree) * calcDayDiff) / calcDaysInMonth);		 
			                			}
				                		monthlyNOA.put(i, (curObject.Amount__c/(noaOrParkSqFt + iaSqFt) * noaOrParkSqFt) - NOATotalsToDate );
				                 		monthlyIA.put(i, (curObject.Amount__c/(noaOrParkSqFt + iaSqFt ) * iaSqFt) - IATotalsToDate );
			                		}
			                	}
			                }
			                //Rent Free Period - Effective Date, and Expiration Date Month calculation ...
			                 */
			                YearlyObligations = YearlyObligations + monthlyIA.get(i) + monthlyNOA.get(i);
			                YearlyObligationsIA = YearlyObligationsIA + monthlyIA.get(i); 
			                YearlyObligationsNOA = YearlyObligationsNOA + monthlyNOA.get(i);
	
			          	} //Month Loop ends here
			          	
			          	If (!blnCurrentYearLoaded) { 
			            	// Assign values to Current Year Monthly 
				            curObject.OCT_NOA__c = monthlyNOA.get(10);
				            curObject.NOV_NOA__c = monthlyNOA.get(11);
				            curObject.DEC_NOA__c = monthlyNOA.get(12);
				            curObject.JAN_NOA__c = monthlyNOA.get(1);
				            curObject.FEB_NOA__c = monthlyNOA.get(2);
				            curObject.MAR_NOA__c = monthlyNOA.get(3);
				            curObject.APR_NOA__c = monthlyNOA.get(4);
				            curObject.MAY_NOA__c = monthlyNOA.get(5);
				            curObject.JUN_NOA__c = monthlyNOA.get(6);
				            curObject.JUL_NOA__c = monthlyNOA.get(7);
				            curObject.AUG_NOA__c = monthlyNOA.get(8);
				            curObject.SEP_NOA__c = monthlyNOA.get(9);
				            curObject.OCT_IA__c = monthlyIA.get(10);
				            curObject.NOV_IA__c = monthlyIA.get(11);
				            curObject.DEC_IA__c = monthlyIA.get(12);
				            curObject.JAN_IA__c = monthlyIA.get(1);
				            curObject.FEB_IA__c = monthlyIA.get(2);
				            curObject.MAR_IA__c = monthlyIA.get(3);
				            curObject.APR_IA__c = monthlyIA.get(4);
				            curObject.MAY_IA__c = monthlyIA.get(5);
				            curObject.JUN_IA__c = monthlyIA.get(6);
				            curObject.JUL_IA__c = monthlyIA.get(7);
				            curObject.AUG_IA__c = monthlyIA.get(8);
				            curObject.SEP_IA__c = monthlyIA.get(9);
				            curObject.ExpirationDate__c = expiryEdateOriginal; //Rent-Free period modifies this for calculations, so reset it back ... for other LS types, this is just a overwrite of the same value.
				            curObject.FY_Obligation__c = YearlyObligations;
			                curObject.FY_Obligation_IA__c = YearlyObligationsIA; 
			                curObject.FY_Obligation_NOA__c = YearlyObligationsNOA;
			                
				            //Accrual Amount Was on Lump Sums but removed from LP Lump Sums
				            //curObject.AccuralAmt__c = 0;
				            //if(curObject.ProcessedDateFY__c > curObject.EffectiveDateFY__c && curObject.StatusCD__c != null) {
				            //	curObject.AccuralAmt__c  = curObject.FY_Obligation__c;
				            //}
				            
				            blnCurrentYearLoaded = true;
			            }
		            
		          		objLSObligationsByFY.Add(new GLXY_LPLumpSumObligations__c(
				            	FiscalYear__c = String.ValueOf(intLoopFY),
				               	FYAndLSId__c = String.ValueOf(intLoopFY) + curObject.Name,
				                LPLumpSum__c = curObject.ID,
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
					            SEP_IA__c = monthlyIA.get(9),
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
				            	SEP_NOA__c = monthlyNOA.get(9)
				         ));
		            }//FY Loop ends here
		        }
	
		    }
		    //Query and delete all Oligation records for the Lump Sums which were created new or updated ...
	        GLXY_LPLumpSumObligations__c[] objsToDelete = [select id from GLXY_LPLumpSumObligations__c where LPLumpSum__c IN :UpdatedOrNewRecordIDs];
	        Delete objsToDelete; 
	                
	        //Final Obligation amounts by FY Update ...
	        Database.UpsertResult[] Upsertresults = Database.Upsert(objLSObligationsByFY, Schema.GLXY_LPLumpSumObligations__c.FYAndLSId__c, false);
			
		}
	}
		
	if(Trigger.isAfter && Trigger.isinsert){
		String strComments;
		for (Glxy_LPLumpSum__c LS : Trigger.new) { 
			If (LS.Comments__c == null){
				strComments = ' ';
			} else {
				strComments = LS.Comments__c + ' ';
			}  
			       
         	objUpdateComments.Add(
         		New Glxy_LPLumpSum__c(
            		ID = LS.ID,
               		Comments__c = strComments)
            );
        } 
		Update objUpdateComments;
	}
	
}