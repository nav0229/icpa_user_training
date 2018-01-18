public with sharing class TitleVISubmissionController {
        
    private ApexPages.StandardController controller {get; set;}
    public Contact currentContactForUser {get;set;}
    public OCIO_Title_VI_Submission__c titleVISubmission {get;set;}
    
    //Title Review related
    public Boolean isEdit {get;set;}
    public List<OCIO_Title_VI_Review__c> titleReviews; 
    public String titleSubmissionId {get; set;}
    public String reviewID;
    
    public Map<String,String> fieldLabel {get;set;}

 
    public TitleVISubmissionController(ApexPages.StandardController stdc) {
        
        controller = stdc;     
        String currentAuthUserId = UserInfo.getUserId();
        User currentUser = getUserInfo(currentAuthUserId);
        System.debug('User Type ' + currentUser.UserType);
        if (currentUser!=null) {
                currentContactForUser = getContactInfo(currentUser.ContactId);
        }
        
        if (ApexPages.currentPage().getParameters().get('id')!=null) {
            String currentID = ApexPages.currentPage().getParameters().get('id');
            String qry = 'select o.SystemModstamp, o.OwnerId, o.OCR_Rollout_Name__c, o.OCR_Submission_Date__c,' 
                		+'o.OCR_pop_White__c, o.OCR_pop_Native_Hawaiian_Pacific_Islande__c, o.OCR_pop_Male__c, '
                		+'o.OCR_pop_Hispanic_or_Latino__c, o.OCR_pop_Female__c, o.OCR_pop_Black_or_African_American__c,'
                		+' o.OCR_phone__c, o.OCR_advis_White__c, o.OCR_advis_Non_Hispanic_or_Non_Latino__c,'
                		+' o.OCR_advis_Native_Hawaiian_Other_Pacific__c, o.OCR_advis_Male__c, o.OCR_advis_Hispanic_or_Latino__c,'
                		+' o.OCR_advis_Female__c, o.OCR_advis_Black_or_African_American__c, o.OCR_advis_Asian__c,'
                		+' o.OCR_advis_American_Indian_Alaska_Native__c, o.OCR_Zip__c, o.OCR_Work_Study_areas__c,'
                		+' o.OCR_Work_Study_Areas_Accessibility__c, o.OCR_Water_Fountains__c, o.OCR_Water_Fountains_Accessibility__c,'
                		+' o.OCR_Unavailable_Data__c, o.OCR_Translation_or_Interpretation_Assist__c, o.OCR_Trans_Interpretation_Assis_Other__c,'
                		+' o.OCR_Training_Educational_Programs__c, o.OCR_Training_Educational_Programs_Desc__c, o.OCR_Telephone__c,'
                		+' o.OCR_Telephone_Accessibility__c, o.OCR_Submission_Status__c, o.OCR_Street_Address__c, o.OCR_State__c,'
                		+' o.OCR_Rollout__c, o.OCR_Restrooms__c, o.OCR_Restrooms_Accessibility__c, o.OCR_Property_Quality__c,'
                		+' o.OCR_Property_Availability__c, o.OCR_Problems_Experienced__c, o.OCR_Preparation_Date__c,'
                		+' o.OCR_Pop_Non_Hispanic_or_Non_Latino__c, o.OCR_Pop_Asian__c, o.OCR_Pop_American_Indian_or_Alaska_Native__c,'
                		+' o.OCR_Plan_for_Collecting_Data__c, o.OCR_Parking__c, o.OCR_Parking_Accessibility__c, o.OCR_Organizational_Type__c,'
                		+' o.OCR_Organizational_Type_Other__c, o.OCR_Organizational_Background__c, o.OCR_Organization_Name__c,'
                		+' o.OCR_Number_of_Hours__c, o.OCR_Number_of_Minutes__c, o.OCR_Market_Advertise__c, o.OCR_Lounges__c,'
                		+' o.OCR_Lounges_Accessibility__c, o.OCR_Limited_English_Proficiency__c, o.OCR_Lanuage_Other__c,'
                		+' o.OCR_Languages_Most_Encountered__c, o.OCR_LEP_Notification_Method__c, o.OCR_LEP_Notification_Method_Other__c,'
                		+' o.OCR_LEP_Additional_Cost__c, o.OCR_LEP_Actual_Cost__c, o.OCR_Information_Unavailable__c, o.OCR_How_Did_You_Learn__c,'
                		+' o.OCR_How_Did_You_Learn_Other__c, o.OCR_Hearing_Visual_Impaired_Assistance__c, o.OCR_Hallways__c,'
                		+' o.OCR_Hallways_Accessibility__c, o.OCR_Full_Fair_Opportunity__c, o.OCR_Fax__c, o.OCR_Entrances_Exits__c,'
                		+' o.OCR_Entrances_Exits_Accessibility__c, o.OCR_Email__c, o.OCR_Elevators__c, o.OCR_Elevators_Accessibility__c,'
                		+' o.OCR_Donee_Contact__c, o.OCR_Donee_Account__c, o.OCR_Conference_Rooms__c, o.OCR_Conference_Rooms_Accessibility__c,'
                		+' o.OCR_Complaints_Filed__c, o.OCR_Complaint_Received__c, o.OCR_Classrooms__c, o.OCR_Classrooms_Accessibility__c,'
                		+' o.OCR_City__c, o.OCR_Cafeteria__c, o.OCR_Cafeteria_Accessibility__c, o.OCR_Administrative_Grievance_Procedure__c,'
                		+' o.OCR_Administrative_Grievance_Procedure_D__c, o.Name, o.OCR_Hard_Copy__c, o.LastModifiedDate, o.LastModifiedById,'
                		+' o.LastActivityDate, o.IsDeleted, o.Id, o.CreatedDate, o.CreatedById'
                		+' From OCIO_Title_VI_Submission__c o where id =\''+String.escapeSingleQuotes(currentID)+'\' limit 1';
            this.titleVISubmission = Database.query(qry);
               
        } else {
            this.titleVISubmission = new OCIO_Title_VI_Submission__c();
            System.debug('new object');
        }
       // submission = (OCIO_Title_VI_Submission__c)stdc.getRecord();
       titleSubmissionId = this.titleVISubmission.id;
       titleReviews = getTitleReviews();
       
       fieldLabel = this.getFieldLabelMap();
            
    } 
    
    public PageReference saveDraft() {
        try {
            titleVISubmission.OCR_Submission_Status__c='Draft';
            upsert titleVISubmission;
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Saved'));
        return new PageReference('/apex/TitleVISubmissionViewForm?id='+titleVISubmission.Id);
    }
    
    public Boolean getIsEditable(){
        return this.canUserEditRecord(titleVISubmission);
    }
    
    public PageReference edit() {   
        return new PageReference('/apex/TitleVISubmissionEditForm?id'+titleVISubmission.Id);
    }
    
    public PageReference cancelEdit() {   
        return new PageReference('/apex/TitleVISubmissionViewForm?id'+titleVISubmission.Id);
    }
       
    public PageReference submit() {
        try {
            String msg = null;
            if (this.getIsPortalUser()) {
                msg = this.validate();
            }
            if(msg==null||msg=='') {
                    if (this.getIsPortalUser()) {
                        titleVISubmission.OCR_Submission_Status__c='Submitted';
                    }
                    upsert titleVISubmission;
            } else {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,msg));
                    return null;
            }
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }   
        return new PageReference('/'+titleVISubmission.Id);
    }

    public List<OCIO_Title_VI_Submission__c> getNonEditableRecords() {
           
        List<OCIO_Title_VI_Submission__c> titleVISubmissionList = getAllSubmissionRecordsForUser();
        List<OCIO_Title_VI_Submission__c> titleVISubmissionListNew  = new List<OCIO_Title_VI_Submission__c>();

        for (OCIO_Title_VI_Submission__c record: titleVISubmissionList) {
            String recStatus = record.OCR_Submission_Status__c;
            Date createdDate = record.CreatedDate.date();
            Date currentDate = System.today(); 
            Integer numberDaysBetween = createdDate.daysBetween(currentDate);
            
            System.debug('createdDate ' + createdDate);
            System.debug('currentDate ' + currentDate);
            System.debug('numberDaysBetween ' + numberDaysBetween);
            System.debug('recStatus ' + recStatus);
            
            if ((recStatus=='Submitted' || recStatus=='Reviewed') || ((recStatus=='No activity' || recStatus=='Draft') && (numberDaysBetween>90))) {
                titleVISubmissionListNew.add(record);
            } 
        }
        return titleVISubmissionListNew;
    }
    
    public List<OCIO_Title_VI_Submission__c> getEditableRecords() {
           
        List<OCIO_Title_VI_Submission__c> titleVISubmissionList = getAllSubmissionRecordsForUser();
        List<OCIO_Title_VI_Submission__c> titleVISubmissionListNew  = new List<OCIO_Title_VI_Submission__c>();

        for (OCIO_Title_VI_Submission__c record: titleVISubmissionList) {
            String recStatus = record.OCR_Submission_Status__c;
            Date createdDate = record.CreatedDate.date();
            Date currentDate = System.today(); 
            Integer numberDaysBetween = createdDate.daysBetween(currentDate);
            if ((recStatus=='No activity' || recStatus=='Draft') && (numberDaysBetween<90)) {
                titleVISubmissionListNew.add(record);
            } 
        }
        return titleVISubmissionListNew;
    }
    
    private List<OCIO_Title_VI_Submission__c> getAllSubmissionRecordsForUser() {
        List<OCIO_Title_VI_Submission__c> titleVISubmissionList = new List<OCIO_Title_VI_Submission__c>();
        if (currentContactForUser!=null) {
                titleVISubmissionList = [Select id,name, OCR_Hard_Copy__c, OCR_Donee_Contact__r.Name,OCR_Preparation_Date__c,
                                         OCR_Submission_Status__c, OCR_rollout_name__c, OCR_Rollout__r.Name, OCR_Donee_Account__r.Name, 
                                         OCR_Donee_Account__r.id, CreatedDate  from OCIO_Title_VI_Submission__c 
                                         where OCR_Donee_Contact__r.id = :currentContactForUser.id order by OCR_Preparation_Date__c];
        } 
       return titleVISubmissionList;    
    }
    
    public Boolean getIsPortalUser() {
        String currentAuthUserId = UserInfo.getUserId();
        User currentUser = getUserInfo(currentAuthUserId);
        if (currentUser.UserType=='CustomerSuccess' || currentUser.UserType=='PowerCustomerSuccess' || currentUser.UserType=='CSPLitePortal')  {
            return true;
        }
        return false;
    }

    private Boolean canUserEditRecord(OCIO_Title_VI_Submission__c record) {
        Boolean isportalUser = this.getIsPortalUser();
        String recStatus = record.OCR_Submission_Status__c;
        Date createdDate = null;
        if (record.CreatedDate!=null) {
            createdDate = record.CreatedDate.date();
        } else {
            //New Record
            createdDate = System.today();
        }
        Date currentDate = System.today(); 
        Integer numberDaysBetween = createdDate.daysBetween(currentDate);
        if (((recStatus=='Submitted' || recStatus=='Reviewed')
            || ((recStatus=='No activity' || recStatus=='Draft') && (numberDaysBetween>90))) && (isportalUser)) {
            return false;
        } 
        return true;
    }
    
    private static User getUserInfo(Id userId) {
        if(userId!=null) {
            User loggedInUser = [Select Id, ContactId, Contact.AccountId, UserType from User where Id = :userId];
            return loggedInUser;
        }
        else
            return null;
    }
    
    
    private static Contact getContactInfo(Id contactId) {
        if(contactId!=null) {
            Contact conInfo = [Select FirstName, LastName, AccountId, MailingStreet, MailingCity, MailingState,
                                      MailingCountry, MailingPostalCode, Phone, Email,
                                      Title, Salutation, MobilePhone, Fax
                                      from Contact where Id = :contactId];
            return conInfo;
        }
        else
            return null;
    }
    
    private Map<String,String> getFieldLabelMap() {
           
           Map<String, Schema.SObjectField> fMap = Schema.SObjectType.OCIO_Title_VI_Submission__c.fields.getMap();
           Map<String,String> fieldLabel = new Map<String,String>();
           
           for (Schema.SObjectField ft : fMap.values()){ 
           		Schema.DescribeFieldResult fd = ft.getDescribe(); 
                fieldLabel.put(fd.getName(),fd.getLabel());
           }  
       return fieldLabel;
    }
        
    private String validate() {
        
        String msg = ': You must enter or select a value.';
        try {    
                if (titleVISubmission.OCR_Organizational_Background__c==null){
                        return fieldLabel.get('OCR_Organizational_Background__c') + msg;
                }
                if (titleVISubmission.OCR_Organizational_Type__c==null){
                        return fieldLabel.get('OCR_Organizational_Type__c') + msg;
                }
                if (String.valueOf(titleVISubmission.OCR_Organizational_Type__c).contains('Other') && titleVISubmission.OCR_Organizational_Type_Other__c==null) {
                        return fieldLabel.get('OCR_Organizational_Type_Other__c') + msg;
                }
                if (!String.valueOf(titleVISubmission.OCR_Organizational_Type__c).contains('Other') && titleVISubmission.OCR_Organizational_Type_Other__c!=null) {
                        return fieldLabel.get('OCR_Organizational_Type_Other__c') + ' is required only if Other is included in the Organization Type field.';
                }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c==null){
                        return fieldLabel.get('OCR_Limited_English_Proficiency__c') + msg;
                }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c=='No' && titleVISubmission.OCR_Hearing_Visual_Impaired_Assistance__c==null){
                        return fieldLabel.get('OCR_Hearing_Visual_Impaired_Assistance__c') + msg;
                }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c=='Yes' && titleVISubmission.OCR_Languages_Most_Encountered__c==null){
                        return fieldLabel.get('OCR_Languages_Most_Encountered__c') + msg;                    
                }                              
                if (titleVISubmission.OCR_Languages_Most_Encountered__c!=null){
                    if (String.valueOf(titleVISubmission.OCR_Languages_Most_Encountered__c).contains('Other') && titleVISubmission.OCR_Lanuage_Other__c==null){
                           system.debug('LME---> '+String.valueOf(titleVISubmission.OCR_Languages_Most_Encountered__c).contains('Other'));
                        return fieldLabel.get('OCR_Lanuage_Other__c') + msg;
                  }
                }
                if (titleVISubmission.OCR_Languages_Most_Encountered__c!=null){
                    if (!String.valueOf(titleVISubmission.OCR_Languages_Most_Encountered__c).contains('Other') && titleVISubmission.OCR_Lanuage_Other__c!=null){                          
                        return fieldLabel.get('OCR_Lanuage_Other__c') +  ' is required only if Other is included in the Languages Most Encountered field.';
                  }
                }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c=='Yes' && titleVISubmission.OCR_Translation_or_Interpretation_Assist__c==null){
                        return fieldLabel.get('OCR_Translation_or_Interpretation_Assist__c') + msg;
                }
                if (titleVISubmission.OCR_Translation_or_Interpretation_Assist__c !=null){
                        if (String.valueOf(titleVISubmission.OCR_Translation_or_Interpretation_Assist__c).contains('Other') && titleVISubmission.OCR_Trans_Interpretation_Assis_Other__c==null){
                                return fieldLabel.get('OCR_Trans_Interpretation_Assis_Other__c') + msg;
                        }
                }
                if (titleVISubmission.OCR_Translation_or_Interpretation_Assist__c !=null){
                        if (!String.valueOf(titleVISubmission.OCR_Translation_or_Interpretation_Assist__c).contains('Other') && titleVISubmission.OCR_Trans_Interpretation_Assis_Other__c!=null){
                                return fieldLabel.get('OCR_Trans_Interpretation_Assis_Other__c') + ' is required only if Other is included in the Translation or Interpretation Assistance field.';
                        }
                }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c=='Yes' && titleVISubmission.OCR_LEP_Notification_Method__c==null){
                        return fieldLabel.get('OCR_LEP_Notification_Method__c') + msg;
                }
                if (titleVISubmission.OCR_LEP_Notification_Method__c !=null){
                        if (String.valueOf(titleVISubmission.OCR_LEP_Notification_Method__c).contains('Other') && titleVISubmission.OCR_LEP_Notification_Method_Other__c==null){
                        return fieldLabel.get('OCR_LEP_Notification_Method_Other__c') + msg;
                        }
                 }
                 if (titleVISubmission.OCR_LEP_Notification_Method__c !=null){
                        if (!String.valueOf(titleVISubmission.OCR_LEP_Notification_Method__c).contains('Other') && titleVISubmission.OCR_LEP_Notification_Method_Other__c!=null){
                        return fieldLabel.get('OCR_LEP_Notification_Method_Other__c') + ' is required only if Other is included in the LEP Notification Method field.';
                        }
                 }
                if (titleVISubmission.OCR_Limited_English_Proficiency__c=='Yes' && titleVISubmission.OCR_LEP_Additional_Cost__c==null){
                        return fieldLabel.get('OCR_LEP_Additional_Cost__c') + msg;
                }
                if (titleVISubmission.OCR_LEP_Additional_Cost__c=='Yes' && titleVISubmission.OCR_LEP_Actual_Cost__c==null){
                                return fieldLabel.get('OCR_LEP_Actual_Cost__c') + msg;
                }
                if (titleVISubmission.OCR_Hearing_Visual_Impaired_Assistance__c==null){
                        return fieldLabel.get('OCR_Hearing_Visual_Impaired_Assistance__c') + msg;
                }
                if (titleVISubmission.OCR_Training_Educational_Programs__c==null){
                        return fieldLabel.get('OCR_Training_Educational_Programs__c') + msg;
                }        
                if (titleVISubmission.OCR_Training_Educational_Programs__c=='Yes' && titleVISubmission.OCR_Training_Educational_Programs_Desc__c==null){
                        return fieldLabel.get('OCR_Training_Educational_Programs_Desc__c') + msg;
                }
                if (titleVISubmission.OCR_Administrative_Grievance_Procedure__c==null){
                        return fieldLabel.get('OCR_Administrative_Grievance_Procedure__c') + msg;
                }
                //if (titleVISubmission.OCR_Administrative_Grievance_Procedure__c=='Yes' && titleVISubmission.OCR_Administrative_Grievance_Procedure_D__c==null){
                //        return fieldLabel.get('OCR_Administrative_Grievance_Procedure_D__c') + msg;
                //}
                if (titleVISubmission.OCR_Market_Advertise__c==null){
                        return fieldLabel.get('OCR_Market_Advertise__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_Pop_American_Indian_or_Alaska_Native__c==null){
                        return fieldLabel.get('OCR_Pop_American_Indian_or_Alaska_Native__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_Pop_Asian__c==null){
                        return fieldLabel.get('OCR_Pop_Asian__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_pop_Black_or_African_American__c==null){
                        return fieldLabel.get('OCR_pop_Black_or_African_American__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_pop_Native_Hawaiian_Pacific_Islande__c==null){
                        return fieldLabel.get('OCR_pop_Native_Hawaiian_Pacific_Islande__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_pop_White__c==null){
                        return fieldLabel.get('OCR_pop_White__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_pop_Hispanic_or_Latino__c==null){
                        return fieldLabel.get('OCR_pop_Hispanic_or_Latino__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_Pop_Non_Hispanic_or_Non_Latino__c==null){
                        return fieldLabel.get('OCR_Pop_Non_Hispanic_or_Non_Latino__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_Pop_Male__c==null){
                        return fieldLabel.get('OCR_Pop_Male__c') + msg;
                }
                if (titleVISubmission.OCR_Market_Advertise__c=='Yes' && titleVISubmission.OCR_Pop_Female__c==null){
                        return fieldLabel.get('OCR_Pop_Female__c') + msg;
                }
                if (titleVISubmission.OCR_Complaints_Filed__c==null){
                        return fieldLabel.get('OCR_Complaints_Filed__c') + msg;
                }
                if (titleVISubmission.OCR_Complaints_Filed__c=='Yes' && titleVISubmission.OCR_Complaint_Received__c==null){
                        return fieldLabel.get('OCR_Complaint_Received__c') + msg;
                }
                if (titleVISubmission.OCR_How_Did_You_Learn__c==null){
                        return fieldLabel.get('OCR_How_Did_You_Learn__c') + msg;
                }
                if (titleVISubmission.OCR_Property_Availability__c==null){
                        return fieldLabel.get('OCR_Property_Availability__c') + msg;
                }
                if (titleVISubmission.OCR_Problems_Experienced__c==null){
                        return fieldLabel.get('OCR_Problems_Experienced__c') + msg;
                }
                if (titleVISubmission.OCR_Property_Quality__c==null){
                        return fieldLabel.get('OCR_Property_Quality__c') + msg;
                }           
                if (titleVISubmission.OCR_Information_Unavailable__c==null){
                        return fieldLabel.get('OCR_Information_Unavailable__c') + msg;
                }
                if (titleVISubmission.OCR_Information_Unavailable__c=='Yes' && titleVISubmission.OCR_Unavailable_Data__c==null){
                        return fieldLabel.get('OCR_Unavailable_Data__c') + msg;
                }
                if ((titleVISubmission.OCR_advis_American_Indian_Alaska_Native__c < 0) || (titleVISubmission.OCR_Pop_American_Indian_or_Alaska_Native__c < 0) || 
                (titleVISubmission.OCR_advis_Asian__c < 0) ||  (titleVISubmission.OCR_Pop_Asian__c < 0) || (titleVISubmission.OCR_advis_Black_or_African_American__c < 0) || 
                (titleVISubmission.OCR_pop_Black_or_African_American__c < 0) || (titleVISubmission.OCR_advis_Native_Hawaiian_Other_Pacific__c < 0) ||
                (titleVISubmission.OCR_pop_Native_Hawaiian_Pacific_Islande__c< 0) || (titleVISubmission.OCR_advis_White__c < 0) || 
                (titleVISubmission.OCR_pop_White__c < 0) || (titleVISubmission.OCR_advis_Hispanic_or_Latino__c < 0) || (titleVISubmission.OCR_pop_Hispanic_or_Latino__c < 0) ||
                (titleVISubmission.OCR_advis_Non_Hispanic_or_Non_Latino__c < 0) || (titleVISubmission.OCR_pop_Non_Hispanic_or_Non_Latino__c < 0) ||
                (titleVISubmission.OCR_advis_Male__c < 0) || (titleVISubmission.OCR_pop_Male__c < 0) || (titleVISubmission.OCR_advis_Female__c < 0) || 
                (titleVISubmission.OCR_pop_Female__c < 0)) {
                    return 'Negatives values are not allowed.';
                }
        } catch (Exception e) {
            system.debug('Exception is ----> ' + e);
            return msg;
        }
      return null;
    }
        
    public List<OCIO_Title_VI_Review__c> getTitleReviews(){
        titleReviews = [Select o.OCR_Title_VI_Submission__r.Name, o.OCR_Title_VI_Submission__r.id, o.OCR_marketing_Data_Submitted__c, 
                        o.OCR_V_How_did_you_learn__c, o.OCR_VI_Are_donee_explanation_acceptable__c, o.OCR_VI_Any_information_omitted__c, o.OCR_Title_VI_Submission__c, 
                        o.OCR_Title_IX_Training__c, o.OCR_Title_IX_Grievance_Policy__c, o.OCR_Title_IX_Data_submitted__c, o.OCR_Title_IX_Any_question_s_or_concern_s__c, 
                        o.OCR_Title_IV_any_question_concern__c, o.OCR_Section_IV_complaint_data_submitted__c, o.OCR_Reviewer__c, o.OCR_REVIEW_RESULTS__c, 
                        o.OCR_Quality_of_property__c, o.OCR_Problems_obtaining_the_property__c, o.OCR_Preparation_Date__c, o.OCR_Nature_and_type_of_organization__c, 
                        o.OCR_Marketing_Any_question_s_or_concern__c, o.OCR_LEP_What_language__c, o.OCR_LEP_Provide_services__c, o.OCR_LEP_How_to_notify__c, 
                        o.OCR_LEP_How_does_donee_communicate__c, o.OCR_LEP_Cost_s_reported__c, o.OCR_LEP_Any_question_s_or_concern_s__c, o.OCR_LEP_Any_costs__c, 
                        o.OCR_IS_chart_completed_for_IIA__c, o.OCR_GSA_Region__c, o.OCR_Find_out_about_property_availability__c, o.OCR_Estimated_amount_of_time_spent__c, 
                        o.OCR_Donee_Name__c, o.OCR_Donee_ID__c, o.OCR_Donee_Contact__c, o.OCR_Contact_Phone__c, o.OCR_Complete_name_and_address__c, 
                        o.OCR_504_Data_submitted__c, o.OCR_504_Any_question_s_or_concern_s__c, o.Name, o.IsDeleted, o.Id, o.OCR_Donee_Address__c, o.OCR_Review_Notes__c, o.OCR_Review_Completion_Date__c
                        From OCIO_Title_VI_Review__c o 
                        where o.OCR_Title_VI_Submission__r.id = : titleVISubmission.Id limit 1]; 
        
        //reviewID = titleReviews.id;
        system.debug('Review is ----> ' + titleReviews);  
        return titleReviews;
    }
     
   public PageReference editReview() {
        // in edit mode
        isEdit = true;
        return null;
    }
    
    public PageReference saveReview() {
        try {          
            // update Title Review input                                         
            update titleReviews;
            // reset the flags
            isEdit = false;
                      
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);           
        }
        return null;   
    }
    
    public PageReference cancelAction() {
       
        // reset the flags
        isEdit = false;     
        return null;    
    }
}