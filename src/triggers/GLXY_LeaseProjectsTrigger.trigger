trigger GLXY_LeaseProjectsTrigger on Glxy_LeaseProjects__c (after insert, after update, before delete) {
	
	if (Trigger.isDelete) {
		
	 	List<string> profileNamelist= new list<string>();
		profileNamelist.add('GSA System Administrator');
		profileNamelist.add('System Administrator');
		Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
		string adminUser= [select id from user where name='CastIron User'].id;
		system.debug(adminUser);
		system.debug(adminProfileMap);
		string RexusRecordType=Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
		system.debug(RexusRecordType);
		for(Glxy_LeaseProjects__c pi:trigger.old ){
			if (pi.AssociatedLeasesCount__c != 0){
				pi.addError('Please delete all Associated Leases/Projects records before deleting this project.');
				continue;
			}
			if(pi.RecordTypeid==RexusRecordType){
		 		if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null){
		   			continue;
		  		}
		   		pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');		
		  	}
		}
	 	
	}else{
		//Krishna added this if condition for applying the underlying business logic while working on LP Step Rents and LP Lump Sums.
		if(Trigger.isAfter && Trigger.isUpdate)
		{
		 	Set<string> modifiedProjectObjs=new Set<string>(); 
		    modifiedProjectObjs.clear();
		    Set<string> UpdatedNewReplacingProjects = new Set<string>(); 
		    UpdatedNewReplacingProjects.clear();
		    Glxy_LeaseProjects__c oldProjectObj=null;
		    Map<string,Glxy_LeaseProjects__c> projectMap= new map<string,Glxy_LeaseProjects__c>();
		    for (Glxy_LeaseProjects__c  project: Trigger.new) 
		    {
		        oldProjectObj=Trigger.oldMap.get(project.id);
		        if( oldProjectObj.IASquareFeet__c!=project.IASquareFeet__c 
		        	|| oldProjectObj.NOASquareFeet__c!=project.NOASquareFeet__c
		        	|| oldProjectObj.BDGFlag__c!=project.BDGFlag__c
		        	|| oldProjectObj.ProcessedDate__c!=project.ProcessedDate__c
		        	|| oldProjectObj.IAConversionDate__c != project.IAConversionDate__c ){
		         	projectMap.put(project.id,project);
		         	modifiedProjectObjs.add(project.id);
		        }
		        
		        if((Project.Project_Type__c == 'New/Replacing') && (oldProjectObj.EffectiveDate__c != project.EffectiveDate__c || oldProjectObj.IASquareFeet__c != project.IASquareFeet__c || oldProjectObj.NOASquareFeet__c != project.NOASquareFeet__c)){
		         	UpdatedNewReplacingProjects.add(project.id);
		        }
		        
		    }

		    List<Glxy_LPLumpSum__c> lsList = new list<Glxy_LPLumpSum__c>();
		    List<Glxy_LPStepRent__c> srList = new list<Glxy_LPStepRent__c>();
		    List<Glxy_AssociatedLeases__c> ALPList = new list<Glxy_AssociatedLeases__c>();
		    
		   	if(modifiedProjectObjs.size()>0)
		   	{
		        lsList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c, ProjectNumber__c, EffectiveDate__c, BDGFlag__c, Budget_Exclusion_Reason__c, ProcessedDate__c  from Glxy_LPLumpSum__c where  ProjectNumber__c in :modifiedProjectObjs];
		        srList=[select IA_Sq_Ft__c, NOA_Sq_Ft__c, ProjectNumber__c,EffectiveDate__c, BDGFlag__c, Budget_Exclusion_Reason__c, ProcessedDate__c  from Glxy_LPStepRent__c where  ProjectNumber__c in :modifiedProjectObjs];
		   	}
		   	
		   	if(UpdatedNewReplacingProjects.size()>0)
		   	{
		        ALPList = [Select JAN__c From Glxy_AssociatedLeases__c Where Project__c in :UpdatedNewReplacingProjects];
		   	}
		   	
		   	oldProjectObj=null;
		    
		    if(lsList.size()>0)
		    {
		            for(Glxy_LPLumpSum__c auth:lsList)
		            {                        
		                    oldProjectObj=projectMap.get(auth.ProjectNumber__c );
		                    auth.IA_Sq_Ft__c= oldProjectObj.IASquareFeet__c ;
		                    auth.NOA_Sq_Ft__c=oldProjectObj.NOASquareFeet__c;
		                    //Krishna - If Effective Date is less than IA Conversion date, combine IA and NOA in NOA
		                    if( oldProjectObj.IAConversionDate__c != null && oldProjectObj.IAConversionDate__c <= auth.EffectiveDate__c ){
		                    	auth.NOA_Sq_Ft__c = oldProjectObj.IASquareFeet__c + oldProjectObj.NOASquareFeet__c;
		                    	auth.IA_Sq_Ft__c = 0;
		                    }else if( oldProjectObj.IAConversionDate__c != null && oldProjectObj.IAConversionDate__c > auth.EffectiveDate__c ){
		                    	auth.NOA_Sq_Ft__c = oldProjectObj.NOASquareFeet__c;
		                    	auth.IA_Sq_Ft__c = oldProjectObj.IASquareFeet__c;
		                    }
		                    //Krishna - if project flag unchecked update the child records with corresponding data
		                    if(string.isBlank(string.valueof(oldProjectObj.Acceptance620Date__c))){ // 02/23/2014 - artf3646
		                    	auth.BDGFlag__c = oldProjectObj.BDGFlag__c;
		                    	auth.Budget_Exclusion_Reason__c = oldProjectObj.Budget_Exclusion_Reason__c;
		                    }
		                    //Krishna - If current process Date is less than project process date, replace it with project process date 
			                if (oldProjectObj.ProcessedDate__c != null && auth.ProcessedDate__c != null && oldProjectObj.ProcessedDate__c >=  auth.EffectiveDate__c ) {
			                    auth.ProcessedDate__c = oldProjectObj.ProcessedDate__c;
			                }else if (oldProjectObj.ProcessedDate__c != null && auth.ProcessedDate__c != null && oldProjectObj.ProcessedDate__c <  auth.EffectiveDate__c ) {
			                    auth.ProcessedDate__c = auth.EffectiveDate__c;
			                }
		            }   
		        update lsList;
		    }
		    if(srList.size()>0)
		    {
		            for(Glxy_LPStepRent__c auth:srList)
		            {            
		                    oldProjectObj=projectMap.get(auth.ProjectNumber__c );
		                    auth.IA_Sq_Ft__c= oldProjectObj.IASquareFeet__c;
		                    auth.NOA_Sq_Ft__c= oldProjectObj.NOASquareFeet__c;
		                    //Krishna - If Effective Date is less than IA Conversion date, combine IA and NOA in NOA else put them back
		                    if( oldProjectObj.IAConversionDate__c != null && oldProjectObj.IAConversionDate__c < auth.EffectiveDate__c ){
		                    	auth.NOA_Sq_Ft__c = oldProjectObj.IASquareFeet__c + oldProjectObj.NOASquareFeet__c;
		                    	auth.IA_Sq_Ft__c = 0;
		                    }else if( oldProjectObj.IAConversionDate__c != null && oldProjectObj.IAConversionDate__c > auth.EffectiveDate__c ){
		                    	auth.NOA_Sq_Ft__c = oldProjectObj.NOASquareFeet__c;
		                    	auth.IA_Sq_Ft__c = oldProjectObj.IASquareFeet__c;
		                    }
		                    //Krishna - if project flag unchecked update the child records with corresponding data
		                    if(string.isBlank(string.valueof(oldProjectObj.Acceptance620Date__c))){ // // 02/23/2014 - artf3646
		                    	auth.BDGFlag__c = oldProjectObj.BDGFlag__c;
		                    	auth.Budget_Exclusion_Reason__c = oldProjectObj.Budget_Exclusion_Reason__c;
		                    }
		                    //Krishna - If current process Date is less than project process date, replace it with project process date 
			                if (oldProjectObj.ProcessedDate__c != null && auth.ProcessedDate__c != null && oldProjectObj.ProcessedDate__c >  auth.EffectiveDate__c ) {
			                    auth.ProcessedDate__c = oldProjectObj.ProcessedDate__c;
			                }else if (oldProjectObj.ProcessedDate__c != null && auth.ProcessedDate__c != null && oldProjectObj.ProcessedDate__c <  auth.EffectiveDate__c ) {
			                    auth.ProcessedDate__c = auth.EffectiveDate__c;
			                }
		            }   
		        update srList;
		   }
		   
		   //Update the JAN (not used column after Double Rent object was created) column amount to 0 to trigger DR calculations ...
		   if(ALPList.size() > 0)
		   {
		 		for(Glxy_AssociatedLeases__c objRecord:ALPList){
		 			objRecord.JAN__c = objRecord.JAN__c + 1;
				}   
				update ALPList;
		   }

		 }
		    
	 	 if(GLXY_Utility.hasUpdated() != true) {
    		Map<Id,Glxy_AssociatedLeases__c> assocLease = 
            new Map<Id,Glxy_AssociatedLeases__c> ([
                SELECT Id, Lease__c, Project__c, Termination_Date__c, Project__r.Project_Type__c 
                FROM Glxy_AssociatedLeases__c 
	                WHERE Project__c IN :Trigger.newMap.keySet()
            ]);
            
            //Glxy_OldIAAndNOAForProject.calculateOldIANOA(assocLease.keySet(), True, 'Project', new Set<Id> ());
            //Glxy_OldIAAndNOAForProject.calculateOldIANOA(assocLease.keySet(), Trigger.isInsert, 'Project', new Set<Id> ());
       		boolean blnCastIronUser = false;
       		string strCIUser = [select id from user where name='CastIron User'].id;
       		if(userinfo.getuserId() == strCIUser){
       			blnCastIronUser = true;
       		}
       		Glxy_OldIAAndNOAForProject.calculateOldIANOA(assocLease.keySet(), True, 'Project', new Set<Id> ());
       		 
		}

		if(GLXY_Utility.hasCalcUpdated() != true) {
	        GLXY_ProjectCalculationHandler.calculateFields(Trigger.newMap, Trigger.oldMap, Trigger.isUpdate); 
	    }

	}
}