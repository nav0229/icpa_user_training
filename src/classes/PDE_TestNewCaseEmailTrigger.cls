@isTest(seeAllData=true)
private class PDE_TestNewCaseEmailTrigger  {

    
    public static Case newCse;
    
   
    static void init(){
    
    newCse = new Case();

    newCse.Status = 'New';
    newCse.PDE_Attachments_To_Load_Counter__c  = 0;
    newCse.RecordTypeID = [select ID from RecordType where Name = 'Pegasys Data Entry' and sObjectType = 'Case'].ID;

    }

    /** Test with an existing contact **/
    static testMethod void testNewCase() {
    init();
    Test.startTest();
    insert newCse;    
        
    Case cse = [select Id, PDE_Attachments_To_Load_Counter__c from Case where Id = :newCse.id];
    cse.PDE_Attachments_To_Load_Counter__c  = 1;
    update cse;
        
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment'; 
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body'); 
    attach.body=bodyBlob; attach.parentId=newCse.Id;
    insert attach;
        
        Id userId = [SELECT Id FROM User WHERE IsActive = true AND Profile.Name  in ('System Administrator', 'GSA System Administrator') LIMIT 1].id;
  
   
        Id caseTeamRoleId= [SELECT Id FROM CaseTeamRole WHERE Name = 'PDE CC Recipient' LIMIT 1].id;
        List<CaseTeamMember> catmList=new List<CaseTeamMember>();
        
        CaseTeamMember tm=new CaseTeamMember();
        tm.ParentId=newCse.Id;
        tm.MemberId=userId;
        tm.TeamRoleId =caseTeamRoleId;
        catmList.add(tm);
        
        upsert catmList;
        
        
    Case cse2 = [select Id, PDE_Attachments_To_Load_Counter__c  from Case where Id = :newCse.id];
    System.assert(cse2 != null);
        
    cse2.PDE_Attachments_To_Load_Counter__c  = 0;
    update cse2;
    Test.stopTest();
    }
   

}