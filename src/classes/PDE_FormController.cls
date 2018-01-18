public class PDE_FormController {

    /*
     * This method gets the picklist values of "Source Document Type" field
     */
    
    @AuraEnabled
    public static List<String> getsourcedocumentpickval() {
        List<String> options = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = PDE_Case_Entry__c.PDE_Source_Document__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }       
        return options;
    }
    
    /*
     * This method gets the picklist values of "Region" field
     */
    
    @AuraEnabled
    public static List<String> getregionpickval() {
        List<String> options = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = PDE_Case_Entry__c.PDE_Region__c.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }       
        return options;
    }
    @AuraEnabled
    /*
     * This method returns logged in User Name
     */
    public static String getUserName() {
        return userinfo.getName();
    }
    @AuraEnabled
    /*
     * This method returns logged in User's Email
     */
    public static String getEmail() {
        return userinfo.getUserEmail();
    }
    @AuraEnabled
    /*
     * This method returns logged in User's Organization Name
     */
    public static String getOrg() {
        return userinfo.getOrganizationName();
    }
    @AuraEnabled
    /*
     * This method returns logged in User's Title
     */
    public static String getTitle() {
        List<User> UserTitle = [SELECT Title FROM User WHERE Id = : UserInfo.getUserId() LIMIT 1];
        String UserTitleName = UserTitle[0].Title;
        return UserTitleName;
    }
    @AuraEnabled
    /*
     * This method returns logged in User's Division
     */
    public static String getDivision() {
        List<User> UserDivision = [SELECT Division FROM User WHERE Id = : UserInfo.getUserId() LIMIT 1];
        String UserDivisionName = UserDivision[0].Division;
        return UserDivisionName;
    }
    
    @AuraEnabled
    /*
     * This method returns UserName from User Id
     */
    public static String getUserNameId(String Id) {
        List<User> UserNameList = [SELECT Name FROM User WHERE Id = : Id LIMIT 1];
        String UserName = UserNameList[0].Name;
        
        return UserName; 
    }

    @AuraEnabled
    public static String getFinalizationData(String pdeCaseEntryId) {
        system.debug('getFinalizationData pdeCaseEntryId=['+pdeCaseEntryId+']');
        PDE_Case_Entry__c z = [SELECT Id, PDE_Attachments_To_Load_Counter__c, PDE_Case__r.CaseNumber FROM PDE_Case_Entry__c WHERE Id = :pdeCaseEntryId LIMIT 1][0];
        String ret = 'finalizationData;'+z.Id+';'+String.valueOf(z.PDE_Attachments_To_Load_Counter__c)+';'+z.PDE_Case__r.CaseNumber;
        system.debug('getFinalizationData ret=['+ret+']');
        return ret;
    }


    /*
     * This method inserts a new PDE_Case_Entry__c and returns PDE_Case_Entry__c Id and PDE_Case_Entry__c Number back to Helper method
     */
    @AuraEnabled
    public static String savePDECaseEntry(PDE_Case_Entry__c newpdecaseentry) {
        String ret = 'error';
        Integer minAttachments = 1;
        if (newpdecaseentry.PDE_Source_Document__c=='Receiving Report – Goods and Services (no attachments)' ||
            newpdecaseentry.PDE_Source_Document__c=='Commitment')
        {
            minAttachments = 0;
        }
        Integer errorCnt = 0;
        if (newpdecaseentry.PDE_Attachments_To_Load_Counter__c < minAttachments)
        {            
            ++errorCnt;
            ret += ';You only uploaded '+String.valueOf(newpdecaseentry.PDE_Attachments_To_Load_Counter__c)+' of '+String.valueOf(minAttachments)+' required attachments.';
        }
        if (newpdecaseentry.PDE_Region__c==null || newpdecaseentry.PDE_Region__c==''){
            ++errorCnt;
            ret += ';You did not enter a region.';
        }
        String s = newpdecaseentry.PDE_PDN__c;
        if (!(s==null||s==''||Pattern.matches('^(1B|AE|AR|CL|CT|D7|EJ|EK|EN|EP|EQ|GP|IX|PJ|PN|PR|PS|PX|RA|RB|RO|RQ|RR|RT|RW)\\w{0,14}$', s.toUpperCase()))){
            ++errorCnt;
            ret += ';PDN must be blank or start with the correct prefex and be at most 16 characters';
        }
        if (errorCnt==0) {
            //adding 1 to the counter to prevent the trigger from firing before team members are added
            if (newpdecaseentry.PDE_Attachments_To_Load_Counter__c==null)
            {
                newpdecaseentry.PDE_Attachments_To_Load_Counter__c = 0;
            }
            newpdecaseentry.PDE_Attachments_To_Load_Counter__c += 1;
            insert newpdecaseentry;
            // return newpdecaseentry.Id + ';' + newpdecaseentry.Name;
            String pdeCaseEntryId = newpdecaseentry.Id;
            system.debug('savePDECaseEntry:PDECaseEntry ID: ' + pdeCaseEntryId);
            pdeCaseEntryId = pdeCaseEntryId.substring(0, pdeCaseEntryId.length()-3);
            newpdecaseentry = [SELECT PDE_Team_Members__c, Id, Name, PDE_Case__r.CaseNumber FROM PDE_Case_Entry__c WHERE Id = :pdeCaseEntryId LIMIT 1][0];
            
            system.debug('savePDECaseEntry:PDE_Team_Members__c='+newpdecaseentry.PDE_Team_Members__c);
 
             Integer teamMemberCnt = 0;
           
            if (newpdecaseentry.PDE_Team_Members__c!=null)
            {
                system.debug('savePDECaseEntry:PDE_Team_Members__c exists');
                List<String> teamMembers = newpdecaseentry.PDE_Team_Members__c.split('\\|');
                for (String teamMember : teamMembers){
                    system.debug('savePDECaseEntry:teamMember=['+teamMember+']');
                    if (teamMember.length()>0){
                        ++teamMemberCnt;
                        createPDECaseTeamEntry(pdeCaseEntryId, teamMember);                    
                    }
                }
            }
            //OK, unhack the attachment counter now that team members are added
            newpdecaseentry = [select id, PDE_Attachments_To_Load_Counter__c, PDE_Case__r.CaseNumber FROM PDE_Case_Entry__c WHERE Id = :newpdecaseentry.id LIMIT 1 for update];
            newpdecaseentry.PDE_Attachments_To_Load_Counter__c -= 1;
            update newpdecaseentry;
            if (newpdecaseentry.PDE_Attachments_To_Load_Counter__c == 0){
                newpdecaseentry = [select id, PDE_Attachments_To_Load_Counter__c, PDE_Case__r.CaseNumber FROM PDE_Case_Entry__c WHERE Id = :newpdecaseentry.id LIMIT 1];            
            }
            ret = 
                'success;' + 
                newpdecaseentry.Id + ';' + 
                pdeCaseEntryId + ';' + 
                (newpdecaseentry.PDE_Case__r==null?'':newpdecaseentry.PDE_Case__r.CaseNumber) + ';' + 
                String.valueOf(teamMemberCnt) + ';' + 
                String.valueOf(newpdecaseentry.PDE_Attachments_To_Load_Counter__c );
        }
        system.debug('savePDECaseEntry ret=['+ret+']');
        return ret;
    }

    @AuraEnabled
    /*
     * This method add a PDE_Case_Team_Entry__c to the new created PDE_Case_Entry__c record
     */
    public Static void createPDECaseTeamEntry(String parentId, String userName) {
        
        system.debug('createPDECaseTeamEntry:userName=['+userName+']');
        String userNameSplit = userName.split(';')[0];
        
        Id userId = [SELECT Id FROM User WHERE Id = :userNameSplit LIMIT 1].id;
        //Id userId = [SELECT Id FROM User WHERE Name = :userNameSplit LIMIT 1].id;
        
        Id caseTeamRoleId= [SELECT Id FROM CaseTeamRole WHERE Name = 'PDE CC Recipient' LIMIT 1].id;
        List<PDE_Case_Team_Entry__c> pdecatmList=new List<PDE_Case_Team_Entry__c>();
        
        PDE_Case_Team_Entry__c tm = new PDE_Case_Team_Entry__c();
        tm.PDE_Case_Entry__c=parentId;
        tm.PDE_Case_Team_Member__c=userId;
        tm.PDE_Case_Team_Member_Role__c=caseTeamRoleId;
        pdecatmList.add(tm);
        
        if(!pdecatmList.isEmpty()){
            Upsert pdecatmList;
        }
    }
}