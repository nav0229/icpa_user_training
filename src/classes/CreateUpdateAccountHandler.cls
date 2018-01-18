/**
	Controller for the Create or Associate Accounts on Contact creation

	@author	Acumen Solutions
	@since	11-06-2014
*/

public with sharing class CreateUpdateAccountHandler {


	public static void createOrAssociateAccount(List<Contact> contacts) {

		ID indRecTypeID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
		ID accRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
		
		List<Contact> contactsToProcess = new List<Contact>();
		
		for (Contact c: contacts) {                   
			if ((c.recordtypeId == indRecTypeID)) {
				contactsToProcess.add(c);
			}
			System.debug('#### contactsToProcess'+ contactsToProcess);	
		}

		List<String> emailAddresses = new List<String>();
		List<String> Names = new List<String>();
		Map<String, Contact> conMap = new Map<String, Contact>();
		List<Contact> lstCon = new List<Contact>();
			
	    //First exclude any contacts where the Account is set, name is not set
	    for (Contact conObj : contactsToProcess) {
	        if (conObj.firstname !='' && conObj.lastname !='' && conObj.AccountId != null) {
	            //emailAddresses.add(conObj.Email);
	            Names.add(conObj.firstname + '-' + conObj.lastname);	            
	        }	
	        System.debug('#### Names'+ Names);	              
	    }

	    //Now we have a nice list of all the contact info.  Let's query on it and see how many accounts already exist.
	    List<Account> listAccounts = [SELECT Id, name FROM Account WHERE name IN :Names];
	    Set<String> takenEmails = new Set<String>();

	    Map<String, Account> AccountMap = new Map<String, Account>();
	    for (Account acc : listAccounts) {			
			AccountMap.put(acc.name, acc); //concatenating the strings to make efficient keys
		}

	    Map<String,Account> infoToAcctMap = new Map<String,Account>();
	   
	    List<Account> newAccounts = new List<Account>();
	    List<Account> newAddAccounts = new List<Account>();	 
	    Map<String, Account> mapNewAccToAdd = new Map<String, Account>();  
	    
		Account selectedAccount;
		
		
		for (Contact c : contactsToProcess) {
			selectedAccount = new Account();			
			//selectedAccount = AccountMap.get(c.firstname+'-' + c.lastname + '-'+c.Email);			
		    			     		    	    
			//if (selectedAccount != null) { //Hooray, found an Account
				//mapNewAccToAdd.put(c.firstname+'-' + c.lastname + '-'+ c.Email,selectedAccount);								
				//conMap.put(c.id, c);									
			//} else {
				if (c.AccountId == null && c.firstname != null &&  c.firstname != '' && c.lastname != null && c.lastname != '' ) {		        			            		            			                
					
					Account a = new Account (Name = c.firstname + '-'+c.lastname, recordtypeid = accRecordTypeID,
										Billingcity = c.mailingcity, billingStreet = c.mailingstreet, Billingstate = c.mailingstate, BillingCountry = c.mailingcountry,
										BillingPostalCode = c.mailingpostalcode);
					newAccounts.add(a);
					mapNewAccToAdd.put(c.firstname + '-'+c.lastname, a); //concatenating the strings to make efficient keys		                		                  						
					conMap.put(c.id, c);	    
					System.debug('#### Account '+ a);
					System.debug('#### conMap '+ conMap);	
					System.debug('#### mapNewAccToAdd '+ mapNewAccToAdd);
		        } 
			//}
		}
		
	    	insert newAccounts;

	    List<Contact> conList = [Select c.LastName, c.IsDeleted, c.Id, c.FirstName, c.Email, c.AccountId From Contact c where id in :conMap.keyset()];

		for (Contact cc : conList) {
	    	if (cc.LastName != null) {
				Account newAcc = mapNewAccToAdd.get(cc.FirstName + '-'+cc.LastName);	        	        
				cc.AccountId = newAcc.Id;
				lstCon.add(cc);
	    	} 
	    	 System.debug('#### lstCon'+ lstCon);	
	    }
	    update lstCon;
	}
}