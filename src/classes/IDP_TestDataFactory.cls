/*-------------------------------------------------------------------------------------------------*
  Data factory for all IDP test classes
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Ramesh Dugar 
  & Nik Kasala     11/21/2016    1.0         created.  
 *-------------------------------------------------------------------------------------------------*
Introduction: TestDataFactory class is a public utility class built for IDP application to create reusable data at one single place. 
This class is defined with isTest annotation and hence do not count towards organization code size limit and execute in test context.
The methods in this public  utility class are defined the same way methods are in non-test classes. They can take parameters and can return a value. 
The methods should be declared as public or global to be visible to other test classes. These common methods can be called by any test 
method in your Apex classes to set up test data for IDP before running the test. The Data created in this class currently only populates fields that are used by other test methods. 
For future, new fields can be added to the class as needed. Implementing this class has reduced a lot of redundancy across all the IDP test classes 
and helped to re-factor old test classes for IDP application making them more robust and clean. 

-------------------------------------------------------------------------------------------------*/
@isTest
public  class IDP_TestDataFactory {

 /* The below method is used for creating test IDP records with virtual data. Argument numIdps is a integer and defines total number of Idps 
  to be created and the remaining arguments are used to pass data into IDP fields. These are very limited for now but more IDP fields can be added as needed. */

    public static List<IDP__c> createTestIDPRecords(Integer numIdps,String FY,String Status,String ShrtGoals,
                                                    String LngGoals,String RecType,String UserProfile){
        List<IDP__c> lstidp = new List<IDP__c>();
        RecordType rtype = [SELECT Name, Id FROM RecordType 
                        WHERE sObjectType='IDP__c' AND isActive=true AND Name=:RecType];
        Profile p = [SELECT Id FROM Profile WHERE Name=:UserProfile];
        User u = [SELECT Id FROM User WHERE isActive = true AND ProfileId =: p.Id LIMIT 1];
        system.debug('***user'+u);
        for(Integer i=0;i<numIdps;i++){
          IDP__C idp = new IDP__C();
          idp.Fiscal_Year_pick__c = FY;
          idp.IDP_Status__c = Status;
          idp.Career_Goals_Long_Run__c = ShrtGoals;
          idp.Career_Goals_Short_Run__c = LngGoals;
          idp.Supervisor__c = u.id;
          idp.Director__c = userInfo.getUserId();
          idp.RecordTypeId = rtype.Id;
          idp.Grade__c = '12';
          idp.Payplan__c = 'WL = Wage Learner';
          idp.Series__c = '0020 - Community Planning Series';
          lstidp.add(idp);
        }
      insert lstidp;
      return lstidp;
  }

/* The below method is used for creating test Developmental Objective records with virtual data. 
 Argument lstidp is a integer and defines total number of IDPS created.Argument numObjs is also a integer that defines how many 
 Developmental Objective to be created for every IDP. As needed, you should be able to populate more Developmental Objective fields*/
 
    public static List<Developmental_Objective__c> createObjective(List<IDP__c> lstidp,Integer numObjs){
        Integer numIdps = lstidp.size();
        List<Developmental_Objective__c> lstObj = new List<Developmental_Objective__c>();
        for(Integer j=0;j<numIdps;j++){
            IDP__c idp = lstidp[j];
            for (Integer k=numObjs*j;k<numObjs*(j+1);k++) {
                lstObj.add(new Developmental_Objective__c(Objective__c = 'Test'+k,
                                            Objective_Title__c='Test'+k,
                                            IDP__c=idp.id));
            }
        }
        insert lstObj;
        return lstObj;
    }

/* The below method is used for creating test Developmental Activity records with virtual data. 
 Argument lstObj is a integer and defines total number of Development Objectives created.
 Argument numActivities is also a integer that defines how many Developmental Activity to be created for every IDP. 
 As needed, you should be able to populate more Developmental Activity fields*/
    
