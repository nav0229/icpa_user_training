/********************************************************************************
 ********************************************************************************
 *  Class            : TitleVISendLetterController
 *  Author           : Acumen Solutions: Alejandro Olivas
 *  Create Date      : 11/16/11
 *  Description      : This class is responsible for generating the content of
 *                     of the title VI campaign letter for the total number of 
 *                     contacts passed in via the URL
 ********************************************************************************
 ********************************************************************************/
public with sharing class TitleVISendLetterController {

    public List<CampaignMember> contactsToMail { get;set; }
    public String todaysDate { get;set; }
    public String letter { get;set; }
    private final Campaign campgn { get;set; }

    public TitleVISendLetterController() {
        // @TODO: put in a check to verify that this ID is from a Campaign object
        String campaignId = System.currentPageReference().getParameters().get('id');
        campgn = [SELECT Id FROM Campaign WHERE Id =: campaignId];

        contactsToMail = new List<CampaignMember>();

        Datetime now = System.now();
        todaysDate = now.format('MMMM d, yyyy');

        String contacts = System.currentPageReference().getParameters().get('contacts');
        parseContactList(contacts);
    }

    /**
     * Parses the "contacts" url parameter as it contains the contact ID's of the 
     * contacts that we are going to be generating PDFs for
     */
    private void parseContactList(String contacts) {
        // parse the contacts with the string tokenizer
        List<String> contactList = contacts.split('\\.');
        Set<ID> contactIds = new Set<ID>();
        for ( String contact : contactList ) {
            contactIds.add(contact);
        }
        contactsToMail = [SELECT CampaignId, Contact.Name, Contact.MailingStreet, 
                           Contact.MailingCity, Contact.MailingState, Contact.MailingPostalCode,
                           Contact.Salutation, Contact.Contact_Organization_Name__c,
                           Contact.OCR_Contact_Via__c, Contact.LastName, Contact.AccountId, Contact.Account.Name,
                           Contact.Account.BillingStreet, Contact.Account.BillingCity, Contact.Account.BillingState, 
                           Contact.Account.BillingPostalCode
                           FROM CampaignMember 
                           WHERE CampaignId =: campgn.Id
                           AND Id IN: contactIds];
    }
}