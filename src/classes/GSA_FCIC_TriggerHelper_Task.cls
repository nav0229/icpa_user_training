public class GSA_FCIC_TriggerHelper_Task {

	// stores information about the email template associated with a task on the task for reporting purposes
	public static void storeTemplateInformation(List<Task> taskList){
		List<Id> whatIds = new List<Id>();
		for(Task task : taskList){
			if(task.WhatId == null) continue;
			whatIds.add(task.WhatId);
		}
		// Grabs all the cases associated with the tasks
		Map<Id, Case> caseMap = new Map<Id, Case>([SELECT Id, CaseNumber FROM Case WHERE Id IN :whatIds]);

		// will store the task and template id that we've manually assigned in the description and body of all email templates
		// the format is XXX is three numbers
		Map<Task, String> taskToTemplateId = new Map<Task, String>();
		for(Task task : taskList){
			// checks that the task is associated with a case
			if(caseMap.get(task.WhatId) == null) return;
			// this will be the string we use to find the template id
			String findString = caseMap.get(task.WhatId).CaseNumber + '-';
			// this is the string that stores the template id
			String templateId;
			// the Description for a task carries information like the Additional To, CCs, Body, etc
			String description = task.Description;
			// the string we will use to find the body in the description
			String bodyString = 'Body:';

			// 4-11 emergency fix - CLC
			if(description == null) continue;

			Integer foundBodyStart = description.indexOf(bodyString, 0);
			String passedTheBody = description.substringAfter('Body:');
			if(passedTheBody == null) return; // body doesn't exist in the Description field; not an email?
			Integer beginningOfCaseString = passedTheBody.indexOf(findString, 0); // second param = 0 returns the first occurrence
			if(beginningOfCaseString == -1) return; // could not find CaseNumber-XXX
			Integer templateIdStart = beginningOfCaseString + findString.length();
			templateId = passedTheBody.substring(templateIdStart, templateIdStart + 3);
			System.debug('TemplateId ' + templateId);
			if(templateId == null) continue;
			taskToTemplateId.put(task, templateId);
		}

		// creating these query strings to do a LIKE query
		// some of the Descriptions will be XXX - Tier 2 so a query for just the number will not suffice
		// we need to do a query for the XXX% where anything % and after will not matter
		List<String> queryStrings = new List<String>();
		for(String s : taskToTemplateId.values()){
			queryStrings.add(s + '%');
		}
		// query the email templates for the template ids we found
		List<EmailTemplate> templateList = [SELECT Id, Name, Description FROM EmailTemplate WHERE Description LIKE :queryStrings];

		// actually assign the template id information to the task itself; this is used for reporting
		for(Task task : taskList){
			for(EmailTemplate template : templateList){
				if(template.Description == null) continue;
				String descriptionId = template.Description.substring(0, 3);
				System.debug('descriptionId ' + descriptionId);
				if(taskToTemplateId.get(task) == descriptionId){
					task.Template_Name__c = template.Name;
					task.Template_Id__c = template.Id;
				}
			}
		}
	}

	public static void afterInsert(List<Task> newTasks){
		Map<String, Id> UCIDToTaskMap = new Map<String, Id>();
		for(Task tas : newTasks) {		 
			 if(tas.AES_SFConnector__UCID__c != null && tas.whatId == null){
				UCIDToTaskMap.put(tas.AES_SFConnector__UCID__c, tas.Id); 
			} 
		}
		
		List<Case> casRec = [Select Id, Avaya_UCID__c 
								FROM Case 
								WHERE Avaya_UCID__c = :UCIDToTaskMap.keySet()
								AND Avaya_ANI__c != null
								AND Avaya_DNIS__c != null];
								//AND CreatedDate within last 15 days --- ask J Haugh ];
		
		Map<String, String> UCIDToCaseMap = new Map<String, String>();
		if(casRec != null && casRec.size() > 0){
			for(Case cas : casRec){ 
				UCIDToCaseMap.put(cas.Avaya_UCID__c, cas.Id);
			}
		}
		
		List<Task> tasRec = [Select Id, WhatId, AES_SFConnector__UCID__c 
								FROM Task 
								WHERE Id = :UCIDToTaskMap.Values()];
		
		List<Task> taskUpdateList = new List<Task>();
		for(Task tas : tasRec){
			if(tas.WhatId == null){
				tas.WhatId = UCIDToCaseMap.get(tas.AES_SFConnector__UCID__c);
				taskUpdateList.add(tas);
			}
		}
		
		update taskUpdateList;		
	}

}