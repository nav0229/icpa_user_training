global class CIS_scheduledTasks implements Schedulable{
    global void execute(SchedulableContext SC) { 
        //Take care of 5 Years Deductions...
        date currentDate = date.today().addYears(-5);
        List<CIS_Assets__c> assets = [Select c.Name,c.Carpet_Drapes_5_yr_Cost_Removed__c,c.Total_Cost__c,c.Member_of_Congress__c, c.Id, c.Expense_Type__c, c.Date_Received__c, c.Current_CIS_Office__c, c.CIS_Office__c, c.Asset_Number__c From CIS_Assets__c c where c.Date_Received__c < :currentDate and c.Expense_Type__c = 'B - Carpet/Drapes' and c.Carpet_Drapes_5_yr_Cost_Removed__c = 'N'];
        if(assets != null && assets.size() > 0)
        {
            Set<Id> pmoOfficeIds = new Set<Id>();
            for (CIS_Assets__c asset : assets) 
            {
                pmoOfficeIds.add(asset.CIS_Office__c);        
            }
            set<string> excludedOffices = new Set<String>{ 'EXCS','66AA','77ZA'}; 
            List<CIS_Offices__c> pmoOfficeList =  [select Id,Member_ID__c,Member_of_Congress__c,PMO_AO_Number__c from CIS_Offices__c where Id IN :pmoOfficeIds and PMO_AO_Number__c != :excludedOffices]; 
            Map<Id,CIS_Offices__c> pmoOfficeMap = new Map<Id,CIS_Offices__c>();         
            for(CIS_Offices__c pmoOffice : pmoOfficeList)
            {
                pmoOfficeMap.put(pmoOffice.Id,pmoOffice);
            }
    
            List<CIS_MemberOfCongress__c> memOfCongressList = [select Id,Spent_Asset_Budget__c FROM CIS_MemberOfCongress__c where Id IN (select Member_ID__c from CIS_Offices__c where Id IN :pmoOfficeIds and PMO_AO_Number__c != :excludedOffices)];        
            Map<Id,CIS_MemberOfCongress__c> memOfCongressMap = new Map<Id,CIS_MemberOfCongress__c>();     
            for(CIS_MemberOfCongress__c memOfCongress : memOfCongressList)
            {
                memOfCongressMap.put(memOfCongress.Id,memOfCongress);
            }        
            
//            List<CIS_MemberOfCongress__c> updateCongress = new List<CIS_MemberOfCongress__c>();
            Map<Id,CIS_MemberOfCongress__c> updateCongress = new Map<Id,CIS_MemberOfCongress__c>();
            
            List<CIS_Assets__c> updateAsset = new List<CIS_Assets__c>();
                        
            for(CIS_Assets__c asset : assets)
            {
                if(pmoOfficeMap.containsKey(asset.CIS_Office__c))
                {
                    CIS_Offices__c pmoOffice = pmoOfficeMap.get(asset.CIS_Office__c);
                    if(memOfCongressMap.containsKey(pmoOffice.Member_ID__c))
                    {
                        CIS_MemberOfCongress__c memOfCongress = memOfCongressMap.get(pmoOffice.Member_ID__c);
                        if(memOfCongress.Spent_Asset_Budget__c == null)
                            memOfCongress.Spent_Asset_Budget__c = 0;
                        memOfCongress.Spent_Asset_Budget__c = memOfCongress.Spent_Asset_Budget__c - asset.Total_Cost__c;    
                        if(updateCongress.containsKey(memOfCongress.Id))
                        {
                            updateCongress.remove(memOfCongress.Id);
                            updateCongress.put(memOfCongress.Id,memOfCongress);
                        }
                        else
                        {
                            updateCongress.put(memOfCongress.Id,memOfCongress);                        
                        }
                        asset.Carpet_Drapes_5_yr_Cost_Removed__c = 'Y';
                        updateAsset.add(asset);
                    }
                }
            }
            if(updateCongress != null && updateCongress.size() > 0)
            {
                List<CIS_MemberOfCongress__c> finalUpdateCongress = new List<CIS_MemberOfCongress__c>();
                for(Id memberOfCongressId : updateCongress.keySet())
                {
                    finalUpdateCongress.add(updateCongress.get(memberOfCongressId));
                }
                if(finalUpdateCongress != null && finalUpdateCongress.size() > 0)
                    update finalUpdateCongress;                
            }
            if(updateAsset != null && updateAsset.size() > 0)
                update updateAsset;                
        }            
        
        //Take care of 4 Years 10 Months...
        date current4Y8MDate = date.today().addYears(-4).addMonths(-10);
        List<CIS_Assets__c> assets4Y8M = [Select c.Name,c.Carpet_Drapes_4_yr_10mo_Email_Sent__c,c.Member_of_Congress__c, c.Id, c.Expense_Type__c, c.Date_Received__c, c.Current_CIS_Office__c, c.CIS_Office__c, c.Asset_Number__c From CIS_Assets__c c where c.Date_Received__c <= :current4Y8MDate and c.Expense_Type__c = 'B - Carpet/Drapes' and c.Carpet_Drapes_4_yr_10mo_Email_Sent__c = 'N'];
        if(assets4Y8M != null && assets4Y8M.size() > 0)
        {
            Set<Id> pmoOfficeIds = new Set<Id>();
            for (CIS_Assets__c asset : assets4Y8M) 
            {
                pmoOfficeIds.add(asset.CIS_Office__c);        
            }
            set<string> excludedOffices = new Set<String>{ 'EXCS','66AA','77ZA'}; 
            List<CIS_Offices__c> pmoOfficeList =  [select Id,Member_ID__c,Member_of_Congress__c,PMO_AO_Number__c from CIS_Offices__c where Id IN :pmoOfficeIds and PMO_AO_Number__c != :excludedOffices]; 
            Map<Id,CIS_Offices__c> pmoOfficeMap = new Map<Id,CIS_Offices__c>();         
            for(CIS_Offices__c pmoOffice : pmoOfficeList)
            {
                pmoOfficeMap.put(pmoOffice.Id,pmoOffice);
            }
            
            List<CIS_MemberOfCongress__c> memOfCongressList = [select Id,Spent_Asset_Budget__c,Region__c FROM CIS_MemberOfCongress__c where Id IN (select Member_ID__c from CIS_Offices__c where Id IN :pmoOfficeIds and PMO_AO_Number__c != :excludedOffices)];        
            Map<Id,CIS_MemberOfCongress__c> memOfCongressMap = new Map<Id,CIS_MemberOfCongress__c>();     
            for(CIS_MemberOfCongress__c memOfCongress : memOfCongressList)
            {
                memOfCongressMap.put(memOfCongress.Id,memOfCongress);
            }            
            
            List<CIS_Assets__c> updateAsset = new List<CIS_Assets__c>();
                      

            //Needs to be changed to who ever it needs to go.
            //Contact recipient = [Select c.LastName,c.FirstName, c.Id ,c.Email From Contact c  where c.Email='Murugaboopathi.Natarajan@gsa.gov' LIMIT 1];
            //Contact recipient = [Select c.LastName,c.FirstName, c.Id ,c.Email From Contact c  where c.Email = 'hamedullah.mohammed@gsa.gov' LIMIT 1];
             
            
            //This comment has to be removed for PROD.
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'app-support@gsa.gov'];
            Map<String,String> emailAddressMap = new Map<String,String>();
            emailAddressMap.put('01','CIS_Region_01@gsa.gov'); //
            emailAddressMap.put('02','CIS_Region_02@gsa.gov'); //
            emailAddressMap.put('03','CIS_Region_03@gsa.gov'); //
            emailAddressMap.put('04','CIS_Region_04@gsa.gov'); //
            emailAddressMap.put('05','CIS_Region_05@gsa.gov'); //
            emailAddressMap.put('06','CIS_Region_06@gsa.gov'); //
            emailAddressMap.put('07','CIS_Region_07@gsa.gov'); //
            emailAddressMap.put('08','CIS_Region_08@gsa.gov'); //
            emailAddressMap.put('09','CIS_Region_09@gsa.gov'); //
            emailAddressMap.put('10','CIS_Region_10@gsa.gov'); //
            emailAddressMap.put('Managers','CIS_Region_Managers@gsa.gov'); //         
            
            /*
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'app-support@gsa.gov'];
            Map<String,String> emailAddressMap = new Map<String,String>();
            emailAddressMap.put('Managers','hamedsufi@gmail.com'); //       
            emailAddressMap.put('01','hamedgsa1@gmail.com'); //
            emailAddressMap.put('02','hamedgsa2@gmail.com'); //
            emailAddressMap.put('03','hamedgsa3@gmail.com'); //
            emailAddressMap.put('04','hamedgsa4@gmail.com'); //
            emailAddressMap.put('05','hamedgsa5@gmail.com'); //
            emailAddressMap.put('06','hamedgsa6@gmail.com'); //
            emailAddressMap.put('07','hamedgsa7@gmail.com'); //
            emailAddressMap.put('08','hamedgsa8@gmail.com'); //
            emailAddressMap.put('09','hamedgsa9@gmail.com'); //
            emailAddressMap.put('10','hamedgsa10@gmail.com'); //
            emailAddressMap.put('Managers','hamedsufi@gmail.com'); //         
            */
//            EmailTemplate et = [Select e.TimesUsed, e.TemplateType, e.TemplateStyle, e.SystemModstamp, e.Subject, e.OwnerId, e.NamespacePrefix, e.Name, e.Markup, e.LastUsedDate, e.LastModifiedDate, e.LastModifiedById, e.IsActive, e.Id, e.HtmlValue, e.FolderId, e.Encoding, e.DeveloperName, e.Description, e.CreatedDate, e.CreatedById, e.BrandTemplateId, e.Body, e.ApiVersion From EmailTemplate e where e.Name = 'CIS Carpet/Drapes Aging' and isActive = true];            

            Messaging.SingleEmailMessage[] allEmails = new LIST<Messaging.SingleEmailMessage>();
            for(CIS_Assets__c asset : assets4Y8M)
            {
                if(pmoOfficeMap.containsKey(asset.CIS_Office__c))
                {
                    CIS_Offices__c pmoOffice = pmoOfficeMap.get(asset.CIS_Office__c);
                    if(memOfCongressMap.containsKey(pmoOffice.Member_ID__c))
                    {
                        CIS_MemberOfCongress__c memOfCongress = memOfCongressMap.get(pmoOffice.Member_ID__c);
                        asset.Carpet_Drapes_4_yr_10mo_Email_Sent__c = 'Y';
                        updateAsset.add(asset);
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                          
                        mail.setUseSignature(true);
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setToAddresses(new String[] {emailAddressMap.get(memOfCongress.Region__c),emailAddressMap.get('Managers') });
                        //mail.setSenderDisplayName('Carpet/Drapes Aging');
                        mail.setSubject('Carpet/Drapes Aging');
                        mail.setPlainTextBody('The Asset Id: ' + asset.Name +' is now 4 years and 10 months old. Asset Number: '+ asset.Asset_Number__c + 'PmoAo Office:  '+ asset.Current_CIS_Office__c  + 'Member of Congress Name: ' + asset.Member_of_Congress__c);  
                        mail.setHtmlBody('The Asset Id: ' + asset.Name +' is now 4 years and 10 months old. <br/>Asset Number: '+ asset.Asset_Number__c + '<br/>PmoAo Office:  '+ asset.Current_CIS_Office__c  + '<br/>Member of Congress Name: ' + asset.Member_of_Congress__c);                    
                        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});                    
                        allEmails.add(mail);
                    }
                }
            }
            if(allEmails != null && allEmails.size() > 0)
            {
                Messaging.Email[] allMails = new LIST<Messaging.Email>();
                for( Integer j = 0; j < allEmails.size(); j++ )
                {
                    allMails.add(allEmails.get(j));
                }
                Messaging.SendEmailResult[] results = Messaging.sendEmail(allMails);
                Messaging.SendEmailError[] errors = new List<Messaging.SendEmailError>();
                String emailErrorReport ;
                for( Messaging.SendEmailResult currentResult : results ) 
                {
                    errors = currentResult.getErrors();
                    if( null != errors ) 
                    {
                        for( Messaging.SendEmailError currentError : errors ) 
                        {
                            emailErrorReport = emailErrorReport + '(' + currentError.getStatusCode() + ') ' + currentError.getMessage() + '\r' ;
                        }
                    }
                }
                //Contact recipient = [Select c.LastName,c.FirstName, c.Id ,c.Email From Contact c  where c.Email = 'hamedullah.mohammed@gsa.gov' and c.LastName='H' LIMIT 1];                
                if(emailErrorReport != null && emailErrorReport.length() > 0)
                {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                          
                    //mail.setTargetObjectId(recipient.id); 
                    //mail.setSenderDisplayName('Carpet/Drapes Aging - EMAIL NOT - ERROR REPORT');
                    mail.setUseSignature(true);
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);                    
                    mail.setPlainTextBody(emailErrorReport);
                    mail.setHtmlBody(emailErrorReport);
                    
                  //  mail.setPlainTextBody('The Asset Id: ' + asset.Name +' is now 4 years and 10 months old. Asset Number: '+ asset.Asset_Number__c + 'PmoAo Office:  '+ asset.Current_CIS_Office__c  + 'Member of Congress Name: ' + asset.Member_of_Congress__c);  
                  //  mail.setHtmlBody('The Asset Id: ' + asset.Name +' is now 4 years and 10 months old. <br/>Asset Number: '+ asset.Asset_Number__c + '<br/>PmoAo Office:  '+ asset.Current_CIS_Office__c  + '<br/>Member of Congress Name: ' + asset.Member_of_Congress__c);                    
                }
            }
            if(updateAsset != null && updateAsset.size() > 0) 
                update updateAsset;                
        }            
    }
}