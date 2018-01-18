/*
  TestUserCountController.cls
  Class for testing UserCountController 
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Rajakumar              09/04/2012  1.0      Creation
  
*/
@isTest(SeeAllData=true)
public class TestUserCountController {
    static testMethod void myTestUserCountController() {
        UserCountController ucount= new UserCountController();
        ucount.setSfhost();
        ucount.getSfhost();
        System.assert(ucount.getResults().size()>0);
        }
}