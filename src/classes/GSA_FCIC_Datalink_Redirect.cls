public class GSA_FCIC_Datalink_Redirect{

    public static String login {get; set;}
    public static String password {get; set;}
    public static String guid {get; set;}

    Integrations__c datalinkIntegration = Integrations__c.getValues('Datalink');
    String guidFromCustomSetting = datalinkIntegration.GUID__c;
    String passwordFromCustomSetting = datalinkIntegration.Password__c;

    public GSA_FCIC_Datalink_Redirect(){
        login = 'GateTest1@convergys.com'; //UserInfo.getUserEmail(); // get from currently signed in user
        password = passwordFromCustomSetting; // get from custom setting
        guid = guidFromCustomSetting; // get from custom setting
    }

}