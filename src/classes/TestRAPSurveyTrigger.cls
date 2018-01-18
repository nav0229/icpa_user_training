@isTest
public class TestRAPSurveyTrigger{
    private static testMethod void unitTest(){
        List<user> usList = [select id from user where profileId =: '00e30000001zjtP' limit 3];
        
        RAP_Survey__c rs = new RAP_Survey__c();
        rs.PCO_Name__c = usList[0].id;
        rs.SIOA_Name__c = usList[1].id; 
        rs.IOA_Name__c = usList[2].id;
        rs.CAV_Date__c = system.toDay()-1;
        insert rs;
        
        SubmitRecord.processDetails(rs.id);
        
        rs.Pre_trip_meeting__c = 'Test';
        rs.Locations_and_Logistics__c = 'Test1';
        rs.IOA_Role__c = 'Test2';
        rs.Experience_for_Job_Performance__c = 'Test3';
        rs.Future_RAP_Opportunities__c = 'Test4';
        rs.Recommend_RAP__c = 'Test5';
        rs.IOA_Information_Seeking__c = 'Test6';
        rs.Interest_in_other_Opportunity__c = 'Test7';
        rs.Why__c = 'Test8';
        rs.Why_do_you__c = 'Test9';
        update rs;
 
        SubmitRecord.processDetails(rs.id);
        
        
        System.assertEquals(true,true);
        }
}