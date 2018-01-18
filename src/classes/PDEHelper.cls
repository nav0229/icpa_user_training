public class PDEHelper 
{
    public static Decimal ParseMoney(String s){
        s = s.remove('$');
        s = s.remove(',');
        s = s.trim();
        return decimal.valueOf(s);        
    }
    
    public static Date ParseDate(String s){
        if(s.contains('<'))
        {
            s = s.substringbefore('<');
        }
         
         return date.parse(s);        
    }
    
    public static String ParseString(String s){
        if(s != null)
        {
            s = s.unescapeHtml4();
            s = s.trim();

        }
        return s;
    }
    
    Public Static String GetAnchorText(String s){ 
        //pure regex Is between {}, you may have to escape it:  {<a\s+[^>]+?>\s*([^<]+?)\s*<\/a>} 
        Pattern p = Pattern.compile('<a\\s+[^>]+?>\\s*([^<]+?)\\s*<\\/a>'); 
        matcher m = p.matcher(s);   
        if (m.find()){ 
            return m.group(1); 
        } 
        Return null; 
    } 


    public class EasiEmailData
    {        
        public EasiEmailData(string body){
            //Raw Unescaped Pattern => <tr\s*[^>]*><td\s*[^>]*><b\s*[^>]*>(.+?)\:?<\/b><\/td><td\s*[^>]*>\s*(.+?)\s*<\/td><\/tr>
            //https://salesforce.stackexchange.com/questions/11195/unable-to-use-multiline-with-pattern
            //http://www.regular-expressions.info/java.html
            Pattern p = Pattern.compile('(?s)<tr\\s*[^>]*><td\\s*[^>]*><b\\s*[^>]*>(.+?)\\:?<\\/b><\\/td><td\\s*[^>]*>\\s*(.+?)\\s*<\\/td><\\/tr>');
            matcher m = p.matcher(body);
            while (m.find())
            {
//                ModNumber = ModNumber + ';';
//                ModNumber = ModNumber + m.group(1) + '=' + m.group(2);
                String k = m.group(1);
                String v = m.group(2);

                if (k=='Mod Number'){                 
                    if (GetAnchorText(v)!=null) 
                    { 
                        v = ParseString(GetAnchorText(v)); 
                    }         
                    ModString= v;
                    Region = RegionParser(ModString);
                    //ModNumber = ModString.substring(ModString.lastIndexOf(' ')+1,ModString.length());
                    ModNumber = ModString.substringafter('Mod ');
                    ModAwardNumber = ModString.substringbefore('Mod');
                    //Region = RegionParser(ModAwardNumber);
                    IsModForm = True;
                } 
                else if (k=='Award Form'){
                    AwardForm = ParseString(v);
                    IsAwardForm = True;
                }
                else if (k=='Title'){
                    Title = ParseString(v);
                }
                else if (k=='Owner'){
                    Owner = ParseString(v);
                }
                else if (k=='Total Amount'){
                    TotalAmount = ParseMoney(v);
                }
                else if (k=='Obligated Values'){
                    ObligatedValues = ParseMoney(v);                
                }
                else if (k=='Option(s) Value'){
                    OptionValues = ParseMoney(v);                
                }
                else if (k=='Vendor Name'){
                    VendorName = ParseString(v);
                }
                else if (k=='Mod Form'){
                    ModForm = ParseString(v);
                }
                else if (k=='Period of Performance Start Date'){
                    PopStartDate = ParseDate(v);
                }
                else if (k=='Period of Performance End Date'){
                    PopEndDate = ParseDate(v);                
                }
                else if (k=='PR Number(s)'){
                    PrNumber= v;
                }
                else if (k=='Award Number'){                 
                        if (GetAnchorText(v)!=null) 
                        { 
                                v = GetAnchorText(v); 
                        }         
                    AwardNumber = ParseString(v);
                    Region = RegionParser(AwardNumber);
                } 
            }
            
            Map<String, String> zonemap = new Map<String, String>();
            zonemap.put('CO','Central Office');
            zonemap.put('1','Zone 1');
            zonemap.put('2','Zone 1');
            zonemap.put('3','Zone 1');
            zonemap.put('4','Zone 2');
            zonemap.put('5','Zone 1');
            zonemap.put('6','Zone 2');
            zonemap.put('7','Zone 2');
            zonemap.put('8','Zone 3');
            zonemap.put('9','Zone 3');
            zonemap.put('10','Zone 3');
            zonemap.put('11','Zone 4');
            
            Zone = zonemap.get(Region);
        }
    
        public String ModNumber;
        public String ModString;
        public String ModAwardNumber;
        public String AwardForm;
        public String Title;
        public String Owner;
        public Decimal TotalAmount;
        public Decimal ObligatedValues;
        public Decimal OptionValues;
        public String VendorName;
        public String ModForm;
        public Date PopStartDate;
        public Date PopEndDate;
        public Boolean IsAwardForm = False;
        public Boolean IsModForm = False;
        public String PrNumber;
        public String AwardNumber;
        public String Region;
        public String Zone;
    }

    public static String RegionParser (String ItemToParse)
    {
        //https://salesforce.stackexchange.com/questions/11195/unable-to-use-multiline-with-pattern
        //http://www.regular-expressions.info/java.html
        Map<String, String> rm = new Map<String, String>();
            rm.put('A','CO');
            rm.put('B','1');
            rm.put('C','2');
            rm.put('D','3');
            rm.put('E','4');
            rm.put('F','5');
            rm.put('G','6');
            rm.put('H','7');
            rm.put('J','8');
            rm.put('K','9');
            rm.put('L','10');
            rm.put('M','11');
            rm.put('00','CO');
            rm.put('01','1');
            rm.put('02','2');
            rm.put('03','3');
            rm.put('04','4');
            rm.put('05','5');
            rm.put('06','6');
            rm.put('07','7');
            rm.put('08','8');
            rm.put('09','9');
            rm.put('10','10');
            rm.put('11','11');
            
        Pattern p = Pattern.compile('(?i)^\\w{2}P([abcdefghjklm])\\w{9}');
        matcher m = p.matcher(ItemToParse);
         
        if (m.find())
        {
            return rm.get(m.group(1));         
        }
 
        p = Pattern.compile('(?i)^\\w{2}-(\\d{2})-\\w-\\w{2}-\\w{2}-\\w-\\w{4}');
        m = p.matcher(ItemToParse);
 
        if (m.find())
        {
            return rm.get(m.group(1)); 
        }

        p = Pattern.compile('(?i)^\\w{2}-P-(\\d{2})-\\w{2}-\\w{2}-\\w{4}');
        m = p.matcher(ItemToParse);
 
        if (m.find())
        {
            return rm.get(m.group(1)); 
        }

        return null;        
    }
    
    public static ID MigrateFromCustomObject2Case (ID srcId)
    {
        //Need to update based on the case fields that will be updated
        PDE_Case_Entry__c cc = [SELECT PDE_Case__c, PDE_Attachments_To_Load_Counter__c , PDE_Source_Document__c, PDE_Region__c, PDE_Zone__c, PDE_Amendment_Number__c, 
        PDE_Invoice_Number__c, PDE_PDN__c, PDE_Status__c, PDE_Origin__c, PDE_Priority__c, PDE_Description__c, PDE_Pegasys_Document_Type__c,
        PDE_Organization_Name__c, PDE_Title__c, PDE_Division__c, PDE_Vendor__c, PDE_Dollar_Amount__c, PDE_Received_On_Date__c, PDE_Accepted_On_Date__c,
        PDE_Subject__c, PDE_Team_Members__c, PDE_POP_End_Date__c, PDE_POP_Start_Date__c, PDE_EASI_Contract_Number__c, PDE_ContractNumber__c, PDE_Case_Initiator__c, CreatedById
        from PDE_Case_Entry__c where id=:srcId][0];
        
        system.debug(
            'MigrateFromCustomObject2Case srcId='+
            string.valueOf(srcId)+
            ' PDE_Attachments_To_Load_Counter__c='+
            string.valueOf(cc.PDE_Attachments_To_Load_Counter__c)+
            ' PDE_Team_Members__c=['+
            cc.PDE_Team_Members__c +
            ']'
            );        
        
        Id RecTypeId =  [Select Id from RecordType where name = 'Pegasys Data Entry' and sObjectType = 'Case' limit 1].Id;
        
        Case c;
        if (cc.PDE_Case__c==null)
        {
            c = new Case();
            insert c;
            cc.PDE_Case__c = c.Id; 
            cc.PDE_Attachments_To_Load_Counter__c = -1;
            if (cc.PDE_Case_Initiator__c == null)
            {
                cc.PDE_Case_Initiator__c = cc.CreatedById;
            }
            update cc;          
        }
        else        
        {
            c = [Select id, PDE_Source_Document__c FROM Case WHERE id = :cc.PDE_Case__c][0];
        }
        //Put other fields that need to get moved here
        c.PDE_Source_Document__c = cc.PDE_Source_Document__c;   
        c.PDE_Region__c = cc.PDE_Region__c;
        c.PDE_Zone__c = cc.PDE_Zone__c;
        c.PDE_Amendment_Number__c = cc.PDE_Amendment_Number__c;
        c.PDE_Invoice_Number__c = cc.PDE_Invoice_Number__c;
        c.PDE_PDN__c = cc.PDE_PDN__c;
        c.PDE_Pegasys_Document_Type__c = cc.PDE_Pegasys_Document_Type__c;
        c.Status = cc.PDE_Status__c;
        c.Origin = cc.PDE_Origin__c;
        c.Priority = cc.PDE_Priority__c;
        c.PDE_Attachments_To_Load_Counter__c = cc.PDE_Attachments_To_Load_Counter__c;
        c.RecordTypeId = RecTypeId;
        c.PDE_Case_Entry_ID__c = cc.Id; 
        c.Description = cc.PDE_Description__c;
        c.PDE_Organization_Name__c = cc.PDE_Organization_Name__c;
        c.PDE_Title__c = cc.PDE_Title__c;
        c.PDE_Division__c = cc.PDE_Division__c;
        c.PDE_Vendor__c = cc.PDE_Vendor__c;
        c.PDE_Dollar_Amount__c = cc.PDE_Dollar_Amount__c;
        c.PDE_Received_On_Date__c = cc.PDE_Received_On_Date__c;
        c.PDE_Accepted_On_Date__c = cc.PDE_Accepted_On_Date__c;
        c.Subject = cc.PDE_Subject__c;
        c.PDE_POP_End_Date__c = cc.PDE_POP_End_Date__c;
        c.PDE_POP_Start_Date__c = cc.PDE_POP_Start_Date__c;
        c.PDE_EASI_Contract_Number__c = cc.PDE_EASI_Contract_Number__c;
        c.PDE_ContractNumber__c = cc.PDE_ContractNumber__c;
        c.PDE_Case_Initiator__c = cc.PDE_Case_Initiator__c;
        
        update c;
        
        
        List <PDE_Case_Team_Entry__c> teamEntries = [select Name, PDE_Case_Team_Member__c, PDE_Case_Team_Member_Role__c, PDE_Case_Entry__c FROM PDE_Case_Team_Entry__c where PDE_Case_Entry__r.Id =:srcId];
        for (PDE_Case_Team_Entry__c  cte : teamEntries)
        {
            system.debug('MigrateFromCustomObject2Case:Insert Case Team Member => '+string.valueOf(cte.Name));
            CaseTeamMember ct = new CaseTeamMember ();
            
            ct.ParentId = c.id;    //set reference to the c_holder built above
            ct.MemberId = cte.PDE_Case_Team_Member__c;   //Copy User ID to MemberId
            ct.TeamRoleId = cte.PDE_Case_Team_Member_Role__c;   //Copy CaseTeamRoleId to TeamRoleId
            insert ct;
        }
        delete teamEntries;      
                        
        //Add PDE Case Initiator as a Case Team Member so they can get the emails
        CaseTeamMember ct = new CaseTeamMember();
        
        ct.ParentId = c.id;
        ct.MemberId = c.PDE_Case_Initiator__c;
        //ct.TeamRoleId = TeamRoleId;
        ct.TeamRoleId = [SELECT Id FROM CaseTeamRole WHERE Name = 'PDE CC Recipient' LIMIT 1].id;

        insert ct;

        
        MoveAttachments(srcId, c.Id);
        
        return c.Id;
    }
    
    
    public static void MoveAttachments(ID srcId, ID dstId)
    {
        List<Attachment> attachmentsToInsert = new List<Attachment>();
        
        List<Attachment> attachmentsToDelete = new List<Attachment>();
        
        List<Attachment> attachments = [
                SELECT SystemModstamp, ParentId, OwnerId, Name, 
                    LastModifiedDate, LastModifiedById, IsPrivate, IsDeleted, 
                    Id, Description, CreatedDate, CreatedById, 
                    ContentType, BodyLength, Body 
                FROM Attachment 
                WHERE parentId=:srcId];
        
        for (Attachment a : attachments)
        {
            Attachment c = a.clone(false, false);
            c.parentId = dstId;
            attachmentstoInsert.add(c);
            attachmentsToDelete.add(a);
        
        }
        
        insert attachmentsToInsert;
        delete attachmentsToDelete;
            
    }
    
    public static void SendEmail(ID CaseId)
    {
        Case cse = [SELECT id,  Case.owner.Name, Case.owner.Email, Case.Createdby.Name,Case.Createdby.Email, Case.Description, Status, CaseNumber,PDE_Source_Document__c, PDE_Region__c, PDE_Zone__c, PDE_Division__c, PDE_PDN__c, PDE_Amendment_Number__c, PDE_Invoice_Number__c, PDE_EmailReferenceId__c, PDE_Case_Initiator__c, PDE_Case_Initiator__r.Name, PDE_Case_Initiator__r.Email from Case WHERE Id =:CaseId];                            
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // Setting the from to the OrgWideEmailAddress for PDE's Shared Inbox
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address like 'pegasysdataentrytoolinbox%'];    //Looking for ID for Email Address
        if ( owea.size() > 0 ) 
        {
            email.setOrgWideEmailAddressId(owea.get(0).Id);    //Setting email from address to the ID of the Inbox
        } //need an else in case the email is not in the system
         /*
         email.setSubject('Testing');
         email.setToAddresses(new String[]{'jonathan.j.chen@us.pwc.com'});
         email.setPlainTextBody('Hello');
         Messaging.sendEmail(new Messaging.singleEmailMessage[] {email}); 
        */

        String subject = 'PDE Tool - SUBMISSION' + ' ';
        if (string.isNotBlank(Cse.PDE_Region__c))
        {
            subject = subject + 'Region '+ Cse.PDE_Region__c + ' ';
        }
        if (string.IsNotBlank(Cse.PDE_PDN__c))
        {
            subject = subject + Cse.PDE_PDN__c+ ' ';
        }
        subject = subject + Cse.PDE_Source_Document__c + '- Case #: ' + Cse.CaseNumber + ' - ' + Cse.PDE_EmailReferenceId__c; 
        email.setSubject(subject);
        
        String body = 'Your document has been submitted to Pegasys Data Entry Tool successfully. ' + '\n\n' +
                         'Case #: ' + Cse.CaseNumber + '\n' +
                         'Submitters Name: ' +  cse.PDE_Case_Initiator__r.Name + '\n';
        if( string.isNotBlank(Cse.PDE_Zone__c))
        {
            body = body + 'Zone: '+ Cse.PDE_Zone__c + '\n';
        }
        if (string.isNotBlank(Cse.PDE_Region__c))
        {
            body = body + 'Region: '+ Cse.PDE_Region__c + '\n';
        }
        if (string.IsNotBlank(Cse.PDE_Division__c))
        {
            body = body + 'Division: '+ Cse.PDE_Division__c + '\n';
        }
        if (string.IsNotBlank(Cse.PDE_PDN__c))
        {
            body = body + 'PDN: '+ Cse.PDE_PDN__c+ '\n';
        }
        if( string.isNotBlank(Cse.PDE_Amendment_Number__c))
        {
            body = body + 'Amendment #: ' + Cse.PDE_Amendment_Number__c + '\n';
        }
        if(string.isNotBlank(Cse.PDE_Invoice_Number__c))
        {
            body = body + 'Invoice #: '+ Cse.PDE_Invoice_Number__c + '\n';
        }
        if(string.isNotBlank(Cse.Description))
        {
            body = body + 'Description:\n\n'+ Cse.Description + '\n\n\n';
        }
        body = body + Cse.PDE_EmailReferenceId__c;
                
        email.setPlainTextBody(body);
                
        //Put your record id in ParentId
        List<Attachment> attList = [SELECT id, Name, body, ContentType FROM Attachment WHERE ParentId =: CaseId];
        // List of attachments handler
        Messaging.EmailFileAttachment[] efaList = new List<Messaging.EmailFileAttachment>();
        // Create the email attachment 
        for(Attachment att : attList)
        {
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(att.Name);
            efa.setBody(att.body);
            efa.setContentType(att.ContentType);
            efa.setInline(false);
            efaList.add(efa);
            system.debug('****SYSTEM DEBUG**** efa return: ' + efa); 
         }
         
         system.debug('****SYSTEM DEBUG**** efaList return: ' + efaList); 
         system.debug('****SYSTEM DEBUG**** attList return: ' + attlist); 

         // Attach files to email instance
         email.setFileAttachments(efaList);
         email.setPlainTextBody(body);
        
         Id caseTeamRoleId= [SELECT Id FROM CaseTeamRole WHERE Name = 'PDE CC Recipient' LIMIT 1].id;
         List<CaseTeamMember> catmlst = [select Id, MemberId from CaseTeamMember where TeamRoleId = :caseTeamRoleId and ParentId =: CaseId];
         system.debug('****SYSTEM DEBUG**** catmlst return *MemberId:* ' + catmlst);
         String [] toEmails = new List<String>();
         toEmails.add(cse.PDE_Case_Initiator__r.Email);
        
         for(CaseTeamMember ctm : catmlst)
         {   
             String teamMemId = ctm.MemberId;
             teamMemId = teamMemId.substring(0, teamMemId.length()-3);
             String userEmailId = [select Id, Email from User where Id = :teamMemId].Email;
             toEmails.add(userEmailId);
         }    

           
         email.setToAddresses(toEmails);

         if(Test.isRunningTest())
         {
            //Nothing
         }
         else
         {
             Messaging.sendEmail(new Messaging.singleEmailMessage[] {email});
        }
                                   
    }
    public static Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        PDE_Case_Entry__c NewPdeEntry = new PDE_Case_Entry__c();
        

