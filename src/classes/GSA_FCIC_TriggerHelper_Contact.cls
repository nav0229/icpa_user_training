public class GSA_FCIC_TriggerHelper_Contact {

	private static RecordType individualRt;

	public static void beforeInsert(List<Contact> contactList){
		if(individualRt == null) setRecordType();
		dedupContact(contactList);
		List<Contact> blankAccountContacts = getContactsWithBlankAccounts(contactList);
		Map<Contact, Account> contactsNeedingAnAccount = createAccount(blankAccountContacts);
		associateNewAccountsToContacts(contactsNeedingAnAccount);
	}

	public static void beforeUpdate(List<Contact> updatedContacts, List<Contact> oldContacts){
		if(individualRt == null) setRecordType();
		List<Contact> filteredContacts = checkForUpdates(updatedContacts, oldContacts);
		filteredContacts = getIndividualTypeContacts(filteredContacts);
		if(filteredContacts == null || filteredContacts.isEmpty()){
			dedupContact(filteredContacts);
			List<Contact> blankAccountContacts = getContactsWithBlankAccounts(filteredContacts);
			Map<Contact, Account> contactsNeedingAnAccount = createAccount(blankAccountContacts);
			associateNewAccountsToContacts(contactsNeedingAnAccount);
		}
	}

	public static void afterInsert(){
		// nothing yet
	}

	public static void afterUpdate(){
		// nothing yet
	}

	private static void setRecordType(){
		individualRt = [
			SELECT Id, SobjectType, Name
			FROM RecordType
			WHERE DeveloperName = 'FCIC_Individual'
			AND SobjectType = 'Contact'
			LIMIT 1
		];
	}

	private static List<Contact> getIndividualTypeContacts(List<Contact> contacts){
		List<Contact> individualTypeContactList = new List<Contact>();
		for(Contact c : contacts){
			if(c.RecordType == individualRt){
				individualTypeContactList.add(c);
			}
		}
		return individualTypeContactList;
	}

	// looks at all contacts in trigger and only includes ones with a blank Account field
	private static List<Contact> getContactsWithBlankAccounts(List<Contact> contacts){
		List<Contact> blankAccountContacts = new List<Contact>();
		for(Contact c : contacts){
			if(c.AccountId == null) {
				blankAccountContacts.add(c);
			}
		}
		return blankAccountContacts;
	}

	private static List<Contact> checkForUpdates(List<Contact> updatedContacts, List<Contact> oldContacts){
		List<Contact> filteredContacts = new List<Contact>();
		for(Contact updatedContact : updatedContacts){
			for(Contact oldContact : oldContacts){
				if(updatedContact.Id == oldContact.Id){
					if(updatedContact.Email != oldContact.Email || updatedContact.Phone != updatedContact.Phone){
						filteredContacts.add(updatedContact);
					}
				}
			}
		}
		return filteredContacts;
	}

	// check if contact(s) already exists
	// if so, update new information
	// if not, create one
	private static void dedupContact(List<Contact> contacts){

		List<Contact> contactsToCheck = new List<Contact>();
		// skips contacts that don't have a first, last name, or (email or phone)
		for(Contact c : contacts){
			if(c.FirstName == null || c.LastName == null || (c.Email == null && c.Phone == null)){
				continue;
			}
			contactsToCheck.add(c);
		}

		// stores essential information for query later
		Set<String> firstNameSet = new Set<String>();
		Set<String> lastNameSet = new Set<String>();
		Set<String> emailSet = new Set<String>();
		Set<String> phoneSet = new Set<String>();

		// fill in the above vars
		for(Contact c : contactsToCheck){
			firstNameSet.add(c.FirstName);
			lastNameSet.add(c.LastName);
			emailSet.add(c.Email);
			phoneSet.add(c.Phone);
		}

		// grabs all existing contacts that use the last names and emails
		List<Contact> oldContactsList = [
			SELECT Id, FirstName, LastName, Email, Phone
			FROM Contact
			WHERE
			RecordTypeId = :individualRt.Id
			AND (Email IN :emailSet OR Phone IN :phoneSet)
			AND FirstName IN :firstNameSet
			AND LastName IN :lastNameSet
		];

		// stores old / found contacts in the same manner that the new ones were stored above in newContactsMap
		Map<String, Contact> oldContactsMap = new Map<String, Contact>();
		for(Contact c : oldContactsList){
			oldContactsMap.put(c.FirstName + c.LastName + c.Email + c.Phone, c);
			oldContactsMap.put(c.FirstName + c.LastName + c.Email, c);
			oldContactsMap.put(c.FirstName + c.LastName + c.Phone, c);
		}

		RecordType duplicateRt = [
			SELECT Id, SobjectType, Name
			FROM RecordType
			WHERE DeveloperName = 'FCIC_Duplicate'
			AND SobjectType = 'Contact'
			LIMIT 1
		];
		List<Contact> contactsToUpdate = new List<Contact>();
		// compares list of new contacts to existing contacts to check for duplicates
		for(Contact newContact : contactsToCheck){
			Contact oldContact;
			oldContact = oldContactsMap.get(newContact.FirstName + newContact.LastName + newContact.Email + newContact.Phone);
			if(oldContact == null){
				oldContact = oldContactsMap.get(newContact.FirstName + newContact.LastName + newContact.Email);
				if(oldContact == null){
					oldContact = oldContactsMap.get(newContact.FirstName + newContact.LastName + newContact.Phone);
					if(oldContact == null){
						// do nothing as this contact is brand new
						continue;
					}
				}
			}
			// contact was found so mark it as a duplicate
			// these will be picked up on a nightly batch for deletion
			// IMPORTANT: this is where we mark the record as a duplicate
			newContact.RecordTypeId = duplicateRt.Id;

			boolean changesMade = false;
			// update old contact with any new information!
			if(oldContact.Email != newContact.Email && newContact.Email != null){
				oldContact.Email = newContact.Email;
				changesMade = true;
			}
			if(oldContact.Phone != newContact.Phone && newContact.Phone != null){
				oldContact.Phone = newContact.Phone;
				changesMade = true;
			}
			if(changesMade){
				contactsToUpdate.add(oldContact);
			}
		}

		if(!contactsToUpdate.isEmpty()) update contactsToUpdate;
	}

	// search for account with last name and email
	// if exists, link the contact and account
	// if not, create account
	private static Map<Contact, Account> createAccount(List<Contact> contacts){
		RecordType accountRt = [
			SELECT Id, SobjectType, Name
			FROM RecordType
			WHERE DeveloperName = 'FCIC_Individual'
			AND SobjectType = 'Account'
			LIMIT 1
		];

		Set<String> nameSet = new Set<String>(); // includes first name + ' ' + last name
		Set<String> emailSet = new Set<String>();
		Set<String> phoneSet = new Set<String>();
		for(Contact c : contacts){
			// space is required as that is the convention in the account name
			nameSet.add(c.FirstName + ' ' + c.LastName);
			emailSet.add(c.Email);
			phoneSet.add(c.Phone);
		}

		List<Account> oldAccountList = [
			SELECT Id, Name, Phone, Email__c
			FROM Account
			WHERE Name IN :nameSet
			AND (Email__c IN :emailSet OR Phone IN :phoneSet)
		];

		Map<String, Account> oldAccountsMap = new Map<String, Account>();
		for(Account a : oldAccountList){
			oldAccountsMap.put(a.Name + ' ' + a.Email__c + ' ' + a.Phone, a);
			oldAccountsMap.put(a.Name + ' ' + a.Email__c, a);
			oldAccountsMap.put(a.Name + ' ' + a.Phone, a);
		}

		Map<Contact, Account> contactToNewAccounts = new Map<Contact, Account>();
		for(Contact c : contacts){
			String firstMatch = c.FirstName + ' ' + c.LastName + ' ' + c.Email + ' ' + c.Phone;
			String secondMatch = c.FirstName + ' ' + c.LastName + ' ' + c.Email;
			String thirdMatch = c.FirstName + ' ' + c.LastName + ' ' + c.Phone;
			Account a1 = oldAccountsMap.get(firstMatch);
			Account a2 = oldAccountsMap.get(secondMatch);
			Account a3 = oldAccountsMap.get(thirdMatch);
			// link the contact and account by changing the Account field on the contact
			// a1 != null means account was found with a matching first, last, email AND phone
			if(a1 != null){
				// Account found
				c.AccountId = a1.Id;
			}
			// a2 != null means account was found with a matching first, last, email
			else if(a2 != null){
				// Account found
				c.AccountId = a2.Id;
			}
			// a3 != null means account was found with a matching first, last, phone
			else if(a3 != null){
				c.AccountId = a3.Id;
			}
			else {
				// Account not found
				// create a new account
				Account newAccount = new Account();
				newAccount.RecordType = accountRt;
				// this is needed if a contact is created directly on contact object
				// it prevents the example Last Name: Coleman, First Name: (blank) and Account name: null Coleman
				if(c.FirstName == null) {
					newAccount.Name = c.LastName;
				} else {
					newAccount.Name = c.FirstName + ' ' + c.LastName;
				}
				if(c.Email != null) newAccount.Email__c = c.Email;
				if(c.Phone != null) newAccount.Phone = c.Phone;
				contactToNewAccounts.put(c, newAccount);
			}
		}

		// we're not updating accounts
		insert contactToNewAccounts.values();

		return contactToNewAccounts;
	}

	public static void associateNewAccountsToContacts(Map<Contact, Account> contactsNeedingAnAccount){
		if(contactsNeedingAnAccount == null || contactsNeedingAnAccount.isEmpty()) return;
		Set<Contact> contactSet = contactsNeedingAnAccount.keySet();
		for(Contact c : contactSet){
			if(c.AccountId == null) {
				c.AccountId = contactsNeedingAnAccount.get(c).Id;
			}
		}
	}

}