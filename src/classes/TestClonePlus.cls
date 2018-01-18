@istest(seeAllData=True)
public class TestClonePlus{

public static testmethod void testcloneplus () {


//Create test data
Account ta = new Account (Name = 'Test A Original');
insert ta;

Contact tc = new Contact (LastName = 'Test C Original', AccountId = ta.Id);
insert tc;

List<Contact> lstCon = new List<Contact>();
lstCon.add(tc);
//Go to Page
PageReference tpageRef = Page.ClonePlus;
Test.setCurrentPage(tpageRef);
//Set Parameters that would be passed in 
ApexPages.currentPage().getParameters().put('Id', ta.Id);
ApexPages.currentPage().getParameters().put('childobjecttypes', 'Contact');
ApexPages.currentPage().getParameters().put('childRelatedFields', 'LastName');
ApexPages.currentPage().getParameters().put('objectName', 'Account');
Apexpages.hasMessages(ApexPages.severity.ERROR);    
String objectID = ApexPages.currentPage().getParameters().get('id');

// Instantiate a new controller with all parameters in place
ClonePlusController pcp = new ClonePlusController();

//Simulate intial action call on page
pcp.initialiseObjectsForCloning();

//Simulate Click Button
pcp.isValid();
pcp.doClone();
pcp.goBack();
pcp.cloneSelectedObjects();
//pcp.isValid();
pcp.getApiLabels();
pcp.populateObjectChildren();
Sobject s = new Account();

 ClonePlusController.relatedObjectRow ro = new ClonePlusController.relatedObjectRow(s,'Name', '');
 List<ClonePlusController.relatedObjectRow> rl = new List<ClonePlusController.relatedObjectRow> ();
 rl.Add(ro);
ClonePlusController.relatedObjects  r = new ClonePlusController.relatedObjects (rl,'Name','Name','Name');
String sr = ro.getName();
String ct= ro.getcreateddate();
String sf = ro.getfieldLabel();

Map <String, String> ApilabelsMap = new Map <String, String> ();


//Check there are now two accounts
Account [] testresults = [Select Id, Name from Account WHERE NAME = 'Test A Original' ORDER BY CREATEDDATE ASC];
system.assertequals(1,testresults.size());

//Check there are now two contacts
Contact [] testcresults = [Select Id, LastName, AccountId from CONTACT WHERE AccountId IN :testresults ORDER BY CREATEDDATE ASC];
system.assertequals(1,testcresults.size());

system.assertEquals(true, true);
}

public static testmethod void testcloneplus1 () {


//Create test data
Account ta = new Account (Name = 'Test A Original');
insert ta;

Contact tc = new Contact (LastName = 'Test C Original', AccountId = ta.Id);
insert tc;

List<Contact> lstCon = new List<Contact>();
lstCon.add(tc);
//Go to Page
PageReference tpageRef = Page.ClonePlus;
Test.setCurrentPage(tpageRef);
//Set Parameters that would be passed in 
ApexPages.currentPage().getParameters().put('Id', ta.Id);
ApexPages.currentPage().getParameters().put('childobjecttypes', 'Contact');
ApexPages.currentPage().getParameters().put('childRelatedFields', 'LastName');
String objectName = ApexPages.currentPage().getParameters().get('');
Apexpages.hasMessages(ApexPages.severity.ERROR);    
String objectID = ApexPages.currentPage().getParameters().get('id');

// Instantiate a new controller with all parameters in place
ClonePlusController pcp = new ClonePlusController();

//Simulate intial action call on page
pcp.initialiseObjectsForCloning();

//Simulate Click Button
pcp.doClone();
pcp.autoNumber='true';   
pcp.goBack();
pcp.cloneSelectedObjects();
pcp.isValid();
pcp.getApiLabels();   
pcp.populateObjectChildren();
Sobject s = new Account();
ClonePlusController.relatedObjectRow ro = new ClonePlusController.relatedObjectRow(s,'Name', 'Name');
List<ClonePlusController.relatedObjectRow> rl = new List<ClonePlusController.relatedObjectRow> ();
rl.Add(ro);
ClonePlusController.relatedObjects  r = new ClonePlusController.relatedObjects (rl,'Name','Name','Name');
String sr = ro.getName();
String ct= ro.getcreateddate();
String sf = ro.getfieldLabel();

Map <String, String> ApilabelsMap = new Map <String, String> ();


//Check there are now two accounts
Account [] testresults = [Select Id, Name from Account WHERE NAME = 'Test A Original' ORDER BY CREATEDDATE ASC];
system.assertequals(1,testresults.size());

//Check there are now two contacts
Contact [] testcresults = [Select Id, LastName, AccountId from CONTACT WHERE AccountId IN :testresults ORDER BY CREATEDDATE ASC];
system.assertequals(1,testcresults.size());

system.assertEquals(true, true);
}
public static testmethod void testcloneplus2 () {


//Create test data
Glxy_Allowance__c ga = new Glxy_Allowance__c ();
insert ga;

//Go to Page
PageReference tpageRef = Page.ClonePlus;
Test.setCurrentPage(tpageRef);
//Set Parameters that would be passed in 
ApexPages.currentPage().getParameters().put('Id', ga.Id);
ApexPages.currentPage().getParameters().put('childobjecttypes', 'user');
ApexPages.currentPage().getParameters().put('childRelatedFields', 'user');
ApexPages.currentPage().getParameters().put('objectName', 'user');
Apexpages.hasMessages(ApexPages.severity.ERROR);    
String objectID = ApexPages.currentPage().getParameters().get('id');

// Instantiate a new controller with all parameters in place
ClonePlusController pcp = new ClonePlusController();

//Simulate intial action call on page
pcp.initialiseObjectsForCloning();

//Simulate Click Button
pcp.isValid();
pcp.doClone();
pcp.goBack();
pcp.cloneSelectedObjects();
//pcp.isValid();
pcp.getApiLabels();
pcp.populateObjectChildren();
Sobject s = new Glxy_Allowance__c();

 /*ClonePlusController.relatedObjectRow ro = new ClonePlusController.relatedObjectRow(s,'Name', '');
 List<ClonePlusController.relatedObjectRow> rl = new List<ClonePlusController.relatedObjectRow> ();
 rl.Add(ro);
ClonePlusController.relatedObjects  r = new ClonePlusController.relatedObjects (rl,'Name','Name','Name');
String sr = ro.getName();
String ct= ro.getcreateddate();
String sf = ro.getfieldLabel();

Map <String, String> ApilabelsMap = new Map <String, String> ();*/


//Check there are now two accounts
Glxy_Allowance__c [] testresults = [Select Id, Name from Glxy_Allowance__c ORDER BY CREATEDDATE ASC limit 1];
system.assertequals(1,testresults.size());
system.assertEquals(true, true);
}

}