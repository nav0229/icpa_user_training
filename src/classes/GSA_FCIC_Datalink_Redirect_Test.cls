@isTest
public class GSA_FCIC_Datalink_Redirect_Test{

    static testMethod void validateConstructor(){
        Test.startTest();

        Integrations__c datalinkIntegration = new Integrations__c();
        datalinkIntegration.Name = 'Datalink';
        datalinkIntegration.GUID__C = '123';
        datalinkIntegration.Password__c = 'password';
        insert datalinkIntegration;

        GSA_FCIC_Datalink_Redirect button = new GSA_FCIC_Datalink_Redirect();

        System.assertNotEquals(null, button);

        Test.stopTest();
    }

}