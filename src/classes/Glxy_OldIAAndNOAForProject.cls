public with sharing class Glxy_OldIAAndNOAForProject {
    
    // Executing this method asynchronously. 
    /* 
     * Calculate the Old NOA and Old IA of the project based on Leases,
     * Lease Agencies ASA and Associated Leases
     * 
     * @params assocLeaseIds - Associated Lease ids based on the following:
     *                         - Any Lease that is inserted or updated and
     *                           and if a Lease does not have a Termination
     *                           date get the data from the Lease Agency ASA
     *                         - Any Project that is inserted or updated
     *                         - Any Association inserted, updated or deleted
     *         insertAction - flag to indicate if it is an insert action
     * 
     */
    public static void calculateOldIANOA(Set<Id> assocLeaseIds, boolean insertAction, String objectName, Set<Id> deletedIds) {
        
        
        System.Debug('assocLeaseIds.size = ' + assocLeaseIds.size() + ', insertAction is ' + insertAction + ' and objectName is ' + objectName);
        
        /* 
         * Fetching Associated Lease data to get Projects, Leases, 
         * Lease Agencies and Project Agencies data.
         *
         * This fetch is to only sort data between 'New/Replacing'
         * projects and all other project types.
         */
        Map<Id,Glxy_AssociatedLeases__c> assocLease = 
                new Map<Id,Glxy_AssociatedLeases__c> ([
                    SELECT Id, Lease__c, Project__c, Project__r.Project_Type__c 
                    FROM Glxy_AssociatedLeases__c 
                    WHERE Id IN :assocLeaseIds
                ]);
        
        Set<Id> leaseIdsWithoutNewReplacing = new Set<Id>();
        Set<Id> projectIdsOnlyNewReplacing = new Set<Id>();
        
        for (Glxy_AssociatedLeases__c al: assocLease.values()) 
        {
    
            if(al.Project__r.Project_Type__c == null || !(al.Project__r.Project_Type__c.equalsIgnoreCase('New/Replacing'))) {
                leaseIdsWithoutNewReplacing.add(al.Lease__c);
            } else {
                projectIdsOnlyNewReplacing.add(al.Project__c);
                
            }
        }
        
        /*
         * Using List to process data in the order it is received.
         * Using child-parent relationship query to get all the 
         * relevant Lease and Project data.
         * 
         * Ordering the returned results in the Ascencing order of 
         * Lease Name and Project Effect Date.
         */
        List<Glxy_AssociatedLeases__c> assocLeasesWithoutNewReplacing = ([
                SELECT Id, Lease__c, Project__c, Project_Effective_Date__c, Rexus_Termination_Date__c, LeaseExpiration_lkp__c,
                       Lease__r.Name, Lease__r.Total_NOA_Sq_feet__c, Lease__r.Total_IA_Sq_feet__c, Lease__r.IAConverstionDate__c,
                       Project__r.Name, Project__r.NOASquareFeet__c, Project__r.IASquareFeet__c, Project__r.Project_Type__c, 
                       Project__r.OldIASqFt__c, Project__r.OldNOASqFt__c, Project__r.CalculatedOldIASqFt__c, Project__r.CalculatedOldNOASqft__c,
                       Project__r.AssociatedLeases_lkup__c, Project__r.Old_Square_Feet__c, Project__r.OldRate__c, Project__r.ParkingOnly__c,
                       Project__r.Old_Annual_Rent__c, Project__r.IAConversionDate__c, Project__r.UpdateOldNOAIA__c
                FROM Glxy_AssociatedLeases__c 
                WHERE Lease__c IN :leaseIdsWithoutNewReplacing 
                And Project__r.Project_Type__c <> 'New/Replacing'
                And Project__r.ProjectStatus__c <> 'Cancelled' 
                And Project__r.BDGFlag__c = true
                And Project__r.CheckCOApproval__c = false
                ORDER BY Lease__r.Name, Project_Effective_Date__c
            ]);
            
        List<Glxy_AssociatedLeases__c> assocLeasesOnlyNewReplacing = ([
                SELECT Id, Lease__c, Project__c, Project_Effective_Date__c, Rexus_Termination_Date__c, LeaseExpiration_lkp__c,
                       Lease__r.Name, Lease__r.Total_NOA_Sq_feet__c, Lease__r.Total_IA_Sq_feet__c, Lease__r.IAConverstionDate__c,
                       Project__r.Name, Project__r.NOASquareFeet__c, Project__r.IASquareFeet__c, Project__r.Project_Type__c, 
                       Project__r.OldIASqFt__c, Project__r.OldNOASqFt__c, Project__r.CalculatedOldIASqFt__c, Project__r.CalculatedOldNOASqft__c,
                       Project__r.AssociatedLeases_lkup__c, Project__r.Old_Square_Feet__c, Project__r.OldRate__c, Project__r.ParkingOnly__c,
                       Project__r.Old_Annual_Rent__c, Project__r.IAConversionDate__c, Project__r.UpdateOldNOAIA__c
                FROM Glxy_AssociatedLeases__c 
                WHERE Project__c IN :projectIdsOnlyNewReplacing 
                AND Project__r.Project_Type__c = 'New/Replacing'
                And Project__r.ProjectStatus__c <> 'Cancelled'
                And Project__r.BDGFlag__c = true
                And Project__r.CheckCOApproval__c = false
                ORDER BY Project__r.Name
            ]);
        
        Set<Id> leaseIdWithoutTermDate = new Set<Id>();
        Set<Id> projectsForLeaseWithoutTermDate = new Set<Id> ();    
        for (Glxy_AssociatedLeases__c al: assocLeasesOnlyNewReplacing) {
        	if( al.Rexus_Termination_Date__c == null) {
                leaseIdWithoutTermDate.add(al.Lease__c);
                projectsForLeaseWithoutTermDate.add(al.Project__c);
            }
        }
        
                
        // create a Lease Agencies Map with the Lease Id as Key 
        Map<Id,Map<Id,Glxy_LeaseAgencies__c>> leaseAgencies = new Map<Id,Map<Id,Glxy_LeaseAgencies__c>> ();
        
        for(Glxy_LeaseAgencies__c l: ([
                        SELECT Id, REXUSASA__c, REXUSASA_IASqFt__c, REXUSASA_NOASqFt__c, LeaseNumber__c 
                        FROM Glxy_LeaseAgencies__c 
                        WHERE LeaseNumber__c IN :leaseIdWithoutTermDate
                        ORDER BY LeaseNumber__r.Name
                    ])
        ) {
            
            // creating a Map of ASA's by Lease Number
            if(leaseAgencies.containsKey(l.LeaseNumber__c)) {
                leaseAgencies.get(l.LeaseNumber__c)
                             .put(l.Id, l);
            } else {
                leaseAgencies.put(l.LeaseNumber__c, new Map<Id,Glxy_LeaseAgencies__c> {l.Id => l});
            }
        }
        
        System.Debug('******* leaseAgencies size is ' + leaseAgencies.size());
        
        Map<Id,Set<String>> projectAgencies = new Map<Id,Set<String>> ();
        //G2 2.1 - Query Changed to read from project Request ASA
        for(Glxy_ProjectRequestASA__c p : ([
                            SELECT ProjectAgencyID__r.Id, OldASA__c, ProjectAgencyID__r.ProjectNumber__c 
                            FROM Glxy_ProjectRequestASA__c 
                            WHERE ProjectAgencyID__r.ProjectNumber__c IN :projectsForLeaseWithoutTermDate
                            ORDER BY ProjectAgencyID__r.ProjectNumber__r.Name
                        ])
        ) {
            
            // creating a Map of ASAs by Project Number
            if(projectAgencies.containsKey(p.ProjectAgencyID__r.ProjectNumber__c)) {
                projectAgencies.get(p.ProjectAgencyID__r.ProjectNumber__c)
                               .add(p.OldASA__c);
            } else {
                projectAgencies.put(p.ProjectAgencyID__r.ProjectNumber__c, new Set<String> {p.OldASA__c});
            }
        }
            
        /*
         * Using curName to maintain the current Lease processing.
         * Using iANOA to maintain prev. Lease or Project values
         * for the a given record.
         */
        String curName = '';
        Map<String,Decimal> iANOA = new Map<String,Decimal> {'IA' => 0, 'NOA' => 0};
        
        // Map that will hold all our results to be updated at the end
        Map<Id,Glxy_LeaseProjects__c> projects = new Map<Id,Glxy_LeaseProjects__c>();
        
        // Old IA and NOA value placeholders
        Map<String, Decimal> fieldValues = new Map<String, Decimal> {'OldIA' => 0, 'OldNOA' => 0};
        
        String strAssociatedLeases;
        
System.Debug('***###%%%$$$ ********* assocLeasesWithoutNewReplacing.size() = ' + assocLeasesWithoutNewReplacing.size());

		Date CurrentProjectIAConversionDate; //IA NOA Conversion Logic Change - Post Release 1.1
		Date PreviousProjectIAConversionDate = Null; //IA NOA Conversion Logic Change - Post Release 1.1
		Boolean blnFirstProjectInTheList; //IA NOA Conversion Logic Change - Post Release 1.1
		String LeaseNameOld = ''; //IA NOA Conversion Logic Change - Post Release 1.1
		String LeaseNameNew = ''; //IA NOA Conversion Logic Change - Post Release 1.1
		
        // Calculating Old IA and NOA for all projects except 'New/Replacing' 
        for (Glxy_AssociatedLeases__c obj : assocLeasesWithoutNewReplacing) 
        {
            System.Debug('Project Name is ' + obj.Project__r.Name);
            //IA NOA Conversion Logic Change - Post Release 1.1
            LeaseNameNew = obj.Lease__r.Name; 
           
           If (LeaseNameNew != LeaseNameOld){
            	blnFirstProjectInTheList = true;
            }
            If (blnFirstProjectInTheList){
            	PreviousProjectIAConversionDate = obj.Lease__r.IAConverstionDate__c;
            	blnFirstProjectInTheList = false;
            } 
            CurrentProjectIAConversionDate = obj.Project__r.IAConversionDate__c; 
            //IA NOA Conversion Logic Change - Post Release 1.1
            
            // If Lease Name is same as curName continue processing for 
            // current lease.
            if(!curName.equalsIgnoreCase(obj.Lease__r.Name)) {
                curName = obj.Lease__r.Name;
                iANOA.putAll(new Map<String, Decimal> {'IA' => 0, 'NOA' => 0});
            }
            
            if(obj.Project__r.Project_Type__c != null && obj.Project__r.Project_Type__c.equalsIgnoreCase('New')) {   
                fieldValues.putAll(new Map<String, Decimal> { 'OldIA' => 0, 'OldNOA' => 0});
            } else {
                
                fieldValues.putAll(new Map<String, Decimal> {
                    'OldIA' => (iANOA.get('IA') > 0 || iANOA.get('NOA') > 0) ? iANOA.get('IA') : obj.Lease__r.Total_IA_Sq_feet__c,
                    'OldNOA' => (iANOA.get('IA') > 0 || iANOA.get('NOA') > 0) ? iANOA.get('NOA') : obj.Lease__r.Total_NOA_Sq_feet__c}
                    );
                                    
                // If Project Effective Date is beyond the IA Conversion Date, assign all values to NOA                    
                //if(obj.Lease__r.IAConverstionDate__c != null && obj.Lease__r.IAConverstionDate__c <= obj.Project_Effective_Date__c) {
                //IA NOA Conversion Logic Change - Post Release 1.1
                if(PreviousProjectIAConversionDate != null && PreviousProjectIAConversionDate <= obj.Project_Effective_Date__c) {
                    fieldValues.putAll(new Map<String, Decimal> {'OldNOA' => fieldValues.get('OldNOA') + fieldValues.get('OldIA'), 'OldIA' => 0 });
                } 
                
                System.Debug('Project to be updated is Name: ' + obj.Project__r.Name+' with values Old IA = ' + fieldValues.get('OldIA') + ' and NOA = ' +fieldValues.get('OldNOA'));
                    
            }
            
            // Reset iANOA to maintain values for the next Project
            iANOA.putAll(new Map<String, Decimal> {'IA' => obj.Project__r.IASquareFeet__c, 'NOA' => obj.Project__r.NOASquareFeet__c});
            
              strAssociatedLeases = objectName.equalsIgnoreCase('Associated')? (projects.containsKey(obj.Project__c) ? projects.get(obj.Project__c).AssociatedLeases_lkup__c: '') : obj.Project__r.AssociatedLeases_lkup__c;
              if(objectName.equalsIgnoreCase('Associated')) {
                if(!deletedIds.isEmpty() && deletedIds.contains(obj.Project__c)) deletedIds.remove(obj.Project__c);
              
              system.debug('1@'+strAssociatedLeases+'2@');
               system.debug(strAssociatedLeases.length() > 0? ', ': '');
                 system.debug('3@'+obj.Lease__r.Name);
                  system.debug('4@'+obj.LeaseExpiration_lkp__c);
                  strAssociatedLeases = String.format('{0}{1}{2}{3}{4}{5}',new List<String>{
                  strAssociatedLeases,
                  strAssociatedLeases!=''&&strAssociatedLeases!=null &&strAssociatedLeases.length() > 0? ', ': '',
                  obj.Lease__r.Name,
                  ' (',
                  obj.LeaseExpiration_lkp__c!=null?obj.LeaseExpiration_lkp__c.format():'',
                  ')'});
              }
            
            Decimal oldSqFt = fieldValues.get('OldIA') + fieldValues.get('OldNOA');
            Decimal oldRate = 0;
            if(obj.Project__r.ParkingOnly__c.equalsIgnoreCase('No')) {
                if(oldSqFt > 0) {
                    oldRate = obj.Project__r.Old_Annual_Rent__c/oldSqFt;
                }
            } else {
                oldRate = obj.Project__r.Old_Annual_Rent__c * (oldSqFt > -1 ? 1 : -1) / (oldSqFt == 0 ? 1 : oldSqFt);
            }
            
           	Decimal dbOldIA = 0.0;
			Decimal dbOldNOA = 0.0;
			if(obj.Project__r.UpdateOldNOAIA__c) {
                 projects.put(obj.Project__c, 
	                 new Glxy_LeaseProjects__c( 
	                     Id = obj.Project__c, 
	                     CalculatedOldIASqFt__c = fieldValues.get('OldIA'), 
	                     CalculatedOldNOASqft__c = fieldValues.get('OldNOA'), 
	                     AssociatedLeases_lkup__c = strAssociatedLeases, 
	                     OldIASqFt__c = fieldValues.get('OldIA'),  
	                     OldNOASqFt__c = fieldValues.get('OldNOA'), 
	                     Old_Square_Feet__c = oldSqFt,
	                     OldRate__c = oldRate));
            } else {
                     projects.put(obj.Project__c, 
                     new Glxy_LeaseProjects__c( 
                         Id = obj.Project__c, 
                         CalculatedOldIASqFt__c = fieldValues.get('OldIA'), 
                         CalculatedOldNOASqft__c = fieldValues.get('OldNOA'), 
                         AssociatedLeases_lkup__c = strAssociatedLeases, 
                         //OldIASqFt__c = insertAction?fieldValues.get('OldIA'):obj.Project__r.OldIASqFt__c, 
                         //OldNOASqFt__c = insertAction?fieldValues.get('OldNOA'):obj.Project__r.OldNOASqFt__c,
                         Old_Square_Feet__c = oldSqFt,
                         OldRate__c = oldRate));
            }    
           PreviousProjectIAConversionDate = CurrentProjectIAConversionDate; //IA NOA Conversion Logic Change - Post Release 1.1
           LeaseNameOld = LeaseNameNew;  
        
        }
System.Debug('***###%%%$$$ ********* assocLeasesOnlyNewReplacing.size() = ' + assocLeasesOnlyNewReplacing.size());
        
        // Calculating Old IA and NOA for all 'New/Replacing' projects
        for (Glxy_AssociatedLeases__c obj : assocLeasesOnlyNewReplacing) 
        {
        
            System.Debug('Project Name is ' + obj.Project__r.Name);
            
            // If Project Name is same as curName continue processing for 
            // current Project.
            if(!curName.equalsIgnoreCase(obj.Project__r.Name)) {
                curName = obj.Project__r.Name;
                iANOA.putAll(new Map<String, Decimal> {'IA' => 0, 'NOA' => 0});
            }
            
            // If we have a Termination Date on the Lease, use the Lease Total values
            // else get the values from ASA
            if(obj.Rexus_Termination_Date__c != null) {
                
                fieldValues.putAll(new Map<String, Decimal> {
                    'OldIA' => iANOA.get('IA') + obj.Lease__r.Total_IA_Sq_feet__c, 
                    'OldNOA' => iANOA.get('NOA') + obj.Lease__r.Total_NOA_Sq_feet__c}
                    );
                
            } else {
                fieldValues.putAll(new Map<String, Decimal> {'OldIA' => 0, 'OldNOA' => 0});
                if(leaseAgencies.containsKey(obj.Lease__c)) {
                    System.Debug('**************** ' +obj.Lease__r.Name);
                    for (Glxy_LeaseAgencies__c la: leaseAgencies.get(obj.Lease__c).values()) 
                    {
                        if(projectAgencies.containsKey(obj.Project__c) && projectAgencies.get(obj.Project__c).contains(la.REXUSASA__c)) {
                            System.Debug('**************** ASA IA = ' +la.REXUSASA_IASqFt__c + ' and ASA NOA = ' +la.REXUSASA_NOASqFt__c);
                            fieldValues.putAll(new Map<String, Decimal> {
                                'OldIA' => fieldValues.get('OldIA') + (la.REXUSASA_IASqFt__c != null ? la.REXUSASA_IASqFt__c:0),
                                'OldNOA' => fieldValues.get('OldNOA') + (la.REXUSASA_NOASqFt__c != null ? la.REXUSASA_NOASqFt__c:0)}
                                ); 
                        }
                    }
                    fieldValues.putAll(new Map<String, Decimal> {'OldIA' => iANOA.get('IA') + fieldValues.get('OldIA'), 'OldNOA' => iANOA.get('NOA') + fieldValues.get('OldNOA')});
                }
                
                System.Debug('Project to be updated is Name: ' + obj.Project__r.Name+' with values Old IA = ' + fieldValues.get('OldIA') + ' and NOA = ' +fieldValues.get('OldNOA') +
                    ' for lease name: ' + obj.Lease__r.Name);
                    
            }
            
            // If Project Effective Date is beyond the IA Conversion Date, assign all values to NOA                    
            if(obj.Lease__r.IAConverstionDate__c != null && obj.Lease__r.IAConverstionDate__c <= obj.Project_Effective_Date__c) {
                fieldValues.putAll(new Map<String, Decimal> {'OldNOA' => fieldValues.get('OldNOA') + fieldValues.get('OldIA'), 'OldIA' => 0 });
            }
            
            // Reset iANOA to maintain values for the next Lease
            iANOA.putAll(new Map<String, Decimal> {'IA' => fieldValues.get('OldIA'), 'NOA' => fieldValues.get('OldNOA')});
            
      strAssociatedLeases = objectName.equalsIgnoreCase('Associated')? (projects.containsKey(obj.Project__c) ? projects.get(obj.Project__c).AssociatedLeases_lkup__c: '') : obj.Project__r.AssociatedLeases_lkup__c;
      if(objectName.equalsIgnoreCase('Associated')) {
        if(!deletedIds.isEmpty() && deletedIds.contains(obj.Project__c)) deletedIds.remove(obj.Project__c);
        strAssociatedLeases = String.format('{0}{1}{2}{3}{4}{5}',new List<String>{
          strAssociatedLeases, 
          strAssociatedLeases!=''&&strAssociatedLeases!=null &&strAssociatedLeases.length() > 0? ', ': '',
          obj.Lease__r.Name,
          ' (',
          obj.LeaseExpiration_lkp__c!=null?obj.LeaseExpiration_lkp__c.format():'',
          ')'});
      }
            
            Decimal oldSqFt = fieldValues.get('OldIA') + fieldValues.get('OldNOA');
            Decimal oldRate = 0;
            if(obj.Project__r.ParkingOnly__c.equalsIgnoreCase('No')) {
                if(oldSqFt > 0) {
                    oldRate = obj.Project__r.Old_Annual_Rent__c/oldSqFt;
                }
            } else {
                oldRate = obj.Project__r.Old_Annual_Rent__c * (oldSqFt > -1 ? 1 : -1) / (oldSqFt == 0 ? 1 : oldSqFt);
            }
            
            // Add values for bulk project updates
            if(obj.Project__r.UpdateOldNOAIA__c) {
                 projects.put(obj.Project__c, 
	                 new Glxy_LeaseProjects__c( 
	                     Id = obj.Project__c, 
	                     CalculatedOldIASqFt__c = fieldValues.get('OldIA'), 
	                     CalculatedOldNOASqft__c = fieldValues.get('OldNOA'), 
	                     AssociatedLeases_lkup__c = strAssociatedLeases, 
	                     OldIASqFt__c = fieldValues.get('OldIA'),  
	                     OldNOASqFt__c = fieldValues.get('OldNOA'), 
	                     Old_Square_Feet__c = oldSqFt,
	                     OldRate__c = oldRate));
            } else {
                     projects.put(obj.Project__c, 
                     new Glxy_LeaseProjects__c( 
                         Id = obj.Project__c, 
                         CalculatedOldIASqFt__c = fieldValues.get('OldIA'), 
                         CalculatedOldNOASqft__c = fieldValues.get('OldNOA'), 
                         AssociatedLeases_lkup__c = strAssociatedLeases, 
                         //OldIASqFt__c = insertAction?fieldValues.get('OldIA'):obj.Project__r.OldIASqFt__c, 
                         //OldNOASqFt__c = insertAction?fieldValues.get('OldNOA'):obj.Project__r.OldNOASqFt__c,
                         Old_Square_Feet__c = oldSqFt,
                         OldRate__c = oldRate));
            }    

        }
    
        System.Debug('deletedIds are ' + deletedIds);
        
    /*for(Id a: deletedIds) {
      projects.put(a, new Glxy_LeaseProjects__c (Id = a, AssociatedLeases_lkup__c = '', CalculatedOldIASqFt__c = 0, CalculatedOldNOASqft__c = 0, OldIASqFt__c = 0, OldNOASqFt__c = 0));
    }*/
    
    for (Glxy_LeaseProjects__c  a: [Select ID, UpdateOldNOAIA__c from Glxy_LeaseProjects__c where id in :deletedids]) {
    	ID RecordID = a.ID;
    	If (a.UpdateOldNOAIA__c){
    		projects.put(RecordID, new Glxy_LeaseProjects__c (Id = RecordID, AssociatedLeases_lkup__c = '', CalculatedOldIASqFt__c = 0, CalculatedOldNOASqft__c = 0, OldIASqFt__c = 0, OldNOASqFt__c = 0));
    	} else {
    		projects.put(RecordID, new Glxy_LeaseProjects__c (Id = RecordID, AssociatedLeases_lkup__c = '', CalculatedOldIASqFt__c = 0, CalculatedOldNOASqft__c = 0));
    	}
    }
    
System.Debug('***###%%%$$$ ********* projects.size() = ' + projects.size());
        
        // Update projects if we have any
        if (projects.size() > 0 ) {
            
            // Set a static variable to avoid recursive trigger
            GLXY_Utility.setUpdating();
            
            // Update all values and skip records that have an error
            // Do not fail for records that have an error.
            Database.update(projects.values(), false); 
        }
        
    }
    
    private static testmethod void validateCalculateOldIANOA() {
       Date myDate = date.newinstance(Datetime.Now().Date().Year(), 10, 10);
       
       Glxy_Lease__c lease = new Glxy_Lease__c (Name='LAK05855', RegionCD__c = '10', BaseLeaseEffectiveDate__c = date.newInstance(1994,2,14), 
           StatusCode__c = 'Active', BaseAnnualRent__c = 46046.88, Total_NOA_Sq_feet__c = 1935.00, Total_IA_Sq_feet__c = 0, BaseSquareFeet__c = 1935.00,
           IAConverstionDate__c = myDate.addYears(-10));
       
       Glxy_LeaseProjects__c project = new Glxy_LeaseProjects__c (Name = '6AK0141', NOASquareFeet__c = 1935.45, IASquareFeet__c = 0, 
           Project_Type__c = 'Succeeding', EffectiveDate__c = date.newInstance(2011,2,14), RegionCd__c = '10',
           AnnualRent__c = 0, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935.45, eEorA__c = 'Actual');
           
       Glxy_LeaseProjects__c project2 = new Glxy_LeaseProjects__c (Name = '1AK2050', NOASquareFeet__c = 1935, IASquareFeet__c = 0, 
           Project_Type__c = 'New/Replacing', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935, eEorA__c = 'Actual');
           
       Glxy_LeaseProjects__c project2a = new Glxy_LeaseProjects__c (Name = '1AK205A', NOASquareFeet__c = 1935, IASquareFeet__c = 0, 
           Project_Type__c = 'New/Replacing', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935, eEorA__c = 'Actual');
               
       Glxy_LeaseProjects__c project3 = new Glxy_LeaseProjects__c (Name = '1AK2052', NOASquareFeet__c = 1935, IASquareFeet__c = 0, 
           Project_Type__c = 'New', EffectiveDate__c = date.newInstance(2014,2,14), RegionCd__c = '10',
           UpdateOldNOAIA__c = false, AnnualRent__c = 50658.30, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935, eEorA__c = 'Actual');
               
       List<Glxy_LeaseProjects__c> projects = new List<Glxy_LeaseProjects__c> {project, project2, project2a, project3};
       
       insert lease;
       insert projects;
       System.Assert(lease!=NULL);
       System.Assert(projects!=NULL);
       
       PBS_AB_Code__c obAB = New PBS_AB_Code__c();
	   obAB.AB_Code__c = '9999';
	   obAB.Agency_Bureau_Name__c = 'test';
	   obAB.Agency_Bureau_Short_Name__c = 'test';
	   obAB.Agency_Code__c = '19';
	   obAB.Bureau_Code__c = '01';
	   insert obAB;
	   
	   Glxy_LeaseAgencies__c objLA1 = new Glxy_LeaseAgencies__c();
	   objLA1.LeaseNumber__c = lease.ID;
	   objLA1.PBSABCode__c = obAB.ID;
	   objLA1.BaseStructuredParkingSpaces__c = 10;
	   objLA1.BaseSurfaceParkingSpaces__c = 20;
	   objLA1.SquareFeet__c = 100;
	   objLA1.ASAID__c = 111;
	   objLA1.ASA__c = 'AAA';
	   objLA1.REXUSASA__c = 'AAA';
	   Insert objLA1;
	   
	   Glxy_ProjectAgency__c objTest11 = new Glxy_ProjectAgency__c();
	   objTest11.ProjectNumber__c = project.id;
	   objTest11.PBSABCode__c = obAB.id;
	   objtest11.BaseStructuredParkingSpaces__c  = 10;
	   objtest11.BaseSurfaceParkingSpace__c = 10;
	   //objtest11.OldBaseStructuredParkingSpaces__c = 0;
	   //objtest11.OldBaseSurfaceParkingSpaces__c = 0;
	   insert objTest11;
	   
	   Glxy_ProjectRequestASA__c objTest11a =  new Glxy_ProjectRequestASA__c();
	   objTest11a.ProjectAgencyID__c = objTest11.id;
	   objTest11a.OldASA__c = 'AAAS';
	   objTest11a.RequestASAID__c = 1112;
	   Insert objTest11a;
	   
	   Glxy_ProjectAgency__c objTest111 = new Glxy_ProjectAgency__c();
	   objTest111.ProjectNumber__c = project2.id;
	   objTest111.PBSABCode__c = obAB.id;
	   objtest111.BaseStructuredParkingSpaces__c  = 10;
	   objtest111.BaseSurfaceParkingSpace__c = 10;
	   //objtest111.OldBaseStructuredParkingSpaces__c = 0;
	   //objtest111.OldBaseSurfaceParkingSpaces__c = 0;
	   insert objTest111;
	   
	   Glxy_ProjectRequestASA__c objTest111a =  new Glxy_ProjectRequestASA__c();
	   objTest111a.ProjectAgencyID__c = objTest111.id;
	   objTest111a.OldASA__c = 'AAA';
	   objTest111a.RequestASAID__c = 111;
	   Insert objTest111a;
	             
       Glxy_AssociatedLeases__c assocLease = new Glxy_AssociatedLeases__c (Lease__c = lease.Id, Project__c = project.Id);
       //Glxy_AssociatedLeases__c assocLease2 = new Glxy_AssociatedLeases__c (Lease__c = lease.Id, Project__c = project2.Id, Rexus_Termination_Date__c = date.newInstance(2013,4,1));
       Glxy_AssociatedLeases__c assocLease2 = new Glxy_AssociatedLeases__c (Lease__c = lease.Id, Project__c = project2.Id);
       Glxy_AssociatedLeases__c assocLease2a = new Glxy_AssociatedLeases__c (Lease__c = lease.Id, Project__c = project2a.Id);
       Glxy_AssociatedLeases__c assocLease3 = new Glxy_AssociatedLeases__c (Lease__c = lease.Id, Project__c = project3.Id);
       List<Glxy_AssociatedLeases__c> assocLeases = new List<Glxy_AssociatedLeases__c> {assocLease, assocLease2, assocLease2a, assocLease3};       
       insert assocLeases;
       
       assocLease.Rexus_Termination_Date__c = null;
       update assocLease;
       
       assocLease2.Rexus_Termination_Date__c = null;
       update assocLease2;
       
       assocLease = [SELECT Id, Lease__c, Project__c, Project_Effective_Date__c, Rexus_Termination_Date__c, 
                       Lease__r.Name, Lease__r.Total_NOA_Sq_feet__c, Lease__r.Total_IA_Sq_feet__c, Lease__r.IAConverstionDate__c,
                       Project__r.Name, Project__r.NOASquareFeet__c, Project__r.IASquareFeet__c, Project__r.Project_Type__c, 
                       Project__r.OldIASqFt__c, Project__r.OldNOASqFt__c, Project__r.CalculatedOldIASqFt__c, Project__r.CalculatedOldNOASqft__c
                FROM Glxy_AssociatedLeases__c 
                WHERE Lease__c = :assocLease.Lease__c
                ORDER BY Lease__r.Name, Project_Effective_Date__c LIMIT 1];
       System.debug('***** Project1: ' +assocLease.Project__r.Name+', Old IA = ' +assocLease.Project__r.OldIASqFt__c+' and Old NOA = '+ assocLease.Project__r.OldNOASqFt__c);

       assocLease2 = [SELECT Id, Lease__c, Project__c, Project_Effective_Date__c, Rexus_Termination_Date__c, 
                       Lease__r.Name, Lease__r.Total_NOA_Sq_feet__c, Lease__r.Total_IA_Sq_feet__c, Lease__r.IAConverstionDate__c,
                       Project__r.Name, Project__r.NOASquareFeet__c, Project__r.IASquareFeet__c, Project__r.Project_Type__c, 
                       Project__r.OldIASqFt__c, Project__r.OldNOASqFt__c, Project__r.CalculatedOldIASqFt__c, Project__r.CalculatedOldNOASqft__c
                FROM Glxy_AssociatedLeases__c 
                WHERE Lease__c = :assocLease2.Lease__c 
                ORDER BY Lease__r.Name, Project_Effective_Date__c DESC LIMIT 1];
       System.debug('***** Project2: ' +assocLease2.Project__r.Name+', Old IA = ' +assocLease2.Project__r.OldIASqFt__c+' and Old NOA = '+ assocLease2.Project__r.OldNOASqFt__c);
      
      Delete objTest11a;
      Delete objTest111a;
      Delete assocLease3;
      Delete project3;
      

    }
    
}