trigger Glxy_AssociatedLeasesTrigger on Glxy_AssociatedLeases__c (before update, before insert, before delete, after delete, after update, after insert) {
	
	List<Glxy_DoubleRent__c> objDoubleRent = New List<Glxy_DoubleRent__c>();
	
	// Block 1 -Trigger.isAfter
	if(Trigger.isAfter) {  
		if(GLXY_Utility.hasUpdated() != true) {
	       	Map<Id,Glxy_AssociatedLeases__c> assocLease = new Map<Id,Glxy_AssociatedLeases__c> ();
	       	if(Trigger.isUpdate || Trigger.isInsert) {
				assocLease = new Map<Id,Glxy_AssociatedLeases__c> ([SELECT Id FROM Glxy_AssociatedLeases__c WHERE Id IN :Trigger.newMap.keySet()]);
	       	}
	       	Set<Id> projectIds = new Set<Id> ();
	
			if(Trigger.isDelete) {
		    	Set<Id> leaseIds = new Set<Id> ();
			    for(Glxy_AssociatedLeases__c a : Trigger.old) {
		        	if(!projectIds.contains(a.Project__c)) projectIds.add(a.Project__c);
		            if(!leaseIds.contains(a.Lease__c)) leaseIds.add(a.Lease__c);
				}
		        Map<Id,Glxy_AssociatedLeases__c> assocLeaseOld2 = 
		        new Map<Id,Glxy_AssociatedLeases__c> ([SELECT Id, Lease__c, Project__c FROM Glxy_AssociatedLeases__c WHERE Project__c IN :projectIds OR Lease__c IN :leaseIds]);
		            
				for(Glxy_AssociatedLeases__c a : assocLeaseOld2.values() ) {
				    if(!assocLease.containsKey(a.Id)) assocLease.put(a.Id, a);
				}
				System.Debug('assocLease is ' + assocLease + ' and projectIds are ' + projectIds);
		    }
	        
		    System.Debug('Trigger.isInsert is ' + Trigger.isInsert);
		    Glxy_OldIAAndNOAForProject.calculateOldIANOA(assocLease.keySet(), Trigger.isInsert, 'Associated', projectIds); 
	    }
	}
	// Block 1 -Trigger.isAfter

	// Block 2 -Trigger.isBefore
	if(Trigger.isBefore & (Trigger.isInsert || Trigger.isUpdate)) {
 		// Get a collection of Lease IDs associated with the records that are in Trigger.new 
   	 	Set<Id> projectIds = new Set<Id>();
   	 	Set<Id> UpdatedOrNewRecordIDs = new Set<Id>();
	    for(Glxy_AssociatedLeases__c c: trigger.new) {
        	projectIds.add(c.Project__c);
        	UpdatedOrNewRecordIDs.add (c.ID);
    	}
        // Get the Parking Only, Structured and Surface Parking,IA Conversion Date, Total IA and NOA fields from the Lease object
    	Map<Id,Glxy_LeaseProjects__c> projects = new Map<Id,Glxy_LeaseProjects__c>([SELECT id, Project_Type__c, IAConverstionFY__c, ParkingOnly__c from Glxy_LeaseProjects__c where id IN :projectIds]);
	    
	    for (Glxy_AssociatedLeases__c curObj: Trigger.new) {
	        //Declarations A - Z
	        Date calcYearEnd;
	        Integer calcDayDiff;
	        Integer calcDaysInMonth;
        	Integer calcMonthDiff;
	        //Initializations A - Z
	        if(curObj.Project_Effective_Date__c == null || curObj.LeaseExpiration_lkp__c == null) {
	            curObj.Double_Rent__c = curObj.OCT__c = curObj.NOV__c = curObj.DEC__c = curObj.JAN__c = curObj.FEB__c = curObj.MAR__c = curObj.APR__c = 
	            curObj.MAY__c = curObj.JUN__c = curObj.JUL__c = curObj.AUG__c = curObj.SEP__c = 0;
	            continue;
	        }
        
	        Date calcEdate = curObj.Project_Effective_Date__c;
	        Date expirationFY = (curObj.Termination_Date__c != null)? curObj.Termination_Date__c : curObj.LeaseExpiration_lkp__c;
	        Integer ExpirationYear = (expirationFY.month() > 9)? expirationFY.year() + 1 : expirationFY.year();
	        Integer intCurrentYearMonth = date.today().Month();
	        Integer intCurrentYearDay= date.today().day();
	        Decimal monRent;
	        If(intCurrentYearMonth == 10 && intCurrentYearDay == 1){
	        	monRent = curObj.Annual_Rent__c/12;
	        }else{
	        	monRent = curObj.Lease_Annual_Rent__c/12;
	        }
	        Integer calcExpDaysInMonth;
	        Integer calcFiscalYr = (calcEdate.month() > 9)? calcEdate.year() + 1 : calcEdate.year();
	        Integer dayEffective = calcEdate.day();
	        Integer monthEffective = calcEdate.month();
	        Integer totalMonths;
	        //Integer yearEffective = calcEdate.year();
	        Integer yearEffective = (calcEdate.month() > 9)? calcEdate.year() + 1 : calcEdate.year();
	        calcYearEnd = date.newInstance(calcFiscalYr, 9, 30);
	        calcDaysInMonth = date.daysInMonth(calcEdate.year(), calcEdate.month());
	        calcDayDiff = calcEdate.daysBetween(date.newInstance(calcEdate.year(), calcEdate.month(), calcDaysInMonth))+1;
	       	
	       	Integer IANOAConversionFY;
	       	Decimal IAMultiplier;
        	Decimal NOAMultiplier;
        	
        	Decimal DoubleRentTotalIA = 0.0;
			Decimal DoubleRentTotalNOA = 0.0;
			Decimal DoubleRentTotal = 0.0;
				
	       	//Galaxy Release 2.0
	       	Decimal ProjectIASqFt = 0.0;
	       	Decimal ProjectNOASqFt = 0.0;
	       	If (curObj.LeaseIASqFtlookup__c != null){
	       		//ProjectIASqFt = curObj.ProjectIASqFtlookup__c; // Galaxy 2.1
	       		ProjectIASqFt = curObj.LeaseIASqFtlookup__c; // Galaxy 2.1 <-- Calculate DR based off Lease Sq Ft.
	       	}
	       	If (curObj.LeaseNOASqFtlookup__c != null){
	       		//ProjectNOASqFt = curObj.ProjectNOASqFtlookup__c; // Galaxy 2.1
	       		ProjectNOASqFt = curObj.LeaseNOASqFtlookup__c; // Galaxy 2.1
	       	}
	       	Decimal ProjectTotalSqFt = ProjectIASqFt + ProjectNOASqFt;
			if (ProjectTotalSqFt <= 0) {
           		ProjectTotalSqFt = 1.0;
        	}
        	
        	//Galaxy Release 2.0
			if (expirationFY > calcYearEnd) {
           		//expirationFY = calcYearEnd;
        	}
        	
        	calcExpDaysInMonth = date.daysInMonth(expirationFY.year(), expirationFY.month());
	        totalMonths = calcMonthDiff = calcEdate.monthsBetween(expirationFY) + 1;
	        Map<Integer,String> monthlyFields = new Map<Integer,String> {1 => 'JAN__c', 2 => 'FEB__c', 3 => 'MAR__c', 4 => 'APR__c', 5 => 'MAY__c', 6 => 'JUN__c', 7 => 'JUL__c', 8 => 'AUG__c', 9 => 'SEP__c', 10 => 'OCT__c', 11 => 'NOV__c', 12 => 'DEC__c'};
        	Map<Boolean,Integer> fYear = new Map<Boolean, Integer> {true => calcFiscalYr - 1, false => calcFiscalYr};
       		Integer compareMonths;
       		Integer GSAFY;
       		curObj.DoubleRentNOA__c = 0;
       		curObj.DoubleRentIA__c = 0;
       		curObj.Double_Rent__c = 0;
       		
           	if (projects.containsKey(curObj.Project__c)) {
           		if (projects.get(curObj.Project__c).Project_Type__c != null && projects.get(curObj.Project__c).Project_Type__c.equalsIgnoreCase('New/Replacing')) {
           			IANOAConversionFY = Integer.valueOf(projects.get(curObj.Project__c).IAConverstionFY__c);
	            	for (Integer LoopFY = ExpirationYear; LoopFY >= yearEffective; LoopFY --) { 
	            		If (IANOAConversionFY <= LoopFY) {
	            			//All IA Converted to NOA during this FY ...
	            			IAMultiplier = 0;
        					NOAMultiplier = ((ProjectNOASqFt + ProjectIASqFt)/ProjectTotalSqFt);
	            		}else{
	            			IAMultiplier = (ProjectIASqFt/ProjectTotalSqFt);
        					NOAMultiplier = (ProjectNOASqFt/ProjectTotalSqFt);
	            		}
						If (projects.get(curObj.Project__c).ParkingOnly__c.equalsIgnoreCase('Yes')) { // Parking-Only Projects, always NOA, irrespective of IA/NOA conversion Date
	            			IAMultiplier = 0;
	            			NOAMultiplier = 1;
						}	
	            		GSAFY = LoopFY; 
	            		System.Debug ('MyDebug - LoopFY' + LoopFY);
	            		for (Integer i=1; i<=12; i++) { 
	            			System.Debug ('MyDebug - month' + i);
	              			if (i == 10) {
		                    	GSAFY = GSAFY - 1 ;
	              			} 
		                	System.Debug ('MyDebug - GSAFY' + GSAFY);
		                	CompareMonths = date.newInstance(GSAFY, i, 1).monthsBetween(expirationFY) + 1;
	            			System.Debug ('MyDebug - compareMonths' + compareMonths);
	              			if (compareMonths > 0 && expirationFY > calcEdate ) {
								if(LoopFY == ExpirationYear && i == monthEffective && ExpirationYear == yearEffective && expirationFY.month() == monthEffective) {
	                                System.Debug ('MyDebug - Inside If Condition 1');
	                                curObj.put(monthlyFields.get(i), (monRent/calcDaysInMonth) * (calcEdate.daysBetween(expirationFY)+1));
	                            } else if(LoopFY == yearEffective && i == monthEffective) {
	                            	System.Debug ('MyDebug - Inside If Condition 2');
	                                curObj.put(monthlyFields.get(i), (monRent/calcDaysInMonth) * calcDayDiff);
	                            } else if (LoopFY == ExpirationYear
	                                       && i == expirationFY.month() 
	                                       && date.daysInMonth(expirationFY.year(), expirationFY.month())!= expirationFY.day()) {
	                                System.Debug ('MyDebug - Inside If Condition 3');
	                                curObj.put(monthlyFields.get(i), (monRent/calcExpDaysInMonth) * expirationFY.day());
	                            } else if (compareMonths <= calcMonthDiff) {
	                            	System.Debug ('MyDebug - Inside If Condition 4');
	                                curObj.put(monthlyFields.get(i), monRent);
	                            } else {
	                            	System.Debug ('MyDebug - Inside If Condition 5');
	                                curObj.put(monthlyFields.get(i), 0);
	                            }
	                        } else {
	                            curObj.put(monthlyFields.get(i), 0);
	                        } 
	                   	}// End Of For Loop Monthly
	                   	objDoubleRent.Add(new Glxy_DoubleRent__c(
				            	Fiscal_Year__c = String.ValueOf(LoopFY),
				               	FYAndId__c = String.ValueOf(LoopFY) + curObj.Name,
				                Associated_Leases_Projects_ID__c = curObj.ID,
				                OCT_IA__c = ((Decimal) curObj.get(monthlyFields.get(10)) * IAMultiplier),
					           	NOV_IA__c = ((Decimal) curObj.get(monthlyFields.get(11)) * IAMultiplier),
					            DEC_IA__c = ((Decimal) curObj.get(monthlyFields.get(12)) * IAMultiplier),
					            JAN_IA__c = ((Decimal) curObj.get(monthlyFields.get(1)) * IAMultiplier),
					            FEB_IA__c = ((Decimal) curObj.get(monthlyFields.get(2)) * IAMultiplier),
					            MAR_IA__c = ((Decimal) curObj.get(monthlyFields.get(3)) * IAMultiplier),
					            APR_IA__c = ((Decimal) curObj.get(monthlyFields.get(4)) * IAMultiplier),
					            MAY_IA__c = ((Decimal) curObj.get(monthlyFields.get(5)) * IAMultiplier),
					            JUN_IA__c = ((Decimal) curObj.get(monthlyFields.get(6)) * IAMultiplier),
					            JUL_IA__c = ((Decimal) curObj.get(monthlyFields.get(7)) * IAMultiplier),
					            AUG_IA__c = ((Decimal) curObj.get(monthlyFields.get(8)) * IAMultiplier),
					            SEP_IA__c = ((Decimal) curObj.get(monthlyFields.get(9)) * IAMultiplier),
					            OCT_NOA__c = ((Decimal) curObj.get(monthlyFields.get(10)) * NOAMultiplier),
				            	NOV_NOA__c = ((Decimal) curObj.get(monthlyFields.get(11)) * NOAMultiplier),
				            	DEC_NOA__c = ((Decimal) curObj.get(monthlyFields.get(12)) * NOAMultiplier),
				            	JAN_NOA__c = ((Decimal) curObj.get(monthlyFields.get(1)) * NOAMultiplier),
				            	FEB_NOA__c = ((Decimal) curObj.get(monthlyFields.get(2)) * NOAMultiplier),
				            	MAR_NOA__c = ((Decimal) curObj.get(monthlyFields.get(3)) * NOAMultiplier),
				            	APR_NOA__c = ((Decimal) curObj.get(monthlyFields.get(4)) * NOAMultiplier),
				            	MAY_NOA__c = ((Decimal) curObj.get(monthlyFields.get(5)) * NOAMultiplier),
				            	JUN_NOA__c = ((Decimal) curObj.get(monthlyFields.get(6)) * NOAMultiplier),
				            	JUL_NOA__c = ((Decimal) curObj.get(monthlyFields.get(7)) * NOAMultiplier),
				            	AUG_NOA__c = ((Decimal) curObj.get(monthlyFields.get(8)) * NOAMultiplier),
				            	SEP_NOA__c = ((Decimal) curObj.get(monthlyFields.get(9)) * NOAMultiplier)
				         ));
				         DoubleRentTotalIA += ((Decimal) curObj.get(monthlyFields.get(10)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(11)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(12)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(1)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(2)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(3)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(4)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(5)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(6)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(7)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(8)) * IAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(9)) * IAMultiplier);
				         DoubleRentTotalNOA += ((Decimal) curObj.get(monthlyFields.get(10)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(11)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(12)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(1)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(2)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(3)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(4)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(5)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(6)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(7)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(8)) * NOAMultiplier) + ((Decimal) curObj.get(monthlyFields.get(9)) * NOAMultiplier);
           			}//End of Loop for FY 
              		expirationFY = (curObj.Termination_Date__c != null) ? curObj.Termination_Date__c: curObj.LeaseExpiration_lkp__c;
                    calcExpDaysInMonth = date.daysInMonth(expirationFY.year(), expirationFY.month());
                    totalMonths = calcEdate.monthsBetween(expirationFY) + 1;
        
                    if (totalMonths > 0 && expirationFY > calcEdate) {
                        /*if (totalMonths > 0 && (expirationFY.year() == yearEffective && expirationFY.month() == monthEffective)) {
                            curObj.Double_Rent__c = (monRent/calcDaysInMonth) * (calcEdate.daysBetween(expirationFY)+1);
                       	} else {
                            curObj.Double_Rent__c = ((totalMonths-2) * monRent)
                                                      + ((monRent/calcExpDaysInMonth) * expirationFY.day())
                                                      + ((monRent/calcDaysInMonth) * calcDayDiff);
                        }
                        curObj.DoubleRentNOA__c = curObj.Double_Rent__c * NOAMultiplier;
                        curObj.DoubleRentIA__c = curObj.Double_Rent__c * IAMultiplier;*/
                        curObj.DoubleRentIA__c = DoubleRentTotalIA;
                        curObj.DoubleRentNOA__c = DoubleRentTotalNOA;
                        curObj.Double_Rent__c = DoubleRentTotalIA + DoubleRentTotalNOA;
                    }  
                    
                    if(trigger.isupdate && intCurrentYearMonth == 10 && intCurrentYearDay == 1){
    					curObj.Lease_Annual_Rent__c = curObj.Annual_Rent__c;
    				}             
               	}
            } 
            
    	}//for (Glxy_AssociatedLeases__c curObj: Trigger.new
    	
    	//Query and delete all Double Rent records for the Associate Lease Project which were created new or updated ...
		Glxy_DoubleRent__c[] objsToDelete = [select id from Glxy_DoubleRent__c where Associated_Leases_Projects_ID__c IN :UpdatedOrNewRecordIDs];
		Delete objsToDelete; 
    	//Final Double Rent FY Update ...
		Database.UpsertResult[] Upsertresults = Database.Upsert(objDoubleRent, Schema.Glxy_DoubleRent__c.FYAndId__c, false);
	}//if(Trigger.isBefore & (Trigger.isInsert || Trigger.isUpdate))
	// Block 2 -Trigger.isBefore
	
	// Block 3 -Trigger.isBefore and isDelete
	if(Trigger.isBefore && Trigger.isDelete) {
		List<string> profileNamelist= new list<string>();
		profileNamelist.add('GSA System Administrator');
		profileNamelist.add('System Administrator');
		Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
		string adminUser= [select id from user where name='CastIron User'].id;
		system.debug(adminUser);
		system.debug(adminProfileMap);
		string RexusRecordType=Schema.SObjectType.Glxy_AssociatedLeases__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		system.debug(RexusRecordType);		
		for(Glxy_AssociatedLeases__c pi:trigger.old ){
  			if(pi.RecordTypeid==RexusRecordType){
 				if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null){
   					continue;
  				}
   				pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');
			}
		}
	}
    // Block 3 -Trigger.isBefore and isDelete

}