@isTest(seealldata=false)
private class TitleVISendLetterControllerTest {
    @TestSetUp
    static void createtestdata(){
        //Create a campaign record
        Campaign camp = new Campaign();
        camp.Name = 'camp name';
        insert camp;
        system.assertNotEquals(null, camp.id);
        
        //Create a contact record
        Contact cont = new Contact();
        cont.LastName = 'Tester';
        cont.FirstName = 'Test';
        insert cont;
        system.assertNotEquals(null, cont.id);
        
        //Create a campaign member record
        CampaignMember member = new CampaignMember();
        member.CampaignId = camp.Id;
        member.ContactId = cont.Id;
        insert member;
        system.assertNotEquals(null, member.id);
    }
    static testMethod void testLetterController()
    {  
        Contact recCon = [select id from contact where LastName = 'Tester' limit 1];
        Campaign recCamp = [select id from Campaign limit 1];
        CampaignMember recCampMem = [select id from CampaignMember limit 1];
        PageReference pageRef = Page.TitleVIFirstLetterTemplate;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('Id', recCamp.Id);
        ApexPages.currentPage().getParameters().put('contacts', recCampMem.Id);
        
        Test.startTest();
        TitleVISendLetterController controller = new TitleVISendLetterController();
        Test.stopTest();
        
        System.assert(controller.contactsToMail[0].contactId == recCon.Id);
    }
}