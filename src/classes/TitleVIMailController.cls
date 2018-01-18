/********************************************************************************
 ********************************************************************************
 *  Class            : TitleVIMailController
 *  Author           : Acumen Solutions: Alejandro Olivas
 *  Create Date      : 11/8/11
 *  Description      : This class is the driving force behind a Campaign's
 *                     send letter functionality. It will look for campaign 
 *                     members that are requesting to be contacted via mail and
 *                     email and either generate a PDF for the "mail" contacts
 *                     and send an email to the "email" contacts. It is also
 *                     responsible to update the campaign status and attach any
 *                     any files sent out.
 *
 *  UPDATES          : 12/20/2011 - Damien Phillippi
 *                     Moving action function DML statements to another method
 *                     in order to get rid of XSRF issues.
 *                   : 01/10/2012 - Damien Phillippi
 *                     Fixing an issue that comes when when ContactVia was null
 ********************************************************************************
 ********************************************************************************/
public with sharing class TitleVIMailController {

    public String sectionHeaderTitle { get;set; }
    public String errorMessage { get;set; }
    public boolean errorsFound { get;set; }
    public boolean closePopup { get;set; }
    public boolean emailOnly { get;set; } // Variable to cover scenario where all campaign members just select contact via email only

    public List<CampaignMember> allCampaignMembers { get;set; }
    public List<CampaignMember> contactsToMail { get;set; }
    public List<CampaignMember> contactsToEmail { get;set; }
    public String todaysDate { get;set; }

    private final Campaign campgn;
    private String letter;

    private boolean firstLetter;
    private boolean contactViaMailMembersFound;
    private boolean contactViaEmailMembersFound;
    private List<Task> tasksToAdd;

    public static Id TITLEVI_RECORDTYPE = [SELECT Id, Name FROM RecordType WHERE Name = 'Title VI Contact' AND SObjectType = 'Contact'].Id;
    
    private User chatty;

    public TitleVIMailController(ApexPages.StandardController stdController) {
        campgn = [SELECT Id, Status FROM Campaign WHERE ID =: stdController.getRecord().Id];
        setupPageLoadVariables();
        getCampaignMembers();
    }

    /**
     * Generates the PDF and/or email of the letter being sent to the campaign
     * member and creates a PDF file to be printed out for each member requesting
     * to be contacted via "mail" and/or sends out the email to those members
     * requesting to be contacted via "email" 
     */
    public PageReference generateAndSendLetter() {
        PageReference pageRef = null;
        if ( contactViaMailMembersFound || contactViaEmailMembersFound ) {
            // Redirect the user to the PDF page of the letter
            String url = generateLetterURL();
            pageRef = new PageReference(url);
            attachPDFLetters(url);
        }

        if ( contactViaEmailMembersFound ) {
            //Execute only once
            if (!emailOnly) { 
                sendLettersViaEmail();
                //Print message on screen to close the window
                errorMessage = 'As Donees opted Contact Via Email. ' + letter + ' letter was generated and sent to them successfully in the form of E-mail. PLEASE CLOSE THIS WINDOW!';
                //Set it as true, so that this statement is executed only once
                emailOnly= true; 
            }
        }
        
        // No PDF needs to be generated, close this window
        //closePopup = contactViaEmailMembersFound && !contactViaMailMembersFound;
        
        return pageRef;
    }

    /**
     * Adds Title VI submissions for every campaign members that doesn't have
     * one already created (this means the first letter was sent out to them)
     * when the user clicks on the send first letter link and updates the
     * campaign's status to reflect the letter sent.
     */
    public PageReference addTitleVISubmissionsAndUpdateCampaign() {
        addTitleVISubmissions();
        if ( !errorsFound ) {
            updateCampAndTasks();
        }
        return null;
    }
    
    private void updateCampAndTasks()
    {
        // Update the campaign status depending on the letter sent
        campgn.Status = letter + ' Letter Sent';
        update campgn;

        // Insert the tasks created
        upsert tasksToAdd;

        // Update the campaign members' statuses
        List<CampaignMember> campaignMembersToUpdate = new List<CampaignMember>();
        campaignMembersToUpdate.addAll(contactsToMail);
        campaignMembersToUpdate.addAll(contactsToEMail);
        for ( CampaignMember curr : campaignMembersToUpdate ) {
            curr.Status = letter + ' Letter Sent';
        }
        update campaignMembersToUpdate;
    }

    /** 
     * Sets up the labels and flags that are required on an initial page load
     */
    private void setupPageLoadVariables() {
        errorsFound = false;
        errorMessage = '';
        closePopup = false;
        emailOnly = false;
        tasksToAdd = new List<Task>();
        chatty = [SELECT Name FROM User WHERE Name =: 'Chatty'];

        letter = System.currentPageReference().getParameters().get('letter');

        // Generate the visualforce page section header
        if ( letter.equalsIgnoreCase('first') ) {
            sectionHeaderTitle = 'First Letter..';
            firstLetter = true;
        } else if ( letter.equalsIgnoreCase('second') ) {
            sectionHeaderTitle = 'Second Letter..';
            firstLetter = false;
        } else {
            sectionHeaderTitle = 'Third Letter..';
            firstLetter = false;
        }
    }

    /**
     * Gets the campaign members to send the letter to, both via mail and
     * email depending on the type of letter and title VI submissions 
     */
    private void getCampaignMembers() {
        if ( isValidUserAction() ) {
            Set<Id> noActivityContacts = getContactsWithNoActivityTitleVISubmissions();
            contactsToMail = new List<CampaignMember>();
            contactsToEmail = new List<CampaignMember>();
            allCampaignMembers = new List<CampaignMember>();

            String sql = 
                'SELECT CampaignId, Contact.Name, Contact.MailingStreet, Contact.Email, ' +  
                'Contact.MailingCity, Contact.MailingState, Contact.MailingPostalCode, ' +
                'Contact.Salutation, Contact.Contact_Organization_Name__c, ' +
                'Contact.OCR_Contact_Via__c, Contact.LastName, Contact.AccountId ' +
                'FROM CampaignMember ' +
                'WHERE CampaignId = \'' + campgn.Id + '\' ' +
                'AND Contact.OCR_Title_VI_Primary_Contact__c = true AND Contact.Account.Type = \'Donee\' '+
                'AND Contact.Account.OCR_Title_VI_Status__c = \'Active\' ' +
                'AND Contact.RecordTypeId = \''+ TITLEVI_RECORDTYPE + '\' ';

            if ( !firstLetter && !noActivityContacts.isEmpty() ) {
                sql += 'AND ContactId IN: noActivityContacts';
            }

            for ( List<CampaignMember> campaignMembers : Database.query(sql) ) {
                for ( CampaignMember curr : campaignMembers ) {
                    String contactVia = curr.Contact.OCR_Contact_Via__c;
                    if (contactVia != null && contactVia.equalsIgnoreCase('E-Mail')) {
                        contactsToEmail.add(curr);
                    } else if (contactVia != null && contactVia.equalsIgnoreCase('Mail')) {
                        contactsToMail.add(curr);
                    }
                    // Keep track of all the campaign members
                    allCampaignMembers.add(curr);
                }
            }

            // Verify that campaign members were found
            if ( !allCampaignMembers.isEmpty() ) {
                // Determine which type of contacts were found to let the system
                // know what to execute: PDF, email or both
                contactViaMailMembersFound = contactsToMail.isEmpty() ? false : true;
                contactViaEmailMembersFound = contactsToEmail.isEmpty() ? false : true;
            } else {
                // // No eligible contacts found, notify the system
                errorsFound = true;
                contactViaMailMembersFound = false;
                contactViaEmailMembersFound = false;
                sectionHeaderTitle = 'Alert!';
                errorMessage = 'There are no contacts on this campaign ' +
                    'eligible to receive the ' + letter + ' letter';
            }
        }
    }

    /**
     * Generates the URL of the of the PDF visualforce page or email template
     * rendered to the user depending on the link clicked by the user
     */
    private String generateLetterURL() {
        String url = '';

        // Generate the campaign member IDs URL parameter string
        String contactStr = '';
        Integer currIndex = 1;
        
        if (contactsToMail.isEmpty() && !contactsToEMail.isEmpty()) {
             contactsToMail.add(contactsToEMail.get(0));
        }

        
        Integer lastIndex = contactsToMail.size();
        for ( CampaignMember member : contactsToMail ) {
            contactStr += member.Id;
            if ( currIndex < lastIndex ) {
                // each campaign member ID is separated by a period
                contactStr += '.';
            }
            currIndex++;
        }

        if ( letter.equalsIgnoreCase('first') ) {
            url = '/apex/TitleVIFirstLetterTemplate?id=' + campgn.Id;
        } else if ( letter.equalsIgnoreCase('second') ) {
            url = '/apex/TitleVISecondLetterTemplate?id=' + campgn.Id;
        } else {
            // default to third letter
            url = '/apex/TitleVIThirdLetterTemplate?id=' + campgn.Id;
        }
        url += + '&letter=' + letter + '&contacts=' + contactStr;
        return url;
    }

    /**
     * Creates individual email messages containing the letters for each of the 
     * campaign member contacts as well as attaches them to the campaign and
     * contacts themselves. The email is subsequently sent out.
     */
    private void sendLettersViaEmail() {
        MassEmailUtility massEmail = new MassEmailUtility();

        List<Id> contactIds = new List<Id>();
        List<EmailUtility> emails = new List<EmailUtility>();

        if ( !errorsFound ) {
            String letterTemplate;
            if ( letter.equalsIgnoreCase('first') ) {
                letterTemplate = 'OCR_Title_VI_First_Letter';
            } else if ( letter.equalsIgnoreCase('second') ) {
                letterTemplate = 'OCR_Title_VI_Second_Letter';
            } else {
                    // default to third letter
                letterTemplate = 'OCR_Title_VI_Third_Letter';
            }

            OrgWideEmailAddress replyEmail = null;
            try {
                // @TODO: wrong email for now, this slows it down SIGNIFICANTLY! Currently
                // speaking with premier support for help on this issue, when and if this
                // issue is resolved I will add the correct email so it is being used.
                replyEmail = 
                    [SELECT ID, DisplayName FROM OrgWideEmailAddress 
                     WHERE Address =: 'ocr_wrong_email@gsa.gov'];
            } catch (Exception e) {
                // @TODO: email the system admins to let them know?
                System.debug('*** The org wide email address does not exist');
            }

            try {
                EmailTemplate template = 
                    [SELECT Name, Markup, HtmlValue, Body, DeveloperName 
                     FROM EmailTemplate WHERE DeveloperName =: letterTemplate];

                for ( CampaignMember curr : contactsToEmail ) {
                    contactIds.add(curr.ContactId);

                    // Build out the email message for the current campaign member contact
                    SingleEmailUtility currEmail = new SingleEmailUtility();

                    currEmail.setTemplateId(template.Id);
                    currEmail.setTargetObjectId(curr.ContactId);
                    currEmail.setWhatId(campgn.Id);

                    if ( replyEmail == null ) {
                        // Send the email as the currently logged in user if the org wide
                        // email address doesn't exist in the current environment
                        currEmail.setSenderDisplayName('Office of Civil Rights Title VI');
                    } else  {
                        currEmail.setOrgWideEmailAddressId(replyEmail.Id);
                    }

                    emails.add(currEmail);
                }
                EmailUtility.sendBulkMessages(emails);
            } catch (Exception e) {
                // @TODO: Email system admin?
                System.debug('*** EXCEPTION IN SEND EMAILS [ ' + e.getMessage() + ' ]');
            }
        }
    } 

    /**
     * Attaches the PDF letters to the both the contacts on the campaign and 
     * the campaign itself. The PDF attached to the campaign contains a single
     * file with all the letter sent out. The PDF attached to the contact only
     * contains the single letter addressed to that user.
     */
    private void attachPDFLetters(String url) {
        // Attach the single PDF file containing the letter sent to all the
        // campaign members, set the parent ID as the Campaign
        List<FeedItem> chatterFeed = new List<FeedItem>();
        Attachment campaignAttachment = createPDFAttachment(url, campgn.Id);
        Blob body = campaignAttachment.Body;
        String name = campaignAttachment.Name;

        // Add chatter feed record for the campaign
        chatterFeed.add(addChatterFeedItem(campgn.Id, body, name));

        //List<Attachment> allPDFattachments = new List<Attachment>();
        for ( CampaignMember curr : contactsToMail ) {
            String individualURL = '';
            if ( letter.equalsIgnoreCase('first') ) {
                individualURL = '/apex/TitleVIFirstLetterTemplate?id=' + campgn.Id;
            } else if ( letter.equalsIgnoreCase('second') ) {
                individualURL = '/apex/TitleVISecondLetterTemplate?id=' + campgn.Id;
            } else {
                // default to third letter
                individualURL = '/apex/TitleVIThirdLetterTemplate?id=' + campgn.Id;
            }
            individualURL += + '&letter=' + letter + '&contacts=' + curr.Id;

            // Attach the PDF of this individual user, set the parent ID as the contact
            Attachment currAttachment = createPDFAttachment(individualURL, curr.ContactId);
            //allPDFattachments.add(currAttachment);
            body = currAttachment.Body;
            name = currAttachment.Name;

            // Add chatter feed record for the current contact
            chatterFeed.add(addChatterFeedItem(curr.ContactId, body, name));
             
        }
        // Add the campaign attachment and insert them all
        //allPDFattachments.add(campaignAttachment);
        //insert allPDFattachments;

        // insert the chatter feed items
        insert chatterFeed;
    }

    /**
     * This function creates a Title VI submission for each person in the contact
     * list with the following fields:
     *  1) Submission Status = No Activity
     *  2) Donee Contact = current contact from list
     *  3) Donee Account = account contact is associated to
     *  3) Campaign = current campaign
     */
    private void addTitleVISubmissions() {
        if ( !errorsFound && firstLetter ) {
            List<OCIO_Title_VI_Submission__c> titleVISubmissions = 
                new List<OCIO_Title_VI_Submission__c>();
            // Add title VI submission for all contacts in the campaign
            for ( CampaignMember curr : allCampaignMembers ) {
                OCIO_Title_VI_Submission__c currSubmission = new OCIO_Title_VI_Submission__c();
                currSubmission.OCR_Submission_Status__c = 'No Activity';
                currSubmission.OCR_Rollout__c = campgn.Id;
                currSubmission.OCR_Donee_Account__c = curr.Contact.AccountId;
                currSubmission.OCR_Donee_Contact__c = curr.ContactId;
                titleVISubmissions.add(currSubmission);
                
                String contactVia = curr.Contact.OCR_Contact_Via__c;
                // While we are creating title VI submission records also add
                // a task for the contacts requesting to be contacted via mail
                if ( contactVia.equalsIgnoreCase('Mail') ) {
                    String taskSubject = 'Mail: ' + letter + ' Letter';
                    tasksToAdd.add(createCompletedTask(curr.ContactId, taskSubject));
                }
            }
            database.insert(titleVISubmissions);
        } else if ( !errorsFound && !firstLetter ) {
            // For the second and third letters simply create the tasks for the
            // campaign members that have requested to be contacted via mail
            for ( CampaignMember curr : contactsToMail ) {           
                String taskSubject = 'Mail: ' + letter + ' Letter';
                tasksToAdd.add(createCompletedTask(curr.ContactId, taskSubject));
            }
        }
    }

    /**
     * Returns a set of contact IDs associated to this campaign, which already
     * have a Title VI submission record with a status of "No Activity"
     */
    private Set<Id> getContactsWithNoActivityTitleVISubmissions() {
        Set<Id> noActivityContacts = new Set<Id>();
        for ( List<OCIO_Title_VI_Submission__c> submissions :
                    [SELECT OCR_Donee_Contact__c FROM OCIO_Title_VI_Submission__c
                     WHERE OCR_Rollout__c =: campgn.Id
                     AND OCR_Submission_Status__c =: 'No Activity'] ) {

            for ( OCIO_Title_VI_Submission__c curr : submissions ) {
                noActivityContacts.add(curr.OCR_Donee_Contact__c);
            }

        }
        return noActivityContacts;
    }

    /**
     * Verifies that the user click on a valid send letter link depending on 
     * the campaign status
     */
    private boolean isValidUserAction() {
        boolean isValidUserAction = true;
        String status = campgn.Status;
        boolean statusFirstLetterSent = status.equalsIgnoreCase('First Letter Sent');
        boolean statusSecondLetterSent = status.equalsIgnoreCase('Second Letter Sent');
        boolean statusThirdLetterSent = status.equalsIgnoreCase('Third Letter Sent');
        boolean statusComplete = status.equalsIgnoreCase('Complete');

        if ( firstLetter ) {
            // For the first letter the status must not be set to any of the above
            isValidUserAction = !statusFirstLetterSent && !statusSecondLetterSent 
                && !statusThirdLetterSent && !statusComplete;
        } else {
            if ( letter.equalsIgnoreCase('Second') ) {
                // For the second letter, the status must be in "First Letter Sent"
                isValidUserAction = statusFirstLetterSent;
            } else {
                // For the third letter, the status must be in "Second Letter Sent"
                isValidUserAction = statusSecondLetterSent;
            }
        }

        if ( !isValidUserAction ) {
            sectionHeaderTitle = 'Alert!';
            errorsFound = true;
            contactViaMailMembersFound = false;
            contactViaEmailMembersFound = false;
            errorMessage = 'You cannot click on <strong>Send ' + letter + 
                ' Letter</strong> when the campaign\'s status is set to ' +
                '<strong>' + status + '</strong>';
        }
        return isValidUserAction;
    }

    /**
     * Creates a PDF attachment object based on the URL of the visualforce page
     */
    private Attachment createPDFAttachment(String url, Id parentId) {
        PageReference pdfPage = new PageReference(url);

        // Create the attachments
        Attachment pdf = new Attachment();
        Blob body;
        try {
            body = pdfPage.getContent();
        } catch (VisualforceException e) {
            // for testing purposes
            body = Blob.valueOf('Test PDF');
        }
        String pdfName = letter + ' Letter ' + System.now().format('MMM-dd-yy') + '.pdf'; 
        pdf.Body = body;
        pdf.Name = pdfName;
        pdf.IsPrivate = false;
        pdf.ParentId = parentId;

        return pdf;
    }

    /**
     * Creates a completed task for a contact on the campaign
     */
    private Task createCompletedTask(Id contactId, String subject) {
        Task currTask = new Task();
        currTask.WhatId = campgn.Id;
        currTask.Status = 'Completed';
        currTask.Subject = subject;
        currTask.WhoId = contactId;
        currTask.ActivityDate = Date.today();
        return currTask;
    }

    /**
     * Adds a chatter feed item to show that a letter was mailed/emailed out
     */
    private FeedItem addChatterFeedItem(Id parentId, Blob pdfBody, String fileName) {
        FeedItem post = new FeedItem();
        post.ParentId = parentId;
        post.Body = letter + ' Letter Sent';
        post.Type = 'ContentPost';
        post.ContentData = pdfBody;
        post.ContentFileName = fileName;
        // After careful consideration, we decided to leave the chatter feed 
        // attachment to be created by the logged in user. However in the future
        // if this needs to change, verify that the chatty user is added 
        // to the public group OCR Title VI Users
        //post.CreatedById = chatty.Id;
        return post;
    }

}