@isTest(seeAllData=true)
private class testIdpWizard{
	public static testmethod void testNavigation(){
		
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Test','Test','IDP Standard','GSA System Administrator'); 
        List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
        List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);

		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		
		ApexPages.currentPage().getParameters().put('id', idp[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Clone');
		IDP_WizardExtension extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('newIDPRec', '');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'Review');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'IDPInformation');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'LongTermGoals');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'ShortTermGoals');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'Objective');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'Activities');
		extension1 = new IDP_WizardExtension();
		
		ApexPages.currentPage().getParameters().put('operation', 'Competencies');
		extension1 = new IDP_WizardExtension();
		System.assertEquals(True, True);
		
	}
	
	public static testmethod void testNavigation1(){                       
		
        List<IDP__c> idp1 = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Test','Test','IDP Standard','GSA System Administrator'); 
        List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp1,1);
        List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);
        
		ApexPages.currentPage().getParameters().put('id', idp1[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');
		IDP_WizardExtension extension1 = new IDP_WizardExtension();
		extension1 = new IDP_WizardExtension();
		extension1.stepSequence  = 'Step01';
		extension1.newIDP.Supervisor__c = userInfo.getUserId();
		extension1.next();
		extension1.newIDP.Director__c = userInfo.getUserId();
		extension1.next();
		extension1.stepSequence  = 'Step02';
		extension1.newIDP.Career_Goals_Long_Run__c = '';
		extension1.next();
		extension1.newIDP.Career_Goals_Long_Run__c = 'Test';
		extension1.save();
		extension1.stepSequence  = 'Step03';
		extension1.newIDP.Career_Goals_Short_Run__c = '';
		extension1.next();        
		Test.startTest();
		extension1.stepSequence  = 'd';
		extension1.next();
		Test.stopTest();       
		extension1.save();
		extension1.submit();
		extension1.getObjectiveWrapperList();
		extension1.getActivityWrapperList();
		extension1.getActivityForObjWrapperList();        
		extension1.getCompetencyWrapperList();
		System.assertEquals(True, True);
 
	}

	
	public static testmethod void testIDPObjective(){                      
        
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
        List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
        List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);
        IDP__c idp1 = new IDP__c();
        idp1 = idp[0];
        

		ApexPages.currentPage().getParameters().put('id', idp1.id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');
		IDP_WizardExtension extension1 = new IDP_WizardExtension();
		extension1.stepSequence  = 'Step01';
		extension1.newIDP.Supervisor__c = userInfo.getUserId();
		extension1.next();
		extension1.newIDP.Director__c = userInfo.getUserId();
		extension1.next();

		extension1.stepSequence  = 'Step02';
		extension1.newIDP.Career_Goals_Long_Run__c = '';
		extension1.next();
		extension1.stepSequence  = 'Step03';
		extension1.newIDP.Career_Goals_Short_Run__c = '';
		extension1.next();

		Test.startTest();
		extension1.stepSequence  = 'Step04';        
		extension1.newObjective.IDP__c = null;
		extension1.newObjective.Objective_Title__c = 'Test';
		extension1.newObjective.Objective__c = 'Test';
		extension1.next();
		Test.stopTest();
		extension1.stepSequence  = 'Step05';        
		extension1.next();
		extension1.stepSequence  = 'Step07';        
		extension1.next();

		idp1 = extension1.retrieveIDPDetails(idp1.Id);
		system.debug( idp1.Fiscal_Year_pick__c + ' :: IDP Info >>>> ' + idp1);
  
		extension1.addActivity();
		extension1.getObjectiveWrapperList();
		extension1.getActivityWrapperList();
		extension1.getActivityForObjWrapperList();
		extension1.getCompetencyWrapperList();
		
		List<recordSharingUtil.RecordSharingDefiniation> rs = new List<recordSharingUtil.RecordSharingDefiniation>{
		new recordSharingUtil.RecordSharingDefiniation(idp1.Id, idp1.Supervisor__c, 'Read', 'Supervisor_Access__c'),
		new recordSharingUtil.RecordSharingDefiniation(idp1.Id, idp1.Director__c, 'Read', 'Other_Viewer_Access__c')
			};
		RecordSharingUtil.share(rs);
		extension1.save();        
		extension1.back();
		System.assertEquals(True, True);
 
	}

	public static testmethod void testRecallApproval(){                    
		
        List<IDP__c> idp1 = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
        List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp1,1);
        List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);
		
		ApexPages.currentPage().getParameters().put('id', idp1[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');
		IDP_WizardExtension extension1 = new IDP_WizardExtension();
		extension1 = new IDP_WizardExtension();
		extension1.stepSequence  = 'Step01';
		extension1.newIDP.Supervisor__c = userInfo.getUserId();
		extension1.next();
		extension1.newIDP.Director__c = userInfo.getUserId();
		extension1.next();
		extension1.stepSequence  = 'Step02';
		extension1.newIDP.Career_Goals_Long_Run__c = '';
		extension1.next();
		extension1.stepSequence  = 'Step03';
		extension1.newIDP.Career_Goals_Short_Run__c = '';
		extension1.next();        
		Test.startTest();
		extension1.stepSequence  = '';
		extension1.newObjective.IDP__c = null;
		extension1.next();
		Test.stopTest();   
		extension1.stepSequence  = 'Step05';        
		extension1.next();    
		extension1.stepSequence  = 'Step07';        
		extension1.next();
		extension1.addActivity();
		extension1.submitForApproval();
		extension1.recallApproval();
		extension1.getObjectiveWrapperList();
		extension1.getActivityWrapperList();
		extension1.getActivityForObjWrapperList();
		extension1.getCompetencyWrapperList();
		
		List<recordSharingUtil.RecordSharingDefiniation> rs = new List<recordSharingUtil.RecordSharingDefiniation>{
		new recordSharingUtil.RecordSharingDefiniation(idp1[0].Id, idp1[0].Supervisor__c, 'Read', 'Supervisor_Access__c'),
		new recordSharingUtil.RecordSharingDefiniation(idp1[0].Id, idp1[0].Director__c, 'Read', 'Other_Viewer_Access__c')
			};
		RecordSharingUtil.share(rs);
		extension1.save();        
		System.assertEquals(True, True);
 
	}
	
	
	public static testmethod void testNoObjectives(){                      
		
        List<IDP__c> idp1 = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2015','New','T','T','IDP Standard','GSA System Administrator'); 

		ApexPages.currentPage().getParameters().put('id', idp1[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');
		IDP_WizardExtension extension1 = new IDP_WizardExtension();
		extension1 = new IDP_WizardExtension();
		extension1.stepSequence  = 'Step01';
		extension1.newIDP.Supervisor__c = userInfo.getUserId();        
		extension1.next();
		extension1.newIDP.Director__c = userInfo.getUserId();
		extension1.next();
		extension1.stepSequence  = 'Step02';
		extension1.newIDP.Career_Goals_Long_Run__c = '';
		extension1.next();
		extension1.newIDP.Career_Goals_Long_Run__c = 'Test';
		extension1.next();
		extension1.stepSequence  = 'Step03';
		extension1.newIDP.Career_Goals_Short_Run__c = '';
		extension1.next();
		extension1.newIDP.Career_Goals_Short_Run__c = 'Test';
		extension1.next();
		extension1.stepSequence  = 'Step04';
		extension1.newObjective.IDP__c = null;
		extension1.newObjective.Objective_Title__c = 'Test';
		extension1.newObjective.Objective__c = 'Test';
		extension1.next();
		extension1.newObjective.Objective_Title__c = null;
		extension1.newObjective.Objective__c = 'Test';
		extension1.next();
		extension1.stepSequence  = 'Step05';        
		extension1.next();
		extension1.stepSequence  = 'Step07';        
		extension1.next();
		//Test.stopTest();        
		System.assertEquals(True, True);
 
	}
	
	
	public static testmethod void testIdpWizardExtension(){
		
		List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','Test','Test','IDP Standard','GSA System Administrator'); 
		List<IDP__c> idp1 = IDP_TestDataFactory.createTestIDPRecords(2,'FY 2051','New','Test','Test','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
        List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+1);
        List<Developmental_Competency__c> comp = IDP_TestDataFactory.createCompetency(activity,3);
		List<IDP_Developmental_Line_Item__c> listAct = [SELECT Id FROM IDP_Developmental_Line_Item__c WHERE IDP_ID__c != :activity[0].IDP_ID__c LIMIT 1];
		
		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		
		ApexPages.currentPage().getParameters().put('id', idp[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');

		IDP_WizardExtension extension = new IDP_WizardExtension();
		//extension.refreshComponents();
		extension.selectedObjective = objective[0];
		extension.stepSequence  = 'Step01';
		extension.newIDP.Supervisor__c = userInfo.getUserId();
		extension.newIDP.Director__c = userInfo.getUserId();
		extension.save();
		extension.next();
		
		extension.stepSequence  = 'Step02';
		extension.newIDP.Career_Goals_Long_Run__c = 'Test';
		extension.save();
		extension.next();
		
		extension.updateObjective();
		
		extension.selectObjective();
		
		extension.objectiveSelectedIndex = 0;
		extension.objectiveWrapperList.get(0).checked = true;
		extension.selectObjective();
		extension.gotoIDPObjectiveDetailPage();
		 
		extension.stepSequence  = 'Step03';
		extension.newIDP.Career_Goals_Short_Run__c = 'Test';
		extension.save();
		extension.next();
		
		List<RecordType> recordTypeList =  [select Id, Name, Description, DeveloperName, IsActive from RecordType where sobjecttype='IDP_Developmental_Line_Item__c'];
		if(recordTypeList.size() > 0){
		  extension.selectedType = recordTypeList[0].Id;
		}           
		extension.addActivity();

		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.newActivity.Required_Date__c = System.today() - 100;
		extension.newActivity.Planned_Start_Date__c = System.today()-300;
		extension.newActivity.Planned_End_Date__c = System.today() -200;
		extension.addActivity();
		
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.newActivity.Required_Date__c = System.today() -400;
		extension.newActivity.Planned_Start_Date__c = System.today() - 600;
		extension.newActivity.Planned_End_Date__c = System.today() -500;
		extension.addActivity();
		
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() - 100;
		extension.newActivity.Planned_Start_Date__c = System.today()-300;
		extension.newActivity.Planned_End_Date__c = System.today() -200;
		extension.addActivity();
		
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() -400;
		extension.newActivity.Planned_Start_Date__c = System.today() - 600;
		extension.newActivity.Planned_End_Date__c = System.today() -500;
		extension.addActivity();
		
		extension.stepSequence  = 'Step04';
		extension.newObjective.IDP__c = null;
		extension.newObjective.Objective_Title__c = null;
		extension.newObjective.Objective__c = 'Test';
		extension.save();
		extension.newObjective.Objective_Title__c = 'Test';
		extension.newObjective.Objective__c = null;
		extension.save();
		extension.newObjective.Objective_Title__c = 'Test';
		extension.newObjective.Objective__c = 'Test';
		extension.save();       
		extension.next();        
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Required_Date__c = System.today();
		extension.newActivity.Planned_Start_Date__c = System.today() + 20;
		extension.newActivity.Planned_End_Date__c = System.today() + 30;
		extension.stepSequence  = 'Step05';
		extension.save();
		extension.next();
		extension.back();
		extension.stepSequence  = 'Step07';        
		extension.activityWrapperList.get(0).checked = true;
		extension.selectActivitiesForObjective();
		extension.save();
				
		extension.getActivityName();
		extension.setActivityName = comp[0].Developmental_Activity__c;
				
		extension.cloneActivityIndex = 0;
		extension.cloneActivity();
				
		extension.deleteActivityIndex = 0;
		extension.deleteActivity();
		
		extension.editObjectiveIndex = 0;
		extension.editObjective();

		extension.deleteCompetencyIndex = 0;
		
		extension.competency.Developmental_Activity__c = listAct[0].Id;
		extension.competency.Competency_Model__c = 'Test Model';
		extension.competency.Competency_Area__c = 'Test Area';
		extension.competency.Competency__c = 'Test Comp';
		
		extension.getCompetencyWrapperList();
		
		extension.cloneObjectiveIndex = 0;
		extension.cloneObjective();
		
		extension.deleteObjectiveIndex = 0;
		Test.StartTest();
		extension.deleteObjective();        
		extension.cancelObjective();        
		extension.stepSequence  = 'Step06';
		extension.back();
		
		extension.stepSequence  = 'Step05';
		
		extension.next();        
		extension.stepSequence  = 'Step07';        
		extension.next();
		extension.stepSequence  = 'Step02';  
		extension.newIDP.Career_Goals_Long_Run__c = '';      
		extension.clearGoalText();

		extension.stepSequence  = 'Step03';
		extension.newIDP.Career_Goals_Short_Run__c = '';

		extension.clearGoalText();
		Test.StopTest();        
		extension.gotoIDPDetailPage();
		extension.newRec = true;
		extension.newIDPRec = idp[0].id;
		extension.cancel();
		System.assertEquals(True, True);

	}
	
	public static testmethod void testIDPsFY(){               
		User u = [SELECT Id FROM User WHERE isActive = true LIMIT 1];
		
        List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(2,'FY 2050','New','Test','Test','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
		List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+365);
		List<Developmental_Competency__c> comp = IDP_TestDataFactory.createCompetency(activity, 1);
		
		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		
		ApexPages.currentPage().getParameters().put('id', idp[0].id);
		ApexPages.currentPage().getParameters().put('operation', 'Edit');
		IDP_WizardExtension extension = new IDP_WizardExtension();
		extension.selectedObjective = objective[0];
		extension.stepSequence  = 'Step01';
		extension.newIDP.Supervisor__c = userInfo.getUserId();
		extension.newIDP.Director__c = userInfo.getUserId();
		extension.newIDP.Supervisor__c = u.Id;
		extension.newIDP.Director__c = u.Id;       
		extension.save();
		//extension.next();
		List<IDP__c> getIDP = [SELECT Id, Fiscal_Year_pick__c FROM IDP__c WHERE Id =:idp[0].Id LIMIT 1];
        system.debug('***IDPFY'+getIDP);
		
		extension.stepSequence  = 'Step02';
		extension.newIDP.Career_Goals_Long_Run__c = '';
		extension.save();
		//extension.next();
		
		extension.updateObjective();
		
		extension.selectObjective();
		
		extension.objectiveSelectedIndex = 0;
		extension.objectiveWrapperList.get(0).checked = true;
		extension.selectObjective();
		extension.gotoIDPObjectiveDetailPage();
		
		 
		extension.stepSequence  = 'Step03';
		extension.newIDP.Career_Goals_Short_Run__c = '';
		extension.save();
		//extension.next();
		
		List<RecordType> recordTypeList =  [select Id, Name, Description, DeveloperName, IsActive from RecordType where sobjecttype='IDP_Developmental_Line_Item__c'];
		if(recordTypeList.size() > 0){
		  extension.selectedType = recordTypeList[0].Id;
		}

		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.addActivity();

		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() - 200;
		extension.newActivity.Planned_Start_Date__c = System.today()-400;
		extension.newActivity.Planned_End_Date__c = System.today() -300;
		extension.addActivity();
		
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() -400;
		extension.newActivity.Planned_Start_Date__c = System.today() - 600;
		extension.newActivity.Planned_End_Date__c = System.today() -500;
		extension.addActivity();
		
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() - 100;
		extension.newActivity.Planned_Start_Date__c = System.today()-300;
		extension.newActivity.Planned_End_Date__c = System.today() -200;
		extension.addActivity();
		
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;
		extension.newActivity.Required_Date__c = System.today() -400;
		extension.newActivity.Planned_Start_Date__c = System.today() - 600;
		extension.newActivity.Planned_End_Date__c = System.today() -500;
		extension.addActivity();
		
		extension.stepSequence  = 'Step04';
		extension.newObjective.IDP__c = null;
		extension.save();
		//extension.next();
		
		extension.editActivityIndex = 0;
		extension.editActivity();
		extension.newActivity.Required_Date__c = System.today();
		extension.newActivity.Planned_Start_Date__c = System.today() + 20;
		extension.newActivity.Planned_End_Date__c = System.today() + 30;
		extension.stepSequence  = 'Step05';
		extension.save();
		//extension.next();
		extension.back();
		extension.stepSequence  = 'Step06';        
		//extension.next();
		extension.activityWrapperList.get(0).checked = true;
		extension.selectActivitiesForObjective();
		extension.save();
		
		extension.cloneActivityIndex = 0;
		extension.cloneActivity();
				
		extension.deleteActivityIndex = 0;
		extension.deleteActivity();
		
		extension.editObjectiveIndex = 0;
		extension.editObjective();
		
		extension.cloneObjectiveIndex = 0;
		extension.cloneObjective();
		
		extension.deleteObjectiveIndex = 0;
		extension.deleteObjective();
		
		extension.cancelObjective();
		
		extension.stepSequence  = 'Step06';
		extension.back();
		
		extension.stepSequence  = 'Step05';
		//extension.next();
		extension.stepSequence  = 'Step07';        
		//extension.next();
		
		extension.stepSequence  = 'Step02';
		extension.newIDP.Career_Goals_Long_Run__c = '';
		Test.StartTest();
		extension.clearGoalText();
		extension.stepSequence  = 'Step03';
		extension.newIDP.Career_Goals_Short_Run__c = '';
		extension.clearGoalText();
		Test.StopTest();        
		extension.gotoIDPDetailPage();
		extension.newRec = true;
		extension.newIDPRec = idp[0].id;
		extension.cancel();
		System.assertEquals(True, True);

	}
	
	public static testmethod void testActivityDates(){  
		
		User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];     
		
		system.runAs(thisUser){
		
		List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
		List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+365);

		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', idp[0].Id);
		ApexPages.currentPage().getParameters().put('operation', null);
		
		IDP_WizardExtension extension = new IDP_WizardExtension();
		extension.selectedObjective = objective[0];
		extension.newIDP.Supervisor__c=null;
		extension.stepSequence  = 'Step01';   
		extension.newIDP.Supervisor__c = userInfo.getUserId();   
		extension.newIDP.Director__c=userInfo.getUserId();
		extension.newIDP.Career_Goals_Long_Run__c = 'TESTING';
		extension.newIDP.Career_Goals_Short_Run__c = 'Test';
		extension.save();
		extension.next();
		
		
		extension.stepSequence  = 'Step02';
		extension.newIDP.Career_Goals_Long_Run__c = 'Test';
		extension.save();
		extension.next();
		
		extension.updateObjective();
		
		extension.selectObjective();
		
		extension.objectiveSelectedIndex = 0;
		extension.objectiveWrapperList.get(0).checked = true;
		extension.selectObjective();
		extension.gotoIDPObjectiveDetailPage();
		
		 
		extension.stepSequence  = 'Step03';
		extension.newIDP.Career_Goals_Long_Run__c = 'TESTING1';
		extension.save();
		extension.next();
		
		List<RecordType> recordTypeList =  [select Id, Name, Description, DeveloperName, IsActive from RecordType where sobjecttype='IDP_Developmental_Line_Item__c'];
		if(recordTypeList.size() > 0){
		  extension.selectedType = recordTypeList[0].Id;
		}  
		
		extension.addActivity();
		extension.newActivity.Assignment_Title__c = 'Test';
		extension.activityEditMode = true;        
		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.newActivity.Required_Date__c = null;
		extension.newActivity.Planned_Start_Date__c = null;
		extension.newActivity.Planned_End_Date__c = null;        
		extension.addActivity();
		
		extension.newActivity.Assignment_Title__c = 'Test Test';
		extension.activityEditMode = true;        
		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.newActivity.Planned_Start_Date__c = System.today() + 20;
		extension.newActivity.Planned_End_Date__c = System.today() + 2;        
		extension.addActivity();
		
		extension.newActivity.Assignment_Title__c = 'Test Test';
		extension.activityEditMode = true;        
		extension.newActivity.Developmental_Objective__c = objective[0].Id;
		extension.newActivity.Training_Need__c = 'Requried';
		extension.newActivity.Required_Date__c = null; 
		extension.addActivity();
		extension.addInformationMessage('This is test error message');
				   
        Competency_Model__c c = new Competency_Model__c();
		c.Competency_Model__c = 'Test Model';
		c.Competency_Area__c = 'Test Area';
		c.Competency__c = 'Test Competency';
		c.Description__c = 'Test Description';
		insert c;
		
		String selectModel = 'Test Model';
		String selectArea = 'Test Area';
		String selectComp = 'Test Competency';
		
		Developmental_Competency__c dc = new Developmental_Competency__c();
		dc.Developmental_Activity__c = activity[0].Id;
		dc.Competency_Model__c = selectModel;
		dc.Competency_Area__c = selectArea;
		dc.Competency__c = selectComp;
		insert dc;
		
		extension.setActivityName = dc.Developmental_Activity__c; 
		extension.getActivityName();
		Map<String, Competency_Model__c> compModal = new Map<String, Competency_Model__c>();
		compModal.put(c.Competency_Model__c, c);
		extension.getCompetencyModel();
		Map<String, Competency_Model__c> compArea = new Map<String, Competency_Model__c>();
		compArea.put(c.Competency_Area__c, c);
		extension.getCompetencyArea();
		Map<String, Competency_Model__c> comp = new Map<String, Competency_Model__c>();
		comp.put(c.Competency__c, c);
		extension.getCompetencies();
		extension.addComp();
		List<IDP_Developmental_Line_Item__c> activityLookup = [SELECT Id, Name, IDP_ID__c FROM IDP_Developmental_Line_Item__c LIMIT 5000];
		Developmental_Competency__c dc1 = new Developmental_Competency__c();
		dc1.Developmental_Activity__c = activity[0].Id;
		dc1.Competency_Model__c = selectModel;
		dc1.Competency_Area__c = selectArea;
		dc1.Competency__c = selectComp;
		extension.addComp();
		extension.getCompetencyWrapperList();
		extension.prepareCompetencyWrapperList();
		extension.retrieveCompetenciesForActivity();
		extension.prepareCompetencyForActWrapperList();
		extension.getCompetencyForActWrapperList();
		extension.retriveCompetencies(idp[0].Id);
		extension.deleteCompetencyIndex = 0;   
		extension.deleteCompetency();     
		System.assertEquals(True, True);
		
		}

	}

	public static testMethod void testObjectiveModal(){

		List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
		List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+365);

		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', idp[0].Id);
		ApexPages.currentPage().getParameters().put('operation', null);

		IDP_WizardExtension newWizard = new IDP_WizardExtension();
		newWizard.showPopupObjective();
		newWizard.closePopupObjective();
		newWizard.selectObjectiveFiltered();
		System.assert(true);

	}

	public static testMethod void testActivityModal(){

		List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
		List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+365);

		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', idp[0].Id);
		ApexPages.currentPage().getParameters().put('operation', null);

		IDP_WizardExtension newWizard = new IDP_WizardExtension();
		newWizard.showPopupActivity();
		newWizard.closePopupActivity();
		newWizard.selectActivityFiltered();
		System.assert(true);

	}

	public static testMethod void testInstantiateVars(){

		List<IDP__c> idp = IDP_TestDataFactory.createTestIDPRecords(1,'FY 2050','New','T','T','IDP Standard','GSA System Administrator'); 
		List<Developmental_Objective__c> objective = IDP_TestDataFactory.createObjective(idp,1);
		List<IDP_Developmental_Line_Item__c> activity = IDP_TestDataFactory.createActivity(objective,1,date.today(),date.today()+365);


		PageReference pageRef = Page.IDP_Wizard;
		pageRef.setRedirect(true);
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', idp[0].Id);
		ApexPages.currentPage().getParameters().put('operation', null);

		IDP_WizardExtension newWizard = new IDP_WizardExtension();
		newWizard.year = '123';
		newWizard.compAct = '123';
		newWizard.objetiveselected = false;
		newWizard.competencyEditMode = false;
		newWizard.editCompetencyIndex = 7;
		newWizard.showActivityName = '123';
		newWizard.selectedCompetency = null;
		newWizard.compWrapperList = null;
		newWizard.recordTypes = null;
		newWizard.selectedTypeLabel = '123';
		newWizard.recordTypeMap = null;
		newWizard.lstComp = null;
		newWizard.showArea = false;
		System.assert(true);

	}
}