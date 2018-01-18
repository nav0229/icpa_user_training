public with sharing class UpdateUserLicenseUtil {
	
    @future
    public static void UpdateUserLicense (Set<Id> userIds) {
    	
    	List<OrgUsersLicense__c> UpdateLicenseObj = new List<OrgUsersLicense__c>();
    	string strFederaditionID;
    	
   		for (User objUser: [SELECT 	ID, IsActive, SAML_Federation_ID_Custom__c, Username, Profile.UserLicense.Name, MAJOR_ORG_DESCRIPTION__c 
   							FROM 	User 
   							WHERE 	ID IN :userIds]){
   			
   			OrgUsersLicense__c objUserUpdated = New OrgUsersLicense__c();
	    	objUserUpdated.ActiveUser__c = objUser.IsActive;
	    	objUserUpdated.FederationID__c = objUser.SAML_Federation_ID_Custom__c;
	    	objUserUpdated.UserID__c = objUser.Username;
	    	objUserUpdated.UserLicense__c = objUser.Profile.UserLicense.Name;
	    	objUserUpdated.OrgID__c = UserInfo.getOrganizationId();
	    	objUserUpdated.OrgName__c = UserInfo.getOrganizationName();
	    	objUserUpdated.OrgFedIDKey__c = (UserInfo.getOrganizationId() + objUser.SAML_Federation_ID_Custom__c);
	    	objUserUpdated.OfficeStaffOffice__c = objUser.MAJOR_ORG_DESCRIPTION__c;
	    	If (objUser.SAML_Federation_ID_Custom__c != Null && (objUser.Profile.UserLicense.Name == 'Salesforce' ||  objUser.Profile.UserLicense.Name == 'Salesforce Platform' ||  objUser.Profile.UserLicense.Name == 'Chatter Free')){
	    		UpdateLicenseObj.Add(objUserUpdated);
	    	}
        }
     	
     	Database.UpsertResult[] upsertResults = Database.upsert(UpdateLicenseObj, OrgUsersLicense__c.OrgFedIDKey__c, false);
    }	
    
}