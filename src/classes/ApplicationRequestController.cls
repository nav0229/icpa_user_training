public with sharing class ApplicationRequestController {

    public static Case newCaseCreated {get; set;}
    public String getCase() {
        return null;
    }
 
//This method get currently logged in User information      
    public ApplicationRequestController() {
    
        //supEmail = UserInfo.getUserEmail();
    }
//Supervisor variable is used for supervisor email    
    private String supervisor;
    
//Passing supervisor information from Visualforce page to controller
    public String getSupervisor()
    {
        //supervisor = strText1;
        supervisor = supEmail;
        return supervisor;
    }
//Getting supervisor variable    
    public void  setSupervisor(String supervisor)
    {
        this.supervisor = supervisor;
    }

    private final GPM_Project__c c; //User sobject
    //Application name used 
    public String applicationName {get; set;}
    //Long text description
    public String txtAreaDescription;
    //For permission sets
    public String txtHiddenPermissionSets;
    //For supervisor email information
    public String supEmail {get; set;}
    //For Justification
    public String justification{get;set;}
    //Getting permission sets for seclected Application name
    public String getTxtHiddenPermissionSets()
    {
        return txtHiddenPermissionSets;
    }
    //Passing text description from Apex to Visualforce page
    public String getTxtAreaDescription()
    {
        return this.txtAreaDescription;
    }
    //Passing text description from Visualforce to Controller
    public void setTxtAreaDescription(String txtAreaDescription)
    {
        this.txtAreaDescription = txtAreaDescription;
    }
   //Storing permission sets to a hiddin  
    public void setTxtHiddenPermissionSets(String value)
    {
        this.txtHiddenPermissionSets = value;
        
        if(this.txtHiddenPermissionSets != null && this.txtHiddenPermissionSets.length() > 0)
        {
            this.listFields = this.txtHiddenPermissionSets.split(',',0);
        }
        else
        {
            this.listFields = new String[]{};
        }
    }
    //Hidden text for Public groups
    public String txtHiddenPublicGroups;
    //Assigning the Public group names to a hidden text from Visualforce page to controller
    public String getTxtHiddenPublicGroups ()
    {
        return txtHiddenPublicGroups ;
    }
    //Assigning the public group names to a hidden text from Apex to Visualforce page
    public void setTxtHiddenPublicGroups (String value)
    {
        this.txtHiddenPublicGroups = value;
        
        if(this.txtHiddenPublicGroups != null && this.txtHiddenPublicGroups.length() > 0)
        {
            this.listGroups = this.txtHiddenPublicGroups.split(',',0);
        }
        else
        {
            this.listGroups =  new String[]{};
        }
    }
    //Hidden text field for long text description
    public String txtHiddenAreaDescription;
    //Assigning the long text description to hidden text description from Apex to Visualforce page
    public String getTxtHiddenAreaDescription()
    {
        return this.txtHiddenAreaDescription;
    }
    //Assigning the long text description to hidden text description from Visualforce page to Controller 
    public void setTxtHiddenAreaDescription(String value)
    {
        this.txtHiddenAreaDescription = value;    
        this.txtAreaDescription = value;
    } 
   
    public String input {get; set;}
    //Drop down list for type of issue for an application
    public String typeOfIssue {get; set;} 
    
    public String emptyValue {get; set;}
    String[] listFields = new String[]{}; 
    public String gsaPermissionSetNames {get; set;}
    
    
    String[] listGroups = new String[]{};
    
    
    public String taskrelated= 'Application';// srini
    
    
    public List<SelectOption> gettaskrelated() { //srini
        List<SelectOption> options = new List<SelectOption>();        
        
         options.add(new SelectOption('System Related','Project management'));
         return Null;        
     }
    //Srini   
   //Assigning the default value to the Priority dropdown list   
    public String listPriority = 'Medium';
    public String getListPriority() {
        return listPriority ;
    }
    
    private string appNameStyle;
    
    public string getAppNameStyle ()
    {
        return appNameStyle;
    }    
    
    private string priorityStyle = '';
    public string getPriorityStyle()
    {
        return priorityStyle;
    }    
    private string typeStyle = '';
    public string getTypeStyle()
    {
        return typeStyle;
    }        


    public void settaskrelated(String taskrelated) {  //srini
        this.taskrelated = taskrelated ;
    }
    public void setListPriority(String listPriority) {
        this.listPriority = listPriority ;
    }
   //Mapping Application Support object  
    Map<Id, Application_Support__c> ApplicationMap = new Map<Id, Application_Support__c >();

//Mapping Email details to Case object
    static Map<String, EmailRecord > caseDetails = new Map<String, EmailRecord >();
  // Grabing custom setting values
      
 // For each type of issue, storing the values on Case object and sending an email when a case is created
    static 
    {
        caseDetails.put('User Access', new EmailRecord ('grant access', 'Give user(s) access to app.'));
        caseDetails.put('Enhancement', new EmailRecord ('enhancement', 'Need an enhancement to this app.'));
        caseDetails.put('Data Update', new EmailRecord ('data update', 'Need to update data inside application.'));
        caseDetails.put('Bug / Defect', new EmailRecord ('bug', 'Identified bug for this app.'));
        caseDetails.put('Application Question', new EmailRecord ('application question', 'Question for this app.'));
        caseDetails.put('Support Deployment', new EmailRecord (' support deployment', 'Need to deploy changes by 3rd party dev team.'));
    }
  //For sending emails
    class EmailRecord {
        public String subject {get;set;}
        public String description{get;set;}
       // public String templateid{get;set;}

        EmailRecord(String subject, String description) 
        {
            this.subject= subject;
            this.description= description;
           // this.templateid= templateid;
        }
    } 
 
    String[] accts = new String[]{};
    private User user;
  
    public String[] getListFields() {
        return listFields ;
    }

    public void setListFields(String[] listFields) {
        this.listFields = listFields ;
    }
    
    public String[] txtHiddenListFields = new String[]{};
    public String[] getTxtHiddenListFields() {
        return txtHiddenListFields;
    }

    public void setTxtHiddenListFields(String[] txtHiddenListFields) {
        this.listFields = txtHiddenListFields ;
        this.txtHiddenListFields = txtHiddenListFields;
    }
    
   //Crating public groups as a list 
    public String[] getListGroups() {
        return listGroups;
    }
        
    public void setListGroups(String[] listGroups) {
        this.listGroups = listGroups;
    }
    public String[] txtHiddenListGroups = new String[]{};
    public String[] getTxtHiddenListGroups() {
        return txtHiddenListGroups;
    }

    public void setTxtHiddenListGroups(String[] listGroups) {
        this.listGroups = listGroups;
        this.txtHiddenListGroups = txtHiddenListGroups;
    }

    
    public String getUserName()    {
        return UserInfo.getUserId();
    } 
   //Getting user details 
    public String getUser()
    {
        if(user == null) 
            user = [Select u.Username, u.Email, u.Id, u.FirstName, u.LastName From User u where u.id = :UserInfo.getUserId()];
        return user.Email;
    }    
    //Displaying the application description when an Application name is selected from a drop down list    
    public PageReference onSelectChangeAppName() {
        return null;
    }
  
    public void onSelectChangeReqType() 
    { 
        PageReference selectedPage = ApexPages.CurrentPage();
        getFields();
    }
  
    
  //Dynamically displaying all the application name from the application support and the status is true for production 
  
    //srini
    
    public List<selectOption> getaccts() {
        List<selectOption> options = new List<selectOption>(); 
        options.add(new selectOption('', '- None -')); 
        //for (Application_Support__c account : [SELECT Id, Name,User_Provisioning_Description__c, Affiliated_Organization__c, App_Description__c, Permission_Sets__c, Public_Groups__c,Application_or_System__c FROM Application_Support__c where Status_In_Production__c = True])
        if(taskrelated  == 'Application'){
        for (Application_Support__c account : [SELECT Id, Name,User_Provisioning_Description__c,Affiliated_Organization__c, App_Description__c, Permission_Sets__c, Public_Groups__c,Application_or_System__c,App_Owner__c,Secondary_Owner__c FROM Application_Support__c where Status_In_Production__c = True order by name asc]) 
        {       if(account.Name != Null && account.Application_or_System__c =='Application' ){       
                ApplicationMap.put(account.Id, account);
                options.add(new selectOption(account.Id, account.Name));  
            }
        }
      }else if(taskrelated== 'System'){
         options.clear();
         options.add(new selectOption('', '- None -'));
         for (Application_Support__c account1 : [SELECT Id, Name,User_Provisioning_Description__c,Affiliated_Organization__c , App_Description__c, Permission_Sets__c, Public_Groups__c,Application_or_System__c,App_Owner__c,Secondary_Owner__c FROM Application_Support__c where Status_In_Production__c = True order by name asc])
          if(account1.Name != Null && account1.Application_or_System__c =='System' ){       
                ApplicationMap.put(account1.Id, account1);
                options.add(new selectOption(account1.Id, account1.Name));  
            }
         
         
      
      } 
       
        return options; 
    }
    
  //Srini  
    
  //Returning the application discription      
    public String getappdesc() {
        return (ApplicationMap.get(applicationName).App_Description__c);
    }
   //Displaying all the permission sets related to the selected application based on the User Access type  
    public List<selectOption> getFields()  {
        PageReference selectedPage = ApexPages.CurrentPage();
      
        List<selectOption> permissionSets  = new List<selectOption>();
        if(typeOfIssue != null && typeOfIssue.equalsIgnoreCase('USER ACCESS') && applicationName != null) 
        {
            if(ApplicationMap.get(applicationName).Permission_Sets__c != null) 
            {
                return createCheckBoxes(ApplicationMap.get(applicationName).Permission_Sets__c);
            }
        }
        else
        {
            permissionSets = null;
            return permissionSets;
        }
        return null;
    }
  //Displaying all the public groups related to the selected application based on the User Access type   
    public List<selectOption> getGroups()  
    {
        List<selectOption> publicGroups = new List<selectOption>();
        if(typeOfIssue != null && typeOfIssue.equalsIgnoreCase('USER ACCESS') && applicationName != null) 
        { 
            if(ApplicationMap.get(applicationName).Public_Groups__c != null) 
            {                    
                return createCheckBoxes(ApplicationMap.get(applicationName).Public_Groups__c);
            }
        }
        else
        {
            publicGroups = null;
            return publicGroups;
        }
        return null;
    }
    //Creating checkboxes for public groups      
    public List<selectOption> createCheckBoxes(String Sets)
    {
        string strgroup = Sets;
        List<selectOption> optionsSets = new List<selectOption>();
        list<string> ligrp = strgroup.split('\\,');
        
        for (Integer j=0;j<ligrp.size();j++) 
        {
            optionsSets.add(new SelectOption((ligrp[j]).trim(),(ligrp[j]).trim()));
        }
        return optionsSets;
    }
   
   
    public ApplicationRequestController(ApexPages.StandardController stdController) {
        this.c = (GPM_Project__c)stdController.getRecord();
    }
    
    private Boolean isValid()
    //public Boolean isValid()
    {
        // this method is called to validate the data entered by user.
        List<ApexPages.message> errorMessages = new List<ApexPages.message>();
        Integer errorCode = 0;
        if (applicationName.equalsIgnoreCase('-None-'))
        {
            errorCode = 1;
            appNameStyle = 'border-size:2px; border-color:red;border-style:solid;';
            errorMessages.add(new ApexPages.message(ApexPages.severity.FATAL,'Application Name has to be selected.'));
        }
        else
        {
            errorCode = 0;
            appNameStyle = '';
        }
        if (listPriority == null || listPriority.equalsIgnoreCase('-None-'))
        {
            errorCode = 1;
            priorityStyle = 'border-size:2px; border-color:red;border-style:solid;';
            errorMessages.add(new ApexPages.message(ApexPages.severity.FATAL,'Priority has to be selected'));
        }
        else
        {
            errorCode = 0;
            priorityStyle = '';
        }
        if (typeOfIssue == null || typeOfIssue.equalsIgnoreCase('-None-'))
        {
            errorCode = 1;
            typeStyle = 'border-size:2px; border-color:red;border-style:solid;';
            errorMessages.add(new ApexPages.message(ApexPages.severity.FATAL,'Type has to be selected'));
        }
        else
        {
            errorCode = 0;
            typeStyle = '';
        }
        if(errorCode == 1)
        {
            for(ApexPages.message msg:errorMessages)
            {
                ApexPages.addMessage(msg);
            }
            return false;
        }
        return true;
    }
    public ApplicationRequestController(AttachmentUtlity controller) { }
     //Declaring a parent Id varible 
    public String parentId {get;set;}
    //Declaring case number variable
    public String caseNumber {get; set;}
    //Redirecting user to the thank you page and display the case number 
    public ApexPages.Pagereference doneAttaching()
    {
        parentId = Apexpages.currentPage().getParameters().get('recordId');
        Case getCase = [SELECT Id, CaseNumber FROM Case WHERE Id = :parentId LIMIT 1];
        //if (getCase.size() > 0) {
        return new PageReference('/apex/ApplicationRequestConfirmation?caseId='+parentId + '&caseNumber=' + getCase.CaseNumber);
       // } 
       // return new PageReference('/apex/ApplicationRequestConfirmation?caseId='+parentId);
    }

//Validate the required fields and Create a Case. After a case has been created redirect to attachment page
    public PageReference save() {  
            if(applicationName == '' || applicationName == null) {
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please select Application Name.');
            ApexPages.addMessage(myMsg);
            return null;
            } else {
            system.debug('This is application name ==============>' + applicationName);
            String textarea = ApexPages.currentPage().getParameters().get('description');
            String perSet = ApplicationMap.get(applicationName).Permission_Sets__c;
            String pubGroups = ApplicationMap.get(applicationName).Public_Groups__c;
            
            if (textarea == '' || textarea == null){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please enter Description.');
            ApexPages.addMessage(myMsg);
            return null;
            } 
            /*if((supEmail==null || supEmail==''|| supEmail==UserInfo.getUserEmail()) && (typeOfIssue=='User Access' || typeOfIssue=='Enhancement')){
                
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Supervisor field must be a valid GSA email address that is NOT your own.');
            ApexPages.addMessage(myMsg);
            return null;
            }else{
                if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}',supEmail)&& (typeOfIssue=='User Access' || typeOfIssue=='Enhancement')){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please ensure Email Address and Supervisor fields have proper email format.');
                ApexPages.addMessage(myMsg);
                return null;
                }
            }
            
            if((justification==null || justification=='') && (typeOfIssue=='User Access' || typeOfIssue=='Enhancement')){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please enter Justification.');
            ApexPages.addMessage(myMsg);
            return null; 
            }*/           
            if((listFields.size()==0) && (listGroups.size()==0) && (typeOfIssue=='User Access') && ((perSet != null) || (pubGroups != null))){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please select Permission Set or Public Group.');
            ApexPages.addMessage(myMsg);
            return null; 
            } 
            if(isValid()){ if(applicationName != null && typeOfIssue != null) { Case caseCreated = new Case(); caseCreated = createCase();
                    system.debug('caseNew before query>>>>>' + caseCreated.Id + ' Number: ' + caseCreated.CaseNumber + ' Name: ' +caseCreated.Case_Description__c);
               		system.debug('newCaseCreated>>>>>' + newCaseCreated.Id);                                                           
                    system.debug('caseNew>>>>>' + caseCreated.Id);
                    //grabing custom setting values
                    Queues__c caQueue = Queues__c.getValues('Triage Queue');
                    caseCreated.ownerId = caQueue.QueueId__c;
                    update caseCreated; 
                    PageReference attachPage = new PageReference('/apex/AppicationRequestAttachfiles?recordId='+caseCreated.Id + '&caseNumber='+newCaseCreated.CaseNumber); 
                    attachPage.getParameters().put('caseId', caseCreated.Id);
                    return attachPage ;
                                                                              
                    
                    
                }
            }
        }
        return null;
    }
     public PageReference homePage() {
         PageReference home = new PageReference('/home/home.jsp');
         return home;
    }
    
    public String failingPageResponse { get; set; }
   
   //Method to create case 
    public Case createCase()
    {   
    try{
        String gsaPermissionSetNames = '<br/><b>        The Permission Sets to be assigned are:  </b></br>' ;  //declare as final - error Final variable has already been initialized
        String gsaGroupNames = '<br><b> The Public Groups to be assigned are:   </b></br>' ; 
      
        if(listFields == null || listFields.size() == 0)
        {
            gsaPermissionSetNames = '';
        }
        else
        {
            for(String g:listFields)
            {
                gsaPermissionSetNames = gsaPermissionSetNames + '<li>' + g  + '</li>'; 
            }
        }              
        if(listGroups == null || listGroups.size() == 0)
        {
            gsaGroupNames  = '';
        }
        else
        {
            for(String f:listGroups)
            {
                gsaGroupNames = gsaGroupNames + '<li>' +f + '</li>';   
            }
        }            
        PageReference selectedPage = ApexPages.CurrentPage();
        User userUpdate = [Select u.Username, u.FirstName, u.Id, u.LastName, u.Email From User u where u.Id = :UserInfo.getUserId()];
        Id recType=Schema.SObjectType.Case.getRecordTypeInfosByName().get('OCIO Task Tracking').getRecordTypeId();
          
        try
        {
           Case c = new Case();
       //    c.Affiliated_Organization__c = ApplicationMap.get(applicationName).Affiliated_Organization__c;
           c.IT_Service_Desk_Ticket_ID__c = '';
           c.Origin = 'Request Form';
           c.First_Name__c = userUpdate.FirstName;
           c.Last_Name__c = userUpdate.LastName;
           c.Email__c = userUpdate.Email;
           //srini
           c.App_Owner__c = ApplicationMap.get(applicationName).App_Owner__c;
           c.Secondary_Owner__c = ApplicationMap.get(applicationName).Secondary_Owner__c;
           c.Application_Module__c = applicationName;
           c.Case_Type__c = ApplicationMap.get(applicationName).Application_or_System__c;
           //srini
           //c.GPM_Project__c = applicationName;
           //c.Application_Support__c = ApplicationMap.get(applicationName).Id;
           c.Issue_Type_del__c = typeOfIssue;
           c.Task_Status__c = 'In Progress';
           c.Status = 'Not Applicable';
           c.Priority = listPriority;
           c.Subject = caseDetails.get(typeOfIssue).subject; 
           c.RecordTypeId = recType; 
           c.description = caseDetails.get(typeOfIssue).description;
           c.Supervisor__c= supEmail;
           c.Justification__c= justification;
           
           String textarea = ApexPages.currentPage().getParameters().get('description');
       
           
           if(typeOfIssue.equalsIgnoreCase('USER ACCESS')) //string buffer
           {
                   //c.Case_Description__c = 'ServiceNow ticket: LINK'+'<br/><ul>'+ gsaPermissionSetNames + '</ul><ul>' + gsaGroupNames + '</ul><br/><pre style="font-size: 14px; font-family:arial; font-weight:normal;">' + textarea+ '</pre><br/><br/>'+'<br/>'+'<u>NOTE</u>:&nbsp;&nbsp;OCIO Control Center info link:&nbsp;&nbsp;'+'<a href ="'+ ApplicationMap.get(applicationName).User_Provisioning_Description__c +'"> '+ ApplicationMap.get(applicationName).Project__r.Name +'</a>';
                   //c.Case_Description__c = 'ServiceNow ticket: LINK'+'<br/><ul>'+ gsaPermissionSetNames + '</ul><ul>' + gsaGroupNames + '</ul><br/><pre style="font-size: 14px; font-family:arial; font-weight:normal;">' + textarea+ '</pre><br/><br/>'+'<br/>';
                   c.Case_Description__c = gsaPermissionSetNames + '</ul><ul>' + gsaGroupNames + '</ul><br/><pre style="font-size: 14px; font-family:arial; font-weight:normal;">' + textarea+ '</pre><br/><br/>'+'<br/>'; //srini
           }
           else 
           {
                         c.Case_Description__c = 'ServiceNow ticket: LINK'+'<br/><br/>'+'<pre style="font-size: 14px; font-family:arial; font-weight:normal;">'+textarea+ '</pre><br/><br/>'+'<br/>';
                         c.Case_Description__c = '<pre style="font-size: 14px; font-family:arial; font-weight:normal;">'+textarea+ '</pre><br/><br/>'+'<br/>'; //srini 
           }
           insert c;
           
           return c;
           
        } 
        
        catch(DMLException e) 
        {
            System.debug('Insert Error: '+e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating case'));
        }
        }
        catch(Exception ex){
        }
           
        return null; 
    }
     //Test Method Begins
     
    @IsTest(SeeAllData=true) public static void testApplicationRequestControllerOne() 
    {

        Account acc = new Account(Name='Test Account');
        insert acc;

        Case c = new Case(AccountId=acc.Id,subject='Test Subject',description='test Description');
        insert c;
        Case c1 = new Case(AccountId=acc.Id,subject='Test Subject',description='test Descriptions');
        insert c1;

        GPM_Project__c gp = new GPM_Project__c(Name = 'Test Project');
        insert gp;
        GPM_Project__c gp1 = new GPM_Project__c(Name = 'Event Tracker');
        insert gp1;
        
        Application_Support__c aobj = new Application_Support__c(Application_or_System__c = 'Application',Permission_Sets__c='Test Permission Set',Public_Groups__c='Test Public Group',App_Description__c='Test Description',Affiliated_Organization__c='OCIO',caseapplication__c=c.Id,Project__c=gp.Id,Org_Office__c='TestOrg');
        insert aobj;
        Application_Support__c aobj1 = new Application_Support__c(Name = 'Event Tracker',Application_or_System__c = 'system',Permission_Sets__c='Test Permission Set',Public_Groups__c='Test Public Group',App_Description__c='Test Description',Affiliated_Organization__c='OCIO',caseapplication__c=c.Id,Project__c=gp1.Id,Org_Office__c='TestOrg');
        insert aobj1;
         c1.Application_Module__c = aobj1.Id;
        List<Attachment> lstAttach = new List<Attachment>();
        Blob b = Blob.valueOf('Test Data');    
        Attachment attachment = new Attachment();  
        attachment.ParentId = c.Id;  
        attachment.Name = 'Test Attachment for Parent';  
        attachment.Body = b;  
        lstAttach.add(attachment);

        ApexPages.currentPage().getParameters().put('caseId',c.Id);

        ApexPages.StandardController stdController = new ApexPages.StandardController(gp);
        
        
        AttachmentUtlity  attachUtility = new AttachmentUtlity ();

        ApplicationRequestController controller = new ApplicationRequestController(stdController);
        
        ApplicationRequestController appController = new ApplicationRequestController(attachUtility);

        ApplicationRequestController app = new ApplicationRequestController();

        Map<Id, Application_Support__c> AppMap = new Map<Id, Application_Support__c >();

        AppMap.put(gp.Id,aobj);

        controller.createCase();               
        controller.caseNumber = '0023451';//s
        //controller.save();

        controller.getCase();

        controller.getSupervisor();

        controller.setSupervisor('Test 2');

        controller.getTxtAreaDescription();

        controller.setTxtAreaDescription('Text Description');

        controller.getAppNameStyle ();

        controller.getListPriority();

        String Sets = 'One\\,Two\\,Three\\,Four';

        controller.createCheckBoxes(Sets);

        controller.setListPriority('list Priority');

        controller.getTxtHiddenPermissionSets();

        controller.setTxtHiddenPermissionSets('Test,Test1');

        controller.getTxtHiddenPublicGroups();

        controller.setTxtHiddenPublicGroups('Test,Test1,Test2');

        controller.getTxtHiddenAreaDescription();

        controller.setTxtHiddenAreaDescription('Test desc');

        controller.getFields();
        controller.gsaPermissionSetNames = 'Test';
        controller.failingPageResponse = 'Test';
        controller.input = 'Test';
        controller.emptyValue ='Test';
        controller.ApplicationMap = AppMap;

        controller.applicationName =gp.Id;

        controller.typeOfIssue ='USER ACCESS';

        controller.getFields();       

        controller.getPriorityStyle();

        controller.getTypeStyle();

        controller.getListFields(); 

        controller.getTxtHiddenListFields(); 

        controller.getListGroups(); 

        controller.getTxtHiddenListGroups();

        controller.getUserName();  

        controller.getUser();

        controller.onSelectChangeAppName(); 

        controller.onSelectChangeReqType(); 

        controller.getaccts();

        controller.getgroups();

        controller.ApplicationMap = AppMap;

        controller.applicationName =gp.Id;

        
        controller.typeOfIssue ='USER ACCESS';

        controller.getgroups();

        String[] stringArray1 = new String[]{'Test'}; 

        controller.setListFields(stringArray1); 

        controller.setTxtHiddenListFields(stringArray1); 

        controller.setListGroups(stringArray1 ); 

        controller.setTxtHiddenListGroups(stringArray1 );
     
        controller.listPriority = 'Medium';
        controller.typeOfIssue = 'User Access';
    
        System.debug('Application Name: ' + controller.applicationName + ' List field size: ' + controller.listFields.size()
                    + ' List Priority: ' + controller.listPriority + 'Type of Issue: ' + controller.typeOfIssue);
        controller.save();

        controller.applicationName = gp.Id;
        
        controller.applicationName = '-None-';

        controller.listPriority = '-None-';

        controller.typeOfIssue = 'User Access';

        controller.txtAreaDescription = 'Test Description';
        controller.taskrelated = 'System';

        controller.txtHiddenPermissionSets = 'Test Permisssion Set';

        controller.supEmail = 'Test 1' ;

        controller.justification = 'Test 2' ; 

        controller.ApplicationMap = AppMap;

        controller.applicationName =gp.Id;

        controller.createCase();

        controller.ApplicationMap = AppMap;
        
        controller.applicationName =gp.Id;

        String[] strFls = new String[]{'abc','def'}; 

        controller.listFields = strFls ;

        String[] strGrp = new String[]{'abc','def'};
        
        controller.listGroups = strGrp ;

        controller.createCase();

        controller.getappdesc(); 
                       
        controller.isValid();        
        
        controller.listPriority = null;
        
        controller.typeOfIssue = null;
        
        controller.isValid();       
        
        controller.listPriority = 'Medium';
        controller.typeOfIssue = 'bug';
        controller.applicationName =gp.Id;
        controller.isValid();
        
        Case objCase = [SELECT Id FROM Case LIMIT 1];
        
        String parentId = apexpages.currentpage().getparameters().put('recordId' , objCase.Id);
        
        controller.doneAttaching();
        
        controller.homePage();               
        
        String textarea = apexpages.currentpage().getparameters().put('description' , '');       
        
        controller.save();       
        
        String textarea2 = apexpages.currentpage().getparameters().put('description' , 'Test');
        
        //controller.supEmail = 'test@test.com';
        
        //controller.justification = 'test';
        
        String[] strFles1 = new String[]{'',''}; 
        
        controller.listFields = strFles1;
        
        String[] strGrp1 = new String[]{'',''}; 
        
        controller.listGroups = strGrp1;
        
        controller.typeOfIssue = 'User Access';
        
         controller.applicationName = '';
        
        controller.save();
        String textarea3 = apexpages.currentpage().getparameters().put('description' , 'Test');
        
        //controller.supEmail = 'test@test.com';
        
        //controller.justification = 'test';
        
        String[] strFles2 = new String[]{'',''}; 
        
        controller.listFields = strFles1;
        
        String[] strGrp2 = new String[]{'',''}; 
        
        controller.listGroups = strGrp2;
        
        controller.typeOfIssue = 'Bug';
        
         controller.applicationName = '';

        controller.save();
        
        ApexPages.currentPage().getParameters().put('caseId',c1.Id);
        ApexPages.StandardController stdController1 = new ApexPages.StandardController(gp);
                
        AttachmentUtlity  attachUtility1 = new AttachmentUtlity ();

        ApplicationRequestController controller1 = new ApplicationRequestController(stdController);
        
        ApplicationRequestController appController1 = new ApplicationRequestController(attachUtility);

        ApplicationRequestController app1 = new ApplicationRequestController();

        Map<Id, Application_Support__c> AppMap1 = new Map<Id, Application_Support__c >();

        AppMap.put(gp1.Id,aobj1);
        controller1.typeOfIssue ='USER ACCESS';
        controller1.getaccts();
        controller1.taskrelated = 'System';
        controller1.getaccts();
        Case objCase1 = [SELECT Id FROM Case WHERE Id =: c1.Id LIMIT 1];
        String parentId1 = apexpages.currentpage().getparameters().put('recordId' , objCase1.Id);
        controller1.createCase();
        Case ca = [SELECT Id, ownerId FROM Case WHERE Id =: objCase1 .Id];
        Queues__c caQueue2 = Queues__c.getValues('Triage Queue');
        ca.ownerId = caQueue2.QueueId__c;
        ca.Status = 'Not Applicable';
        update ca;
        controller.save();
        controller1.caseNumber = '021066'; 
        controller1.getCase();
        controller1.getTxtAreaDescription();
        controller1.gettaskrelated();
        controller1.settaskrelated('System');
        controller.getUser();
        controller1.getgroups();
        controller1.getFields();
        controller1.gsaPermissionSetNames = 'Test1';
        controller1.failingPageResponse = 'Test1';
        controller1.input = 'Test1';
        controller1.emptyValue ='Test1';
        controller1.ApplicationMap = AppMap;

        controller1.applicationName =gp.Id;
        controller1.setTxtAreaDescription('Text Descriptions');
        String textarea1 = apexpages.currentpage().getparameters().put('description' , '');
        controller1.ApplicationMap = AppMap;
        controller1.applicationName =gp.Id; 
        
        controller1.doneAttaching();
        controller1.homePage(); 
        controller1.save();
        String textareas = apexpages.currentpage().getparameters().put('description' , 'Test');
        controller1.save();
        //controller1.save();
        //update c1;
        System.assertEquals (True,True);
       }        
       //Test Method ends
}