/*        NewPdeEntry.PDE_Description__c body = email.htmlBody;*/
/*        string searchString;
        
        searchString = '\''+email.fromAddress+'\'';
       
        String soslQuery = 'FIND :searchString IN NAME FIELDS RETURNING '
                          + 'User (Id WHERE (not email like \'%=%\') and Profile.UserLicense.LicenseDefinitionKey 
                          in (\'AUL\', \'SFDC\') and isActive = true)  LIMIT 1';
 */     
       List <User> u = [SELECT ID FROM User WHERE email = :email.fromAddress and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true LIMIT 1];                  
      
        if (u.size() > 0)
        {
              NewPdeEntry.PDE_Case_Initiator__c= u[0].Id;
        }
        else
        {
              User d = [SELECT ID FROM User WHERE email = 'lynn.wu@gsa.gov' and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true LIMIT 1];                  
              NewPdeEntry.PDE_Case_Initiator__c= d.Id;

        }
        
        PDEHelper.EasiEmailData e = new PDEHelper.EasiEmailData(email.htmlBody);
        NewPdeEntry.PDE_Contact_Email__c = email.fromAddress;        
        NewPdeEntry.PDE_Subject__c = email.subject;
        NewPdeEntry.PDE_Description__c = email.plainTextBody;
        
        NewPdeEntry.PDE_Amendment_Number__c = e.ModNumber;
        NewPdeEntry.PDE_Title__c = e.Title.left(50);
        NewPdeEntry.PDE_Vendor__c = e.VendorName;
        NewPdeEntry.PDE_Origin__c = 'Email';
        NewPdeEntry.PDE_POP_Start_Date__c = e.PopStartDate;
        NewPdeEntry.PDE_POP_End_Date__c = e.PopEndDate;
        NewPdeEntry.PDE_Status__c = 'New';
        NewPdeEntry.PDE_Region__c = e.Region;
        NewPdeEntry.PDE_Zone__c = e.Zone;


        if (e.IsAwardForm) {
            NewPdeEntry.PDE_Source_Document__c = 'Order/Award';
            NewPdeEntry.PDE_ContractNumber__c = e.AwardNumber;
            //NewPdeEntry.PDE_Dollar_Amount__c = e.TotalAmount;
        }
        else if (e.IsModForm) {
            NewPdeEntry.PDE_Source_Document__c = 'Amendment/Mod';
            NewPdeEntry.PDE_ContractNumber__c = e.ModAwardNumber;
        }

        NewPdeEntry.PDE_Attachments_To_Load_Counter__c = 2;
        
        insert NewPdeEntry;
        
        string searchString;
        
        searchString = '\''+e.Owner+'\'';
        
        String soslQuery = 'FIND :searchString IN NAME FIELDS RETURNING '
                          + 'User (Id WHERE (not email like \'%=%\') and Profile.UserLicense.LicenseDefinitionKey in (\'AUL\', \'SFDC\') and isActive = true)  LIMIT 1';
        System.debug('SOSL QUERY: '+soslQuery);
        List<List<SObject>> results =  Search.query(soslQuery);
        
        if(results.size()>0){
            for(SObject sobj : results[0]){
                PDE_Case_Team_Entry__c tm = new PDE_Case_Team_Entry__c();
                tm.PDE_Case_Entry__c=NewPdeEntry.Id;
                tm.PDE_Case_Team_Member__c=(String)sobj.get('Id');
                Id caseTeamRoleId = [SELECT Id FROM CaseTeamRole WHERE Name = 'PDE CC Recipient' LIMIT 1].id;
                tm.PDE_Case_Team_Member_Role__c = caseTeamRoleId;
                
                insert tm;
               }
          }
        
         NewPdeEntry.PDE_Attachments_To_Load_Counter__c = 1;
         
                 
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0)
        {
            for (integer i = 0 ; i < email.binaryAttachments.size() ; i++)
            {
                Attachment attachment = new Attachment();
                // attach to the newly created contact record
                attachment.ParentId = NewPdeEntry.Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                attachment.ContentType = email.binaryAttachments[i].mimeTypeSubType;
                insert attachment;
            }
        }        
                  
         NewPdeEntry.PDE_Attachments_To_Load_Counter__c = 0;
         
         update NewPdeEntry;
         
         return result;
      }
   
}