    public Static List<IDP_Developmental_Line_Item__c> createActivity(List<Developmental_Objective__c> lstObj,Integer numActivities,Date StartD,Date EndD){
        Integer numObjs = lstObj.size();
        List<IDP_Developmental_Line_Item__c> lstAct = new List<IDP_Developmental_Line_Item__c>();
        for(Integer j=0;j<numObjs;j++){
            Developmental_Objective__c obj = lstObj[j];
            for (Integer k=numActivities*j;k<numActivities*(j+1);k++) {
                lstAct.add(new IDP_Developmental_Line_Item__c(IDP_Activity_Status__c = 'Initial',
                                     Developmental_Objective__c = obj.id,
                                     Priority__c = 'High',
                                     Assignment_Title__c = 'Test'+k,
                                     Planned_Start_Date__c = StartD,
                                     Training_Need__c = 'Required',
                                     Planned_End_Date__c = EndD,
                                     Required_Date__c = Date.today(),
                                     Series__c = 'Test',
                                     Books_Material_Costs__c = 1000.00,
                                     Tuition_Fees__c = 2000.00,
                                     Cost_Travel__c = 2000.00,
                                     Per_Diem__c = 50.00,
                                     Vendor__c = 'Test'+k,
                                     Location__c = 'Virginia',
                                     Organization_City__c = 'Arlington'));
            }
        }
        insert lstAct;
        return lstAct;
    }

/* The below method is used for creating test Developmental Competency records with virtual data. 
    Argument lstAct is a integer and defines total number of Developmental Activities created.
    Argument numComps is also a integer that defines how many Developmental Competencies to be created for every Developmental Activity.
    As needed, you should be able to populate more Developmental Competency fields*/


     public Static List<Developmental_Competency__c> createCompetency(List<IDP_Developmental_Line_Item__c> lstAct,Integer numComps){
        Integer numActs = lstAct.size();
        List<Developmental_Competency__c> lstComp = new List<Developmental_Competency__c>();
        for(Integer j=0;j<numActs;j++){
            IDP_Developmental_Line_Item__c act = lstAct[j];
            for (Integer k=numComps*j;k<numComps*(j+1);k++) {
                lstComp.add(new Developmental_Competency__c(Competency_Model__c = 'Test Model'+k,
                                     Competency_Area__c = 'Test Area'+k,
                                     Competency__c = 'Test Competency',
                                     Developmental_Activity__c = act.Id));
            }
        }
        insert lstComp;
        return lstComp;
    }
    
/* The below method is used for creating test SF 182 records with virtual data. 
Argument lstidp is a integer and defines total number of IDP's created.Argument numsf is also a integer that defines how many SF 182's 
to be created for every IDP. As needed, you should be able to populate more SF182 fields The SF182 Requests created here are linked to IDP records created in createTestIDPRecords method */
  
    public Static List<Form_SF_182__c> createsfoneeightytwo(List<IDP__c> lstidp,Integer numsf){
        Integer numidp = lstidp.size();
        List<Form_SF_182__c> lstsf = new List<Form_SF_182__c>();
        for(Integer j=0;j<numidp;j++){
            IDP__c idp = lstidp[j];
            for (Integer k=numsf*j;k<numsf*(j+1);k++) {
                lstsf.add(new Form_SF_182__c(                                             
                                     IDP__c=idp.id));
            }
        }
        insert lstsf;
        return lstsf;
    } 
        
 /* The below method is used for creating test SF 182 Request records with virtual data. 
 Argument lstsf is a integer and defines total number of SF182's created.Argument numsfreq is also a integer that defines how many 
 SF 182 Request's to be created for every SF 182. As needed, you should be able to populate more SF 182 request's fields. 
 The SF182 Requests created here are linked to SF182 records created in createsfoneeightytwo method */
   
    public Static List<SF_182_Training__c> createsfoneeightytworeq(List<Form_SF_182__c> lstsf,Integer numsfreq,String UserProfile){
        
        Profile p = [SELECT Id FROM Profile WHERE Name=:UserProfile];
        User u = [SELECT Id FROM User WHERE isActive = true AND ProfileId =: p.Id LIMIT 1];
        Integer numsf = lstsf.size();
        List<SF_182_Training__c> lstsfreq = new List<SF_182_Training__c>();
        for(Integer j=0;j<numsf;j++){
            Form_SF_182__c sf182 = lstsf[j];
            for (Integer k=numsfreq*j;k<numsfreq*(j+1);k++) {
                lstsfreq.add(new SF_182_Training__c( Supervisor__c = u.Id,                                            
                                     SF_182__c=sf182.id));
            }
        }
        insert lstsfreq;
        return lstsfreq;
    } 
}