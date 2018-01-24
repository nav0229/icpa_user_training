@isTest
public with sharing class TestDataUtil {
	public static Account createAccount(){
		return new Account(
			Name = 'Test Account'
		);
	}

	public static Account insertAccount(){
		Account testAccount = createAccount();
		insert testAccount;
		return testAccount;
	}

	public static Contact createContact(){
		return new Contact(
			LastName = 'Test Contact'
		);
	}

	public static Contact insertContact(){
		Account testAccount = insertAccount();
		Contact testContact = createContact(); 
		testContact.AccountId = testAccount.Id;
		insert testContact;
		return testContact;
	}

	public static Contact insertContact(Account acct){
		Contact testContact = createContact();
		testContact.AccountId = acct.Id;
		insert testContact;
		return testContact;
	}

	public static Applicant__c createApplicant(){
		return new Applicant__c(
			Name = 'Test Applicant',
			Primary_Applicant__c = true
		);
	}

	public static Applicant__c insertApplicant(){
		Account testAccount = insertAccount();
		Contact testContact = insertContact(testAccount);
		Application__c testApplication = insertApplication();
		Applicant__c testApplicant = createApplicant();
		testApplicant.Application__c = testApplication.Id;
		testApplicant.Account__c = testAccount.Id;
		testApplicant.Contact__c = testContact.Id;
		insert testApplicant;
		return testApplicant;
	}

	public static Applicant__c insertApplicant(Application__c application){
		Account testAccount = insertAccount();
		Contact testContact = insertContact(testAccount);
		Applicant__c testApplicant = createApplicant();
		testApplicant.Application__c = application.Id;
		testApplicant.Account__c = testAccount.Id;
		testApplicant.Contact__c = testContact.Id;
		insert testApplicant;
		return testApplicant;
	}

	public static Applicant__c insertApplicant(Account acct, Contact cont, Application__c application) {
		Applicant__c testApplicant = createApplicant();
		testApplicant.Account__c = acct.Id;
		testApplicant.Application__c = application.Id;
		testApplicant.Contact__c = cont.Id;
		insert testApplicant;
		return testApplicant;
	}

	public static Application__c createApplication(){
		return new Application__c(
			Name = 'TestApplication',
			Family_Size__c = 2,
			External_ID__c = datetime.now().formatGMT('MMM d yyyy HH:mm')
		);
	}

	public static Application__c insertApplication(){
		Application__c testApplication = createApplication();
		insert testApplication;
		return testApplication;
	}

	public static Case createCase(){
		return new Case(
			Status = 'Requested',
			Origin = 'Application Requirement'
		);
	}

	public static Case insertCase(){
		Application__c testApplication = insertApplication();
		Case testCase = createCase();
		testCase.Application__c = testApplication.Id;
		insert testCase;
		return testCase;
	}

	public static Case insertCase(Application__c application){
		Case testCase = createCase();
		testCase.Application__c = application.Id;
		insert testCase;
		return testCase;
	}

	public static Property__c createDamagedProperty(){
		Application__c testApplication = insertApplication();
		return new Property__c(
				Name = 'Test Damaged Property',
				Damaged_Property__c = true,
				Application__c = testApplication.Id
			);
	}

	public static Property__c createDamagedProperty(Application__c testApplication){
		return new Property__c(
				Name = 'Test Damaged Property',
				Damaged_Property__c = true,
				Application__c = testApplication.Id
			);
	}

	public static Property__c insertDamagedProperty(){
		Property__c testDamagedProperty = createDamagedProperty();
		insert testDamagedProperty;
		return testDamagedProperty;
	}

	public static Property__c insertDamagedProperty(Application__c testApplication){
		Property__c testDamagedProperty = createDamagedProperty(testApplication);
		insert testDamagedProperty;
		return testDamagedProperty;
	}

	public static Property__c createOtherProperty(){
		Application__c testApplication = insertApplication();
		return new Property__c(
				Name = 'Test Other Property',
				Other_Property__c = true,
				Application__c = testApplication.Id
			);
	}

	public static Property__c createOtherProperty(Application__c testApplication){
		return new Property__c(
				Name = 'Test Other Property',
				Other_Property__c = true,
				Application__c = testApplication.Id
			);
	}

	public static Property__c insertOtherProperty(){
		Property__c testDamagedProperty = createOtherProperty();
		insert testDamagedProperty;
		return testDamagedProperty;
	}

	public static Property__c insertOtherProperty(Application__c testApplication){
		Property__c testDamagedProperty = createOtherProperty(testApplication);
		insert testDamagedProperty;
		return testDamagedProperty;
	}

	public static Loss_Verification_Inspections__c createLossVerification(){
		Property__c damagedProperty = insertDamagedProperty();
		return new Loss_Verification_Inspections__c(
			Name = 'Test Loss Verification',
			Property__c = damagedProperty.Id
			);
	}

	public static Loss_Verification_Inspections__c createLossVerification(Property__c property){
		return new Loss_Verification_Inspections__c(
			Name = 'Test Loss Verification', 
			Property__c = property.Id
			);
	}

	public static Loss_Verification_Inspections__c insertLossVerification(){
		Loss_Verification_Inspections__c testLossVerification = createLossVerification();
		insert testLossVerification;
		return testLossVerification;
	}

	public static Loss_Verification_Inspections__c insertLossVerification(Property__c property){
		Loss_Verification_Inspections__c testLossVerification = createLossVerification(property);
		insert testLossVerification;
		return testLossVerification;
	}

}