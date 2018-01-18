public with sharing class GSAITApplication {
      
    //HSTS Workaround
    public void hstsHeader() {
        System.currentPageReference().getHeaders().put(
                    'Strict-Transport-Security', 
                    'max-age=3153600; includeSubDomains');
    }
  
      
    // submit button is clicked
    public PageReference submit() {

        
        GSA_IT_Applications__c newApplication = applicant.clone(false, false);
        
        
        //newApplication.Applicant_Email_Address__c=ApplicantInfo.Email__c; // required by confirmation email alert
        
        List<Applicants_Information__c> ApplicantInfoList = [SELECT id, Name, Email__c, Phone__c, Current_Employer__c, City_State_or_Zip_Code__c FROM Applicants_Information__c 
                                                    WHERE Email__c=:ApplicantInfo.Email__c LIMIT 1];
        if (ApplicantInfoList.size()>100) {
        //  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Email address already used to submit an application. Please choose a different email.'));
            return null;  
            /*
            for (Applicants_Information__c oldApplicantInfo : ApplicantInfoList) {
                
                if (ApplicantInfo.Name!=null && ApplicantInfo.Name!=oldApplicantInfo.Name) { oldApplicantInfo.Name=ApplicantInfo.Name; }
                if (ApplicantInfo.Phone__c!=null && ApplicantInfo.Phone__c!=oldApplicantInfo.Phone__c) { oldApplicantInfo.Phone__c=ApplicantInfo.Phone__c; }
                if (ApplicantInfo.Current_Employer__c!=null && ApplicantInfo.Current_Employer__c!=oldApplicantInfo.Current_Employer__c) { oldApplicantInfo.Current_Employer__c=ApplicantInfo.Current_Employer__c; }
                if (ApplicantInfo.City_State_or_Zip_Code__c!=null && ApplicantInfo.City_State_or_Zip_Code__c!=oldApplicantInfo.City_State_or_Zip_Code__c) { oldApplicantInfo.City_State_or_Zip_Code__c=ApplicantInfo.City_State_or_Zip_Code__c; }
                
                Applicants_Information__c updatedApplicantInfo = new Applicants_Information__c(id=oldApplicantInfo.id);
                updatedApplicantInfo.Name=oldApplicantInfo.Name;
                updatedApplicantInfo.Phone__c=oldApplicantInfo.Phone__c;
                updatedApplicantInfo.Current_Employer__c=oldApplicantInfo.Current_Employer__c;
                updatedApplicantInfo.City_State_or_Zip_Code__c=oldApplicantInfo.City_State_or_Zip_Code__c;
                
                try { update updatedApplicantInfo; } catch (Exception e) { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error updating a  Applicant Information.'));}
                newApplication.Applicant_Name__c=oldApplicantInfo.id;
            }*/
        } else {
            Applicants_Information__c newApplicantInfo = new Applicants_Information__c();
            newApplicantInfo.Name=ApplicantInfo.Name;
            newApplicantInfo.Email__c=ApplicantInfo.Email__c;
            newApplicantInfo.Phone__c=ApplicantInfo.Phone__c;
            newApplicantInfo.Current_Employer__c=ApplicantInfo.Current_Employer__c;
            newApplicantInfo.City_State_or_Zip_Code__c=ApplicantInfo.City_State_or_Zip_Code__c;
            try { insert newApplicantInfo; } 
            catch (Exception e) { 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error inserting a new  Applicant Information.'));
            }
            newApplication.Applicant_Name__c= newApplicantInfo.Id;
            newApplication.Applicant_Email_Address__c = newApplicantInfo.Email__c;
            newApplication.Best_Contact_Number__c=newApplicantInfo.Phone__c;
            newApplication.City_and_State_or_Zip_Code__c=newApplicantInfo.City_State_or_Zip_Code__c;
            newApplication.Current_Employer__c=newApplicantInfo.Current_Employer__c;
            //applicant.Veteran_Status_US_Armed_Forces__c=newApplication.Veteran_Status_US_Armed_Forces__c;

        }  
         // inserts the new record into the database\

           
        try { insert newApplication; } catch (DMLException e) { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Email address already used to submit an application. Please choose a different email.')); return null; }
        
        
        List<GSA_IT_Applications__c> appid = [SELECT Name FROM GSA_IT_Applications__c WHERE Id = :newApplication.Id];
        PageReference pg = new PageReference('/apex/GSAIT_Application_Confirmation?appid=' + appId[0].Name);
        pg.setredirect(true);
        return pg;
        
    }
    // the contact record you are adding values to
    public Applicants_Information__c ApplicantInfo {
        get {
            if (ApplicantInfo == null)
                ApplicantInfo = new Applicants_Information__c();
            return ApplicantInfo;
        }
        set; }
    
    public GSA_IT_Applications__c applicant {
        get {
            if (applicant == null) applicant = new GSA_IT_Applications__c();
            return applicant;
        }
        set;
    }

}