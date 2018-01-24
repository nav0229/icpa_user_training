/****************************************************************
 Name: CBRCreditProfileJSON
============================================================
Author: Kevin
Purpose: JIRA#1336
	JSON Structure for CBR CreditProfile Callout
============================================================

****************************************************************/

public with sharing class CBRCreditProfileJSON {
	
	public class CBRCreditProfileRequest {
		public String applicationNumber;
		public String applicationSFID;
		public List<Applicants> applicants;
	}

	public class Applicants {
		public String isPrimary;
		public String ssn;
		public String applicantSFID;
		public Name name;
		public CurrentAddress currentAddress;
	}

	public class Name {
		public String surName;
		public String firstName;
	}

	public class CurrentAddress {
		public String street;
		public String city;
		public String state;
		public String zip;
	}

	public class CBRCreditProfileResponse {}
}