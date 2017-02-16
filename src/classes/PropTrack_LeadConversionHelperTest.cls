@isTest
private class PropTrack_LeadConversionHelperTest {
	public static Lead testLead;
	public static Opportunity testOppty;
	
	@isTest
    public static void testTransferAttachedDocs_LeadHasAttachments_AttachmentsTransferedToOppty(){
    	List<Lead> leads = [SELECT id 
    						FROM Lead];
    	List<Opportunity> opptys = [SELECT id
    								FROM Opportunity];
    	testLead = leads.get(0);
    	testOppty = opptys.get(0);

        Attachment a = new Attachment(
                Body = Blob.valueof('testBody'),
                Name = 'test Attachment',
                Description = 'test description',
                ParentId = testLead.id
        );
        insert a;

        PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs idList = new PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs();
        List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> idListList = new List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> ();
        idList.leadId = testLead.id;
        idList.opptyId = testOppty.id;
        idListList.add(idList);

        PropTrack_LeadConversionHelper.transferAttachedDocs(idListList);

        List<Attachment> attachmentList =  [
                SELECT Id
                FROM Attachment
                WHERE parentid = :testOppty.id
        ];

        System.assertEquals(attachmentList.size(), 1, 'One attachment should exist for the Opportunity');
    }

    @isTest
    public static void testTransferAttachedDocs_LeadNullConvertedOpp_NoTransfersAndNoErrors(){
    	List<Lead> leads = [SELECT id 
	    						FROM Lead];
    	testLead = leads.get(0);

        PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs idList = new PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs();
        List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> idListList = new List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> ();
        idList.leadId = testLead.id;
        idList.opptyId = null;
        idListList.add(idList);

    	try {
	        PropTrack_LeadConversionHelper.transferAttachedDocs(idListList);
	    } catch (Exception e) {
	    	System.assert(false, 'Null input caused Errors' + e.getMessage());
	    }

        System.assert(true);
    }


    @isTest
    public static void testTransferAttachedDocs_LeadHasContentPosts_ContentPostsCreatedForOppty(){
        List<Lead> leads = [SELECT id 
    						FROM Lead];
    	List<Opportunity> opptys = [SELECT id
    								FROM Opportunity];
    	testLead = leads.get(0);
    	testOppty = opptys.get(0);

        List<ContentDocument> cds = [
                SELECT Id
                FROM ContentDocument
                LIMIT 1
        ];

        ContentDocumentLink newCDL = new ContentDocumentLink(
                ContentDocumentId = cds.get(0).id,
                sharetype = 'V',
                linkedEntityId = testLead.id
        );

        insert newCDL;

        PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs idList = new PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs();
        List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> idListList = new List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> ();
        idList.leadId = testLead.id;
        idList.opptyId = testOppty.id;
        idListList.add(idList);

        PropTrack_LeadConversionHelper.transferAttachedDocs(idListList);

        List<ContentDocumentLink> cdlList = [
                SELECT Id, ContentDocumentId, ShareType, visibility
                FROM ContentDocumentLink
                WHERE linkedEntityId= :testOppty.id
        ];

        System.assertEquals(cdlList.size(), 1, 'One CDL should exist for the created Opportunity');
    }

    @isTest
    public static void testTransferAttachedDocs_LeadHasAttachmentsAndContentPosts_AttachmentsAndContentPostsCreatedForOppty(){
        List<Lead> leads = [SELECT id 
    						FROM Lead];
    	List<Opportunity> opptys = [SELECT id
    								FROM Opportunity];
    	testLead = leads.get(0);
    	testOppty = opptys.get(0);

        List<ContentDocument> cds = [
                SELECT Id
                FROM ContentDocument
        ];

        ContentDocumentLink newCDL1 = new ContentDocumentLink(
                ContentDocumentId = cds.get(0).id,
                sharetype = 'V',
                linkedEntityId = testLead.id
        );
        ContentDocumentLink newCDL2 = new ContentDocumentLink(
                ContentDocumentId = cds.get(1).id,
                sharetype = 'V',
                linkedEntityId = testLead.id
        );
        ContentDocumentLink newCDL3 = new ContentDocumentLink(
                ContentDocumentId = cds.get(2).id,
                sharetype = 'V',
                linkedEntityId = testLead.id
        );
        List<ContentDocumentLink> cdlsToInsert = new List<ContentDocumentLink> {newCDL1, newCDL2, newCDL3};
        insert cdlsToInsert;

        Attachment a1 = new Attachment(
                Body = Blob.valueof('testBody'),
                Name = 'test Attachment',
                Description = 'test description',
                ParentId = testLead.id
        );
        Attachment a2 = new Attachment(
                Body = Blob.valueof('testBody'),
                Name = 'test Attachment',
                Description = 'test description',
                ParentId = testLead.id
        );
        Attachment a3 = new Attachment(
                Body = Blob.valueof('testBody'),
                Name = 'test Attachment',
                Description = 'test description',
                ParentId = testLead.id
        );
        List<Attachment> aList = new List<Attachment> {a1, a2, a3};
        insert aList;

        PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs idList = new PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs();
        List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> idListList = new List<PropTrack_LeadConversionHelper.PropTrack_LeadAndOpportunityIDs> ();
        idList.leadId = testLead.id;
        idList.opptyId = testOppty.id;
        idListList.add(idList);

        PropTrack_LeadConversionHelper.transferAttachedDocs(idListList);

        List<ContentDocumentLink> cdlList = [
                SELECT Id, ContentDocumentId, ShareType, visibility
                FROM ContentDocumentLink
                WHERE linkedEntityId= :testOppty.id
        ];

        List<Attachment> attachmentList =  [
                SELECT Id
                FROM Attachment
                WHERE parentid = :testOppty.id
        ];

        System.assertEquals(cdlList.size(), 3, 'Three CDLs should exist for the created Opportunity');
        System.assertEquals(attachmentList.size(), 3, 'Three Attachments should exist for the created Opportunity');
    }

    @testSetup
    public static void setupTestData() {
    	try{
   	    	id pifRecordType = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('18F Lead').getRecordTypeId();
	    	testLead = new Lead(recordTypeId=pifRecordType, LastName='test', Company='TestCompany');
	    	insert testlead;

	    	testOppty = new Opportunity(Name = 'Test', StageName='New', 
	    		CloseDate=System.date.today());
	    	insert testOppty;

	    	ContentVersion cv1 = new ContentVersion(
                    Title = 'Penguins',
                    PathOnClient = 'Penguins.jpg',
                    VersionData = Blob.valueOf('Test Content'),
                    IsMajorVersion = true
            );
            ContentVersion cv2 = new ContentVersion(
                    Title = 'Giraffes',
                    PathOnClient = 'Giraffes.jpg',
                    VersionData = Blob.valueOf('Test Content'),
                    IsMajorVersion = true
            );
            ContentVersion cv3 = new ContentVersion(
                    Title = 'Dogs',
                    PathOnClient = 'Dogs.jpg',
                    VersionData = Blob.valueOf('Test Content'),
                    IsMajorVersion = true
            );
            List<ContentVersion> cvList = new List<ContentVersion> {cv1, cv2, cv3};
            insert cvList;

    	} catch (Exception e) {
    		System.assert(false, 'Test setup method failed: ' + e.getMessage());
    	}
    }
}