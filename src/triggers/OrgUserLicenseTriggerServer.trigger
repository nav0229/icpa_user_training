trigger OrgUserLicenseTriggerServer on OrgUsersLicense__c (after insert, after update) {
    
    List<string> FedIDsUpdated = new List<string>();
    List<OrgUsersLicense__c> MaxLicenseRecords = new List<OrgUsersLicense__c>();
    
    OrgUsersLicense__c objUpdateRecord;         
    string strPrevious = '-';
    string strCurrent;
     
    //Collect the Federation ID's of all the users (records) updated ...
    for (OrgUsersLicense__c newUserLicense : TRIGGER.new) 
        FedIDsUpdated.Add(newUserLicense.FederationID__c);

    //Collect the Major Orgs for all the users (records) updated ...
    Map<string, String> mapMajorOrgs = new Map<string, String>();
    AggregateResult[] AgR = Database.Query('Select FederationID__c, Max(OfficeStaffOffice__c) Office From OrgUsersLicense__c Where FederationID__c in :FedIDsUpdated Group By FederationID__c Limit 50000');
    for (AggregateResult RowData : AgR)
        mapMajorOrgs.put((String) RowData.get('FederationID__c'), (String) RowData.get('Office'));
    
    for (OrgUsersLicense__c newUserLicense : [Select ID, FederationID__c, OrgID__c, OfficeStaffOffice__c 
                                              From 	OrgUsersLicense__c 
                                              Where FederationID__c in :FedIDsUpdated 
                                              And 	FederationID__c != null 
                                              And ActiveUser__c = true
                                              Order by FederationID__c, LicenseRank__c Desc, CreatedDate Asc]) {
        objUpdateRecord = New OrgUsersLicense__c ();
        objUpdateRecord.ID = newUserLicense.ID;
        
        //Mark the Max License record
        strCurrent = newUserLicense.FederationID__c;
        if (strCurrent <> strPrevious){
            objUpdateRecord.MaxLicense__c = true; //Max License record for this user ...
             //objUpdateRecord.Comments__c = 'Set True by the Max License Code Logic; Current Record - ' + strCurrent + '; Previous Record - ' + strPrevious;
        } else {
            objUpdateRecord.MaxLicense__c = false; //all others make false - they could potentially be Max Licenses from before ...
            //objUpdateRecord.Comments__c = 'Set False by the Max License Code Logic; Current Record - ' + strCurrent + '; Previous Record - ' + strPrevious;
        }
        strPrevious = strCurrent;
        
        //Check if the Field Office is NULL; If NULL, assign a value from one of the previous records ...
        If (newUserLicense.OfficeStaffOffice__c == null)
            objUpdateRecord.OfficeStaffOffice__c = mapMajorOrgs.get(newUserLicense.FederationID__c);
        
        //Add the record to the collection ...
        MaxLicenseRecords.Add(objUpdateRecord);
    }
    
    //Check for recursive trigger invocations ...
    if (checkRecursive.runOnce()) {
        //database.update(MaxLicenseRecords);
        Update MaxLicenseRecords;
    }
     
}