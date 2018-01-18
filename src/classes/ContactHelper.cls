/*-------------------------------------------------------------------------------------------------*
  Apex class
  Helper class for ContactTriggers apex trigger - Contact Manager VOE Surveys
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/17/2015    1.0       Initial version.
  Rajakumar          09/30/2015    1.1       case# 21022 - avoid multiple triggers of hiring manager surveys
  GaneshKumar Mandava    08/24/2017           Removed code that uses SurveyURL__c field on Email Tracker Object
 *-------------------------------------------------------------------------------------------------*
 *-------------------------------------------------------------------------------------------------*/
 public class ContactHelper {
     // after updating the contact record
     /*
     This is to create the EmailTracker__c record for respective Supervisor__c (send the email for hiring manager feedback)
     when the contact NewHireEmailTextStatuses__c is changed to 'NH_30 Day Sent'
     */
     public static void onAfterUpdate(List<Contact> triggerNew, Map<Id, Contact> triggerOldMap) {
         // declarations
         Set<Id> contactIds = new Set<Id>();
         Map<Id, Id> contactToSupervisorMap = new Map<Id,Id>();
         List<EmailTracker__c> newets = new List<EmailTracker__c>();
         String surveyBaseURLof30DayNH = null;
         // processing the contacts which are come under the survey i.e.NH 30 Day Sent
         for(Contact c: triggerNew) {
             String newhireStatusText = (c.NewHireEmailTextStatuses__c != null) ? c.NewHireEmailTextStatuses__c: null;
             // added validation for case# 21022 - BEGIN
             Boolean old30DaySentFlag = false;
             if(triggerOldMap.get(c.Id).NewHireEmailTextStatuses__c != null &&
                 triggerOldMap.get(c.Id).NewHireEmailTextStatuses__c.contains('NH_30 Day Sent') )
                 old30DaySentFlag = true;
             // added validation for case# 21022 - END
             if(c.NewHireEmailTextStatuses__c != null &&
                 newhireStatusText.containsIgnoreCase('NH_30 Day Sent') && c.Supervisor__c != null &&
                 (c.NewHireEmailTextStatuses__c != triggerOldMap.get(c.Id).NewHireEmailTextStatuses__c) &&
                 // added below line oldmapflag validation for case# 21022
                 old30DaySentFlag == false) {

                 System.debug('statustext: '+c.NewHireEmailTextStatuses__c);
                 contactIds.add(c.Id);
                
                 system.debug('hired employee name: ' + c.Name);
                 system.debug('hired first name: ' + c.FirstName);
                 system.debug('hired last name name: ' + c.LastName);
                 newets.add(new EmailTracker__c(Status__c='Sent',
                                             Type__c= 'VOE - Hiring Manager Survey',
                                             ToContact__c= c.Supervisor__c,
                                             Hired_Employee__c = c.FirstName + ' ' + c.LastName,
                                             Hired_Employee_ID__c = c.id,
                                             SendDate__c= Date.today()));
             }
         }

         // insert the new emailtracker records
         if(!contactIds.isEmpty()) {
             try {
                 insert newets;
             }
             catch(DMLException e) {
                 System.debug(LoggingLevel.INFO,'Error while inserting the OHRM VOE Hiring Manager Survey EmailTracker records :' +e.getMessage());
             }
         }
     }

    /**
     * Begin Acumen Solutions APEX development
     *
     * Trigger logic supporting the New Supervisor Survey functionality.
     *  Manage Email Tracker records to Queue and Send Email Alerts
     *  via Time-Based Workflow.
     *
     * @author Justin Lyon
     * @created 09.24.2015
     */

    private static final String EMTRACKER_QUEUED = 'Queued';
    private static final String NEW_SUPERVISOR_SURVEY = 'VOE - New Supervisor Survey';

    // After Update/Insert, When Contact.SupervisorStatus changes/is to 2, initiate the New Supervisor Survey process
    public static void catchNewSupervisors(List<Contact> newContacts, Map<Id, Contact> oldContactMap) {
        List<EmailTracker__c> emTrackers = new List<EmailTracker__c>();

        if(oldContactMap != null) { // After Update
            for(Contact c : newContacts) {
                Contact oldContact = oldContactMap.get(c.Id);
                if(isNewSupervisor(c) && c.Supervisory_Status__c != oldContact.Supervisory_Status__c) {
                    emTrackers.add(buildEmailTracker(c,EMTRACKER_QUEUED,NEW_SUPERVISOR_SURVEY));
                }
            }

        } else { // After Insert
            for(Contact c : newContacts) {
                if(isNewSupervisor(c)) {
                    emTrackers.add(buildEmailTracker(c,EMTRACKER_QUEUED,NEW_SUPERVISOR_SURVEY));
                }
            }
        }

        try {
            insert emTrackers;
        }
        catch(DMLException e) {
            System.debug(
                LoggingLevel.INFO,
                'Error while inserting the OHRM VOE New Supervisory Survey EmailTracker records :'
                + e.getMessage());
        }
    }

    private static Boolean isNewSupervisor(Contact newC) {
        return newC.Supervisory_Status__c == 2
            && newC.Email != null;
    }

    private static EmailTracker__c buildEmailTracker(Contact c, String status, String type) {
        return new EmailTracker__c(
            Status__c = status,
            Type__c = type,
            ToContact__c = c.Id,
            SendDate__c = Date.today().addDays(30));
    }
 }