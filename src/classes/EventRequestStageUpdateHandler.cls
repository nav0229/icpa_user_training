/****************************************************************
 Name:  EventRequestStageUpdateHandler
============================================================
Author: Lenny
Purpose: JIRA#1248, #1250, #1476 
Processes the provided Event Requests according to Stage.
This class is invoked from the Event Request Trigger Controller.                                                                                                                
============================================================

****************************************************************/

public with sharing class EventRequestStageUpdateHandler implements EventRequestStageUpdateHandlerInterface{
    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();
    @TestVisible private static CreditBureauDAO creditBureauDA = new CreditBureauDataAccessor();
    @TestVisible private static GroupDAO groupDA = new GroupDataAccessor();

    @TestVisible private static JobQueuerInterface queuer = new JobQueuer();
    @TestVisible private static CreditBureauLineItemDupeCheckerInterface cbLineItemDupeChecker = new CreditBureauLineItemDupeChecker();

    @TestVisible private ChecklistItemUpdaterInterface checklistItemUpdaterByCBR = new ChecklistItemUpdaterByCreditBureau();
    //@TestVisible private ChecklistItemGeneratorInterface checklistItemGeneratorBySBALoanHistory = new ChecklistItemGeneratorBySBALoanHistory();
    @TestVisible private ChecklistItemUpdaterInterface checklistItemUpdaterBySBALoanHistory = new ChecklistItemUpdaterBySBALoanHistory();

    private static final Set<String> EXPERIAN_ERROR_CODES = new Set<String>{
        '1000',
        '1001',
        '1002',
        '1003',
        '1004',
        '2000',
        '4000'
    };
    private static final Set<String> RE_RUN_CODES = new Set<String>{
        'Order Loan History ReRun',
        'Order Other Assistance ReRun' 
    };
    
    private static final Map<String, String> STAGE_TO_STAGE_MAP = new Map<String,String>{
        EventRequestDataAccessor.STAGE_SUBMIT_CBR => ApplicationDataAccessor.STAGE_SUBMIT_CBR,
        EventRequestDataAccessor.STAGE_ORDER_CBR => ApplicationDataAccessor.STAGE_ORDER_CBR,
        EventRequestDataAccessor.STAGE_RECEIVED_CBR => ApplicationDataAccessor.STAGE_RECEIVED_CBR,
        EventRequestDataAccessor.STAGE_SUBMIT_AUTO_DECLINE => ApplicationDataAccessor.STAGE_SUBMIT_AUTO_DECLINE,
        EventRequestDataAccessor.STAGE_SENT_AUTO_DECLINE => ApplicationDataAccessor.STAGE_SENT_AUTO_DECLINE
    };

    /****************************************************************
        Purpose:  Main method that sorts and processes the Applications
        related to each Event Request. The Applications are then processed depending on
        their respective Stage association, and their sub-status is updated accordingly.
        Parameters: List of Event Requests
        Returns: N/A
     ****************************************************************/

    public void processEventRequest(List<Event_Request__c> eventRequests) {
        Map<String,Set<String>> stageToApplicationNumberMap = mapApplicationNumbersByStage(eventRequests);
        List<String> applicationNumbers = compoundApplicationNumbers(stageToApplicationNumberMap);
        Map<String,Application__c> relatedApplicationIdToApplicationMap = constructRelatedApplicationMap(applicationNumbers);
        Set<Application__c> updatedApplications = setSubStatusOnApplications(relatedApplicationIdToApplicationMap.values(), stageToApplicationNumberMap);
        
        if(stageToApplicationNumberMap.containsKey(EventRequestDataAccessor.STAGE_SUBMIT_CBR)){
            orderCreditProfile(stageToApplicationNumberMap.get(EventRequestDataAccessor.STAGE_SUBMIT_CBR));
        }

        if(stageToApplicationNumberMap.containsKey(EventRequestDataAccessor.STAGE_RE_ORDER_CBR)){
            List<Event_Request__c> reOrderRequests = getRelatedEventRequests(eventRequests, stageToApplicationNumberMap.get(EventRequestDataAccessor.STAGE_RE_ORDER_CBR));
            checklistItemUpdaterByCBR.handleChecklistUpdates(reOrderRequests);
        }

        if(stageToApplicationNumberMap.containsKey(EventRequestDataAccessor.STAGE_RECEIVED_CBR)){
            List<Application__c> applicationsForCBLineItemDedupe = new List<Application__c>();

            for(String applicationNumber : stageToApplicationNumberMap.get(EventRequestDataAccessor.STAGE_RECEIVED_CBR)){
                if(relatedApplicationIdToApplicationMap.containsKey(applicationNumber)){
                    applicationsForCBLineItemDedupe.add(relatedApplicationIdToApplicationMap.get(applicationNumber));
                }
            }

            if(!applicationsForCBLineItemDedupe.isEmpty()){
                cbLineItemDupeChecker.markDuplicateRelatedCBLineItems(applicationsForCBLineItemDedupe);
            }
        }

        if(stageToApplicationNumberMap.containsKey(EventRequestDataAccessor.STAGE_ORDER_LOAN_HISTORY)){
            //List<Event_Request__c> orderHistoryRequests = getRelatedEventRequests(
            //  eventRequests,
            //  stageToApplicationNumberMap.get(EventRequestDataAccessor.STAGE_ORDER_LOAN_HISTORY)
            //);
            //checklistItemGeneratorBySBALoanHistory.handleChecklistGeneration(orderHistoryRequests);
        }

        if(stageToApplicationNumberMap.containsKey(EventRequestDataAccessor.STAGE_RECEIVE_LOAN_HISTORY)){ 
            List<Event_Request__c> receiveHistoryRequests = getRelatedEventRequests(eventRequests, stageToApplicationNumberMap.get(EventRequestDataAccessor.STAGE_RECEIVE_LOAN_HISTORY));
            checklistItemUpdaterBySBALoanHistory.handleChecklistUpdates(receiveHistoryRequests);
        }
        System.debug(updatedApplications+'----updatedApplications------');
        
        updatedApplications = assignExceptionApplicationsToQueue(updatedApplications);
        
        try {
            applicationDA.updateApplications(new List<Application__c>(updatedApplications));
        } catch (QueryException e) {
            throw new QueryException('An error occurred processing the Event Request(s): '+e.getMessage());
        }
    }

    private Map<String,Application__c> constructRelatedApplicationMap(List<String> applicationNumbers){
        Map<String,Application__c> applicationIdToApplicationMap = new Map<String,Application__c>();

        for(Application__c application : applicationDA.getApplicationsByApplicationNumber(applicationNumbers)){
            applicationIdToApplicationMap.put(application.Name, application);
        }

        return applicationIdToApplicationMap;
    }

    /****************************************************************
        Purpose:  This method takes a list of Application Numbers and 
        passes each to the CBRCreditProfileInitializer to begin the process 
        to request a Credit Bureau Report via callout.
        Parameters: Set<String>
        Returns: N/A
     ****************************************************************/
    private void orderCreditProfile(Set<String> submittedCBRApplicationNumbers){
        if(!submittedCBRApplicationNumbers.isEmpty()){
            for(String applicationNumber : submittedCBRApplicationNumbers){
                queuer.queueJob(new CBRCreditProfileInitializer(applicationNumber));        
            }
        }
    }

    /****************************************************************
        Purpose: This method takes a list of event requests and groups
        the application numbers associated with each by Stage 
        Parameters: List of Event Requests
        Returns: Map<String,Set<String>>
    ****************************************************************/
    private Map<String,Set<String>> mapApplicationNumbersByStage(List<Event_Request__c> eventRequests) {
        Map<String,Set<String>> stageToApplicationNumberMap = new Map<String,Set<String>>();
        for(Event_Request__c request : eventRequests) {
            //Remember to check to that the Stage is in the set of Stage that you care about
            if(!stageToApplicationNumberMap.containsKey(request.Stage__c)) {
                stageToApplicationNumberMap.put(request.Stage__c, new Set<String>());
            }
            stageToApplicationNumberMap.get(request.Stage__c).add(request.Application_Number__c);
        }
        return stageToApplicationNumberMap;
    }
    
    /****************************************************************
        Purpose: This method takes the map of application number sets
        keyed by stage and returns a composite list of the application
        numbers. 
        Parameters: Map<String,Set<String>>
        Returns: List<String>
    ****************************************************************/
    private List<String> compoundApplicationNumbers(Map<String,Set<String>> stageToApplicationNumberMap) {
        List<String> applicationNumbers = new List<String>();
        for(String stage : stageToApplicationNumberMap.keySet()) {
            applicationNumbers.addAll(stageToApplicationNumberMap.get(stage));
        }
        return applicationNumbers;
    }

    /****************************************************************
        Purpose: This method takes the map of application number sets
        keyed by stage and the list of related applications and sets
        their new substatus field values based on the stage.   
        Parameters: List<Application__c>, Map<String,Set<String>>
        Returns: List<Application__c>
    ****************************************************************/
    private Set<Application__c> setSubStatusOnApplications(List<Application__c> relatedApplications, Map<String,Set<String>> stageToApplicationNumberMap){
        Set<Application__c> updatedApplications = new Set<Application__c>();
        for(String stage : stageToApplicationNumberMap.keySet()) {
            if(!RE_RUN_CODES.contains(stage)) {
           		updatedApplications.addAll(assignApplicationStatuses(relatedApplications, stageToApplicationNumberMap.get(stage), STAGE_TO_STAGE_MAP.get(stage)));
            }
        }
        return updatedApplications;
    }

    /****************************************************************
        Purpose:  This method takes in a list of Applications related and
        the sub-status is updated to the provided status string if the 
        Application Name exists in the applicationNumber list. 
        Parameters: List of Applications, List of Strings, String
        Returns: List<Application__c>
     ****************************************************************/
    private Set<Application__c> assignApplicationStatuses(List<Application__c> applications, Set<String> applicationNumbers, String status){
        Set<Application__c> updatedApplications = new Set<Application__c>();
        if(!applicationNumbers.isEmpty() && status != null){
            for(Application__c app : applications) {
                for(String appNumber : applicationNumbers) {
                    if(app.Name == appNumber){
                        app.Sub_Status__c = status;
                        updatedApplications.add(app);
                    }
                }
            }
        }
        return updatedApplications;
    }

    /****************************************************************
        Purpose:  This method takes a list of Applications and assigns
        them to the Exception Queue if they received a CBR with a
        Credit Score exception.
        Parameters: List of Applications, List of Strings, String
        Returns: List<Application__c>
     ****************************************************************/
    @TestVisible
    private Set<Application__c> assignExceptionApplicationsToQueue(Set<Application__c> updatedApplications) {
        List<Credit_Bureau__c> updatedCreditBureaus = new List<Credit_Bureau__c>();
        Group exceptionQueue = groupDA.getGroupByDeveloperNameAndType('Exception_Queue','Queue');
        for(Application__c app : updatedApplications) {
            if(app.Sub_Status__c == ApplicationDataAccessor.STAGE_RECEIVED_CBR) {
                List<Credit_Bureau__c> relatedCBRs = creditBureauDA.getActiveCreditBureausByApplicationLatestFirst(app);
                if(relatedCBRs.size() > 0) {
                    Credit_Bureau__c currentCBR = relatedCBRs.remove(0);
                    
                    relatedCBRs = deactivateOtherRelatedCreditBureaus(relatedCBRs);
                    updatedCreditBureaus.addAll(relatedCBRs);

                    String cScore = currentCBR.Credit_Score__c;
                    if(cScore == 'Zero' || cScore == '0' || cScore == 'Null' || EXPERIAN_ERROR_CODES.contains(cScore)) {
                        app.OwnerId = exceptionQueue.Id;
                    }
                }
            }
        }
        creditBureauDA.updateCreditBureaus(updatedCreditBureaus);
        return updatedApplications;
    }

    /****************************************************************
        Purpose:  This method takes a list of Credit Bureaus and sets
        their Active field to false.
        Parameters: List of Credit Bureaus
        Returns: List<Credit_Bureau__c>
     ****************************************************************/
    private List<Credit_Bureau__c> deactivateOtherRelatedCreditBureaus(List<Credit_Bureau__c> relatedCBRs) {
        for(Credit_Bureau__c cbr : relatedCBRs) {
            cbr.Active__c = false;
        }
        return relatedCBRs;
    }

    private List<Event_Request__c> getRelatedEventRequests(List<Event_Request__c> eventRequests, Set<String> applicationNumbers) {
        List<Event_Request__c> relatedEventRequests = new List<Event_Request__c>();
        for(Event_Request__c request : eventRequests){
            if(applicationNumbers.contains(request.Application_Number__c)){
                relatedEventRequests.add(request);
            }
        }
        return relatedEventRequests;
    }
}