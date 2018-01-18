@istest
class CIS_TestscheduledTasks 
{
    public static String CRON_EXP = '0 0 0 10 10 ? 2020';
    static testmethod void testCISscheduledTasks() {
        Test.startTest();
        Contact emailContact = new Contact();
        emailContact.firstName = 'EmailLastName';
        emailContact.lastName = 'H';        
        emailContact.email = 'hamedullah.mohammed@gsa.gov';
        insert emailContact;
        
        CIS_Contact__c contactOne = new CIS_Contact__c();
        contactOne.Name = 'TESTLASTNAME';
        contactOne.First_Name__c = 'TESTFIRSTNAME';
        contactOne.Type__c = 'Member of Congress';
        insert contactOne;
    
        CIS_MemberOfCongress__c memOfCongress = new CIS_MemberOfCongress__c();
        Schema.DescribeSObjectResult memOfCongressSchema = Schema.SObjectType.CIS_MemberOfCongress__c;
        Map<String,Schema.RecordTypeInfo> memOfCongressRecordTypeInfo = memOfCongressSchema.getRecordTypeInfosByName(); 
        memOfCongress.recordTypeId = memOfCongressRecordTypeInfo.get('Senate').getRecordTypeId();
        memOfCongress.State_of_Office__c = 'AL';
        memOfCongress.Region__c = '01';
        memOfCongress.Original_Budget__c = 10000.00;
        memOfCongress.Election_Year__c = '2010';
        memOfCongress.Member_of_Congress_Name__c = contactOne.Id;        
        memOfCongress.Spent_Asset_Budget__c = null;
        insert memOfCongress;
        
        Schema.DescribeSObjectResult pmoOfficeSchema = Schema.SObjectType.CIS_Offices__c;
        Map<String,Schema.RecordTypeInfo> pmoOfficeRecordTypeInfo = pmoOfficeSchema.getRecordTypeInfosByName();      
        CIS_Offices__c pmoOffice = new CIS_Offices__c();
        pmoOffice.recordTypeId = pmoOfficeRecordTypeInfo.get('Senate').getRecordTypeId();
        pmoOffice.PMO_AO_Number__c = 'TE12';
        pmoOffice.Space_Assigned__c = 'GSA';
        pmoOffice.Member_ID__c = memOfCongress.Id;
        insert  pmoOffice;
        
      
        pmoOffice = [SELECT Id,Name, PMO_AO_Number__c,Member_ID__c FROM CIS_Offices__c WHERE PMO_AO_Number__c = 'TE12' and Member_ID__c = :memOfCongress.Id][0];

        CIS_Assets__c asset = new CIS_Assets__c();
        asset.Name = 'TE01';
        system.debug('---------------------------------------------------pmoOffice.Id---------:'+pmoOffice.Id);
        asset.CIS_Office__c = pmoOffice.Id;
        asset.Unit_Cost__c = 100;
        asset.Quantity__c = 2;
        asset.Expense_Type__c = 'B - Carpet/Drapes';
        date currentDate = date.today().addYears(-6);
        asset.Date_Received__c = currentDate;
        insert asset;
        
        String jobId = System.schedule('CIS_TestscheduledTasks Test',CIS_TestscheduledTasks.CRON_EXP, new CIS_scheduledTasks());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CIS_TestscheduledTasks.CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2020-10-10 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }
}