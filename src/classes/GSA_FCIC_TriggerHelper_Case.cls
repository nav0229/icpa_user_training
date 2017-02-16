public class GSA_FCIC_TriggerHelper_Case {

	// used to avoid a recursion onUpdate since we need to update the case with a contact name after we've insterted the contact (which happens in the after insert / after update)
	public static boolean alreadyRan = false;
	public static boolean isTest = false;

	private static RecordType contactRecordType;

	public static void beforeInsert(List<Case> newCases){
		if(contactRecordType == null) setContactRecordType();
		copyDescriptionToSubject(newCases);
		supportWebToCase(newCases);
		List<Case> tier2Cases = getNewTier2Cases(newCases);
		populateEmailAddresses(tier2Cases);
	}

	public static void beforeUpdate(Map<Id, Case> updatedCases, Map<Id, Case> oldCases){
		if(isTest || !alreadyRan){
			if(contactRecordType == null) setContactRecordType();
			List<Case> tier2Cases = getUpdatedTier2Cases(updatedCases, oldCases);
			populateEmailAddresses(tier2Cases);
			calculateBusinessHoursAge(updatedCases.values(), oldCases);
		}
	}

	public static void afterInsert(Map<Id, Case> insertedCases){
		if(contactRecordType == null) setContactRecordType();
		createContact(insertedCases);
		removeCCRsOnCasesWithoutEmailAndPhone(insertedCases);
	}

	public static void afterUpdate(Map<Id, Case> updatedCases, Map<Id, Case> oldCases){
		if(isTest || !alreadyRan) {
			if(contactRecordType == null) setContactRecordType();
			Map<Id, Case> filteredCases = checkForEssentialChanges(updatedCases, oldCases);
			createContact(filteredCases);
			removeCCRsOnCasesWithoutEmailAndPhone(filteredCases);
		}
	}

	private static void setContactRecordType(){
		contactRecordType = [SELECT Id, SobjectType, Name FROM RecordType WHERE DeveloperName = 'FCIC_Individual' AND SobjectType = 'Contact' LIMIT 1];
	}

	// used to grab all Tier 2 cases that are being inserted
	private static List<Case> getNewTier2Cases(List<Case> newCases){
		List<Case> tier2Cases = new List<Case>();
		for(Case c : newCases) {
			if(c.Tier_2_Subject__c != null) {
				tier2Cases.add(c);
			}
		}
		return tier2Cases;
	}

	// used to grab all cases that has an updated tier 2 subject
	private static List<Case> getUpdatedTier2Cases(Map<Id, Case> updatedCases, Map<Id, Case> oldCases){
		List<Case> tier2Cases = new List<Case>();
		Set<Id> caseIds = updatedCases.keySet();
		for(Id caseId : caseIds) {
			String oldTier2Subject = oldCases.get(caseId).Tier_2_Subject__c;
			String newTier2Subject = updatedCases.get(caseId).Tier_2_Subject__c;

			if(newTier2Subject != oldTier2Subject)
			{
				tier2Cases.add(updatedCases.get(caseId));
			}
		}
		return tier2Cases;
	}

	// this method populates email addresses 1 through 5 according to which emails are in the custom setting
	private static void populateEmailAddresses(List<Case> tier2Cases){
		if(!tier2Cases.isEmpty()) {
			Set<String> siteStrings = new Set<String>();
			Set<String> tier2SubjectStrings = new Set<String>();
			for(Case c : tier2Cases){
				siteStrings.add(c.Site__c);
				tier2SubjectStrings.add(c.Tier_2_Subject__c);
			}

			List<Tier2Email__c> tier2Emails = [SELECT Category__c, Program__c, Template_Id__c, From_Email_Address__c, Email_Address_1__c, Email_Address_2__c, Email_Address_3__c, Email_Address_4__c, Email_Address_5__c
													FROM Tier2Email__c
													WHERE Program__c IN :siteStrings
													AND Category__c IN :tier2SubjectStrings];

			for(Case c : tier2Cases){
				if(c.Site__c == null) continue;
				if(c.Tier_2_Subject__c == null){
					c.template_id__c = '';
					c.Tier_2_From_Email_Address__c = '';
					c.Tier_2_Email_Address_1__c = '';
					c.Tier_2_Email_Address_2__c = '';
					c.Tier_2_Email_Address_3__c = '';
					c.Tier_2_Email_Address_4__c = '';
					c.Tier_2_Email_Address_5__c = '';
					continue;
				}
				for(Tier2Email__c tier2email : tier2Emails) {
					if(c.Site__c.equals(tier2email.Program__c) && c.Tier_2_Subject__c.equals(tier2email.Category__c)){
						c.template_id__c = tier2email.Template_Id__c;
						c.Tier_2_From_Email_Address__c = tier2email.From_Email_Address__c;
						c.Tier_2_Email_Address_1__c = tier2email.Email_Address_1__c;
						c.Tier_2_Email_Address_2__c = tier2email.Email_Address_2__c;
						c.Tier_2_Email_Address_3__c = tier2email.Email_Address_3__c;
						c.Tier_2_Email_Address_4__c = tier2email.Email_Address_4__c;
						c.Tier_2_Email_Address_5__c = tier2email.Email_Address_5__c;
					}
				}
			}
		}
	}

	// essential info at this time: first name, last name, phone OR email
	private static List<Case> filterCasesWithoutEssentialInfo(Map<Id, Case> caseMap){
		List<Case> caseList = caseMap.values();
		List<Case> casesToCreateContactsFor = new List<Case>();
		for(Case c : caseList){
			if(c.Customer_First_Name__c == null) continue;
			if(c.Customer_Last_Name__c == null) continue;
			if(c.Customer_Email_address__c == null && c.Customer_Phone__c == null) continue;
			casesToCreateContactsFor.add(c);
		}
		return casesToCreateContactsFor;
	}

	// 'essential' changes are anything that would incite a change to CCRs and Contact creation
	// at this time those essential changes are change to last name, first name, email and phone
	private static Map<Id, Case> checkForEssentialChanges(Map<Id, Case> newCaseMap, Map<Id, Case> oldCaseMap){
		Map<Id, Case> filteredCases = new Map<Id, Case>();
		List<Case> newCaseList = newCaseMap.values();
		for(Case newCase: newCaseList){
			Case oldCase = oldCaseMap.get(newCase.Id);
			if(newCase.Customer_First_Name__c != oldCase.Customer_First_Name__c) {
				filteredCases.put(newCase.Id, newCase);
				continue;
			}
			if(newCase.Customer_Last_Name__c != oldCase.Customer_Last_Name__c) {
				filteredCases.put(newCase.Id, newCase);
				continue;
			}
			if(newCase.Customer_Phone__c != oldCase.Customer_Phone__c){
				filteredCases.put(newCase.Id, newCase);
				continue;
			}
			if(newCase.Customer_Email_address__c != oldCase.Customer_Email_address__c){
				filteredCases.put(newCase.Id, newCase);
				continue;
			}
		}
		return filteredCases;
	}

	// web to case will have the Supplied Name field filled out rather than the First Name and Last Name custom fields
	// we need to parse the Supplied Name for two words via the first space
	private static void supportWebToCase(List<Case> caseList) {
		for(Case c : caseList) {
			if(c.SuppliedName != null){
				String name = c.SuppliedName;
				// this is only ever needed for OOB versions of web to case where format of SuppliedName is 'Lastname, Firstname'
				String commaAndSpace = ', ';
				Integer firstCaseSeparator = name.indexOf(commaAndSpace);
				if(firstCaseSeparator == -1){
					String space = ' ';
					Integer secondCaseSeparator = name.indexOf(space);
					if(secondCaseSeparator == -1){
						c.Customer_Last_Name__c = name;
					} else{
						String firstName = name.substring(0, secondCaseSeparator);
						String lastName = name.substring(secondCaseSeparator, name.length());
						c.Customer_First_Name__c = firstName;
						c.Customer_Last_Name__c = lastName;
					}
				} else {
					// last name is in the first half due to format of 'Lastname, Firstname'
					String lastName = name.substring(0, firstCaseSeparator);
					// firstCaseSeparator + 1 due to our subString consisting of two characters
					String firstName = name.substring(firstCaseSeparator + 1, name.length());
					c.Customer_First_Name__c = firstName;
					c.Customer_Last_Name__c = lastName;
				}
			}
			if(c.SuppliedEmail != null){
				c.Customer_Email_address__c = c.SuppliedEmail;
			}
		}
	}

	/*
		- Requirement added to copy the value of the description field into the subject field whenever a prechat survey is filled out via the LiveAgentForm_XXX.pages and the GSA_FCIC_LiveAgent_Prechat_Controller.cls
		- This will be called on insert and assume any new case with a populated Description (a field already filled out via the pre-chat code) and the subject empty (something that isn't filled out on new chats) is something we want to modify
		- This ensures any new cases that are created with a populated subject and description that the subject isn't lost
	*/
	private static void copyDescriptionToSubject(List<Case> newCases){
		for(Case c : newCases){
			if(c.Description != null && c.Subject == null) {
				String description = c.Description;
				if(description.length() < 255){
					c.Subject = c.Description;
				} else {
					c.Subject = description.substring(0,255);
				}
			}
		}
	}

	private static void createContact(Map<Id, Case> caseMap){

		List<Case> casesToCreateContactsFor = filterCasesWithoutEssentialInfo(caseMap);
		if(casesToCreateContactsFor == null || casesToCreateContactsFor.isEmpty()) return;

		Map<String, Contact> existingContactsMap = queryExistingContacts(casesToCreateContactsFor);

		Map<Case, Contact> caseToContactMap = compareCasesToExistingContacts(casesToCreateContactsFor, existingContactsMap);

		try {
			upsert caseToContactMap.values();
		} catch (DmlException e) {
			casesToCreateContactsFor.get(0).addError('An error occurred while trying to insert/update contacts');
			System.debug(e);
		}

		fixCaseContactRoles(caseToContactMap);

	}

	// creates a map that stores three keys for every contact queried
	// if any of these keys are matched to the new or updated case information
	// then we would have a duplicate contact
	private static Map<String, Contact> queryExistingContacts(List<Case> caseList){
		Map<String, Contact> existingContactsMap = new Map<String, Contact>();
		Set<String> firstNameSet = new Set<String>();
		Set<String> lastNameSet = new Set<String>();
		Set<String> emailSet = new Set<String>();
		Set<String> phoneSet = new Set<String>();

		for(Case c : caseList) {
			firstNameSet.add(c.Customer_First_Name__c);
			lastNameSet.add(c.Customer_Last_Name__c);
			if(c.Customer_Email_address__c != null) emailSet.add(c.Customer_Email_address__c);
			if(c.Customer_Phone__c != null) phoneSet.add(c.Customer_Phone__c);
		}

		// grab contacts that have the same essential information as the cases that we're looking at
		// stored in existingContactsMap
		List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Phone
										FROM Contact
										WHERE
											RecordTypeId = :contactRecordType.Id
											AND (Email IN :emailSet OR Phone IN :phoneSet)
											AND FirstName IN :firstNameSet
											AND LastName IN :lastNameSet];

		// creates three keys to compare the new contacts to
		// if any of these keys match data in our case then we have a duplicate
		for(Contact c : contactList){
			String key1 = c.FirstName + c.LastName + c.Email + c.Phone;
			String key2 = c.FirstName + c.LastName + c.Email;
			String key3 = c.FirstName + c.LastName + c.Phone;
			existingContactsMap.put(key1, c);
			existingContactsMap.put(key2, c);
			existingContactsMap.put(key3, c);
		}

		return existingContactsMap;
	}

	// here we compare each new or updated case to the keys from the queryExistingContacts() result
	private static Map<Case, Contact> compareCasesToExistingContacts(List<Case> newOrUpdatedCases, Map<String, Contact> existingContacts){
		if(existingContacts == null) return null;

		Map<Case, Contact> caseToContactMap = new Map<Case, Contact>();

		for(Case cas3 : newOrUpdatedCases){
			Contact contac7 = existingContacts.get(cas3.Customer_First_Name__c + cas3.Customer_Last_Name__c + cas3.Customer_Email_address__c + cas3.Customer_Phone__c);
			if(contac7 == null){
				contac7 = existingContacts.get(cas3.Customer_First_Name__c + cas3.Customer_Last_Name__c + cas3.Customer_Email_address__c);
				if(contac7 == null) {
					contac7 = existingContacts.get(cas3.Customer_First_Name__c + cas3.Customer_Last_Name__c + cas3.Customer_Phone__c);
					if(contac7 == null) {
						// no contact exists for this case
						Contact c = new Contact();
						c.FirstName = cas3.Customer_First_Name__c;
						c.LastName = cas3.Customer_Last_Name__c;
						c.Email = cas3.Customer_Email_address__c;
						c.Phone = cas3.Customer_Phone__c;
						c.RecordType = contactRecordType;
						caseToContactMap.put(cas3, c);
						continue;
					// existing contact is found with a first name, last name and phone only
					} else{
					}
				// existing contact is found with a first name, last name and email address only
				} else{
				}
			// existing contact is found with all four fields matched to the case
			} else {
				// do nothing - contact already has all 4 pieces of information
			}
			// contact already exists
			// TODO: validate changes
			contac7.Email = cas3.Customer_Email_address__c;
			contac7.Phone = cas3.Customer_Phone__c;
			caseToContactMap.put(cas3, contac7);
		}
		return caseToContactMap;
	}

	private static void fixCaseContactRoles(Map<Case, Contact> caseToContactMap){
		if(caseToContactMap == null || caseToContactMap.isEmpty()) return;

		Set<Case> caseSet = caseToContactMap.keySet();
		Set<Id> caseIds = new Set<Id>();
		List<CaseContactRole> caseContactRolesToCreate = new List<CaseContactRole>();
		Map<Id, Case> casesToUpdateMap = new Map<Id, Case>();
		Map<Case, Contact> caseToOldContactMap = new Map<Case, Contact>();
		for(Case c : caseSet){
			// this means upon contact creation the trigger changed the record type to Duplicate, therefore we shouldn't assign the CaseContactRole to this contact but the old one instead
			if(caseToContactMap.get(c).RecordTypeId != contactRecordType.Id){
				caseToOldContactMap.put(c, caseToContactMap.get(c));
				continue;
			}
			caseIds.add(c.Id);
			CaseContactRole ccr = new CaseContactRole();
			ccr.CasesId = c.Id;
			ccr.ContactId = caseToContactMap.get(c).Id;
			caseContactRolesToCreate.add(ccr);

			Case cas3 = new Case();
			cas3.Id = c.Id;
			cas3.ContactId = caseToContactMap.get(c).Id;
			cas3.Customer_First_Name__c = c.Customer_First_Name__c;
			cas3.Customer_Last_Name__c = c.Customer_Last_Name__c;
			if(c.Customer_Email_address__c != null) cas3.Customer_Email_address__c = c.Customer_Email_address__c;
			if(c.Customer_Phone__c != null) cas3.Customer_Phone__c = c.Customer_Phone__c;
			casesToUpdateMap.put(cas3.Id, cas3);
		}

		// create sets for query of old contacts; we need these for new CaseContactRoles
		List<Contact> dupContacts = caseToOldContactMap.values();
		Set<String> firstNames = new Set<String>();
		Set<String> lastNames = new Set<String>();
		Set<String> emails = new Set<String>();
		Set<String> phones = new Set<String>();
		for(Contact dupe : dupContacts){
			firstNames.add(dupe.FirstName);
			lastNames.add(dupe.LastName);
			if(dupe.Email != null) emails.add(dupe.Email);
			if(dupe.Phone != null) phones.add(dupe.Phone);
		}

		List<Contact> oldContactList = [SELECT Id, FirstName, LastName, Phone, Email
											FROM Contact
											WHERE
												RecordTypeId = :contactRecordType.Id
												AND (Email IN :emails OR Phone IN :phones)
												AND FirstName IN :firstNames
												AND LastName IN :lastNames];

		Set<Case> casesWithOldContacts = caseToOldContactMap.keySet();
		for(Case c : casesWithOldContacts){
			for(Contact oldContact : oldContactList){
				if(oldContact.FirstName != caseToOldContactMap.get(c).FirstName) continue;
				if(oldContact.LastName != caseToOldContactMap.get(c).LastName) continue;
				if(oldContact.Email == caseToOldContactMap.get(c).Email || oldContact.Phone == caseToOldContactMap.get(c).Phone){
					caseIds.add(c.Id);
					CaseContactRole ccr = new CaseContactRole();
					ccr.CasesId = c.Id;
					ccr.ContactId = oldContact.Id;
					caseContactRolesToCreate.add(ccr);

					Case cas3 = new Case();
					cas3.Id = c.Id;
					cas3.ContactId = oldContact.Id;
					cas3.Customer_First_Name__c = c.Customer_First_Name__c;
					cas3.Customer_Last_Name__c = c.Customer_Last_Name__c;
					if(c.Customer_Email_address__c != null) cas3.Customer_Email_address__c = c.Customer_Email_address__c;
					if(c.Customer_Phone__c != null) cas3.Customer_Phone__c = c.Customer_Phone__c;
					casesToUpdateMap.put(cas3.Id, cas3);
				}
			}
		}

		// find all existing casecontactroles that match the CONTACTS that are already created.. we only want a contact to be associated with this most recent case
		List<CaseContactRole> caseContactRolesToDelete = [SELECT Id, CasesId, ContactId
															FROM CaseContactRole
															WHERE CasesId IN :caseIds];

		delete caseContactRolesToDelete;

		insert caseContactRolesToCreate;

		List<Case> casesToUpdate = casesToUpdateMap.values();
		if(!casesToUpdate.isEmpty()){
			alreadyRan = true;
			update casesToUpdate;
		}

	}

	private static void removeCCRsOnCasesWithoutEmailAndPhone(Map<Id, Case> caseMap) {
		List<Case> caseList = caseMap.values();
		Set<Id> caseIdsSet = new Set<Id>();
		for(Case c : caseList){
			if(c.Customer_Phone__c == null && c.Customer_Email_address__c == null || c.Customer_First_Name__c == null || c.Customer_Last_Name__c == null){
				caseIdsSet.add(c.Id);
			}
		}

		List<CaseContactRole> caseContactRolesToDelete = [SELECT Id FROM CaseContactRole WHERE CasesId IN :caseIdsSet];

		delete caseContactRolesToDelete;
	}

	public static void calculateBusinessHoursAge(List<Case> updatedCaseList, Map<Id, Case> oldCaseMap){
		List<BusinessHours> businessHoursList = [SELECT Id FROM BusinessHours WHERE Name = 'FCIC hours'];
		if(businessHoursList.size() == 0) return;
		Id bsnsHoursId = businessHoursList.get(0).Id;
		for(Case updatedCase : updatedCaseList){
			Case oldCase = oldCaseMap.get(updatedCase.Id);
			if(oldCase.Status != updatedCase.Status && updatedCase.Status == 'Closed'){
				Datetime startTime = updatedCase.CreatedDate;
				Datetime endTime = Datetime.now();
				Decimal timeInMilliseconds = BusinessHours.diff(bsnsHoursId, startTime, endTime);
				Decimal timeInMinutes = timeInMilliseconds/1000/60;
				Decimal timeInHours = timeInMinutes/60;
				updatedCase.Business_Hours_Age__c = timeInHours;
				System.debug(BusinessHours.diff(bsnsHoursId, startTime, endTime));
			} else if(updatedCase.Status != 'Closed'){
				updatedCase.Business_Hours_Age__c = NULL;
			}
		}
	}
	// SCRIPT TO UPDATE AN ORG WITHOUT THIS INFORMATION ALREADY CALCULATED
	/*
		BusinessHours bsnsHours = [SELECT Id FROM BusinessHours WHERE Name = 'FCIC hours' LIMIT 1];
		Id bsnsHoursId = bsnsHours.Id;

		List<Case> caseList = [SELECT Id, CreatedDate, ClosedDate, Business_Hours_Age__c FROM Case WHERE ClosedDate != NULL];
		for(Case c : caseList){
		    Datetime startTime = c.CreatedDate;
			Datetime endTime = c.ClosedDate;
		    Decimal timeInMilliseconds = BusinessHours.diff(bsnsHoursId, startTime, endTime);
		    Decimal timeInMinutes = timeInMilliseconds/1000/60;
		    Decimal timeInHours = timeInMinutes/60;
		    c.Business_Hours_Age__c = timeInHours;
		}
		update caseList;
	*/

}