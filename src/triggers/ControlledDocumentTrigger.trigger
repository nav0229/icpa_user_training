/*-------------------------------------------------------------------------------------------------*
  Controlled Document Trigger.
  Trigger on Approval Step to do the following:
   - Date Overdue Calculation if applicable
   - Date Difference Calculation
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Sathish Durairaj   10/22/2014    1.0       Created
  Stefan Maurer      11/14/2014    2.0       Added ChatterFileCollaborator call/ApprovalStep Delete
  Christian Coleman  5/11/2015     3.0       Added LocationAndStageHistoryHelper and updated setDayFields
  Rajakumar P        9/15/2015     4.0       Case# 19424- ExecSec OverDue field calculation issue
  Rajakumar P        08/31/2016    5.0       Case#27460 - Validation to limit the ability to choose controls for the Administrator's signature.
  Rajakumar P        02/06/2017    6.0       Case# 30805 - fix the production issue
  Rajakumar P        02/16/2017    7.0       Case# 30880 - custom settings to store the agency admin name
 *-------------------------------------------------------------------------------------------------*/

trigger ControlledDocumentTrigger on Controlled_Document__c (before insert, before update, after insert, after update) {
    // * BEGIN - COMMENTED FOR 4.0
    //public Double daysOpen;
    //public Double daysOverdue;
    //public Double daysExecSecOverdue;
    // * END - COMMENTED FOR 4.0
    public BusinessHours cdtBusinessHours = [SELECT Id 
                                                FROM BusinessHours 
                                                WHERE Name = 'CDT Business Hours'];
    
    // BEFORE
    if(Trigger.isBefore) {
        // BEFORE INSERT
        if (trigger.isInsert){ 
            // v5.0 - BEGIN
            String agencyAdmin = fetchAgencyAdmin();
            if(agencyAdmin != null)
            	doValidate(trigger.new, null, agencyAdmin);
            // v5.0 - END             
            setDayFields(trigger.new);
            
            LocationAndStageHistoryHelper.insertStartDatesAndSetCurrentLocation(trigger.new);
        }
        // BEFORE UPDATE
        else if(trigger.isUpdate){
            // v5.0 - BEGIN
            String agencyAdmin = fetchAgencyAdmin();
            if(agencyAdmin != null)            
            	doValidate(trigger.new, trigger.oldMap, agencyAdmin);
            // v5.0 - END
            setDayFields(trigger.new);
            
            // recursion happens after a workflow updates the Controlled_Document__c's End Date after being closed
            LocationAndStageHistoryHelper.checkAndUpdateHistory(trigger.newMap, trigger.oldMap);
            
        }
        // BEFORE DELETE
        else if(trigger.isDelete){
            //Cascade delete does not fire triggers for child objects. The following line fires
            //the approval step triggers in order to ensure that the Control Doc and ChatterFeed
            //sharing entities stay in sync.
            //delete [SELECT id FROM Approval_Step__c WHERE Correspondence_Document__c IN: trigger.old];
        }
    }
    // AFTER
    
    else{
        // AFTER INSERT
        if(trigger.isInsert){
            LocationAndStageHistoryHelper.insertLocationHistoryForNewCDocs(trigger.new);
        }
        // AFTER UPDATE
        if(trigger.isUpdate){
            ChatterFileCollaboratorTH.updateCollaborators(trigger.oldMap, trigger.new);
        }
    }

    private static void setDayFields(List<Controlled_Document__c> controlledDocumentList){
        Datetime current = System.now();
        Date currDate = current.date();
        Time currTime = Time.newInstance(0, 0, 0, 0);
        Datetime currentLocal = Datetime.newInstance(currDate, currTime);

        for (Controlled_Document__c controlledDocument : controlledDocumentList) {
            // BEGIN -version 4.0 Added the fields to each record level to reflect the correct calculations
            Double daysOpen = null;
            Double daysOverdue = null;
            Double daysExecSecOverdue = null;  
            // END -version 4.0 Added the fields to each record level to reflect the correct calculations
            if(controlledDocument.ExecSec_Start_Date__c == null) controlledDocument.Days_Open__c = null;
            if(controlledDocument.ExecSec_Due_Date__c == null) controlledDocument.ExecSec_Days_Overdue__c = null;
            //Days open calculation if applicable
            if ((controlledDocument.ExecSec_Start_Date__c != NULL)) {                   
                if ((controlledDocument.ExecSec_End_Date__c != null)) {  
                    daysOpen = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.ExecSec_Start_Date__c, controlledDocument.ExecSec_End_Date__c);       
                } 
                else {
                   daysOpen = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.ExecSec_Start_Date__c, currentLocal);
                }
                controlledDocument.days_open__c =  daysOpen;
            }
            //Days Overdue calculation if applicable
            if ((controlledDocument.Stage__c != 'Closed') && (controlledDocument.Due_Date__c != null)) {                    
                if ((currentLocal > controlledDocument.Due_Date__c)) {
                    daysOverdue = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.Due_Date__c, currentLocal);             
                } 
                else {                     
                   //do Nothing
                }
                controlledDocument.Days_Overdue__c =  daysOverdue;
            } else if ((controlledDocument.Stage__c == 'Closed') && (controlledDocument.Due_Date__c != null) && (controlledDocument.ExecSec_End_Date__c != null)) {     
                if ((controlledDocument.Due_Date__c < controlledDocument.ExecSec_End_Date__c)) {
                    daysOverdue = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.Due_Date__c, controlledDocument.ExecSec_End_Date__c);        
                } 
                else {                     
                   //do Nothing
                }
                //daysOverdue = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.Date_Closed__c, controlledDocument.Due_Date__c);
                controlledDocument.Days_Overdue__c =  daysOverdue;
            }
            //ExecSec Days Overdue calculation if applicable
            //ExecSec_Days_Overdue__c ExecSec_Due_Date__c ExecSec_End_Date__c
            if ((controlledDocument.ExecSec_Due_Date__c != null) && (controlledDocument.ExecSec_End_Date__c != null)) {                                     
                if ((controlledDocument.ExecSec_End_Date__c > controlledDocument.ExecSec_Due_Date__c)) {        
                    daysExecSecOverdue = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.ExecSec_Due_Date__c, controlledDocument.ExecSec_End_Date__c);          
                }                   
                controlledDocument.ExecSec_Days_Overdue__c =  daysExecSecOverdue;
            } else  if ((controlledDocument.ExecSec_Due_Date__c != null) && (controlledDocument.ExecSec_End_Date__c == null)) {                                     
                if ((currentLocal > controlledDocument.ExecSec_Due_Date__c)) {
                    daysExecSecOverdue = getBsnsHoursDifference(cdtBusinessHours, controlledDocument.ExecSec_Due_Date__c, currentLocal);             
                }                   
                controlledDocument.ExecSec_Days_Overdue__c =  daysExecSecOverdue;
            } 
        }
    }

    private static Long getBsnsHoursDifference(BusinessHours bsnsHours, Datetime startTime, Datetime endtime){
        Long l = BusinessHours.diff(bsnsHours.Id, startTime, endtime);
        return l/1000/3600/8;
    }
    
    // v5.0 - BEGIN
    // Validation error while choosing the control for administrtor's review by users who are not part of the ExecSec-Admin or ExecSec-User groups
    private static void doValidate(List<Controlled_Document__c> triggerNew, Map<Id, Controlled_Document__c> oldMap, String adminName) {
        List<GroupMember> gmList = new List<GroupMember>();
        //User gsaAdmin = new User();
        List<User> gsaAdminList = new List<User>();
        gmList = [SELECT Id FROM GroupMember WHERE UserorGroupId = :UserInfo.getUserId() AND Group.DeveloperName IN ('CDT_OAS_User','CDT_OAS_Admin_User')]; 
        gsaAdminList = [SELECT Id FROM User WHERE Name = :adminName AND IsActive = true LIMIT 1];
        //gsaAdmin = [SELECT Id FROM User WHERE Name = :adminName AND IsActive = true LIMIT 1];        
        if(!gsaAdminList.isEmpty()) {            
            for(Controlled_Document__c cdt : triggerNew) {
                if(((cdt.GSA_Action_Required__c == 'Signature/Approval of the Administrator' && 
                    (oldMap == null || cdt.GSA_Action_Required__c != oldMap.get(cdt.Id).GSA_Action_Required__c)) || 
                    (cdt.Final_Signatory__c == gsaAdminList[0].Id && 
                    (oldMap == null || cdt.Final_Signatory__c != oldMap.get(cdt.Id).Final_Signatory__c))) 
                    && gmList.isEmpty() ) {
                    cdt.addError('For help issuing controls for the Administrator\'s signature, please email executive-secretariat@gsa.gov.');
                }
            }
        }    
    }
    // v5.0 - END
    private static String fetchAgencyAdmin() {
        Map<String, CDT_GSA_Administrator__c> cmMap = CDT_GSA_Administrator__c.getAll();
        String agencyAdmin = null;
        if(!cmMap.isEmpty()) {
        	CDT_GSA_Administrator__c cm = cmMap.get('Agency Administrator');
            agencyAdmin = (cm.FullName__c != null) ? cm.FullName__c : null;                
        }
        return agencyAdmin;
    }
}

/*
The field is calculated as the number of business days that have passed since the date in Due_Date__c as long as the Stage does not equal "Closed". 
If today's date is still before the Due Date, the field should either be blank or show a 0. Once the record is closed, i.e., Stage = Closed, 
the calculation should use the Date_Closed__c field instead of today's date to calculate the "Days Overdue" field.
*/