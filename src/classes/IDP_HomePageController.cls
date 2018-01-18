/*
    Controller for IDP Home Page.

    @author Erin Clemmer <erin.c@lookthink.com>
    @since 2015-10-29
*/

public with sharing class IDP_HomePageController {

    private final String LIST_PREFIX = '?fcf=';
    private final String FIRST_LINK = 'In Progress Requests';
    private final String SECOND_LINK = 'Submitted Requests';
    private final String THIRD_LINK = 'Approved Requests';
    private final String FOURTH_LINK = 'Requests to Approve';
    private final String FIFTH_LINK = 'Shared with Me';
    private final String SIXTH_LINK = 'SF 182';
    
    private String userId;
    private String urlString;
    public SF_182_Training__c[] trainings {get;set;}
    public String urlOtherRequests {get;set;}
    public String urlSubmittedRequests {get; set;}
    public String urlApprovedRequests {get; set;}
    public String urlRequestsToApprove {get; set;}
    public String urlSharedWithMe {get; set;}
    public String urlMySF182s {get; set;}
    
    public IDP_HomePageController() {
        loadTrainings();
        setSF182URLs();
        setSF182RequestURLs();
    }
    
    private void loadTrainings(){
        userId = Userinfo.getUserId();
        System.debug('userId is ' + userId);
        trainings = [Select tr.Id From SF_182_Training__c tr 
                                    Where SF_182__r.OwnerId = :userId
                                    And tr.Approval_Status__c != 'Rejected'
                                    And tr.Approval_Status__c != 'Final Approval'];
        System.debug('trainings is ' + trainings);
    }
    
    
    public Boolean getHasApprovalRequests(){
        if(trainings.size() > 0){
            return true;    
        }   
        return false;
    }

    
    public PageReference createIDP(){
        IDP__c newIDP = new IDP__c();
        Date sdate = Date.today();
        Integer year = sdate.year();
        String curFiscalYear = 'FY '+String.valueOf(year);
        newIDP.Fiscal_Year_pick__c = curFiscalYear;
        insert newIDP;

        String newIDPRec;
        urlString='/apex/IDP_Wizard?Id='+newIDP.Id;
        urlString += '&newIDPRec='+'newRec';
        system.debug('urlString is ' + urlString);
        PageReference PageRef = new PageReference(urlString);
        
        return pageRef;
    }

    public void setSF182URLs(){
        Schema.DescribeSObjectResult sf182RequestSchema = Form_SF_182__c.SObjectType.getDescribe();
        String sf182Prefix = sf182RequestSchema.getKeyPrefix();

        ApexPages.StandardSetController sf182StandardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name FROM Form_SF_182__c LIMIT 1]));
        List<SelectOption> ListViews = sf182StandardSetController.getListViewOptions();
        for(SelectOption listView : ListViews){
            String listViewId = listView.getValue().left(15);
            if(listView.getLabel() == SIXTH_LINK){
                urlMySF182s = '/' + sf182Prefix + LIST_PREFIX + listViewId;
            }
        }
    }

    // https://developer.salesforce.com/forums/?id=906F000000096ONIAY
    public void setSF182RequestURLs(){
        Schema.DescribeSObjectResult sf182RequestSchema = SF_182_Training__c.SObjectType.getDescribe();
        String sf182RequestPrefix = sf182RequestSchema.getKeyPrefix();

        ApexPages.StandardSetController sf182StandardSetController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name FROM SF_182_Training__c LIMIT 1]));
        List<SelectOption> ListViews = sf182StandardSetController.getListViewOptions();
        for(SelectOption listView : ListViews){
            String listViewId = listView.getValue().left(15);
            if(listView.getLabel() == FIRST_LINK){
                urlOtherRequests = '/' + sf182RequestPrefix + LIST_PREFIX + listViewId;
            }
            if(listView.getLabel() == SECOND_LINK){
                urlSubmittedRequests = '/' + sf182RequestPrefix + LIST_PREFIX + listViewId;
            }
            if(listView.getLabel() == THIRD_LINK){
                urlApprovedRequests = '/' + sf182RequestPrefix + LIST_PREFIX + listViewId;
            }
            if(listView.getLabel() == FOURTH_LINK){
                urlRequestsToApprove = '/' + sf182RequestPrefix + LIST_PREFIX + listViewId;
            }
            if(listView.getLabel() == FIFTH_LINK){
                urlSharedWithMe = '/' + sf182RequestPrefix + LIST_PREFIX + listViewId;
            }
        }
    }

}