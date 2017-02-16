@isTest
public class GSA_FCIC_CTI_Case_Creation_Test{

       static testMethod void GSAFCICCTICaseCreationTest(){
       
        integer dnis =null;
        TriggerControls__c triCon2 = new TriggerControls__c(Name = 'Case', On__c = true); insert triCon2;
        TriggerControls__c triCon3 = new TriggerControls__c(Name = 'Contact', On__c = true); insert triCon3;
         KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3); insert kbSync ;
        Exception__c exc = new Exception__c(Name = 'CTI Exception'); insert exc;
        Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('GSA.gov').getRecordTypeId();
        CTI_Cases__c cti = new CTI_Cases__c(Name = '14698',DNIS__c =14698, Case_Record_Type_ID__c = recTypeId ); insert cti;
        ApexPages.currentPage().getParameters().put('dnis','');
        GSA_FCIC_CTI_Case_Creation ctiCaseCreation = new GSA_FCIC_CTI_Case_Creation();
        ctiCaseCreation.displayCase(); 
        System.AssertEquals(null,dnis); 
         
        
      }
      
      
       static testMethod void CTICaseCreationTest1(){
       
        integer dnis = 14698;
        TriggerControls__c triCon2 = new TriggerControls__c(Name = 'Case', On__c = true); insert triCon2;
        TriggerControls__c triCon3 = new TriggerControls__c(Name = 'Contact', On__c = true); insert triCon3;
         KBSyncSettings__c kbSync = new KBSyncSettings__c(Name='SyncSettings', API_Key__c= '1234',Create_Exception_Record__c= true,  Date_Delta__c = 3,Email_Exception__c = true,Page_Size__c=3); insert kbSync ;
        Exception__c exc = new Exception__c(Name = 'CTI Exception'); insert exc;
        Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('GSA.gov').getRecordTypeId();
        CTI_Cases__c cti = new CTI_Cases__c(Name = '14698',DNIS__c =14698, Case_Record_Type_ID__c = recTypeId ); insert cti;
        ApexPages.currentPage().getParameters().put('dnis','14698'); 
        GSA_FCIC_CTI_Case_Creation ctiCaseCreation = new GSA_FCIC_CTI_Case_Creation();
        ctiCaseCreation.displayCase();
         System.Assert(14698==dnis); 
         
        
      }
}