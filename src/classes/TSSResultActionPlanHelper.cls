/*-------------------------------------------------------------------------------------------------*
  Apex class 
  Helper class for TSS_Result_Action_Plan__c object apex trigger
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/05/2014    1.0       Initial version.
  Rajakumar          05/19/2015    1.1       Updated to include the vf page changes
  Rajakumar          09/14/2017    1.2       case# 38030
 *-------------------------------------------------------------------------------------------------*
 
 *-------------------------------------------------------------------------------------------------*/
public with sharing class TSSResultActionPlanHelper {
   // for visualforce page
    //public transient List<TSS_Response__c> responses;
    public transient List<Result> responses;
    public Boolean found {get { 
                               if(found != true) found = false; 
                               return found;
                             } 
                           set;
                        }
   
    public TSSResultActionPlanHelper(){
       Id pId = ApexPages.currentPage().getParameters().get('id');
       /*
       responseext = (pId == null) ? new List<TSS_Response__c>() : [SELECT Id, Name, Response_text__c, TSS_Survey__c, 
                       Service_Category__c, TSS_Survey__r.TSS_Result_Action_Plan__c 
                       FROM TSS_Response__c 
                       WHERE TSS_Survey__r.TSS_Result_Action_Plan__c = :pId];
       */
       //responses = new List<TSS_Response__c>();
       responses = new List<Result>();
       if(pid != null) {
           for(TSS_Response__c t: [SELECT Id, Response_text__c, TSS_Survey__r.Name, TSS_Survey__c, //Name,  Response_Score__c, 
                               //Service_Category__c, TSS_Survey__r.TSS_Result_Action_Plan__c,
                                   TSS_Survey__r.Agency_txt__c, TSS_Survey__r.Bureau_txt__c, Question__c
                               FROM TSS_Response__c 
                               WHERE TSS_Survey__r.TSS_Result_Action_Plan__c = :pId AND Response_Score__c = null
                               AND Type_of_Response__c='Comment']) {
               if(t.response_text__c != null) 
                   responses.add(new Result(t));               
           }
       }
       //responseext.clear();
       if(!responses.isEmpty())
           found = true;       
    }
   
    //public List<TSS_Response__c> getResponses() {
    public List<Result> getResponses() {
       return responses;
    } 
   
    // Before Inserting a new record
    public static void onBeforeInsert(List<TSS_Result_Action_Plan__c> triggerNew) {
        for(TSS_Result_Action_Plan__c tr: triggerNew) {
            if(tr.Property_Manager__c != null) {
                tr.OwnerId = tr.Property_Manager__c;
            }    
        }
    }
    // Before updating the existing record
    public static void onBeforeUpdate(List<TSS_Result_Action_Plan__c> triggerNew, Map<Id, TSS_Result_Action_Plan__c> triggerOldMap) {
        for(TSS_Result_Action_Plan__c tr: triggerNew) {
            if( (tr.Property_Manager__c != null) && (tr.Property_Manager__c != triggerOldMap.get(tr.Id).Property_Manager__c) ) {
                tr.OwnerId = tr.Property_Manager__c;
            }    
        }    
    } 
    
    // for resolving the view state interal error
    public class Result {
        //public transient TSS_Response__c record { get; set; }
        public transient String survey { get; set; }
        public transient String surveyrecordId { get; set; }
        public transient String agency { get; set; }
        public transient String bureau { get; set; }
        public transient String comment { get; set; }
        public transient String question { get; set; }
        public Result(TSS_Response__c  record) {
            survey = record.TSS_Survey__r.Name;
            surveyrecordId = record.TSS_Survey__c;
            agency = record.TSS_Survey__r.Agency_txt__c;
            bureau = record.TSS_Survey__r.Bureau_txt__c;
            comment = record.Response_Text__c;
            question = record.Question__c;
        }
    }
    
}