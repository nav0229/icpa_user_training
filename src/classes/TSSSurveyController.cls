/*-------------------------------------------------------------------------------------------------*
  Apex class for TSSSurveyWizard1, TSSSurveyWizard2, TSSSurveyThankyou pages - survey functionality
  TSS Action Planning application
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          05/19/2015    1.1       Survey form - created.
  Rajakumar          08/05/2015    1.2       O&M Case# -20045 for adding agencies/bureaus
                                             O&M Case# -20093 for adding states PR and VI
                                             O&M Case# -20121 for adding states GU, MP, AS, PR, VI
  Rajakumar          08/10/2015    1.3       O&M Case# - 20080, 200162, 20155 - adding agencies/bureaus
  Rajakumar          08/12/2015    1.4       O&M Case# -20203 for adding a bureau under the agency
  Rajakumar          08/14/2015    1.5       O&M Case# -20250 for adding a bureau under the agency
  Rajakumar          08/18/2015    1.6       O&M Case# -20277 for adding bureaus for agencies
  Rajakumar          08/20/2015    1.7       O&M Case# -20309 for adding bureaus for agencies
  Rajakumar          08/27/2015    1.8       O&M Case# -20435 for adding bureaus for agencies
  Rajakumar          09/08/2015    1.9       0&M Case# -20550 for adding agencies and bureaus
  TCarlough          04/20/2016    1.10      Update UI
  Ramesh Dugar       05/10/2016    1.11      Updated controller to add labels for TSS WizardPage2 radio buttons
  Brad Smith         05/18/2016    1.12      Modified lines 151-172 for prevention of survey resubmission
  Brad Smith         05/18/2016    1.13      Modified save() method to support anonymous submission of surveys
  Ramesh Dugar       05/24/2016    1.14      Added  variables and modfied code to implement building not listed option
  Raja Kumar P       07/21/2016    1.15      Case# 26791 - add bureau 'National Endowment for the Arts' 
  
 *-------------------------------------------------------------------------------------------------*

 *-------------------------------------------------------------------------------------------------*/

public with sharing class TSSSurveyController {
    public String cId { get; set; }
    public Boolean contactfound { get { if (contactfound == null) contactfound = false; return contactfound; } set; }
    public Boolean surveyfound { get { if (surveyfound == null) surveyfound = false; return surveyfound; } set; }
    public Boolean Flag{get;set;}
    public String contact { get; set; }
    public String agency { get; set; }
    public String bureau { get; set; }
    public String state { get; set; }
    public String city { get; set; }
    public String virtbuilding { get; set;}
    public String building { get; set; }
    public String telework { get; set; }
    public List<SelectOption> teleworktype { get; set; }
    public String cleancat1 { get; set; }
    public String cleancat2 { get; set; }
    public String cleancat3 { get; set; }
    public String cleancat4 { get; set; }
    public String condcat1 { get; set; }
    public String condcat2 { get; set; }
    public String condcat3 { get; set; }
    public String condcat4 { get; set; }
    public String workcat1 { get; set; }
    public String workcat2 { get; set; }
    public String workcat3 { get; set; }
    public String workcat4 { get; set; }
    public String comments { get; set; }
    public String elevator { get; set; }
    public String overallsat { get; set; }
    public String bldgmgmt1 { get; set; }
    public String bldgmgmt2 { get; set; }
    public String security { get; set; }
    Public List<String> osratingslabel { get; set;}//adding label for 508 compliance
    //New value for new question 4/15/2016
    public String securityPersonnel { get; set; }
    public String wkspacetype { get; set; }
    public String meetspace { get; set; }
    //New value for building not listed 5/24/16 -Ramesh
    public String bldngntlisted {get; set;}
    public String bldngntlistedvalue {get; set;}
    public List<SelectOption> ratings { get; set; }
    public List<SelectOption> blankratings { get; set; }
    public List<SelectOption> osratings { get; set; }
    public List<SelectOption> naratings { get; set; }
    public List<SelectOption> namobratings { get; set; }
    public List<SelectOption> wsratings { get; set; }
    public List<SelectOption> wsmobratings { get; set; }
    public List<SelectOption> bmratings { get; set; }
    public List<SelectOption> bmmobratings { get; set; }
    //public String selectedValues { get; set; }
    public List<TSS_Survey__c> exsurveys { get; set;}
    public TSS_Survey__c survey { get; set;}
    public List<TSS_Response__c> responses {get; set; }



    // constructor of the controller for initial variables pre populated
    public TSSSurveyController() {

        flag=false;
        bldngntlistedvalue = 'no match';
        teleworktype = new List<SelectOption>();
        teleworktype.add(new SelectOption('--Select--','--Select--'));
        teleworktype.add(new SelectOption('No','No'));
        teleworktype.add(new SelectOption('Yes','Yes'));
        bmratings = new List<SelectOption>();
        bmratings.add(new SelectOption('0','No'));
        bmratings.add(new SelectOption('1','Yes'));
        bmmobratings = new List<SelectOption>();
        bmmobratings.add(new SelectOption('0', ' - Please Select An Option - '));
        bmmobratings.add(new SelectOption('0','No'));
        bmmobratings.add(new SelectOption('1','Yes'));
        blankratings = new List<SelectOption>();
        blankratings.add(new SelectOption('1', 'Highly Dissatisfied'));
        blankratings.add(new SelectOption('2', 'Dissatisfied'));
        blankratings.add(new SelectOption('3', 'Neutral'));
        blankratings.add(new SelectOption('4', 'Satisfied'));
        blankratings.add(new SelectOption('5', 'Highly Satisfied'));
        blankratings.add(new SelectOption('0','Not Applicable'));
        ratings = new List<SelectOption>();
        ratings.add(new SelectOption('0', ' - Please Select An Option - '));
        ratings.add(new SelectOption('1', 'Highly Dissatisfied'));
        ratings.add(new SelectOption('2', 'Dissatisfied'));
        ratings.add(new SelectOption('3', 'Neutral'));
        ratings.add(new SelectOption('4', 'Satisfied'));
        ratings.add(new SelectOption('5', 'Highly Satisfied'));
        ratings.add(new SelectOption('0', 'Cannot Rate'));
        osratings = new List<SelectOption>();
        osratings.add(new SelectOption('1', 'Highly Dissatisfied'));
        osratings.add(new SelectOption('2', 'Dissatisfied'));
        osratings.add(new SelectOption('3', 'Neutral'));
        osratings.add(new SelectOption('4', 'Satisfied'));
        osratings.add(new SelectOption('5', 'Highly Satisfied'));
        osratingslabel = new List<String>{'Highly Dissatisfied','Dissatisfied','Neutral','Satisfied','Highly Satisfied'};

        naratings = new List<SelectOption>();
        naratings.add(new SelectOption('1', 'Highly Dissatisfied'));
        naratings.add(new SelectOption('2', 'Dissatisfied'));
        naratings.add(new SelectOption('3', 'Neutral'));
        naratings.add(new SelectOption('4', 'Satisfied'));
        naratings.add(new SelectOption('5', 'Highly Satisfied'));
        naratings.add(new SelectOption('0', 'Not Applicable'));
        namobratings = new List<SelectOption>();
        namobratings.add(new SelectOption('0', ' - Please Select An Option - '));
        namobratings.add(new SelectOption('1', 'Highly Dissatisfied'));
        namobratings.add(new SelectOption('2', 'Dissatisfied'));
        namobratings.add(new SelectOption('3', 'Neutral'));
        namobratings.add(new SelectOption('4', 'Satisfied'));
        namobratings.add(new SelectOption('5', 'Highly Satisfied'));
        namobratings.add(new SelectOption('0', 'Not Applicable'));
        wsratings = new List<SelectOption>();
        wsratings.add(new SelectOption('An enclosed single-person office','An enclosed single-person office'));
        wsratings.add(new SelectOption('An enclosed multi-person office','An enclosed multi-person office'));
        wsratings.add(new SelectOption('A workstation with partitions that most people cannot see over when standing','A workstation with partitions that most people cannot see over when standing'));
        wsratings.add(new SelectOption('A workstation with partitions that most people cannot see over when seated','A workstation with partitions that most people cannot see over when seated'));
        wsratings.add(new SelectOption('A workstation with partitions that most people can see over when seated','A workstation with partitions that most people can see over when seated'));
        wsratings.add(new SelectOption('Open workspace with no partitions','Open workspace with no partitions'));
        wsratings.add(new SelectOption('I don’t have an assigned workspace','I don’t have an assigned workspace'));
        wsratings.add(new SelectOption('Other','Other'));
        wsmobratings = new List<SelectOption>();
        wsmobratings.add(new SelectOption('',' - Please Select An Option - '));
        wsmobratings.add(new SelectOption('An enclosed single-person office','An enclosed single-person office'));
        wsmobratings.add(new SelectOption('An enclosed multi-person office','An enclosed multi-person office'));
        wsmobratings.add(new SelectOption('A workstation with partitions that most people cannot see over when standing','A workstation with partitions that most people cannot see over when standing'));
        wsmobratings.add(new SelectOption('A workstation with partitions that most people cannot see over when seated','A workstation with partitions that most people cannot see over when seated'));
        wsmobratings.add(new SelectOption('A workstation with partitions that most people can see over when seated','A workstation with partitions that most people can see over when seated'));
        wsmobratings.add(new SelectOption('Open workspace with no partitions','Open workspace with no partitions'));
        wsmobratings.add(new SelectOption('I don’t have an assigned workspace','I don’t have an assigned workspace'));
        wsmobratings.add(new SelectOption('Other','Other'));

        //next 22 lines modified by Brad Smith
        //gets the possible contact ID from the URL
        cId = ApexPages.currentPage().getParameters().get('id');

        List<Contact> contacts = new List<Contact>();
        List<TSS_Survey__c> surveyRecords = new List<TSS_Survey__c>();

        virtbuilding = [SELECT Id, Name
                        FROM TSS_Result_Action_Plan__c
                        WHERE Fiscal_Year__c = 'FY16' AND Location_Code_Plus__c ='VIRTUAL16' LIMIT 1].Id;

        //detects valid contact ID from Survey URL ID parameter
        if(cId != null) {
            contacts = [SELECT Id, FirstName FROM Contact WHERE Id =:cId];
        }
        if(contacts.size() > 0){
            contactfound = true;

            //now that we know that a contact record exists for the id parameter, it detects if any contacts found for this ID has an existing TSS Survey reponse record
            surveyRecords = [SELECT Name FROM TSS_Survey__c WHERE Contact__c =:cId and FY__c = 'FY16' ];
            if(surveyRecords.size() > 0){
                surveyfound = true;
            }
        }

        survey = new TSS_Survey__c();
        responses = new List<TSS_Response__c>();
        exsurveys = new List<TSS_Survey__c>();
    }

    //Code to detect Mobile
    public boolean isMobile {get;set;}
    public String contactID {get;set;}


    public void ServerSideDeviceDetection() {
        String originalURL = ApexPages.currentPage().getUrl();
        contactID = originalURL.right(15);
        System.debug('Orig URL: '+originalURL);
        system.debug('ID: '+contactID);

        String userAgent =
            System.currentPageReference().getHeaders().get('User-Agent');
            system.debug(userAgent);
        if (userAgent.contains('iPhone') || userAgent.contains('Android') || userAgent.contains('BB9')
            || userAgent.contains('BB10') || userAgent.contains('Playbook') || userAgent.contains('Nokia')) {
            isMobile = TRUE;
        }
        else
            isMobile = FALSE;
    }

    /*Commented out by Ramesh Dugar 5/28/2016
    public PageReference detectDevice(){

        String strurl = ApexPages.currentPage().getUrl();
        String strurl2 = strurl.split('apex/')[1];
        String currentPageName = strurl2.split('Page2')[0];
        System.debug('**: '+currentPageName);
        system.debug('URL: '+strurl);
        ServerSideDeviceDetection();
        if (isMobile && currentPageName != 'TSSSurveyWizardMobile' && currentPageName != 'tsssurveywizardmobilepage2') {
             //Pagereference p = new Pagereference('/apex/TSSSurveyWizardMobilePage2?contactID='+cID);
             //building='+building+'&telework='+telework+'&city='+city+'&state='+state+'&agency='+agency+'&bureau='+bureau+'&cId='+cId);
             //return p.setRedirect(true);
             return Page.TSSSurveyWizardMobilePage2;

        }
        else {
            return null;
        }
    }*/


    // for states picklist values display
    public List<SelectOption> getStates() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--Select State--'));
        options.add(new SelectOption('AL','AL'));
        options.add(new SelectOption('AK','AK'));
        options.add(new SelectOption('AZ','AZ'));
        options.add(new SelectOption('AR','AR'));
        options.add(new SelectOption('CA','CA'));
        options.add(new SelectOption('CO','CO'));
        options.add(new SelectOption('CT','CT'));
        options.add(new SelectOption('DE','DE'));
        options.add(new SelectOption('DC','DC'));
        options.add(new SelectOption('FL','FL'));
        options.add(new SelectOption('GA','GA'));
        options.add(new SelectOption('HI','HI'));
        options.add(new SelectOption('ID','ID'));
        options.add(new SelectOption('IL','IL'));
        options.add(new SelectOption('IN','IN'));
        options.add(new SelectOption('IA','IA'));
        options.add(new SelectOption('KS','KS'));
        options.add(new SelectOption('KY','KY'));
        options.add(new SelectOption('LA','LA'));
        options.add(new SelectOption('ME','ME'));
        options.add(new SelectOption('MD','MD'));
        options.add(new SelectOption('MA','MA'));
        options.add(new SelectOption('MI','MI'));
        options.add(new SelectOption('MN','MN'));
        options.add(new SelectOption('MS','MS'));
        options.add(new SelectOption('MO','MO'));
        options.add(new SelectOption('MT','MT'));
        options.add(new SelectOption('NE','NE'));
        options.add(new SelectOption('NV','NV'));
        options.add(new SelectOption('NH','NH'));
        options.add(new SelectOption('NJ','NJ'));
        options.add(new SelectOption('NM','NM'));
        options.add(new SelectOption('NY','NY'));
        options.add(new SelectOption('NC','NC'));
        options.add(new SelectOption('ND','ND'));
        options.add(new SelectOption('OH','OH'));
        options.add(new SelectOption('OK','OK'));
        options.add(new SelectOption('OR','OR'));
        options.add(new SelectOption('PA','PA'));
        options.add(new SelectOption('PR','PR'));
        options.add(new SelectOption('RI','RI'));
        options.add(new SelectOption('SC','SC'));
        options.add(new SelectOption('SD','SD'));
        options.add(new SelectOption('TN','TN'));
        options.add(new SelectOption('TX','TX'));
        options.add(new SelectOption('UT','UT'));
        options.add(new SelectOption('VT','VT'));
        options.add(new SelectOption('VI','VI'));
        options.add(new SelectOption('VA','VA'));
        options.add(new SelectOption('WA','WA'));
        options.add(new SelectOption('WV','WV'));
        options.add(new SelectOption('WI','WI'));
        options.add(new SelectOption('WY','WY'));
        options.add(new SelectOption('GU','GU'));
        options.add(new SelectOption('MP','MP'));
        options.add(new SelectOption('AS','AS'));
        options.sort();
        return options;
        //return null;
    }

    // for city picklist values based on the state picklist selection
    public List<SelectOption> cities {
        get {
            List<SelectOption> options = new List<SelectOption>();
            if(state != null) {
                List<TSS_Result_Action_Plan__c> buildextract = new List<TSS_Result_Action_Plan__c>();
                buildextract = [SELECT Id, City__c
                                  FROM TSS_Result_Action_Plan__c
                                 WHERE Fiscal_Year__c='FY16' AND State__c = :state
                                   AND Location_Code_Plus__c !='VIRTUAL16'];
                Map<String,String> citymap = new Map<String, String>();
                List<String> cities = new List<String>();
                if(!buildextract.isEmpty()) {
                    for(TSS_Result_Action_Plan__c t: buildextract) {
                        String cityUpper = String.valueOf(t.City__c).toUpperCase();
                        if(!citymap.containskey(cityUpper))
                            citymap.put(cityUpper, cityUpper);
                    }
                    cities = citymap.values();
                    cities.sort();
                    options.add(new selectoption('', '--Select City--'));
                    for(String s: cities) {
                        options.add(new SelectOption(s, s));
                    }
                }
            }
            return options;
        }
        set;
    }

    // for building picklist based on the state picklist value selection
    public List<SelectOption> buildings {
        get {
            List<SelectOption> options = new List<SelectOption>();
            List<TSS_Result_Action_Plan__c> buildextract = new List<TSS_Result_Action_Plan__c>();
            TSS_Result_Action_Plan__c buildnotlisted = new TSS_Result_Action_Plan__c();
            buildnotlisted = [SELECT Id, Building_Name__c, Building_Address__c
                            FROM TSS_Result_Action_Plan__c
                           WHERE Fiscal_Year__c ='FY16' AND Location_Code_Plus__c ='BuildingNotListed16' Limit 1];
                           

            if(city!=null) {
                buildextract = [SELECT Id, Building_Name__c, Building_Address__c
                            FROM TSS_Result_Action_Plan__c
                           WHERE Fiscal_Year__c ='FY16' AND Location_Code_Plus__c !='VIRTUAL16'
                             AND State__c = :state AND City__c = :city ORDER BY Building_Address__c];
                System.debug('extract:'+buildextract.size());
                if(buildextract.size()>0) {
                    options.add(new selectoption('', '--Select Building--'));
                    for(TSS_Result_Action_Plan__c s: buildextract) {
                        String bname = (s.Building_Name__c == null) ? null : String.valueOf(s.Building_Name__c);
                        system.debug('building name'+bname);
                        String baddress = (s.Building_Address__c == null) ? null: String.valueOf(s.Building_Address__c);
                        if(bname != null && baddress!= null && (!bname.equals(baddress)))
                            options.add(new SelectOption(s.Id, baddress + ' ~ ' +bname));
                        else if (bname != null)
                            options.add(new SelectOption(s.Id, bname));
                        else
                            options.add(new SelectOption(s.Id, baddress));

                    }
                    //options.sort();
                            options.add(new SelectOption(buildnotlisted.Id,'Building Not Listed'));
                            bldngntlistedvalue = buildnotlisted.Id;
                }
            }
            system.debug('building'+options);
            return options;

        }
        set;
    }

    // for agency picklist values
    public List<SelectOption> getAgencies() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--Select Agency--'));
        options.add(new SelectOption('UNITED STATES CONGRESS','UNITED STATES CONGRESS'));
        options.add(new SelectOption('ARCHITECT OF THE CAPITOL','ARCHITECT OF THE CAPITOL'));
        options.add(new SelectOption('U.S. CAPITOL','U.S. CAPITOL'));
        options.add(new SelectOption('SUPREME COURT','SUPREME COURT'));
        options.add(new SelectOption('LIBRARY OF CONGRESS','LIBRARY OF CONGRESS'));
        options.add(new SelectOption('GOVERNMENT PRINTING OFFICE','GOVERNMENT PRINTING OFFICE'));
        options.add(new SelectOption('GOVERNMENT ACCOUNTABILITY OFFICE','GOVERNMENT ACCOUNTABILITY OFFICE'));
        options.add(new SelectOption('GENERAL ACCOUNTING OFFICE','GENERAL ACCOUNTING OFFICE'));
        options.add(new SelectOption('LEGISLATIVE BRANCH','LEGISLATIVE BRANCH'));
        options.add(new SelectOption('U.S. COURTS/ JUDICIARY','U.S. COURTS/ JUDICIARY'));
        options.add(new SelectOption('EXECUTIVE OFFICE OF THE PRESIDENT','EXECUTIVE OFFICE OF THE PRESIDENT'));
        options.add(new SelectOption('THE WHITE HOUSE OFFICE','THE WHITE HOUSE OFFICE'));
        options.add(new SelectOption('PEACE CORPS','PEACE CORPS'));
        options.add(new SelectOption('DEPARTMENT OF AGRICULTURE','DEPARTMENT OF AGRICULTURE'));
        options.add(new SelectOption('DEPARTMENT OF COMMERCE','DEPARTMENT OF COMMERCE'));
        options.add(new SelectOption('DEPARTMENT OF THE INTERIOR','DEPARTMENT OF THE INTERIOR'));
        options.add(new SelectOption('DEPARTMENT OF JUSTICE','DEPARTMENT OF JUSTICE'));
        options.add(new SelectOption('DEPARTMENT OF LABOR','DEPARTMENT OF LABOR'));
        options.add(new SelectOption('DEPARTMENT OF THE NAVY','DEPARTMENT OF THE NAVY'));
        options.add(new SelectOption('UNITED STATES POSTAL SERVICE','UNITED STATES POSTAL SERVICE'));
        options.add(new SelectOption('DEPARTMENT OF STATE','DEPARTMENT OF STATE'));
        options.add(new SelectOption('DEPARTMENT OF THE TREASURY','DEPARTMENT OF THE TREASURY'));
        options.add(new SelectOption('DEPARTMENT OF THE ARMY','DEPARTMENT OF THE ARMY'));
        options.add(new SelectOption('UNITED STATES TAX COURT','UNITED STATES TAX COURT'));
        options.add(new SelectOption('OFFICE OF PERSONNEL MANAGEMENT','OFFICE OF PERSONNEL MANAGEMENT'));
        options.add(new SelectOption('NATIONAL CREDIT UNION ADMINISTRATION','NATIONAL CREDIT UNION ADMINISTRATION'));
        options.add(new SelectOption('FEDERAL RETIREMENT THRIFT INVESTMENT BOARD','FEDERAL RETIREMENT THRIFT INVESTMENT BOARD'));
        options.add(new SelectOption('FEDERAL COMMUNICATIONS COMMISSION','FEDERAL COMMUNICATIONS COMMISSION'));
        options.add(new SelectOption('SOCIAL SECURITY ADMINISTRATION','SOCIAL SECURITY ADMINISTRATION'));
        options.add(new SelectOption('FEDERAL TRADE COMMISSION','FEDERAL TRADE COMMISSION'));
        options.add(new SelectOption('NUCLEAR REGULATORY COMMISSION','NUCLEAR REGULATORY COMMISSION'));
        options.add(new SelectOption('SMITHSONIAN INSTITUTION','SMITHSONIAN INSTITUTION'));
        options.add(new SelectOption('INTERNATIONAL TRADE COMMISSION','INTERNATIONAL TRADE COMMISSION'));
        options.add(new SelectOption('DEPARTMENT OF VETERANS AFFAIRS','DEPARTMENT OF VETERANS AFFAIRS'));
        options.add(new SelectOption('MERIT SYSTEMS PROTECTION BOARD','MERIT SYSTEMS PROTECTION BOARD'));
        options.add(new SelectOption('EQUAL EMPLOYMENT OPPORTUNITY COMMISSION','EQUAL EMPLOYMENT OPPORTUNITY COMMISSION'));
        options.add(new SelectOption('REGIONAL COMMISSIONS','REGIONAL COMMISSIONS'));
        options.add(new SelectOption('GENERAL SERVICES ADMINISTRATION','GENERAL SERVICES ADMINISTRATION'));
        options.add(new SelectOption('U.S. COMMISSIONS','U.S. COMMISSIONS'));
        options.add(new SelectOption('NATIONAL SCIENCE FOUNDATION','NATIONAL SCIENCE FOUNDATION'));
        options.add(new SelectOption('SECURITIES AND EXCHANGE COMMISSION','SECURITIES AND EXCHANGE COMMISSION'));
        options.add(new SelectOption('FEDERAL DEPOSIT INSURANCE CORPORATION','FEDERAL DEPOSIT INSURANCE CORPORATION'));
        options.add(new SelectOption('PERMIT AND ENFORCE FED INSPCTOR FOR THE ALSKA GAS PIPELINE','PERMIT AND ENFORCE FED INSPCTOR FOR THE ALSKA GAS PIPELINE'));
        options.add(new SelectOption('FEDERAL LABOR RELATIONS AUTHORITY','FEDERAL LABOR RELATIONS AUTHORITY'));
        options.add(new SelectOption('CENTRAL INTELLIGENCE AGENCY','CENTRAL INTELLIGENCE AGENCY'));
        options.add(new SelectOption('DEPARTMENT OF THE AIR FORCE','DEPARTMENT OF THE AIR FORCE'));
        options.add(new SelectOption('NATIONAL FOUNDATION ON THE ARTS AND THE HUMANITIES','NATIONAL FOUNDATION ON THE ARTS AND THE HUMANITIES'));
        options.add(new SelectOption('RAILROAD RETIREMENT BOARD','RAILROAD RETIREMENT BOARD'));
        options.add(new SelectOption('CONSUMER PRODUCT SAFETY COMMISSION','CONSUMER PRODUCT SAFETY COMMISSION'));
        options.add(new SelectOption('U.S. OFFICE OF SPECIAL COUNSEL','U.S. OFFICE OF SPECIAL COUNSEL'));
        options.add(new SelectOption('NATIONAL LABOR RELATIONS BOARD','NATIONAL LABOR RELATIONS BOARD'));
        options.add(new SelectOption('TENNESSEE VALLEY AUTHORITY','TENNESSEE VALLEY AUTHORITY'));
        options.add(new SelectOption('FEDERAL MARITIME COMMISSION','FEDERAL MARITIME COMMISSION'));
        options.add(new SelectOption('ENVIRONMENTAL PROTECTION AGENCY','ENVIRONMENTAL PROTECTION AGENCY'));
        options.add(new SelectOption('DEPARTMENT OF TRANSPORTATION','DEPARTMENT OF TRANSPORTATION'));
        options.add(new SelectOption('DEPARTMENT OF HOMELAND SECURITY','DEPARTMENT OF HOMELAND SECURITY'));
        options.add(new SelectOption('AGENCY FOR INTERNATIONAL DEVELOPMENT','AGENCY FOR INTERNATIONAL DEVELOPMENT'));
        options.add(new SelectOption('SMALL BUSINESS ADMINISTRATION','SMALL BUSINESS ADMINISTRATION'));
        options.add(new SelectOption('AMERICAN BATTLE MONUMENTS COMMISSION','AMERICAN BATTLE MONUMENTS COMMISSION'));
        options.add(new SelectOption('DEPARTMENT OF HEALTH AND HUMAN SERVICES','DEPARTMENT OF HEALTH AND HUMAN SERVICES'));
        options.add(new SelectOption('COMMEMORATIVE COMMISSIONS','COMMEMORATIVE COMMISSIONS'));
        options.add(new SelectOption('FARM CREDIT ADMINISTRATION','FARM CREDIT ADMINISTRATION'));
        options.add(new SelectOption('NATIONAL AERONAUTICS AND SPACE ADMINISTRATION','NATIONAL AERONAUTICS AND SPACE ADMINISTRATION'));
        options.add(new SelectOption('FEDERAL HOME LOAN BANK BOARD','FEDERAL HOME LOAN BANK BOARD'));
        options.add(new SelectOption('EXPORT-IMPORT BANK OF THE UNITED STATES','EXPORT-IMPORT BANK OF THE UNITED STATES'));
        options.add(new SelectOption('ARMED FORCES RETIREMENT HOME','ARMED FORCES RETIREMENT HOME'));
        options.add(new SelectOption('WATER RESOURCES COUNCIL','WATER RESOURCES COUNCIL'));
        options.add(new SelectOption('DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT','DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT'));
        options.add(new SelectOption('NATIONAL ARCHIVES AND RECORDS ADMINISTRATION','NATIONAL ARCHIVES AND RECORDS ADMINISTRATION'));
        options.add(new SelectOption('DEPARTMENT OF ENERGY','DEPARTMENT OF ENERGY'));
        options.add(new SelectOption('SELECTIVE SERVICE SYSTEM','SELECTIVE SERVICE SYSTEM'));
        options.add(new SelectOption('DEPARTMENT OF EDUCATION','DEPARTMENT OF EDUCATION'));
        options.add(new SelectOption('FEDERAL MEDIATION AND CONCILIATION SERVICE','FEDERAL MEDIATION AND CONCILIATION SERVICE'));
        options.add(new SelectOption('INDEPENDENT U.S. GOVERNMENT OFFICES','INDEPENDENT U.S. GOVERNMENT OFFICES'));
        options.add(new SelectOption('U.S. ARMY CORPS OF ENGINEERS','U.S. ARMY CORPS OF ENGINEERS'));
        options.add(new SelectOption('DEPARTMENT OF DEFENSE (OFFICE OF THE SECRETARY OF DEFENSE)','DEPARTMENT OF DEFENSE (OFFICE OF THE SECRETARY OF DEFENSE)'));
        options.add(new SelectOption('DISTRICT OF COLUMBIA','DISTRICT OF COLUMBIA'));
        // - 20045
        options.add(new SelectOption('CORPORATION FOR NATIONAL AND COMMUNITY SERVICE','CORPORATION FOR NATIONAL AND COMMUNITY SERVICE'));
        options.add(new SelectOption('NATIONAL TRANSPORTATION SAFETY BOARD','NATIONAL TRANSPORTATION SAFETY BOARD'));
        options.add(new SelectOption('CONSUMER FINANCIAL PROTECTION BUREAU','CONSUMER FINANCIAL PROTECTION BUREAU'));
        options.add(new SelectOption('FEDERAL ENERGY REGULATORY COMMISSION','FEDERAL ENERGY REGULATORY COMMISSION'));
        options.add(new SelectOption('BROADCASTING BOARD OF GOVERNORS','BROADCASTING BOARD OF GOVERNORS'));
        options.add(new SelectOption('PENSION BENEFIT GUARANTY CORPORATION','PENSION BENEFIT GUARANTY CORPORATION'));
        options.add(new SelectOption('NATIONAL MEDIATION BOARD','NATIONAL MEDIATION BOARD'));
        options.add(new SelectOption('COMMODITY FUTURES TRADING COMMISSION','COMMODITY FUTURES TRADING COMMISSION'));
        // - 20080
        options.add(new SelectOption('MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION','MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION'));
        // - 20155
        options.add(new SelectOption('VOICE OF AMERICA','VOICE OF AMERICA'));
        options.add(new SelectOption('FEDERAL HOUSING FINANCE AGENCY','FEDERAL HOUSING FINANCE AGENCY'));
        options.add(new SelectOption('COURT SERVICES AND OFFENDER SUPERVISION AGENCY','COURT SERVICES AND OFFENDER SUPERVISION AGENCY'));
        // - 20162
        options.add(new SelectOption('OVERSEAS PRIVATE INVESTMENT CORPORATION','OVERSEAS PRIVATE INVESTMENT CORPORATION'));
        options.add(new SelectOption('U.S. CHEMICAL SAFETY BOARD','U.S. CHEMICAL SAFETY BOARD'));
        // - 20550
        options.add(new SelectOption('NATIONAL ENDOWMENT FOR THE HUMANITIES','NATIONAL ENDOWMENT FOR THE HUMANITIES'));
        options.add(new SelectOption('U.S. TRADE AND DEVELOPMENT AGENCY','U.S. TRADE AND DEVELOPMENT AGENCY'));
        options.add(new SelectOption('NATIONAL CAPITAL PLANNING COMMISSION','NATIONAL CAPITAL PLANNING COMMISSION'));
        options.sort();
        return options;
        //return null;
    }

    // for bureaus picklist based on the agency selection.
    public List<SelectOption> getBureaus() {
        List<SelectOption> options = new List<SelectOption>();
        if(agency == 'UNITED STATES CONGRESS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('UNITED STATES CONGRESS','UNITED STATES CONGRESS'));
            options.add(new SelectOption('CONGRESSIONAL COMMITTEES AND SUBCOMMITTEES','CONGRESSIONAL COMMITTEES AND SUBCOMMITTEES'));
            options.add(new SelectOption('HOUSE OF REPRESENTATIVES','HOUSE OF REPRESENTATIVES'));
            options.add(new SelectOption('TEMPORARY COMMISSION ON FINANCIAL OVERSIGHT OF DISTRICT OF COLUMBIA','TEMPORARY COMMISSION ON FINANCIAL OVERSIGHT OF DISTRICT OF COLUMBIA'));
            options.add(new SelectOption('SENATE','SENATE'));
            options.add(new SelectOption('PRESIDENTIAL TRANSITION','PRESIDENTIAL TRANSITION'));
            options.add(new SelectOption('TRIBAL ORGANIZATIONS','TRIBAL ORGANIZATIONS'));
            options.add(new SelectOption('INAUGURAL COMMITTEE','INAUGURAL COMMITTEE'));
            options.add(new SelectOption('FOOD AND AGRICULTURE ORGANIZATION OF THE UNITED NATIONS','FOOD AND AGRICULTURE ORGANIZATION OF THE UNITED NATIONS'));
            options.add(new SelectOption('INTERAMERICAN DEFENSE BOARD','INTERAMERICAN DEFENSE BOARD'));
            options.add(new SelectOption('INTERAMERICAN DEVELOPMENT BANK','INTERAMERICAN DEVELOPMENT BANK'));
            options.add(new SelectOption('INTERGOVERNMENTAL COMMITTEE FOR EUROPEAN MIGRATION','INTERGOVERNMENTAL COMMITTEE FOR EUROPEAN MIGRATION'));
            options.add(new SelectOption('INTERNATIONAL ATOMIC ENERGY AGENCY','INTERNATIONAL ATOMIC ENERGY AGENCY'));
            options.add(new SelectOption('INTERNATIONAL BANK FOR RECONSTRUCTION AND DEVELOPMENT','INTERNATIONAL BANK FOR RECONSTRUCTION AND DEVELOPMENT'));
            options.add(new SelectOption('INTERNATIONAL CIVIL AVIATION ORGANIZATION','INTERNATIONAL CIVIL AVIATION ORGANIZATION'));
            options.add(new SelectOption('INTERNATIONAL FINANCE CORPORATION','INTERNATIONAL FINANCE CORPORATION'));
            options.add(new SelectOption('INTERNATIONAL MONETARY FUND','INTERNATIONAL MONETARY FUND'));
            options.add(new SelectOption('INTERNATIONAL TELECOMMUNICATIONS UNION','INTERNATIONAL TELECOMMUNICATIONS UNION'));
            options.add(new SelectOption('NATIONAL ACADEMY OF SCIENCES','NATIONAL ACADEMY OF SCIENCES'));
            options.add(new SelectOption('ORGANIZATION OF AMERICAN STATES (PAN AMERICAN UNION)','ORGANIZATION OF AMERICAN STATES (PAN AMERICAN UNION)'));
            options.add(new SelectOption('PAN AMERICAN HEALTH ORGANIZATION','PAN AMERICAN HEALTH ORGANIZATION'));
            options.add(new SelectOption('STATUE OF LIBERTY/ELLIS ISLAND FOUNDATION','STATUE OF LIBERTY/ELLIS ISLAND FOUNDATION'));
            options.add(new SelectOption('SOUTH PACIFIC COMMISSION','SOUTH PACIFIC COMMISSION'));
            options.add(new SelectOption('UNITED NATIONS','UNITED NATIONS'));
            options.add(new SelectOption('UNITED NATIONS EDUCATIONAL SCIENTIFIC, AND CULTURAL ORGANIZATION','UNITED NATIONS EDUCATIONAL SCIENTIFIC, AND CULTURAL ORGANIZATION'));
            options.add(new SelectOption('UNIVERSAL POSTAL UNION','UNIVERSAL POSTAL UNION'));
            options.add(new SelectOption('WORLD HEALTH ORGANIZATION','WORLD HEALTH ORGANIZATION'));
            options.add(new SelectOption('WORLD METEOROLOGICAL ORGANIZATION','WORLD METEOROLOGICAL ORGANIZATION'));
            options.add(new SelectOption('AMERICAN FREEDOM FROM HUNGER SOCIETY','AMERICAN FREEDOM FROM HUNGER SOCIETY'));
            options.add(new SelectOption('ARMY AND AIR FORCE EXCHANGE SERVICE','ARMY AND AIR FORCE EXCHANGE SERVICE'));
            options.add(new SelectOption('INTERAGENCY COMMITTEE ON MARINE RESEARCH, EDUCATION, AND FACILITIES','INTERAGENCY COMMITTEE ON MARINE RESEARCH, EDUCATION, AND FACILITIES'));
            options.add(new SelectOption('NORTH ATLANTIC TREATY ORGANIZATION','NORTH ATLANTIC TREATY ORGANIZATION'));
            options.add(new SelectOption('ARMY AND AIR FORCE MOTION PICTURE SERVICE','ARMY AND AIR FORCE MOTION PICTURE SERVICE'));
            options.add(new SelectOption('NATIONAL TRUST FOR HISTORICAL PRESERVATION','NATIONAL TRUST FOR HISTORICAL PRESERVATION'));
            options.add(new SelectOption('FEDERAL RESERVE SYSTEM','FEDERAL RESERVE SYSTEM'));
            options.add(new SelectOption('AMERICAN NATIONAL RED CROSS','AMERICAN NATIONAL RED CROSS'));
            options.add(new SelectOption('CARIBBEAN ORGANIZATION','CARIBBEAN ORGANIZATION'));
            options.add(new SelectOption('UNITED NATIONS INTERNATIONAL LABOR OFFICE','UNITED NATIONS INTERNATIONAL LABOR OFFICE'));
            options.add(new SelectOption('NATIONAL ALLIANCE OF BUSINESSMEN','NATIONAL ALLIANCE OF BUSINESSMEN'));
            options.add(new SelectOption('NATIONAL BUILDING MUSEUM','NATIONAL BUILDING MUSEUM'));
            options.add(new SelectOption('NATIONAL CONSUMER COOPERATIVE BANK','NATIONAL CONSUMER COOPERATIVE BANK'));
            options.add(new SelectOption('UNITED NATIONS INFORMATION SERVICE','UNITED NATIONS INFORMATION SERVICE'));
            options.add(new SelectOption('MISCELLANEOUS NONGOVERNMENT ACCOUNTS','MISCELLANEOUS NONGOVERNMENT ACCOUNTS'));
            options.add(new SelectOption('ORGANIZATION FOR ECONOMIC COOPERATION AND DEVELOPMENT','ORGANIZATION FOR ECONOMIC COOPERATION AND DEVELOPMENT'));
            options.add(new SelectOption('NAVY RESALE AND SERVICES','NAVY RESALE AND SERVICES'));
            options.add(new SelectOption('WASHINGTON METROPOLITAN AREA TRANSIT COMMISSION','WASHINGTON METROPOLITAN AREA TRANSIT COMMISSION'));
            options.add(new SelectOption('UN WORLD FOOD PROGRAM','UN WORLD FOOD PROGRAM'));
        }
        else if(agency == 'ARCHITECT OF THE CAPITOL') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('ARCHITECT OF THE CAPITOL','ARCHITECT OF THE CAPITOL'));
            options.add(new SelectOption('UNITED STATES BOTANIC GARDEN','UNITED STATES BOTANIC GARDEN'));
        }
        else if(agency == 'U.S. CAPITOL') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CAPITOL BUILDINGS','CAPITOL BUILDINGS'));
            options.add(new SelectOption('CAPITOL POWER PLANT','CAPITOL POWER PLANT'));
        }
        else if(agency == 'SUPREME COURT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SUPREME COURT ','SUPREME COURT '));
        }
        else if(agency == 'LIBRARY OF CONGRESS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('LIBRARY OF CONGRESS','LIBRARY OF CONGRESS'));
        }
        else if(agency == 'GOVERNMENT PRINTING OFFICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('GOVERNMENT PRINTING OFFICE','GOVERNMENT PRINTING OFFICE'));
        }
        else if(agency == 'GENERAL ACCOUNTING OFFICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('GENERAL ACCOUNTING OFFICE','GENERAL ACCOUNTING OFFICE'));
        }
        else if(agency == 'GOVERNMENT ACCOUNTABILITY OFFICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('GOVERNMENT ACCOUNTABILITY OFFICE','GOVERNMENT ACCOUNTABILITY OFFICE'));
        }
        else if(agency == 'LEGISLATIVE BRANCH') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('LEGISLATIVE BRANCH','LEGISLATIVE BRANCH'));
            options.add(new SelectOption('OFFICE OF TECHNOLOGY ASSESSMENT','OFFICE OF TECHNOLOGY ASSESSMENT'));
            options.add(new SelectOption('BIOMEDICAL ETHICS BOARD','BIOMEDICAL ETHICS BOARD'));
            options.add(new SelectOption('COPYRIGHT ROYALTY TRIBUNAL','COPYRIGHT ROYALTY TRIBUNAL'));
            options.add(new SelectOption('OFFICE OF COMPLIANCE','OFFICE OF COMPLIANCE'));
        }
        else if(agency == 'U.S. COURTS/ JUDICIARY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('JUDICIARY','JUDICIARY'));
            options.add(new SelectOption('ADMINISTRATIVE OFFICE OF U.S. COURTS','ADMINISTRATIVE OFFICE OF U.S. COURTS'));
            options.add(new SelectOption('PUBLIC DEFENDER SERVICE','PUBLIC DEFENDER SERVICE'));
            options.add(new SelectOption('COURTS OF THE DISTRICT OF COLUMBIA','COURTS OF THE DISTRICT OF COLUMBIA'));
            options.add(new SelectOption('BICENTENNIAL COMMISSION OF THE JUDICIAL CONFERENCE OF THE U.S.','BICENTENNIAL COMMISSION OF THE JUDICIAL CONFERENCE OF THE U.S.'));
            options.add(new SelectOption('DISTRICT COURTS OF THE UNITED STATES','DISTRICT COURTS OF THE UNITED STATES'));
            options.add(new SelectOption('UNITED STATES BANKRUPTCY COURT','UNITED STATES BANKRUPTCY COURT'));
            options.add(new SelectOption('UNITED STATES SENTENCING COMMISSION','UNITED STATES SENTENCING COMMISSION'));
            options.add(new SelectOption('TERRITORIAL COURTS','TERRITORIAL COURTS'));
            options.add(new SelectOption('UNITED STATES COURTS OF APPEALS','UNITED STATES COURTS OF APPEALS'));
            options.add(new SelectOption('UNITED STATES CLAIMS COURT','UNITED STATES CLAIMS COURT'));
            options.add(new SelectOption('BANKRUPTCY JUDGE COURTROOMS','BANKRUPTCY JUDGE COURTROOMS'));
            options.add(new SelectOption('UNITED STATES COURT OF INTERNATIONAL TRADE (CUSTOMS COURTS)','UNITED STATES COURT OF INTERNATIONAL TRADE (CUSTOMS COURTS)'));
            options.add(new SelectOption('BANKRUPTCY CLERK','BANKRUPTCY CLERK'));
            options.add(new SelectOption('UNITED STATES COURT OF APPEALS FOR THE FEDERAL CIRCUIT','UNITED STATES COURT OF APPEALS FOR THE FEDERAL CIRCUIT'));
            options.add(new SelectOption('UNITED STATES SUPREME COURT','UNITED STATES SUPREME COURT'));
            options.add(new SelectOption('FEDERAL JUDICIAL CENTER','FEDERAL JUDICIAL CENTER'));
            options.add(new SelectOption('JUDICIAL PANEL ON MULTI-DISTRICT LEGISLATION','JUDICIAL PANEL ON MULTI-DISTRICT LEGISLATION'));
            options.add(new SelectOption('COMMUNITY DEFENDERS','COMMUNITY DEFENDERS'));
            options.add(new SelectOption('COURT OF APPEALS JUDGES CHAMBERS','COURT OF APPEALS JUDGES CHAMBERS'));
            options.add(new SelectOption('COURT OF APPEALS COURTROOMS','COURT OF APPEALS COURTROOMS'));
            options.add(new SelectOption('COURT OF APPEALS CLERK','COURT OF APPEALS CLERK'));
            options.add(new SelectOption('CIRCUIT EXECUTIVE','CIRCUIT EXECUTIVE'));
            options.add(new SelectOption('COURT OF APPEALS CENTRAL LEGAL STAFF','COURT OF APPEALS CENTRAL LEGAL STAFF'));
            options.add(new SelectOption('CIRCUIT LIBRARIES','CIRCUIT LIBRARIES'));
            options.add(new SelectOption('DISTRICT JUDGE CHAMBERS','DISTRICT JUDGE CHAMBERS'));
            options.add(new SelectOption('DISTRICT JUDGE COURTROOMS','DISTRICT JUDGE COURTROOMS'));
            options.add(new SelectOption('MAGISTRATE JUDGE CHAMBERS','MAGISTRATE JUDGE CHAMBERS'));
            options.add(new SelectOption('MAGISTRATE JUDGE COURTROOMS','MAGISTRATE JUDGE COURTROOMS'));
            options.add(new SelectOption('DISTRICT CLERK','DISTRICT CLERK'));
            options.add(new SelectOption('PROBATION','PROBATION'));
            options.add(new SelectOption('PRETRIAL SERVICES','PRETRIAL SERVICES'));
            options.add(new SelectOption('STATE COURTS','STATE COURTS'));
            options.add(new SelectOption('COURTS, JOINT USE FEDERAL AND STATE','COURTS, JOINT USE FEDERAL AND STATE'));
        }
        else if(agency == 'EXECUTIVE OFFICE OF THE PRESIDENT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('EXECUTIVE OFFICE OF THE PRESIDENT','EXECUTIVE OFFICE OF THE PRESIDENT'));
            options.add(new SelectOption('OFFICE OF MANAGEMENT AND BUDGET','OFFICE OF MANAGEMENT AND BUDGET'));
            options.add(new SelectOption('COUNCIL ON ENVIRONMENTAL QUALITY','COUNCIL ON ENVIRONMENTAL QUALITY'));
            options.add(new SelectOption('COUNCIL OF ECONOMIC ADVISERS','COUNCIL OF ECONOMIC ADVISERS'));
            options.add(new SelectOption('NATIONAL SECURITY COUNCIL','NATIONAL SECURITY COUNCIL'));
            options.add(new SelectOption('OFFICE OF THE VICE PRESIDENT','OFFICE OF THE VICE PRESIDENT'));
            options.add(new SelectOption('OFFICE OF THE UNITED STATES TRADE REPRESENTATIVE','OFFICE OF THE UNITED STATES TRADE REPRESENTATIVE'));
            options.add(new SelectOption('OFFICE OF CONSUMER AFFAIRS','OFFICE OF CONSUMER AFFAIRS'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATION','OFFICE OF ADMINISTRATION'));
            options.add(new SelectOption('NATIONAL SPACE COUNCIL','NATIONAL SPACE COUNCIL'));
            options.add(new SelectOption('OFFICE OF NATIONAL AIDS POLICY','OFFICE OF NATIONAL AIDS POLICY'));
            options.add(new SelectOption('OFFICE OF SCIENCE AND TECHNOLOGY POLICY','OFFICE OF SCIENCE AND TECHNOLOGY POLICY'));
            options.add(new SelectOption('COUNCIL ON WAGE AND PRICE STABILITY','COUNCIL ON WAGE AND PRICE STABILITY'));
            options.add(new SelectOption('OFFICE OF NATIONAL DRUG CONTROL POLICY','OFFICE OF NATIONAL DRUG CONTROL POLICY'));
            options.add(new SelectOption('U.S. TRADE AND DEVELOPMENT AGENCY','U.S. TRADE AND DEVELOPMENT AGENCY'));
        }
        else if(agency == 'THE WHITE HOUSE OFFICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('THE WHITE HOUSE OFFICE','THE WHITE HOUSE OFFICE'));
        }
        else if(agency == 'PEACE CORPS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('PEACE CORPS','PEACE CORPS'));
        }
        else if(agency == 'DEPARTMENT OF AGRICULTURE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF AGRICULTURE','DEPARTMENT OF AGRICULTURE'));
            options.add(new SelectOption('FARM SERVICE AGENCY','FARM SERVICE AGENCY'));
            options.add(new SelectOption('NATIONAL AGRICULTURAL STATISTICS SERVICE','NATIONAL AGRICULTURAL STATISTICS SERVICE'));
            options.add(new SelectOption('AGRICULTURAL MARKETING SERVICE','AGRICULTURAL MARKETING SERVICE'));
            options.add(new SelectOption('AGRICULTURAL RESEARCH SERVICE','AGRICULTURAL RESEARCH SERVICE'));
            options.add(new SelectOption('RURAL DEVELOPMENT ADMINISTRATION','RURAL DEVELOPMENT ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF THE CHIEF INFORMATION OFFICER','OFFICE OF THE CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('FOOD AND NUTRITION SERVICE','FOOD AND NUTRITION SERVICE'));
            options.add(new SelectOption('OFFICE OF CONGRESSIONAL RELATIONS','OFFICE OF CONGRESSIONAL RELATIONS'));
            options.add(new SelectOption('RURAL HOUSING SERVICE','RURAL HOUSING SERVICE'));
            options.add(new SelectOption('RISK MANAGEMENT AGENCY','RISK MANAGEMENT AGENCY'));
            options.add(new SelectOption('FOREIGN AGRICULTURAL SERVICE','FOREIGN AGRICULTURAL SERVICE'));
            options.add(new SelectOption('OFFICE OF ENVIRONMENTAL MARKETS','OFFICE OF ENVIRONMENTAL MARKETS'));
            options.add(new SelectOption('FOREST SERVICE','FOREST SERVICE'));
            options.add(new SelectOption('OFFICE OF THE GENERAL COUNSEL','OFFICE OF THE GENERAL COUNSEL'));
            options.add(new SelectOption('GRAIN INSPECTION, PACKERS, AND STOCKYARDS ADMINISTRATION','GRAIN INSPECTION, PACKERS, AND STOCKYARDS ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF COMMUNICATIONS','OFFICE OF COMMUNICATIONS'));
            options.add(new SelectOption('RURAL UTILITIES SERVICES','RURAL UTILITIES SERVICES'));
            options.add(new SelectOption('FAITH BASED AND NEIGHBORHOOD PARTNERSHIPS','FAITH BASED AND NEIGHBORHOOD PARTNERSHIPS'));
            options.add(new SelectOption('OFFICE OF THE EXECUTIVE SECRETARIAT','OFFICE OF THE EXECUTIVE SECRETARIAT'));
            options.add(new SelectOption('ANIMAL AND PLANT HEALTH INSPECTION SERVICE','ANIMAL AND PLANT HEALTH INSPECTION SERVICE'));
            options.add(new SelectOption('NATURAL RESOURCES CONSERVATION SERVICE','NATURAL RESOURCES CONSERVATION SERVICE'));
            options.add(new SelectOption('FOOD SAFETY AND INSPECTION SERVICE','FOOD SAFETY AND INSPECTION SERVICE'));
            options.add(new SelectOption('OFFICE OF THE CHIEF SCIENTIST','OFFICE OF THE CHIEF SCIENTIST'));
            options.add(new SelectOption('OFFICE OF TRIBAL RELATIONS','OFFICE OF TRIBAL RELATIONS'));
            options.add(new SelectOption('OFFICE OF BUDGET AND PROGRAM ANALYSIS','OFFICE OF BUDGET AND PROGRAM ANALYSIS'));
            options.add(new SelectOption('CENTER FOR NUTRITION POLICY AND PROMOTION','CENTER FOR NUTRITION POLICY AND PROMOTION'));
            options.add(new SelectOption('OFFICE OF THE CHIEF FINANCIAL OFFICER','OFFICE OF THE CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('ECONOMIC RESEARCH SERVICE','ECONOMIC RESEARCH SERVICE'));
            options.add(new SelectOption('NATIONAL AGRICULTURAL LIBRARY','NATIONAL AGRICULTURAL LIBRARY'));
            options.add(new SelectOption('OFFICE OF THE INSPECTOR GENERAL','OFFICE OF THE INSPECTOR GENERAL'));
            options.add(new SelectOption('NATIONAL APPEALS DIVISION','NATIONAL APPEALS DIVISION'));
            options.add(new SelectOption('OFFICE OF CHIEF ECONOMIST','OFFICE OF CHIEF ECONOMIST'));
            options.add(new SelectOption('NATIONAL INSTITUTE OF FOOD AND AGRICULTURE','NATIONAL INSTITUTE OF FOOD AND AGRICULTURE'));
            options.add(new SelectOption('OFFICE OF THE ASSISTANT SECRETARY FOR CIVIL RIGHTS','OFFICE OF THE ASSISTANT SECRETARY FOR CIVIL RIGHTS'));
            options.add(new SelectOption('OFFICE OF ADVOCACY AND OUTREACH','OFFICE OF ADVOCACY AND OUTREACH'));
            options.add(new SelectOption('DEPARTMENTAL MANAGEMENT','DEPARTMENTAL MANAGEMENT'));
            options.add(new SelectOption('RURAL BUSINESS COOPERATIVE SERVICE','RURAL BUSINESS COOPERATIVE SERVICE'));
        }
        else if(agency == 'DEPARTMENT OF COMMERCE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF COMMERCE','DEPARTMENT OF COMMERCE'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('MINORITY BUSINESS DEVELOPMENT AGENCY','MINORITY BUSINESS DEVELOPMENT AGENCY'));
            options.add(new SelectOption('BUREAU OF THE CENSUS','BUREAU OF THE CENSUS'));
            options.add(new SelectOption('NATIONAL TELECOMMUNICATIONS AND INFORMATION ADMINISTRATION','NATIONAL TELECOMMUNICATIONS AND INFORMATION ADMINISTRATION'));
            options.add(new SelectOption('NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY','NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY'));
            options.add(new SelectOption('NATIONAL TECHNICAL INFORMATION SERVICE','NATIONAL TECHNICAL INFORMATION SERVICE'));
            options.add(new SelectOption('PATENT AND TRADEMARK OFFICE','PATENT AND TRADEMARK OFFICE'));
            options.add(new SelectOption('INTERNATIONAL TRADE ADMINISTRATION','INTERNATIONAL TRADE ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('NATIONAL OCEANIC ATMOSPHERIC ADMINISTRATION','NATIONAL OCEANIC ATMOSPHERIC ADMINISTRATION'));
            options.add(new SelectOption('ECONOMICS AND STATISTICS ADMINISTRATION','ECONOMICS AND STATISTICS ADMINISTRATION'));
            options.add(new SelectOption('BUREAU OF INDUSTRY AND SECURITY','BUREAU OF INDUSTRY AND SECURITY'));
            options.add(new SelectOption('OFFICE OF CHIEF INFORMATION OFFICER','OFFICE OF CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('BUREAU OF ECONOMIC ANALYSIS','BUREAU OF ECONOMIC ANALYSIS'));
            options.add(new SelectOption('ECONOMIC DEVELOPMENT ADMINISTRATION','ECONOMIC DEVELOPMENT ADMINISTRATION'));
        }
        else if(agency == 'DEPARTMENT OF THE INTERIOR') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF THE INTERIOR','DEPARTMENT OF THE INTERIOR'));
            options.add(new SelectOption('OFFICE OF SURFACE MINING RECLAMATION AND ENFORCEMENT','OFFICE OF SURFACE MINING RECLAMATION AND ENFORCEMENT'));
            options.add(new SelectOption('GEOLOGICAL SURVEY','GEOLOGICAL SURVEY'));
            options.add(new SelectOption('OFFICE OF HEARING AND APPEALS','OFFICE OF HEARING AND APPEALS'));
            options.add(new SelectOption('BUREAU OF INDIAN AFFAIRS','BUREAU OF INDIAN AFFAIRS'));
            options.add(new SelectOption('OFFICE OF POLICY, MANAGEMENT AND BUDGET','OFFICE OF POLICY, MANAGEMENT AND BUDGET'));
            options.add(new SelectOption('BUREAU OF LAND MANAGEMENT','BUREAU OF LAND MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF THE SPECIAL TRUSTEE FOR AMERICAN INDIANS','OFFICE OF THE SPECIAL TRUSTEE FOR AMERICAN INDIANS'));
            options.add(new SelectOption('BUREAU OF MINES','BUREAU OF MINES'));
            options.add(new SelectOption('NATIONAL PARK SERVICE','NATIONAL PARK SERVICE'));
            options.add(new SelectOption('BUREAU OF SAFETY AND ENVIRONMENTAL ENFORCEMENT','BUREAU OF SAFETY AND ENVIRONMENTAL ENFORCEMENT'));
            options.add(new SelectOption('OFFICE OF AVIATION SERVICES','OFFICE OF AVIATION SERVICES'));
            options.add(new SelectOption('BUREAU OF RECLAMATION','BUREAU OF RECLAMATION'));
            options.add(new SelectOption('NATIONAL BUSINESS CENTER','NATIONAL BUSINESS CENTER'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('OFFICE OF THE SOLICITOR','OFFICE OF THE SOLICITOR'));
            options.add(new SelectOption('OFFICE OF INSULAR AFFAIRS','OFFICE OF INSULAR AFFAIRS'));
            options.add(new SelectOption('UNITED STATES FISH AND WILDLIFE SERVICE','UNITED STATES FISH AND WILDLIFE SERVICE'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF THE CHIEF INFORMATION OFFICER','OFFICE OF THE CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('BUREAU OF OCEAN ENERGY MANAGEMENT','BUREAU OF OCEAN ENERGY MANAGEMENT'));
            options.add(new SelectOption('BUREAU OF INDIAN AFFAIRS EDUCATION','BUREAU OF INDIAN AFFAIRS EDUCATION'));
        }
        else if(agency == 'DEPARTMENT OF JUSTICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF JUSTICE','DEPARTMENT OF JUSTICE'));
            options.add(new SelectOption('UNITED STATES TRUSTEES','UNITED STATES TRUSTEES'));
            options.add(new SelectOption('JUSTICE MANAGEMENT DIVISION','JUSTICE MANAGEMENT DIVISION'));
            options.add(new SelectOption('ANTITRUST DIVISION','ANTITRUST DIVISION'));
            options.add(new SelectOption('OFFICE OF PROFESSIONAL RESPONSIBILITY','OFFICE OF PROFESSIONAL RESPONSIBILITY'));
            options.add(new SelectOption('OFFICE OF THE ATTORNEY GENERAL','OFFICE OF THE ATTORNEY GENERAL'));
            options.add(new SelectOption('OFFICE OF ASSOCIATE ATTORNEY GENERAL','OFFICE OF ASSOCIATE ATTORNEY GENERAL'));
            options.add(new SelectOption('CIVIL DIVISION','CIVIL DIVISION'));
            options.add(new SelectOption('INTERPOL - WASHINGTON','INTERPOL - WASHINGTON'));
            options.add(new SelectOption('CIVIL RIGHTS DIVISION','CIVIL RIGHTS DIVISION'));
            options.add(new SelectOption('OFFICE OF LEGISLATIVE AFFAIRS','OFFICE OF LEGISLATIVE AFFAIRS'));
            options.add(new SelectOption('CRIMINAL DIVISION','CRIMINAL DIVISION'));
            options.add(new SelectOption('OFFICE OF THE DEPUTY ATTORNEY GENERAL','OFFICE OF THE DEPUTY ATTORNEY GENERAL'));
            options.add(new SelectOption('FEDERAL BUREAU OF INVESTIGATION','FEDERAL BUREAU OF INVESTIGATION'));
            options.add(new SelectOption('NATIONAL INSTITUTE OF CORRECTIONS','NATIONAL INSTITUTE OF CORRECTIONS'));
            options.add(new SelectOption('ENVIRONMENT AND NATURAL RESOURCES DIVISION','ENVIRONMENT AND NATURAL RESOURCES DIVISION'));
            options.add(new SelectOption('OFFICE OF LEGAL COUNSEL','OFFICE OF LEGAL COUNSEL'));
            options.add(new SelectOption('BUREAU OF PRISONS','BUREAU OF PRISONS'));
            options.add(new SelectOption('OFFICE OF THE SOLICITOR GENERAL','OFFICE OF THE SOLICITOR GENERAL'));
            options.add(new SelectOption('TAX DIVISION','TAX DIVISION'));
            options.add(new SelectOption('OFFICE OF PUBLIC AFFAIRS','OFFICE OF PUBLIC AFFAIRS'));
            options.add(new SelectOption('OFFICE OF THE PARDON ATTORNEY','OFFICE OF THE PARDON ATTORNEY'));
            options.add(new SelectOption('UNITED STATES MARSHALS SERVICE','UNITED STATES MARSHALS SERVICE'));
            options.add(new SelectOption('EXECUTIVE OFFICE FOR IMMIGRATION REVIEW','EXECUTIVE OFFICE FOR IMMIGRATION REVIEW'));
            options.add(new SelectOption('OFFICE OF JUSTICE PROGRAMS','OFFICE OF JUSTICE PROGRAMS'));
            options.add(new SelectOption('COMMUNITY RELATIONS SERVICE','COMMUNITY RELATIONS SERVICE'));
            options.add(new SelectOption('UNITED STATES PAROLE COMMISSION','UNITED STATES PAROLE COMMISSION'));
            options.add(new SelectOption('DRUG ENFORCEMENT ADMINISTRATION','DRUG ENFORCEMENT ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF THE SPECIAL PROSECUTOR','OFFICE OF THE SPECIAL PROSECUTOR'));
            options.add(new SelectOption('OFFICE OF U.S. ATTORNEYS','OFFICE OF U.S. ATTORNEYS'));
            options.add(new SelectOption('FOREIGN CLAIMS SETTLEMENT COMMISSION','FOREIGN CLAIMS SETTLEMENT COMMISSION'));
            options.add(new SelectOption('OFFICE OF SPECIAL COUNSEL','OFFICE OF SPECIAL COUNSEL'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF VIOLENCE AGAINST WOMEN','OFFICE OF VIOLENCE AGAINST WOMEN'));
            options.add(new SelectOption('BUREAU OF ALCOHOL,TOBACCO,FIREARMS AND EXPLOSIVES','BUREAU OF ALCOHOL,TOBACCO,FIREARMS AND EXPLOSIVES'));
        }
        else if(agency == 'DEPARTMENT OF LABOR') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF LABOR','DEPARTMENT OF LABOR'));
            options.add(new SelectOption('OFFICE OF THE ASSISTANT SECRETARY FOR ADMINISTRATION AND MANAGEMENT','OFFICE OF THE ASSISTANT SECRETARY FOR ADMINISTRATION AND MANAGEMENT'));
            options.add(new SelectOption('MINE SAFETY AND HEALTH ADMINISTRATION','MINE SAFETY AND HEALTH ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('EMPLOYEE BENEFITS SECURITY ADMINSTRATION','EMPLOYEE BENEFITS SECURITY ADMINSTRATION'));
            options.add(new SelectOption('PENSION BENEFIT GUARANTY CORPORATION','PENSION BENEFIT GUARANTY CORPORATION'));
            options.add(new SelectOption('OFFICE OF LABOR MANAGEMENT STANDARDS','OFFICE OF LABOR MANAGEMENT STANDARDS'));
            options.add(new SelectOption('BUREAU OF INTERNATIONAL LABOR AFFAIRS','BUREAU OF INTERNATIONAL LABOR AFFAIRS'));
            options.add(new SelectOption('OFFICE OF THE CHIEF FINANCIAL OFFICER','OFFICE OF THE CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('OCCUPATIONAL SAFETY AND HEALTH ADMINISTRATION','OCCUPATIONAL SAFETY AND HEALTH ADMINISTRATION'));
            options.add(new SelectOption('BUREAU OF LABOR STATISTICS','BUREAU OF LABOR STATISTICS'));
            options.add(new SelectOption('EMPLOYMENT AND TRAINING ADMINISTRATION','EMPLOYMENT AND TRAINING ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('EMPLOYMENT STANDARDS ADMINISTRATION','EMPLOYMENT STANDARDS ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF THE SOLICITOR','OFFICE OF THE SOLICITOR'));
            options.add(new SelectOption('VETERANS EMPLOYMENT AND TRAINING ADMINISTRATION','VETERANS EMPLOYMENT AND TRAINING ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF PUBLIC ENGAGEMENT','OFFICE OF PUBLIC ENGAGEMENT'));
            options.add(new SelectOption('OFFICE OF CONGRESSIONAL AND INTERGOVERNMENTAL AFFAIRS','OFFICE OF CONGRESSIONAL AND INTERGOVERNMENTAL AFFAIRS'));
            options.add(new SelectOption('OFFICE OF THE ASSISTANT SECRETARY FOR POLICY','OFFICE OF THE ASSISTANT SECRETARY FOR POLICY'));
            options.add(new SelectOption('WOMEN\'S BUREAU','WOMEN\'S BUREAU'));
            options.add(new SelectOption('BENEFITS REVIEW BOARD','BENEFITS REVIEW BOARD'));
            options.add(new SelectOption('EMPLOYEES COMPENSATION APPEALS BOARD','EMPLOYEES COMPENSATION APPEALS BOARD'));
            options.add(new SelectOption('ADMINISTRATIVE REVIEW BOARD','ADMINISTRATIVE REVIEW BOARD'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATIVE LAW JUDGES','OFFICE OF ADMINISTRATIVE LAW JUDGES'));
            options.add(new SelectOption('OFFICE OF WORKERS COMPENSATION PROGRAMS','OFFICE OF WORKERS COMPENSATION PROGRAMS'));
            options.add(new SelectOption('WAGE AND HOUR DIVISION','WAGE AND HOUR DIVISION'));
            options.add(new SelectOption('OFFICE OF FEDERAL CONTRACT COMPLIANCE PROGRAMS','OFFICE OF FEDERAL CONTRACT COMPLIANCE PROGRAMS'));
            options.add(new SelectOption('CENTER FOR FAITH-BASED AND NEIGHBORHOOD PARTNERSHIPS','CENTER FOR FAITH-BASED AND NEIGHBORHOOD PARTNERSHIPS'));
            options.add(new SelectOption('OFFICE OF DISABILITY EMPLOYMENT POLICY','OFFICE OF DISABILITY EMPLOYMENT POLICY'));
            options.add(new SelectOption('OMBUDSMAN FOR ENERGY EMPLOYEES OCCUPATIONAL ILLNESS COMPENSATION PROGRAM','OMBUDSMAN FOR ENERGY EMPLOYEES OCCUPATIONAL ILLNESS COMPENSATION PROGRAM'));
        }
        else if(agency == 'DEPARTMENT OF THE NAVY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF THE NAVY','DEPARTMENT OF THE NAVY'));
            options.add(new SelectOption('SECRETARY OF THE NAVY','SECRETARY OF THE NAVY'));
            options.add(new SelectOption('CHIEF OF NAVAL RESEARCH','CHIEF OF NAVAL RESEARCH'));
            options.add(new SelectOption('COMMANDER IN CHIEF PACIFIC FLEET','COMMANDER IN CHIEF PACIFIC FLEET'));
            options.add(new SelectOption('COMPTROLLER OF THE NAVY','COMPTROLLER OF THE NAVY'));
            options.add(new SelectOption('COMMANDER IN CHIEF ATLANTIC FLEET','COMMANDER IN CHIEF ATLANTIC FLEET'));
            options.add(new SelectOption('CHIEF OF NAVAL OPERATIONS','CHIEF OF NAVAL OPERATIONS'));
            options.add(new SelectOption('NAVAL SEA SYSTEMS COMMAND','NAVAL SEA SYSTEMS COMMAND'));
            options.add(new SelectOption('CHIEF OF NAVAL EDUCATION AND TRAINING','CHIEF OF NAVAL EDUCATION AND TRAINING'));
            options.add(new SelectOption('COMMANDER, NAVAL AIR ATLANTIC FLEET','COMMANDER, NAVAL AIR ATLANTIC FLEET'));
            options.add(new SelectOption('CHIEF OF NAVAL PERSONNEL','CHIEF OF NAVAL PERSONNEL'));
            options.add(new SelectOption('COMMANDER, NAVAL FACILITIES ENGINEERING COMMAND','COMMANDER, NAVAL FACILITIES ENGINEERING COMMAND'));
            options.add(new SelectOption('BUREAU OF MEDICINE AND SURGERY','BUREAU OF MEDICINE AND SURGERY'));
            options.add(new SelectOption('COMMANDER, NAVAL AIR PACIFIC FLEET','COMMANDER, NAVAL AIR PACIFIC FLEET'));
            options.add(new SelectOption('NAVAL MATERIEL COMMAND','NAVAL MATERIEL COMMAND'));
            options.add(new SelectOption('SPACE AND NAVAL WARFARE SYSTEMS COMMAND','SPACE AND NAVAL WARFARE SYSTEMS COMMAND'));
            options.add(new SelectOption('OCEANOGRAPHER OF THE NAVY','OCEANOGRAPHER OF THE NAVY'));
            options.add(new SelectOption('COMMANDER, NAVAL SUPPLY SYSTEMS COMMAND','COMMANDER, NAVAL SUPPLY SYSTEMS COMMAND'));
            options.add(new SelectOption('NAVAL TELECOMMUNICATIONS COMMAND','NAVAL TELECOMMUNICATIONS COMMAND'));
            options.add(new SelectOption('COMMANDER, NAVAL AIR SYSTEMS COMMAND','COMMANDER, NAVAL AIR SYSTEMS COMMAND'));
            options.add(new SelectOption('NAVAL SECURITY GROUP ACTIVITY','NAVAL SECURITY GROUP ACTIVITY'));
            options.add(new SelectOption('NAVAL INTELLIGENCE COMMAND HEADQUARTERS','NAVAL INTELLIGENCE COMMAND HEADQUARTERS'));
            options.add(new SelectOption('COMMANDING GENERAL, 4TH MARINE DIVISION','COMMANDING GENERAL, 4TH MARINE DIVISION'));
            options.add(new SelectOption('COMMANDER, NAVAL WEATHER SERVICE COMMAND','COMMANDER, NAVAL WEATHER SERVICE COMMAND'));
            options.add(new SelectOption('NAVAL RESERVE RECRUITING COMMAND AREA PACIFIC','NAVAL RESERVE RECRUITING COMMAND AREA PACIFIC'));
            options.add(new SelectOption('COMMANDER MILITARY SEALIFT COMMAND','COMMANDER MILITARY SEALIFT COMMAND'));
            options.add(new SelectOption('DEPT OF NAVY/MARINE CORPS MOBILIZATION COMMAND','DEPT OF NAVY/MARINE CORPS MOBILIZATION COMMAND'));
            options.add(new SelectOption('CHIEF OF NAVAL RESERVE','CHIEF OF NAVAL RESERVE'));
            options.add(new SelectOption('NAVY RESALE SYSTEMS OFFICE','NAVY RESALE SYSTEMS OFFICE'));
            options.add(new SelectOption('COMMANDANT OF THE MARINE CORPS','COMMANDANT OF THE MARINE CORPS'));
            options.add(new SelectOption('COMMANDER, NAVAL RECRUITING COMMAND','COMMANDER, NAVAL RECRUITING COMMAND'));
            options.add(new SelectOption('U.S. MARINE CORPS, AIR BASES - EASTERN AREA','U.S. MARINE CORPS, AIR BASES - EASTERN AREA'));
            options.add(new SelectOption('U.S. MARINE CORPS, AIR BASES - WESTERN AREA','U.S. MARINE CORPS, AIR BASES - WESTERN AREA'));
            options.add(new SelectOption('U.S. MARINE CORPS, AIR RESERVE TRAINING COMMAND','U.S. MARINE CORPS, AIR RESERVE TRAINING COMMAND'));
            options.add(new SelectOption('U.S. MARINE CORPS, 6TH MARINE CORPS DISTRICT','U.S. MARINE CORPS, 6TH MARINE CORPS DISTRICT'));
            options.add(new SelectOption('U.S. MARINE CORPS, 1ST MARINE CORPS DISTRICT','U.S. MARINE CORPS, 1ST MARINE CORPS DISTRICT'));
            options.add(new SelectOption('U.S. MARINE CORPS, 9TH MARINE CORPS DISTRICT','U.S. MARINE CORPS, 9TH MARINE CORPS DISTRICT'));
            options.add(new SelectOption('U.S. MARINE CORPS, 8TH MARINE CORPS DISTRICT','U.S. MARINE CORPS, 8TH MARINE CORPS DISTRICT'));
            options.add(new SelectOption('U.S. MARINE CORPS, 4TH MARINE CORPS DISTRICT','U.S. MARINE CORPS, 4TH MARINE CORPS DISTRICT'));
            options.add(new SelectOption('U.S. MARINE CORPS, 12TH MARINE CORPS DISTRICT','U.S. MARINE CORPS, 12TH MARINE CORPS DISTRICT'));
            options.add(new SelectOption('CHIEF OF NAVAL TECHNICAL TRAINING','CHIEF OF NAVAL TECHNICAL TRAINING'));
            options.add(new SelectOption('CHIEF OF INFORMATION','CHIEF OF INFORMATION'));
            options.add(new SelectOption('COMMANDER NAVAL INSTALLATIONS','COMMANDER NAVAL INSTALLATIONS'));
        }
        else if(agency == 'UNITED STATES POSTAL SERVICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('UNITED STATES POSTAL SERVICE','UNITED STATES POSTAL SERVICE'));
            options.add(new SelectOption('CHIEF POSTAL INSPECTOR','CHIEF POSTAL INSPECTOR'));
            options.add(new SelectOption('OFFICE OF THE INSPECTOR GENERAL','OFFICE OF THE INSPECTOR GENERAL'));
            options.add(new SelectOption('FINANCE AND ADMINISTRATION','FINANCE AND ADMINISTRATION'));
            options.add(new SelectOption('OPERATIONS','OPERATIONS'));
            options.add(new SelectOption('PERSONNEL','PERSONNEL'));
            options.add(new SelectOption('POSTAL SUPPLY DEPOTS','POSTAL SUPPLY DEPOTS'));
            options.add(new SelectOption('OFFICE OF POSTMASTER GENERAL','OFFICE OF POSTMASTER GENERAL'));
            options.add(new SelectOption('POSTMASTERS','POSTMASTERS'));
            options.add(new SelectOption('REGIONAL COMPTROLLER','REGIONAL COMPTROLLER'));
            options.add(new SelectOption('DISTRICT MANAGERS','DISTRICT MANAGERS'));
            options.add(new SelectOption('COMMISSION ON POSTAL SERVICE','COMMISSION ON POSTAL SERVICE'));
            options.add(new SelectOption('POSTAL RATE COMMISSION','POSTAL RATE COMMISSION'));
        }
        else if(agency == 'DEPARTMENT OF STATE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF STATE','DEPARTMENT OF STATE'));
            options.add(new SelectOption('BUREAU OF ADMINISTRATION','BUREAU OF ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF THE UNDER SECRETARY FOR MANAGEMENT','OFFICE OF THE UNDER SECRETARY FOR MANAGEMENT'));
            options.add(new SelectOption('AFRICAN AFFAIRS','AFRICAN AFFAIRS'));
            options.add(new SelectOption('POLITICAL - MILITARY AFFAIRS','POLITICAL - MILITARY AFFAIRS'));
            options.add(new SelectOption('ECONOMIC AFFAIRS AND BUSINESS AFFAIRS','ECONOMIC AFFAIRS AND BUSINESS AFFAIRS'));
            options.add(new SelectOption('UNDER SECRETARY FOR CIVILIAN SECURITY, DEMOCRACY, AND HUMAN RIGHTS','UNDER SECRETARY FOR CIVILIAN SECURITY, DEMOCRACY, AND HUMAN RIGHTS'));
            options.add(new SelectOption('EUROPEAN AND EURASIAN AFFAIRS','EUROPEAN AND EURASIAN AFFAIRS'));
            options.add(new SelectOption('INTERNATIONAL NARCOTICS AND LAW ENFORCEMENT AFFAIRS','INTERNATIONAL NARCOTICS AND LAW ENFORCEMENT AFFAIRS'));
            options.add(new SelectOption('EAST ASIAN AND PACIFIC AFFAIRS','EAST ASIAN AND PACIFIC AFFAIRS'));
            options.add(new SelectOption('INTELLIGENCE AND RESEARCH','INTELLIGENCE AND RESEARCH'));
            options.add(new SelectOption('BUREAU OF AFRICAN AFFAIRS','BUREAU OF AFRICAN AFFAIRS'));
            options.add(new SelectOption('UNDER SECRETARY FOR ECONOMIC GROWTH, ENERGY, AND ENVIRONMENT','UNDER SECRETARY FOR ECONOMIC GROWTH, ENERGY, AND ENVIRONMENT'));
            options.add(new SelectOption('INTERNATIONAL BOUNDARY AND WATER COMMISSION, U.S. AND MEXICO','INTERNATIONAL BOUNDARY AND WATER COMMISSION, U.S. AND MEXICO'));
            options.add(new SelectOption('INTERNATIONAL ORGANIZATION AFFAIRS','INTERNATIONAL ORGANIZATION AFFAIRS'));
            options.add(new SelectOption('OCEAN AND INTERNATIONAL ENVIRONMENTAL AND SCIENTIFIC AFFAIRS','OCEAN AND INTERNATIONAL ENVIRONMENTAL AND SCIENTIFIC AFFAIRS'));
            options.add(new SelectOption('NEAR EASTERN AFFAIRS','NEAR EASTERN AFFAIRS'));
            options.add(new SelectOption('PUBLIC AFFAIRS','PUBLIC AFFAIRS'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY OF STATE','OFFICE OF THE SECRETARY OF STATE'));
            options.add(new SelectOption('CHIEF INFORMATION OFFICER','CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('CONSULAR AFFAIRS','CONSULAR AFFAIRS'));
            options.add(new SelectOption('OFFICE OF FOREIGN MISSIONS','OFFICE OF FOREIGN MISSIONS'));
            options.add(new SelectOption('UNITED STATES MISSION TO THE UNITED NATIONS','UNITED STATES MISSION TO THE UNITED NATIONS'));
            options.add(new SelectOption('BUDGET AND PLANNING','BUDGET AND PLANNING'));
            options.add(new SelectOption('OVERSEAS BUILDINGS OPERATIONS','OVERSEAS BUILDINGS OPERATIONS'));
            options.add(new SelectOption('FOREIGN SERVICE INSTITUTE','FOREIGN SERVICE INSTITUTE'));
            options.add(new SelectOption('INSPECTOR GENERAL','INSPECTOR GENERAL'));
            options.add(new SelectOption('LEGAL ADVISER','LEGAL ADVISER'));
            options.add(new SelectOption('UNDER SECRETARY FOR ARMS CONTROL AND INTERNATIONAL SECURITY','UNDER SECRETARY FOR ARMS CONTROL AND INTERNATIONAL SECURITY'));
            options.add(new SelectOption('DIPLOMATIC SECURITY','DIPLOMATIC SECURITY'));
            options.add(new SelectOption('DEPUTY SECRETARY FOR MANAGEMENT AND RESOURCES','DEPUTY SECRETARY FOR MANAGEMENT AND RESOURCES'));
            // for version 1.4
            options.add(new SelectOption('BUREAU OF INTERNATIONAL INFORMATION PROGRAMS','BUREAU OF INTERNATIONAL INFORMATION PROGRAMS'));
            // for version 1.5
            options.add(new SelectOption('BUREAU OF HUMAN RESOURCES','BUREAU OF HUMAN RESOURCES'));
            // for version 1.6
            options.add(new SelectOption('BUREAU OF LEGISLATIVE AFFAIRS','BUREAU OF LEGISLATIVE AFFAIRS'));
            // for version 1.8
            options.add(new SelectOption('BUREAU OF COUNTERTERRORISM','BUREAU OF COUNTERTERRORISM'));
            options.add(new SelectOption('BUREAU OF EDUCATION AND CULTURAL AFFAIRS','BUREAU OF EDUCATION AND CULTURAL AFFAIRS'));
        }
        else if(agency == 'DEPARTMENT OF THE TREASURY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF THE TREASURY','DEPARTMENT OF THE TREASURY'));
            options.add(new SelectOption('OFFICE OF FINANCIAL RESEARCH','OFFICE OF FINANCIAL RESEARCH'));
            options.add(new SelectOption('OFFICE OF THE COMPTROLLER OF THE CURRENCY','OFFICE OF THE COMPTROLLER OF THE CURRENCY'));
            options.add(new SelectOption('OFFICE OF LEGISLATIVE AFFAIRS','OFFICE OF LEGISLATIVE AFFAIRS'));
            options.add(new SelectOption('OFFICE OF MANAGEMENT','OFFICE OF MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF INTERNATIONAL AFFAIRS','OFFICE OF INTERNATIONAL AFFAIRS'));
            options.add(new SelectOption('BUREAU OF ENGRAVING AND PRINTING','BUREAU OF ENGRAVING AND PRINTING'));
            options.add(new SelectOption('INTERNAL REVENUE SERVICE','INTERNAL REVENUE SERVICE'));
            options.add(new SelectOption('UNITED STATES MINT - DENVER','UNITED STATES MINT - DENVER'));
            options.add(new SelectOption('UNITED STATES MINT-WASHINGTON DC','UNITED STATES MINT-WASHINGTON DC'));
            options.add(new SelectOption('UNITED STATES MINT-SAN FRANCISCO','UNITED STATES MINT-SAN FRANCISCO'));
            options.add(new SelectOption('OFFICE OF TERRORISM AND FINANCIAL INTELLIGENCE','OFFICE OF TERRORISM AND FINANCIAL INTELLIGENCE'));
            options.add(new SelectOption('OFFICE OF TAX POLICY','OFFICE OF TAX POLICY'));
            options.add(new SelectOption('TREASURER OF THE UNITED STATES','TREASURER OF THE UNITED STATES'));
            options.add(new SelectOption('FINANCIAL CRIMES ENFORCEMENT NETWORK (FINCEN)','FINANCIAL CRIMES ENFORCEMENT NETWORK (FINCEN)'));
            options.add(new SelectOption('OFFICE OF ECONOMIC POLICY','OFFICE OF ECONOMIC POLICY'));
            options.add(new SelectOption('BUREAU OF THE FISCAL SERVICES','BUREAU OF THE FISCAL SERVICES'));
            options.add(new SelectOption('OFFICE OF THE INSPECTOR GENERAL','OFFICE OF THE INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF THRIFT SUPERVISION','OFFICE OF THRIFT SUPERVISION'));
            options.add(new SelectOption('INTERNAL REVENUE SERVICE - SOUTHEAST REGION','INTERNAL REVENUE SERVICE - SOUTHEAST REGION'));
            options.add(new SelectOption('INTERNAL REVENUE SERVICE - WESTERN REGION','INTERNAL REVENUE SERVICE - WESTERN REGION'));
            options.add(new SelectOption('INTERNAL REVENUE SERVICE - MIDSTATES REGION','INTERNAL REVENUE SERVICE - MIDSTATES REGION'));
            options.add(new SelectOption('INTERNAL REVENUE SERVICE - NORTHEAST REGION','INTERNAL REVENUE SERVICE - NORTHEAST REGION'));
            options.add(new SelectOption('OFFICE OF THE INSPECTOR GENERAL FOR TAX ADMINISTRATION (TIGTA)','OFFICE OF THE INSPECTOR GENERAL FOR TAX ADMINISTRATION (TIGTA)'));
            options.add(new SelectOption('OFFICE OF DOMESTIC FINANCE','OFFICE OF DOMESTIC FINANCE'));
            options.add(new SelectOption('OFFICE OF PUBLIC AFFAIRS','OFFICE OF PUBLIC AFFAIRS'));
            options.add(new SelectOption('ALCOHOL AND TOBACCO TAX AND TRADE BUREAU','ALCOHOL AND TOBACCO TAX AND TRADE BUREAU'));
            options.add(new SelectOption('COMMUNITY DEVELOPMENT FINANCIAL INSTITUTIONS FUND','COMMUNITY DEVELOPMENT FINANCIAL INSTITUTIONS FUND'));
            options.add(new SelectOption('OFFICE OF THE GENERAL COUNSEL','OFFICE OF THE GENERAL COUNSEL'));
            // for version 1.6
            options.add(new SelectOption('OFFICE OF THE SPECIAL INSPECTOR GENERAL FOR THE TROUBLED ASSET RELIEF PROGRAM','OFFICE OF THE SPECIAL INSPECTOR GENERAL FOR THE TROUBLED ASSET RELIEF PROGRAM'));
        }
        else if(agency == 'DEPARTMENT OF THE ARMY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF THE ARMY','DEPARTMENT OF THE ARMY'));
            options.add(new SelectOption('COMMUNICATIONS COMMAND','COMMUNICATIONS COMMAND'));
            options.add(new SelectOption('MILITARY DISTRICT OF WASHINGTON, DC','MILITARY DISTRICT OF WASHINGTON, DC'));
            options.add(new SelectOption('U.S. ARMY INFORMATION SYSTEMS COMMAND','U.S. ARMY INFORMATION SYSTEMS COMMAND'));
            options.add(new SelectOption('ARMY RESERVE','ARMY RESERVE'));
            options.add(new SelectOption('U.S. ARMY INTELLIGENCE AGENCY','U.S. ARMY INTELLIGENCE AGENCY'));
            options.add(new SelectOption('SURGEON GENERAL','SURGEON GENERAL'));
            options.add(new SelectOption('CORPS OF ENGINEERS','CORPS OF ENGINEERS'));
            options.add(new SelectOption('U.S. ARMY SOUTH','U.S. ARMY SOUTH'));
            options.add(new SelectOption('DEFENSE TELECOMMUNICATION SYSTEM - WASHINGTON','DEFENSE TELECOMMUNICATION SYSTEM - WASHINGTON'));
            options.add(new SelectOption('ADJUTANT GENERAL','ADJUTANT GENERAL'));
            options.add(new SelectOption('ARMY INTELLIGENCE AND SECURITY COMMAND','ARMY INTELLIGENCE AND SECURITY COMMAND'));
            options.add(new SelectOption('CRIMINAL INVESTIGATION COMMAND','CRIMINAL INVESTIGATION COMMAND'));
            options.add(new SelectOption('US ARMY MEDICAL COMMAND (MEDCOM)','US ARMY MEDICAL COMMAND (MEDCOM)'));
            options.add(new SelectOption('NATIONAL GUARD BUREAU','NATIONAL GUARD BUREAU'));
            options.add(new SelectOption('THE JUDGE ADVOCATE GENERAL','THE JUDGE ADVOCATE GENERAL'));
            options.add(new SelectOption('MILITARY POLICE CORPS','MILITARY POLICE CORPS'));
            options.add(new SelectOption('U. S. ARMY INSTALLATION MANAGEMENT COMMAND','U. S. ARMY INSTALLATION MANAGEMENT COMMAND'));
            options.add(new SelectOption('MILITARY REVIEW BOARDS','MILITARY REVIEW BOARDS'));
            options.add(new SelectOption('ARMY RECRUITING COMMAND','ARMY RECRUITING COMMAND'));
            options.add(new SelectOption('AUDIT AGENCY','AUDIT AGENCY'));
            options.add(new SelectOption('MILITARY TRAFFIC MANAGEMENT COMMAND','MILITARY TRAFFIC MANAGEMENT COMMAND'));
            options.add(new SelectOption('TRAINING AND DOCTRINE COMMAND','TRAINING AND DOCTRINE COMMAND'));
            options.add(new SelectOption('MATERIEL COMMAND','MATERIEL COMMAND'));
            options.add(new SelectOption('US ARMY PERSONNEL CENTER','US ARMY PERSONNEL CENTER'));
            options.add(new SelectOption('ARMY FORCES COMMAND','ARMY FORCES COMMAND'));
            options.add(new SelectOption('MILITARY ENLISTMENT PROCESSING COMMAND','MILITARY ENLISTMENT PROCESSING COMMAND'));
            options.add(new SelectOption('ALASKA COMMAND','ALASKA COMMAND'));
            options.add(new SelectOption('ARMY COMMUNICATIONS ELECTRONICS COMMAND','ARMY COMMUNICATIONS ELECTRONICS COMMAND'));
            options.add(new SelectOption('US ARMY TEST AND EVALUATION COMMAND','US ARMY TEST AND EVALUATION COMMAND'));
            options.add(new SelectOption('ARMY PROJECT MANAGER, LOGISTICS INFORMATION SYSTEMS','ARMY PROJECT MANAGER, LOGISTICS INFORMATION SYSTEMS'));
            options.add(new SelectOption('ARMY NORTH','ARMY NORTH'));
            options.add(new SelectOption('US ARMY SECURITY ASSISTANCE COMMAND','US ARMY SECURITY ASSISTANCE COMMAND'));
            options.add(new SelectOption('U.S.ARMY CENTRAL COMMAND','U.S.ARMY CENTRAL COMMAND'));
        }
        else if(agency == 'UNITED STATES TAX COURT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('UNITED STATES TAX COURT','UNITED STATES TAX COURT'));
        }
        else if(agency == 'OFFICE OF PERSONNEL MANAGEMENT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('OFFICE OF PERSONNEL MANAGEMENT','OFFICE OF PERSONNEL MANAGEMENT'));
        }
        else if(agency == 'NATIONAL CREDIT UNION ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL CREDIT UNION ADMINISTRATION','NATIONAL CREDIT UNION ADMINISTRATION'));
        }
        else if(agency == 'FEDERAL RETIREMENT THRIFT INVESTMENT BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL RETIREMENT THRIFT INVESTMENT BOARD','FEDERAL RETIREMENT THRIFT INVESTMENT BOARD'));
        }
        else if(agency == 'FEDERAL COMMUNICATIONS COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL COMMUNICATIONS COMMISSION','FEDERAL COMMUNICATIONS COMMISSION'));
        }
        else if(agency == 'SOCIAL SECURITY ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SOCIAL SECURITY ADMINISTRATION','SOCIAL SECURITY ADMINISTRATION'));
            options.add(new SelectOption('SSA OFFICE OF THE INSPECTOR GENERAL','SSA OFFICE OF THE INSPECTOR GENERAL'));
            // for version 1.7
            options.add(new SelectOption('OFFICE OF DISABILITY ADJUDICATION AND REVIEW','OFFICE OF DISABILITY ADJUDICATION AND REVIEW'));
        }
        else if(agency == 'FEDERAL TRADE COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL TRADE COMMISSION','FEDERAL TRADE COMMISSION'));
        }
        else if(agency == 'NUCLEAR REGULATORY COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NUCLEAR REGULATORY COMMISSION','NUCLEAR REGULATORY COMMISSION'));
        }
        else if(agency == 'SMITHSONIAN INSTITUTION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SMITHSONIAN INSTITUTION','SMITHSONIAN INSTITUTION'));
            options.add(new SelectOption('ARCHIVES OF AMERICAN ART','ARCHIVES OF AMERICAN ART'));
            options.add(new SelectOption('SMITHSONIAN ASTROPHYSICAL OBSERVATORY','SMITHSONIAN ASTROPHYSICAL OBSERVATORY'));
            options.add(new SelectOption('SMITHSONIAN TROPICAL RESEARCH INSTITUTE','SMITHSONIAN TROPICAL RESEARCH INSTITUTE'));
            options.add(new SelectOption('FREER GALLERY OF ART','FREER GALLERY OF ART'));
            options.add(new SelectOption('JOHN F. KENNEDY CENTER FOR THE PERFORMING ARTS','JOHN F. KENNEDY CENTER FOR THE PERFORMING ARTS'));
            options.add(new SelectOption('NATIONAL MUSEUM OF HISTORY AND TECHNOLOGY','NATIONAL MUSEUM OF HISTORY AND TECHNOLOGY'));
            options.add(new SelectOption('NATIONAL MUSEUM OF NATURAL HISTORY','NATIONAL MUSEUM OF NATURAL HISTORY'));
            options.add(new SelectOption('NATIONAL AIR AND SPACE MUSEUM','NATIONAL AIR AND SPACE MUSEUM'));
            options.add(new SelectOption('NATIONAL COLLECTION OF FINE ARTS','NATIONAL COLLECTION OF FINE ARTS'));
            options.add(new SelectOption('NATIONAL PORTRAIT GALLERY','NATIONAL PORTRAIT GALLERY'));
            options.add(new SelectOption('NATIONAL GALLERY OF ART','NATIONAL GALLERY OF ART'));
            options.add(new SelectOption('MARINE SCIENCE CENTER','MARINE SCIENCE CENTER'));
            options.add(new SelectOption('NATIONAL ZOOLOGICAL PARK','NATIONAL ZOOLOGICAL PARK'));
            options.add(new SelectOption('RADIATION BIOLOGY LABORATORY','RADIATION BIOLOGY LABORATORY'));
            options.add(new SelectOption('UNITED STATES NATIONAL MUSEUM','UNITED STATES NATIONAL MUSEUM'));
            options.add(new SelectOption('JOSEPH H. HIRSHHORN MUSEUM AND SCULPTURE GARDEN','JOSEPH H. HIRSHHORN MUSEUM AND SCULPTURE GARDEN'));
            options.add(new SelectOption('OFFICE OF PUBLIC AFFAIRS','OFFICE OF PUBLIC AFFAIRS'));
            options.add(new SelectOption('DIVISION ON PERFORMING ARTS','DIVISION ON PERFORMING ARTS'));
            options.add(new SelectOption('WOODROW WILSON INTERNATIONAL CENTER FOR SCHOLARS','WOODROW WILSON INTERNATIONAL CENTER FOR SCHOLARS'));
            options.add(new SelectOption('NATIONAL MUSEUM OF AMERICAN HISTORY','NATIONAL MUSEUM OF AMERICAN HISTORY'));
            // for version 1.6
            options.add(new SelectOption('SMITHSONIAN AMERICAN ART MUSEUM','SMITHSONIAN AMERICAN ART MUSEUM'));
        }
        else if(agency == 'INTERNATIONAL TRADE COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('INTERNATIONAL TRADE COMMISSION','INTERNATIONAL TRADE COMMISSION'));
        }
        else if(agency == 'DEPARTMENT OF VETERANS AFFAIRS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF VETERANS AFFAIRS','DEPARTMENT OF VETERANS AFFAIRS'));
            options.add(new SelectOption('INSPECTOR GENERAL','INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF OPERATIONS, SECURITY, AND PREPAREDNESS','OFFICE OF OPERATIONS, SECURITY, AND PREPAREDNESS'));
            options.add(new SelectOption('OFFICE OF POLICY AND PLANNING','OFFICE OF POLICY AND PLANNING'));
            options.add(new SelectOption('OFFICE OF INFORMATION AND TECHNOLOGY','OFFICE OF INFORMATION AND TECHNOLOGY'));
            options.add(new SelectOption('DEPARTMENT OF MEDICINE AND SURGERY','DEPARTMENT OF MEDICINE AND SURGERY'));
            options.add(new SelectOption('DEPARTMENT OF MEMORIAL AFFAIRS','DEPARTMENT OF MEMORIAL AFFAIRS'));
            options.add(new SelectOption('VETERANS BENEFITS ADMINISTRATION','VETERANS BENEFITS ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF GENERAL COUNSEL','OFFICE OF GENERAL COUNSEL'));
            options.add(new SelectOption('OFFICE OF PUBLIC AND INTERGOVERNMENTAL AFFAIRS','OFFICE OF PUBLIC AND INTERGOVERNMENTAL AFFAIRS'));
            options.add(new SelectOption('OFFICE OF CONGRESSIONAL AND LEGISLATIVE AFFAIRS','OFFICE OF CONGRESSIONAL AND LEGISLATIVE AFFAIRS'));
            options.add(new SelectOption('OFFICE OF HUMAN RESOURCES AND ADMINISTRATION','OFFICE OF HUMAN RESOURCES AND ADMINISTRATION'));
            options.add(new SelectOption('VETERANS HEALTH ADMINISTRATION','VETERANS HEALTH ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF MANAGEMENT','OFFICE OF MANAGEMENT'));
            options.add(new SelectOption('NATIONAL CEMETARY ADMINISTRATION','NATIONAL CEMETARY ADMINISTRATION'));
        }
        else if(agency == 'MERIT SYSTEMS PROTECTION BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('MERIT SYSTEMS PROTECTION BOARD','MERIT SYSTEMS PROTECTION BOARD'));
        }
        else if(agency == 'EQUAL EMPLOYMENT OPPORTUNITY COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('EQUAL EMPLOYMENT OPPORTUNITY COMMISSION','EQUAL EMPLOYMENT OPPORTUNITY COMMISSION'));
        }
        else if(agency == 'REGIONAL COMMISSIONS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('REGIONAL COMMISSIONS','REGIONAL COMMISSIONS'));
            options.add(new SelectOption('DELAWARE RIVER BASIN COMMISSION','DELAWARE RIVER BASIN COMMISSION'));
            options.add(new SelectOption('APPALACHIAN REGIONAL COMMISSION','APPALACHIAN REGIONAL COMMISSION'));
            options.add(new SelectOption('WASHINGTON METROPOLITAN AREA TRANSIT AUTHORITY','WASHINGTON METROPOLITAN AREA TRANSIT AUTHORITY'));
            options.add(new SelectOption('MARTIN LUTHER KING JR. FEDERAL HOLIDAY COMMISSION','MARTIN LUTHER KING JR. FEDERAL HOLIDAY COMMISSION'));
        }
        else if(agency == 'GENERAL SERVICES ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('GENERAL SERVICES ADMINISTRATION','GENERAL SERVICES ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATOR','OFFICE OF ADMINISTRATOR'));
            options.add(new SelectOption('OFFICE OF CHIEF ACQUISITION OFFICER','OFFICE OF CHIEF ACQUISITION OFFICER'));
            options.add(new SelectOption('OFFICE OF THE CHIEF FINANCIAL OFFICER','OFFICE OF THE CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF CIVIL RIGHTS','OFFICE OF CIVIL RIGHTS'));
            options.add(new SelectOption('OFFICE OF GOVERNMENTWIDE POLICY','OFFICE OF GOVERNMENTWIDE POLICY'));
            options.add(new SelectOption('OFFICE OF MISSION ASSURANCE','OFFICE OF MISSION ASSURANCE'));
            options.add(new SelectOption('OFFICE OF CITIZEN SERVICES AND INNOVATIVE TECHNOLOGIES','OFFICE OF CITIZEN SERVICES AND INNOVATIVE TECHNOLOGIES'));
            options.add(new SelectOption('OFFICE OF SMALL BUSINESS UTILITZATION','OFFICE OF SMALL BUSINESS UTILITZATION'));
            options.add(new SelectOption('OFFICE OF COMMUNICATIONS AND MARKETING','OFFICE OF COMMUNICATIONS AND MARKETING'));
            options.add(new SelectOption('OFFICE OF GENERAL COUNSEL','OFFICE OF GENERAL COUNSEL'));
            options.add(new SelectOption('CIVILIAN BOARD OF CONTRACT APPEALS','CIVILIAN BOARD OF CONTRACT APPEALS'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE ','PUBLIC BUILDINGS SERVICE '));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF REAL PROPERTY ASSET MANAGEMENT','PUBLIC BUILDINGS SERVICE - OFFICE OF REAL PROPERTY ASSET MANAGEMENT'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF THE COMMISSIONER','PUBLIC BUILDINGS SERVICE - OFFICE OF THE COMMISSIONER'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF LEASING','PUBLIC BUILDINGS SERVICE - OFFICE OF LEASING'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF DESIGN AND CONSTRUCTION','PUBLIC BUILDINGS SERVICE - OFFICE OF DESIGN AND CONSTRUCTION'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF FACILITIES MANAGEMENT AND SERVICES PROGRAMS','PUBLIC BUILDINGS SERVICE - OFFICE OF FACILITIES MANAGEMENT AND SERVICES PROGRAMS'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF ACQUISITION','PUBLIC BUILDINGS SERVICE - OFFICE OF ACQUISITION'));
            options.add(new SelectOption('CONGRESSIONAL AND INTERGOVERNMENTAL AFFAIRS','CONGRESSIONAL AND INTERGOVERNMENTAL AFFAIRS'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF STRATEGIC PLANNING AND PERFORMANCE MANAGEMENT','PUBLIC BUILDINGS SERVICE - OFFICE OF STRATEGIC PLANNING AND PERFORMANCE MANAGEMENT'));
            options.add(new SelectOption('PUBLIC BUILDINGS SERVICE - OFFICE OF CLIENT SOLUTIONS','PUBLIC BUILDINGS SERVICE - OFFICE OF CLIENT SOLUTIONS'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF THE COMMISSIONER','FEDERAL ACQUISITION SERVICE - OFFICE OF THE COMMISSIONER'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF INTEGRATED TECHNOLOGY SERVICES','FEDERAL ACQUISITION SERVICE - OFFICE OF INTEGRATED TECHNOLOGY SERVICES'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF ASSISTED ACQUISITION SERVICES','FEDERAL ACQUISITION SERVICE - OFFICE OF ASSISTED ACQUISITION SERVICES'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF GENERAL SUPPLIES AND SERVICES','FEDERAL ACQUISITION SERVICE - OFFICE OF GENERAL SUPPLIES AND SERVICES'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF TRAVEL, MOTOR AND VEHICLE SERVICES','FEDERAL ACQUISITION SERVICE - OFFICE OF TRAVEL, MOTOR AND VEHICLE SERVICES'));
            options.add(new SelectOption('OFFICE OF THE CHIEF INFORMATION OFFICER','OFFICE OF THE CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF CUSTOMER ACCOUNTS AND RESEARCH','FEDERAL ACQUISITION SERVICE - OFFICE OF CUSTOMER ACCOUNTS AND RESEARCH'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF STRATEGY MANAGEMENT','FEDERAL ACQUISITION SERVICE - OFFICE OF STRATEGY MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATIVE SERVICES','OFFICE OF ADMINISTRATIVE SERVICES'));
            options.add(new SelectOption('OFFICE OF HUMAN RESOURCES MANAGEMENT','OFFICE OF HUMAN RESOURCES MANAGEMENT'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF ACQUISITION MANAGEMENT','FEDERAL ACQUISITION SERVICE - OFFICE OF ACQUISITION MANAGEMENT'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE - OFFICE OF INTEGRATED AWARD ENVIRONMENT','FEDERAL ACQUISITION SERVICE - OFFICE OF INTEGRATED AWARD ENVIRONMENT'));
            options.add(new SelectOption('FEDERAL ACQUISITION SERVICE','FEDERAL ACQUISITION SERVICE'));
        }
        else if(agency == 'U.S. COMMISSIONS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('U.S. COMMISSIONS','U.S. COMMISSIONS'));
            options.add(new SelectOption('NATIONAL COMMISSION TO PREVENT INFANT MORTALITY','NATIONAL COMMISSION TO PREVENT INFANT MORTALITY'));
            options.add(new SelectOption('COMMISSION FOR THE STUDY OF INTERNATIONAL MIGRATION AND COOPERATIVE ECONOMIC DEVELOPMENT','COMMISSION FOR THE STUDY OF INTERNATIONAL MIGRATION AND COOPERATIVE ECONOMIC DEVELOPMENT'));
            options.add(new SelectOption('INTERNATIONAL CULTURAL AND TRADE CENTER COMMISSION','INTERNATIONAL CULTURAL AND TRADE CENTER COMMISSION'));
            options.add(new SelectOption('NATIONAL ECONOMIC COMMISSION','NATIONAL ECONOMIC COMMISSION'));
            options.add(new SelectOption('NATIONAL BANKRUPTCY REVIEW COMMISSION','NATIONAL BANKRUPTCY REVIEW COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON RESTRUCTURING THE IRS ','NATIONAL COMMISSION ON RESTRUCTURING THE IRS '));
            options.add(new SelectOption('NATIONAL ALCOHOL FUELS COMMISSION','NATIONAL ALCOHOL FUELS COMMISSION'));
            options.add(new SelectOption('COMMISSION ON RAILROAD RETIREMENT REFORM','COMMISSION ON RAILROAD RETIREMENT REFORM'));
            options.add(new SelectOption('COMMISSION ON AGRICULTURAL WORKERS','COMMISSION ON AGRICULTURAL WORKERS'));
            options.add(new SelectOption('NUCLEAR WASTE TECHNICAL REVIEW BOARD','NUCLEAR WASTE TECHNICAL REVIEW BOARD'));
            options.add(new SelectOption('PRESIDENTIAL COMMISSION ON CATASTROPHIC NUCLEAR ACCIDENTS','PRESIDENTIAL COMMISSION ON CATASTROPHIC NUCLEAR ACCIDENTS'));
            options.add(new SelectOption('OFFICE OF NUCLEAR WASTE NEGOTIATOR','OFFICE OF NUCLEAR WASTE NEGOTIATOR'));
            options.add(new SelectOption('INTERAGENCY COUNCIL FOR THE HOMELESS','INTERAGENCY COUNCIL FOR THE HOMELESS'));
            options.add(new SelectOption('NATIONAL COMMISSION ON SEVERELY DISTRESSED PUBLIC HOUSING','NATIONAL COMMISSION ON SEVERELY DISTRESSED PUBLIC HOUSING'));
            options.add(new SelectOption('NATIONAL COMMISSION ON AMERICAN INDIAN, ALASKA NATIVE, AND NATIVE HAWAIIAN HOUSING','NATIONAL COMMISSION ON AMERICAN INDIAN, ALASKA NATIVE, AND NATIVE HAWAIIAN HOUSING'));
            options.add(new SelectOption('NATIONAL COMMISSION ON JUDICIAL DISCIPLINE AND REMOVAL','NATIONAL COMMISSION ON JUDICIAL DISCIPLINE AND REMOVAL'));
            options.add(new SelectOption('JOINT FEDERAL-STATE COMMISSION ON POLICIES AND PROGRAMS AFFECTING ALASKA NATIVES','JOINT FEDERAL-STATE COMMISSION ON POLICIES AND PROGRAMS AFFECTING ALASKA NATIVES'));
            options.add(new SelectOption('UNITED STATES COMMISSION ON IMPROVING THE EFFECTIVENESS OF THE UNITED NATIONS','UNITED STATES COMMISSION ON IMPROVING THE EFFECTIVENESS OF THE UNITED NATIONS'));
            options.add(new SelectOption('NATIONAL COMMISSION ON MANUFACTURED HOUSING','NATIONAL COMMISSION ON MANUFACTURED HOUSING'));
            options.add(new SelectOption('THOMAS JEFFERSON COMMEMORATION COMMISSION','THOMAS JEFFERSON COMMEMORATION COMMISSION'));
            options.add(new SelectOption('JOHN F. KENNEDY ASSASSINATION RECORDS REVIEW BOARD','JOHN F. KENNEDY ASSASSINATION RECORDS REVIEW BOARD'));
            options.add(new SelectOption('COMMISSION RAIL ROAD RETIREMENT','COMMISSION RAIL ROAD RETIREMENT'));
            options.add(new SelectOption('MEDICARE PAYMENT ADVISORY COMMISSION','MEDICARE PAYMENT ADVISORY COMMISSION'));
            options.add(new SelectOption('OFFICE OF NAVAJO AND HOPI INDIAN RELOCATION','OFFICE OF NAVAJO AND HOPI INDIAN RELOCATION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON STUDENT FINANCIAL ASSISTANCE','NATIONAL COMMISSION ON STUDENT FINANCIAL ASSISTANCE'));
            options.add(new SelectOption('COMMISSION ON THE UKRAINE FAMINE','COMMISSION ON THE UKRAINE FAMINE'));
            options.add(new SelectOption('STATE JUSTICE INSTITUTE','STATE JUSTICE INSTITUTE'));
            options.add(new SelectOption('COMMISSION ON EDUCATION OF THE DEAF','COMMISSION ON EDUCATION OF THE DEAF'));
            options.add(new SelectOption('AVIATION SAFETY COMMISSION','AVIATION SAFETY COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON FINANCIAL INSTITUTION REFORM, RECOVERY AND ENFORCEMENT','NATIONAL COMMISSION ON FINANCIAL INSTITUTION REFORM, RECOVERY AND ENFORCEMENT'));
            options.add(new SelectOption('NATIONAL GRAMBLING IMPACT STUDY COMMISSION','NATIONAL GRAMBLING IMPACT STUDY COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON COST OF HIGHER EDUCATION','NATIONAL COMMISSION ON COST OF HIGHER EDUCATION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON ADVANCEMENT OF FEDERAL LAW ENFORCEMENT','NATIONAL COMMISSION ON ADVANCEMENT OF FEDERAL LAW ENFORCEMENT'));
            options.add(new SelectOption('MEDICARE PAYMENT ADVISORY COMMISSION','MEDICARE PAYMENT ADVISORY COMMISSION'));
            options.add(new SelectOption('PRESIDENT\'S ADVISORY COMMISSION ON HOLOCAUST ASSETS IN THE UNITED STATES','PRESIDENT\'S ADVISORY COMMISSION ON HOLOCAUST ASSETS IN THE UNITED STATES'));
            options.add(new SelectOption('COMMISSION ON OCEAN POLICY','COMMISSION ON OCEAN POLICY'));
            options.add(new SelectOption('COMMISSION ON ON-LINE CHILD PROTECTION','COMMISSION ON ON-LINE CHILD PROTECTION'));
            options.add(new SelectOption('COMMISSION ON AFFORDABLE HOUSING AND HEALTH CARE FACILITY NEEDS IN THE 21ST CENTURY','COMMISSION ON AFFORDABLE HOUSING AND HEALTH CARE FACILITY NEEDS IN THE 21ST CENTURY'));
            options.add(new SelectOption('DWIGHT D. EISENHOWER MEMORIAL COMMISSION','DWIGHT D. EISENHOWER MEMORIAL COMMISSION'));
            options.add(new SelectOption('U.S. CHINA SECURITY REVIEW COMMISSION','U.S. CHINA SECURITY REVIEW COMMISSION'));
            options.add(new SelectOption('COMMISSION FOR INTERNATIONAL RELIGIOUS FREEDOM','COMMISSION FOR INTERNATIONAL RELIGIOUS FREEDOM'));
            options.add(new SelectOption('TRADE DEFICIT REVIEW COMMISSION','TRADE DEFICIT REVIEW COMMISSION'));
            options.add(new SelectOption('MILLENNIAL HOUSING COMMISSION','MILLENNIAL HOUSING COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON TERRORIST ATTACKS UPON THE UNITED STATES','NATIONAL COMMISSION ON TERRORIST ATTACKS UPON THE UNITED STATES'));
            options.add(new SelectOption('FINANCIAL CRISIS INQUIRY COMMISSION','FINANCIAL CRISIS INQUIRY COMMISSION'));
            options.add(new SelectOption('MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION','MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON CHILDREN','NATIONAL COMMISSION ON CHILDREN'));
            options.add(new SelectOption('HELPING ENHANCE THE LIVELIHOOD OF PEOPLE AROUND THE GLOBE','HELPING ENHANCE THE LIVELIHOOD OF PEOPLE AROUND THE GLOBE'));
            options.add(new SelectOption('PREVENT WEAPONS MASS DESTRUCTION PROLIFERATION AND TERROISM','PREVENT WEAPONS MASS DESTRUCTION PROLIFERATION AND TERROISM'));
        }
        else if(agency == 'NATIONAL SCIENCE FOUNDATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL SCIENCE FOUNDATION','NATIONAL SCIENCE FOUNDATION'));
            options.add(new SelectOption('NATIONAL RADIO ASTRONOMY OBSERVATORY','NATIONAL RADIO ASTRONOMY OBSERVATORY'));
            options.add(new SelectOption('NATIONAL CENTER FOR ATMOSPHERIC RESEARCH','NATIONAL CENTER FOR ATMOSPHERIC RESEARCH'));
            options.add(new SelectOption('UNITED STATES ARCTIC RESEARCH COMMISSION','UNITED STATES ARCTIC RESEARCH COMMISSION'));
            options.add(new SelectOption('OFFICE OF DIRECTOR','OFFICE OF DIRECTOR'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('DIRECTORATE FOR BIOLOGICAL SCIENCES','DIRECTORATE FOR BIOLOGICAL SCIENCES'));
            options.add(new SelectOption('DIRECTORATE FOR COMPUTER AND INFORMATION SCIENCE AND ENGINEERING','DIRECTORATE FOR COMPUTER AND INFORMATION SCIENCE AND ENGINEERING'));
            options.add(new SelectOption('DIRECTORATE FOR EDUCATION AND HUMAN RESOURCES','DIRECTORATE FOR EDUCATION AND HUMAN RESOURCES'));
            options.add(new SelectOption('DIRECTORATE FOR ENGINEERING','DIRECTORATE FOR ENGINEERING'));
            options.add(new SelectOption('DIRECTORATE FOR GEOSCIENCES','DIRECTORATE FOR GEOSCIENCES'));
            options.add(new SelectOption('DIRECTORATE FOR MATHEMATICAL AND PHYSICAL SCIENCES','DIRECTORATE FOR MATHEMATICAL AND PHYSICAL SCIENCES'));
            options.add(new SelectOption('DIRECTORATE FOR SOCIAL, BEHAVIORAL, AND ECONOMIC SCIENCES','DIRECTORATE FOR SOCIAL, BEHAVIORAL, AND ECONOMIC SCIENCES'));
            options.add(new SelectOption('OFFICE OF BUDGET, FINANCE, AND AWARD MANAGEMENT','OFFICE OF BUDGET, FINANCE, AND AWARD MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF INFORMATION AND RESOURCE MANAGEMENT','OFFICE OF INFORMATION AND RESOURCE MANAGEMENT'));
        }
        else if(agency == 'SECURITIES AND EXCHANGE COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SECURITIES AND EXCHANGE COMMISSION','SECURITIES AND EXCHANGE COMMISSION'));
        }
        else if(agency == 'FEDERAL DEPOSIT INSURANCE CORPORATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL DEPOSIT INSURANCE CORPORATION','FEDERAL DEPOSIT INSURANCE CORPORATION'));
        }
        else if(agency == 'PERMIT AND ENFORCE FED INSPCTOR FOR THE ALSKA GAS PIPELINE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('PERMITTING AND ENFORCEMENT FEDERAL INSPECTOR FOR THE ALASKA GAS PIPELINE','PERMITTING AND ENFORCEMENT FEDERAL INSPECTOR FOR THE ALASKA GAS PIPELINE'));
        }
        else if(agency == 'FEDERAL LABOR RELATIONS AUTHORITY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL LABOR RELATIONS AUTHORITY','FEDERAL LABOR RELATIONS AUTHORITY'));
        }
        else if(agency == 'CENTRAL INTELLIGENCE AGENCY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CENTRAL INTELLIGENCE AGENCY','CENTRAL INTELLIGENCE AGENCY'));
        }
        else if(agency == 'DEPARTMENT OF THE AIR FORCE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF THE AIR FORCE','DEPARTMENT OF THE AIR FORCE'));
            options.add(new SelectOption('HEADQUARTERS, AIR STAFF','HEADQUARTERS, AIR STAFF'));
            options.add(new SelectOption('AIR FORCE DISTRICT OF WASHINGTON','AIR FORCE DISTRICT OF WASHINGTON'));
            options.add(new SelectOption('AIR FORCE SPACE COMMAND','AIR FORCE SPACE COMMAND'));
            options.add(new SelectOption('ACCOUNTING AND FINANCE CENTER','ACCOUNTING AND FINANCE CENTER'));
            options.add(new SelectOption('AIR FORCE COMMUNICATIONS COMMAND','AIR FORCE COMMUNICATIONS COMMAND'));
            options.add(new SelectOption('ELECTRONIC SECURITY COMMAND','ELECTRONIC SECURITY COMMAND'));
            options.add(new SelectOption('AIR TRAINING COMMAND, RECRUITING SERVICE','AIR TRAINING COMMAND, RECRUITING SERVICE'));
            options.add(new SelectOption('AIR FORCE LOGISTICS COMMAND','AIR FORCE LOGISTICS COMMAND'));
            options.add(new SelectOption('MILITARY AIRLIFT COMMAND','MILITARY AIRLIFT COMMAND'));
            options.add(new SelectOption('STRATEGIC AIR COMMAND','STRATEGIC AIR COMMAND'));
            options.add(new SelectOption('AIR FORCE SYSTEMS COMMAND','AIR FORCE SYSTEMS COMMAND'));
            options.add(new SelectOption('AIR COMBAT COMMAND','AIR COMBAT COMMAND'));
            options.add(new SelectOption('MANPOWER PERSONNEL CENTER','MANPOWER PERSONNEL CENTER'));
            options.add(new SelectOption('APPELLATE REVIEW','APPELLATE REVIEW'));
            options.add(new SelectOption('OFFICE OF SPECIAL INVESTIGATIONS','OFFICE OF SPECIAL INVESTIGATIONS'));
            options.add(new SelectOption('ALASKAN AIR COMMAND','ALASKAN AIR COMMAND'));
            options.add(new SelectOption('AIR NATIONAL GUARD','AIR NATIONAL GUARD'));
            options.add(new SelectOption('AIR FORCE CIVIL AIR PATROL','AIR FORCE CIVIL AIR PATROL'));
            options.add(new SelectOption('AIR COMB COMMAND (CENTCOM)','AIR COMB COMMAND (CENTCOM)'));
            options.add(new SelectOption('AIR MOBILITY COMMAND','AIR MOBILITY COMMAND'));
            options.add(new SelectOption('AIR EDUCATION AND TRAINING COMMAND','AIR EDUCATION AND TRAINING COMMAND'));
            options.add(new SelectOption('AF RECRUITING SERVICE','AF RECRUITING SERVICE'));
            options.add(new SelectOption('AIR FORCE RESERVE COMMAND','AIR FORCE RESERVE COMMAND'));
            options.add(new SelectOption('AIR FORCE MATERIAL COMMAND','AIR FORCE MATERIAL COMMAND'));
            options.add(new SelectOption('AIR NATIONAL GUARD BUREAU','AIR NATIONAL GUARD BUREAU'));
            options.add(new SelectOption('US AIR FORCE ACADEMY','US AIR FORCE ACADEMY'));
            options.add(new SelectOption('AIR FORCE SPACE COMMAND','AIR FORCE SPACE COMMAND'));
            options.add(new SelectOption('AIR FORCE OFC SPEC INVESTIGATIONS','AIR FORCE OFC SPEC INVESTIGATIONS'));
            options.add(new SelectOption('PACIFIC AIR FORCES','PACIFIC AIR FORCES'));
            options.add(new SelectOption('US AIR FORCES EUROPE','US AIR FORCES EUROPE'));
            options.add(new SelectOption('AIR FORCE SPECIAL OPERATIONS COMMAND','AIR FORCE SPECIAL OPERATIONS COMMAND'));
        }
        else if(agency == 'NATIONAL FOUNDATION ON THE ARTS AND THE HUMANITIES') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL FOUNDATION ON THE ARTS AND THE HUMANITIES','NATIONAL FOUNDATION ON THE ARTS AND THE HUMANITIES'));
            options.add(new SelectOption('NATIONAL ENDOWMENT FOR HUMANITIES','NATIONAL ENDOWMENT FOR HUMANITIES'));
            options.add(new SelectOption('NATIONAL FOUNDATION FOR THE ARTS','NATIONAL FOUNDATION FOR THE ARTS'));
            options.add(new SelectOption('INSTITUTE OF MUSEUM SERVICES','INSTITUTE OF MUSEUM SERVICES'));
        }
        else if(agency == 'RAILROAD RETIREMENT BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('RAILROAD RETIREMENT BOARD','RAILROAD RETIREMENT BOARD'));
        }
        else if(agency == 'CONSUMER PRODUCT SAFETY COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CONSUMER PRODUCT SAFETY COMMISSION','CONSUMER PRODUCT SAFETY COMMISSION'));
        }
        else if(agency == 'U.S. OFFICE OF SPECIAL COUNSEL') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('U.S. OFFICE OF SPECIAL COUNSEL','U.S. OFFICE OF SPECIAL COUNSEL'));
        }
        else if(agency == 'NATIONAL LABOR RELATIONS BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL LABOR RELATIONS BOARD','NATIONAL LABOR RELATIONS BOARD'));
        }
        else if(agency == 'TENNESSEE VALLEY AUTHORITY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('TENNESSEE VALLEY AUTHORITY','TENNESSEE VALLEY AUTHORITY'));
        }
        else if(agency == 'FEDERAL MARITIME COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL MARITIME COMMISSION','FEDERAL MARITIME COMMISSION'));
        }
        else if(agency == 'ENVIRONMENTAL PROTECTION AGENCY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('ENVIRONMENTAL PROTECTION AGENCY','ENVIRONMENTAL PROTECTION AGENCY'));
            options.add(new SelectOption('OFFICE OF WATER','OFFICE OF WATER'));
            options.add(new SelectOption('OFFICE OF RESEARCH AND DEVELOPMENT','OFFICE OF RESEARCH AND DEVELOPMENT'));
            options.add(new SelectOption('OFFICE OF AIR AND RADIATION','OFFICE OF AIR AND RADIATION'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATION AND RESOURCES MANAGEMENT','OFFICE OF ADMINISTRATION AND RESOURCES MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF SOLID WASTE AND EMERGENCY RESPONSE','OFFICE OF SOLID WASTE AND EMERGENCY RESPONSE'));
            options.add(new SelectOption('OFFICE OF CHEMICAL SAFETY AND POLLUTION PREVENTION','OFFICE OF CHEMICAL SAFETY AND POLLUTION PREVENTION'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATOR','OFFICE OF ADMINISTRATOR'));
            options.add(new SelectOption('OFFICE OF CHIEF FINANCIAL OFFICER','OFFICE OF CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('OFFICE OF ENVIRONMENTAL INFORMATION','OFFICE OF ENVIRONMENTAL INFORMATION'));
            options.add(new SelectOption('OFFICE OF GENERAL COUNSEL','OFFICE OF GENERAL COUNSEL'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF INTERNATIONAL AND TRIBAL AFFAIRS','OFFICE OF INTERNATIONAL AND TRIBAL AFFAIRS'));
            options.add(new SelectOption('OFFICE OF ENFORCEMENT AND COMPLIANCE ASSURANCE','OFFICE OF ENFORCEMENT AND COMPLIANCE ASSURANCE'));
        }
        else if(agency == 'DEPARTMENT OF TRANSPORTATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF TRANSPORTATION','DEPARTMENT OF TRANSPORTATION'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('PIPELINE AND HAZARDOUS MATERIALS SAFETY ADMINISTRATION','PIPELINE AND HAZARDOUS MATERIALS SAFETY ADMINISTRATION'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('FEDERAL AVIATION ADMINISTRATION','FEDERAL AVIATION ADMINISTRATION'));
            options.add(new SelectOption('FEDERAL HIGHWAY ADMINISTRATION','FEDERAL HIGHWAY ADMINISTRATION'));
            options.add(new SelectOption('AMTRAK','AMTRAK'));
            options.add(new SelectOption('FEDERAL RAILROAD ADMINISTRATION','FEDERAL RAILROAD ADMINISTRATION'));
            options.add(new SelectOption('MARITIME ADMINISTRATION','MARITIME ADMINISTRATION'));
            options.add(new SelectOption('ST. LAWRENCE SEAWAY DEVELOPMENT CORPORATION','ST. LAWRENCE SEAWAY DEVELOPMENT CORPORATION'));
            options.add(new SelectOption('NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION','NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION'));
            options.add(new SelectOption('SURFACE TRANSPORTATION BOARD','SURFACE TRANSPORTATION BOARD'));
            options.add(new SelectOption('FEDERAL TRANSIT ADMINISTRATION','FEDERAL TRANSIT ADMINISTRATION'));
            options.add(new SelectOption('RESEARCH AND INNOVATIVE TECHNOLOGY ADMINISTRATION','RESEARCH AND INNOVATIVE TECHNOLOGY ADMINISTRATION'));
            options.add(new SelectOption('FEDERAL MOTOR CARRIER SAFETY ADMINISTRATION','FEDERAL MOTOR CARRIER SAFETY ADMINISTRATION'));
            options.add(new SelectOption('PIPELINE HAZARDOUS MATERIALS AND SAFETY ADMINISTRATION','PIPELINE HAZARDOUS MATERIALS AND SAFETY ADMINISTRATION'));
            // for version 1.8
            options.add(new SelectOption('JAMES RIVER RESERVE FLEET','JAMES RIVER RESERVE FLEET'));
        }
        else if(agency == 'DEPARTMENT OF HOMELAND SECURITY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF HOMELAND SECURITY','DEPARTMENT OF HOMELAND SECURITY'));
            options.add(new SelectOption('UNITED STATES SECRET SERVICE','UNITED STATES SECRET SERVICE'));
            options.add(new SelectOption('UNITED STATES COAST GUARD','UNITED STATES COAST GUARD'));
            options.add(new SelectOption('DEPARTMENTAL OPERATIONS (IMMEDIATE OFFICE OF THE SECRETARY)','DEPARTMENTAL OPERATIONS (IMMEDIATE OFFICE OF THE SECRETARY)'));
            options.add(new SelectOption('U.S. CITIZENSHIP AND IMMIGRATION SERVICES','U.S. CITIZENSHIP AND IMMIGRATION SERVICES'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('OFFICE OF INTELLIGENCE AND ANALYSIS','OFFICE OF INTELLIGENCE AND ANALYSIS'));
            options.add(new SelectOption('MANAGEMENT DIRECTORATE','MANAGEMENT DIRECTORATE'));
            options.add(new SelectOption('FEDERAL AIR MARSHAL SERVICE','FEDERAL AIR MARSHAL SERVICE'));
            options.add(new SelectOption('NATIONAL PROTECTION AND PROGRAMS DIRECTORATE','NATIONAL PROTECTION AND PROGRAMS DIRECTORATE'));
            options.add(new SelectOption('OFFICE OF POLICY','OFFICE OF POLICY'));
            options.add(new SelectOption('SCIENCE AND TECHNOLOGY DIRECTORATE','SCIENCE AND TECHNOLOGY DIRECTORATE'));
            options.add(new SelectOption('DOMESTIC NUCLEAR DETECTION OFFICE','DOMESTIC NUCLEAR DETECTION OFFICE'));
            options.add(new SelectOption('FEDERAL EMERGENCY MANAGEMENT AGENCY (FEMA)','FEDERAL EMERGENCY MANAGEMENT AGENCY (FEMA)'));
            options.add(new SelectOption('OFFICE OF HEALTH AFFAIRS','OFFICE OF HEALTH AFFAIRS'));
            options.add(new SelectOption('FEDERAL INSURANCE AND MITIGATION ADMINISTRATION','FEDERAL INSURANCE AND MITIGATION ADMINISTRATION'));
            options.add(new SelectOption('U.S. CUSTOMS AND BORDER PROTECTION','U.S. CUSTOMS AND BORDER PROTECTION'));
            options.add(new SelectOption('TRANSPORTATION SECURITY ADMINISTRATION','TRANSPORTATION SECURITY ADMINISTRATION'));
            options.add(new SelectOption('U.S. IMMIGRATION AND CUSTOMS ENFORCEMENT','U.S. IMMIGRATION AND CUSTOMS ENFORCEMENT'));
            options.add(new SelectOption('FEDERAL PROTECTIVE SERVICE','FEDERAL PROTECTIVE SERVICE'));
            options.add(new SelectOption('FEDERAL LAW ENFORCEMENT TRAINING CENTER','FEDERAL LAW ENFORCEMENT TRAINING CENTER'));
            options.add(new SelectOption('OFFICE OF OPERATIONS COORDINATION AND PLANNING','OFFICE OF OPERATIONS COORDINATION AND PLANNING'));
        }
        else if(agency == 'AGENCY FOR INTERNATIONAL DEVELOPMENT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('AGENCY FOR INTERNATIONAL DEVELOPMENT','AGENCY FOR INTERNATIONAL DEVELOPMENT'));
            options.add(new SelectOption('GLOBAL HEALTH','GLOBAL HEALTH'));
        }
        else if(agency == 'SMALL BUSINESS ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SMALL BUSINESS ADMINISTRATION','SMALL BUSINESS ADMINISTRATION'));
        }
        else if(agency == 'AMERICAN BATTLE MONUMENTS COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('AMERICAN BATTLE MONUMENTS COMMISSION','AMERICAN BATTLE MONUMENTS COMMISSION'));
        }
        else if(agency == 'DEPARTMENT OF HEALTH AND HUMAN SERVICES') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF HEALTH AND HUMAN SERVICES','DEPARTMENT OF HEALTH AND HUMAN SERVICES'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('HEALTH RESOURCES AND SERVICES ADMINISTRATION','HEALTH RESOURCES AND SERVICES ADMINISTRATION'));
            options.add(new SelectOption('CENTERS FOR MEDICARE AND MEDICAID SERVICES','CENTERS FOR MEDICARE AND MEDICAID SERVICES'));
            options.add(new SelectOption('FOOD AND DRUG ADMINISTRATION','FOOD AND DRUG ADMINISTRATION'));
            options.add(new SelectOption('NATIONAL INSTITUTES OF HEALTH','NATIONAL INSTITUTES OF HEALTH'));
            options.add(new SelectOption('CENTERS FOR DISEASE CONTROL AND PREVENTION','CENTERS FOR DISEASE CONTROL AND PREVENTION'));
            options.add(new SelectOption('INDIAN HEALTH SERVICE','INDIAN HEALTH SERVICE'));
            options.add(new SelectOption('PROGRAM SUPPORT CENTER','PROGRAM SUPPORT CENTER'));
            options.add(new SelectOption('SUBSTANCE ABUSE AND MENTAL HEALTH SERVICES ADMINISTRATION','SUBSTANCE ABUSE AND MENTAL HEALTH SERVICES ADMINISTRATION'));
            options.add(new SelectOption('ADMINISTRATION FOR COMMUNITY LIVING','ADMINISTRATION FOR COMMUNITY LIVING'));
            options.add(new SelectOption('ADMINISTRATION FOR CHILDREN AND FAMILIES','ADMINISTRATION FOR CHILDREN AND FAMILIES'));
            options.add(new SelectOption('AGENCY FOR HEALTHCARE RESEARCH AND QUALITY','AGENCY FOR HEALTHCARE RESEARCH AND QUALITY'));
            options.add(new SelectOption('DEPARTMENTAL MANAGEMENT (IG)','DEPARTMENTAL MANAGEMENT (IG)'));
            options.add(new SelectOption('AGENCY FOR TOXIC SUBSTANCES AND DISEASE REGISTRY','AGENCY FOR TOXIC SUBSTANCES AND DISEASE REGISTRY'));
        }
        else if(agency == 'COMMEMORATIVE COMMISSIONS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('COMMEMORATIVE COMMISSIONS','COMMEMORATIVE COMMISSIONS'));
            options.add(new SelectOption('FRANKLIN DELANO ROOSEVELT MEMORIAL COMMISSION','FRANKLIN DELANO ROOSEVELT MEMORIAL COMMISSION'));
            options.add(new SelectOption('CHRISTOPHER COLUMBUS QUINCENTENARY JUBILEE COMMISSION','CHRISTOPHER COLUMBUS QUINCENTENARY JUBILEE COMMISSION'));
            options.add(new SelectOption('BICENTENNIAL CONSTITUTION COMMISSION','BICENTENNIAL CONSTITUTION COMMISSION'));
            options.add(new SelectOption('JAMES MADISON MEMORIAL COMMISSION','JAMES MADISON MEMORIAL COMMISSION'));
            options.add(new SelectOption('LEWIS AND CLARK TRIAL COMMISSION','LEWIS AND CLARK TRIAL COMMISSION'));
            options.add(new SelectOption('DWIGHT DAVID EISENHOWER CENTENNIAL COMMISSION','DWIGHT DAVID EISENHOWER CENTENNIAL COMMISSION'));
            options.add(new SelectOption('US TERRITORY EXPANSION MEMORIAL COMMISSION','US TERRITORY EXPANSION MEMORIAL COMMISSION'));
            options.add(new SelectOption('WOODROW WILSON MEMORIAL COMMISSION','WOODROW WILSON MEMORIAL COMMISSION'));
            options.add(new SelectOption('MARTIN LUTHER KING, JR., FEDERAL HOLIDAY COMMISSION','MARTIN LUTHER KING, JR., FEDERAL HOLIDAY COMMISSION'));
            options.add(new SelectOption('CHRISTOPHER COLUMBUS FELLOWSHIP FOUNDATION','CHRISTOPHER COLUMBUS FELLOWSHIP FOUNDATION'));
        }
        else if(agency == 'FARM CREDIT ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FARM CREDIT ADMINISTRATION','FARM CREDIT ADMINISTRATION'));
        }
        else if(agency == 'NATIONAL AERONAUTICS AND SPACE ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL AERONAUTICS AND SPACE ADMINISTRATION','NATIONAL AERONAUTICS AND SPACE ADMINISTRATION'));
            options.add(new SelectOption('NASA HEADQUARTERS','NASA HEADQUARTERS'));
            options.add(new SelectOption('GLENN RESEARCH CENTER','GLENN RESEARCH CENTER'));
            options.add(new SelectOption('AMES RESEARCH CENTER','AMES RESEARCH CENTER'));
            options.add(new SelectOption('DRYDEN FLIGHT RESEARCH CENTER','DRYDEN FLIGHT RESEARCH CENTER'));
            options.add(new SelectOption('GODDARD SPACE FLIGHT CENTER','GODDARD SPACE FLIGHT CENTER'));
            options.add(new SelectOption('JET PROPULSION LABORATORY','JET PROPULSION LABORATORY'));
            options.add(new SelectOption('JOHNSON SPACE CENTER','JOHNSON SPACE CENTER'));
            options.add(new SelectOption('KENNEDY SPACE CENTER','KENNEDY SPACE CENTER'));
            options.add(new SelectOption('LANGLEY RESEARCH CENTER','LANGLEY RESEARCH CENTER'));
            options.add(new SelectOption('LEWIS RESEARCH CENTER','LEWIS RESEARCH CENTER'));
            options.add(new SelectOption('MARSHALL SPACE FLIGHT CENTER','MARSHALL SPACE FLIGHT CENTER'));
            options.add(new SelectOption('MICHOUD ASSEMBLY FACILITY','MICHOUD ASSEMBLY FACILITY'));
            options.add(new SelectOption('JOHN C. STENNIS SPACE CENTER','JOHN C. STENNIS SPACE CENTER'));
            options.add(new SelectOption('WALLOPS FLIGHT CENTER','WALLOPS FLIGHT CENTER'));
            options.add(new SelectOption('WHITE SANDS TEST FACILITY','WHITE SANDS TEST FACILITY'));
            options.add(new SelectOption('PLUM BROOK STATION ','PLUM BROOK STATION '));
            options.add(new SelectOption('ARMSTRONG FLIGHT RESEARCH CENTER','ARMSTRONG FLIGHT RESEARCH CENTER'));
        }
        else if(agency == 'FEDERAL HOME LOAN BANK BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL HOME LOAN BANK BOARD','FEDERAL HOME LOAN BANK BOARD'));
        }
        else if(agency == 'EXPORT-IMPORT BANK OF THE UNITED STATES') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('EXPORT-IMPORT BANK OF THE UNITED STATES','EXPORT-IMPORT BANK OF THE UNITED STATES'));
        }
        else if(agency == 'ARMED FORCES RETIREMENT HOME') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('ARMED FORCES RETIREMENT HOME','ARMED FORCES RETIREMENT HOME'));
            options.add(new SelectOption('UNITED STATES SOLDIERS AND AIRMENS HOME','UNITED STATES SOLDIERS AND AIRMENS HOME'));
            options.add(new SelectOption('UNITED STATES NAVAL HOME','UNITED STATES NAVAL HOME'));
        }
        else if(agency == 'WATER RESOURCES COUNCIL') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('WATER RESOURCES COUNCIL','WATER RESOURCES COUNCIL'));
            options.add(new SelectOption('GREAT LAKES BASIN COMMISSION','GREAT LAKES BASIN COMMISSION'));
            options.add(new SelectOption('PACIFIC NORTHWEST BASIN COMMISSION','PACIFIC NORTHWEST BASIN COMMISSION'));
            options.add(new SelectOption('OHIO RIVER BASIN COMMISSION','OHIO RIVER BASIN COMMISSION'));
            options.add(new SelectOption('NEW ENGLAND BASIN COMMISSION','NEW ENGLAND BASIN COMMISSION'));
            options.add(new SelectOption('WATER RESOURCES COUNCIL HEADQUARTERS','WATER RESOURCES COUNCIL HEADQUARTERS'));
            options.add(new SelectOption('MISSOURI RIVER BASIN COMMISSION','MISSOURI RIVER BASIN COMMISSION'));
            options.add(new SelectOption('UPPER MISSISSIPPI RIVER BASIN COMMISSION','UPPER MISSISSIPPI RIVER BASIN COMMISSION'));
        }
        else if(agency == 'DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT','DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('OFFICE OF GENERAL COUNSEL','OFFICE OF GENERAL COUNSEL'));
            options.add(new SelectOption('CHIEF INFORMATION OFFICER','CHIEF INFORMATION OFFICER'));
            options.add(new SelectOption('CHIEF PROCUREMENT OFFICER','CHIEF PROCUREMENT OFFICER'));
            options.add(new SelectOption('CHIEF FINANCIAL OFFICER','CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('OFFICE OF DEPARTMENTAL EQUAL EMPLOYMENT OPPORTUNITY','OFFICE OF DEPARTMENTAL EQUAL EMPLOYMENT OPPORTUNITY'));
            options.add(new SelectOption('FAITH BASED AND NEIGHBORHOOD PARTNERSHIPS','FAITH BASED AND NEIGHBORHOOD PARTNERSHIPS'));
            options.add(new SelectOption('FIELD POLICY AND MANAGEMENT','FIELD POLICY AND MANAGEMENT'));
            options.add(new SelectOption('HEALTHY HOMES AND LEAD HAZARD CONTROL','HEALTHY HOMES AND LEAD HAZARD CONTROL'));
            options.add(new SelectOption('INSPECTOR GENERAL','INSPECTOR GENERAL'));
            options.add(new SelectOption('PUBLIC AFFAIRS','PUBLIC AFFAIRS'));
            options.add(new SelectOption('PUBLIC AND INDIAN HOUSING','PUBLIC AND INDIAN HOUSING'));
            options.add(new SelectOption('COMMUNITY PLANNING AND DEVELOPMENT','COMMUNITY PLANNING AND DEVELOPMENT'));
            options.add(new SelectOption('POLICY DEVELOPMENT AND RESEARCH','POLICY DEVELOPMENT AND RESEARCH'));
            options.add(new SelectOption('REAL ESTATE ASSESSMENT CENTER','REAL ESTATE ASSESSMENT CENTER'));
            options.add(new SelectOption('FAIR HOUSING AND EQUAL OPPORTUNITY','FAIR HOUSING AND EQUAL OPPORTUNITY'));
            options.add(new SelectOption('GOVERNMENT NATIONAL MORTGAGE ASSOCIATION','GOVERNMENT NATIONAL MORTGAGE ASSOCIATION'));
            options.add(new SelectOption('CONGRESSIONAL AND INTERGOVERNMENTAL RELATIONS','CONGRESSIONAL AND INTERGOVERNMENTAL RELATIONS'));
            options.add(new SelectOption('HOUSING','HOUSING'));
            options.add(new SelectOption('OFFICE OF CHIEF HUMAN CAPITAL OFFICER','OFFICE OF CHIEF HUMAN CAPITAL OFFICER'));
            options.add(new SelectOption('OFFICE OF ADMINISTRATION','OFFICE OF ADMINISTRATION'));
        }
        else if(agency == 'NATIONAL ARCHIVES AND RECORDS ADMINISTRATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL ARCHIVES AND RECORDS ADMINISTRATION','NATIONAL ARCHIVES AND RECORDS ADMINISTRATION'));
        }
        else if(agency == 'DEPARTMENT OF ENERGY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF ENERGY','DEPARTMENT OF ENERGY'));
            options.add(new SelectOption('RICHLAND OPERATIONS OFFICE ','RICHLAND OPERATIONS OFFICE '));
            options.add(new SelectOption('OFFICE OF FOSSIL ENERGY','OFFICE OF FOSSIL ENERGY'));
            options.add(new SelectOption('OFFICE OF ELECTRICITY DELIVERY AND ENERGY RELIABILITY','OFFICE OF ELECTRICITY DELIVERY AND ENERGY RELIABILITY'));
            options.add(new SelectOption('OFFICE OF NUCLEAR ENERGY','OFFICE OF NUCLEAR ENERGY'));
            options.add(new SelectOption('IDAHO OPERATIONS OFFICE ','IDAHO OPERATIONS OFFICE '));
            options.add(new SelectOption('SAVANNAH RIVER OPERATIONS OFFICE ','SAVANNAH RIVER OPERATIONS OFFICE '));
            options.add(new SelectOption('WESTERN AREA POWER ADMINISTRATION ','WESTERN AREA POWER ADMINISTRATION '));
            options.add(new SelectOption('BONNEVILLE POWER ADMINISTRATION','BONNEVILLE POWER ADMINISTRATION'));
            options.add(new SelectOption('SOUTHEASTERN POWER ADMINISTRATION','SOUTHEASTERN POWER ADMINISTRATION'));
            options.add(new SelectOption('SOUTHWESTERN POWER ADMINISTRATION','SOUTHWESTERN POWER ADMINISTRATION'));
            options.add(new SelectOption('OAK RIDGE OFFICE OF ENVIRONMENTAL MANAGEMENT','OAK RIDGE OFFICE OF ENVIRONMENTAL MANAGEMENT'));
            options.add(new SelectOption('GOLDEN FIELD OFFICE','GOLDEN FIELD OFFICE'));
            options.add(new SelectOption('LOAN PROGRAMS OFFICE','LOAN PROGRAMS OFFICE'));
            options.add(new SelectOption('OFFICE OF SCIENCE','OFFICE OF SCIENCE'));
            options.add(new SelectOption('OFFICE OF ENVIRONMENTAL MANAGEMENT','OFFICE OF ENVIRONMENTAL MANAGEMENT'));
            options.add(new SelectOption('OFFICE OF LEGACY MANAGEMENT','OFFICE OF LEGACY MANAGEMENT'));
            options.add(new SelectOption('ADVANCED RESEARCH PROJECTS AGENCY','ADVANCED RESEARCH PROJECTS AGENCY'));
            options.add(new SelectOption('OFFICE OF INDIAN ENERGY POLICY AND PROGRAMS','OFFICE OF INDIAN ENERGY POLICY AND PROGRAMS'));
            options.add(new SelectOption('OFFICE OF ENERGY EFFICIENCY AND RENEWABLE ENERGY','OFFICE OF ENERGY EFFICIENCY AND RENEWABLE ENERGY'));
            options.add(new SelectOption('NATIONAL NUCLEAR SECURITY ADMINISTRATION','NATIONAL NUCLEAR SECURITY ADMINISTRATION'));
            // for version 1.7
            options.add(new SelectOption('FEDERAL ENERGY REGULATORY COMMISSION','FEDERAL ENERGY REGULATORY COMMISSION'));
        }
        else if(agency == 'SELECTIVE SERVICE SYSTEM') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('SELECTIVE SERVICE SYSTEM','SELECTIVE SERVICE SYSTEM'));
        }
        else if(agency == 'DEPARTMENT OF EDUCATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DEPARTMENT OF EDUCATION','DEPARTMENT OF EDUCATION'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY','OFFICE OF THE SECRETARY'));
            options.add(new SelectOption('OFFICE OF DEPUTY SECRETARY','OFFICE OF DEPUTY SECRETARY'));
            options.add(new SelectOption('OFFICE OF THE UNDERSECRETARY','OFFICE OF THE UNDERSECRETARY'));
        }
        else if(agency == 'FEDERAL MEDIATION AND CONCILIATION SERVICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL MEDIATION AND CONCILIATION SERVICE','FEDERAL MEDIATION AND CONCILIATION SERVICE'));
        }
        else if(agency == 'INDEPENDENT U.S. GOVERNMENT OFFICES') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('INDEPENDENT U.S. GOVERNMENT OFFICES','INDEPENDENT U.S. GOVERNMENT OFFICES'));
            options.add(new SelectOption('BOARD FOR INTERNATIONAL BROADCASTING','BOARD FOR INTERNATIONAL BROADCASTING'));
            options.add(new SelectOption('NATIONAL CAPITAL PLANNING COMMISSION','NATIONAL CAPITAL PLANNING COMMISSION'));
            options.add(new SelectOption('PHYSICIAN PAYMENT REVIEW COMMISSION','PHYSICIAN PAYMENT REVIEW COMMISSION'));
            options.add(new SelectOption('FEDERAL MINE SAFETY AND HEALTH REVIEW COMMISSION','FEDERAL MINE SAFETY AND HEALTH REVIEW COMMISSION'));
            options.add(new SelectOption('EISENHOWER EXCHANGE FELLOWSHIP PROGRAM TRUST FUND','EISENHOWER EXCHANGE FELLOWSHIP PROGRAM TRUST FUND'));
            options.add(new SelectOption('FEDERAL ELECTION COMMISSION','FEDERAL ELECTION COMMISSION'));
            options.add(new SelectOption('COMMODITY FUTURES TRADING COMMISSION','COMMODITY FUTURES TRADING COMMISSION'));
            options.add(new SelectOption('NATIONAL TRANSPORTATION SAFETY BOARD','NATIONAL TRANSPORTATION SAFETY BOARD'));
            options.add(new SelectOption('APPRAISAL SUBCOMMITTEE OF THE FEDERAL FINANCIAL INSTITUTIONS EXAMINATION COUNCIL','APPRAISAL SUBCOMMITTEE OF THE FEDERAL FINANCIAL INSTITUTIONS EXAMINATION COUNCIL'));
            options.add(new SelectOption('HARRY S TRUMAN SCHOLARSHIP FOUNDATION','HARRY S TRUMAN SCHOLARSHIP FOUNDATION'));
            options.add(new SelectOption('FEDERAL HOUSING FINANCE BOARD','FEDERAL HOUSING FINANCE BOARD'));
            options.add(new SelectOption('JAPAN-UNITED STATES FRIENDSHIP COMMISSION','JAPAN-UNITED STATES FRIENDSHIP COMMISSION'));
            options.add(new SelectOption('MARINE MAMMAL COMMISSION','MARINE MAMMAL COMMISSION'));
            options.add(new SelectOption('OCCUPATIONAL SAFETY AND HEALTH REVIEW COMMISSION','OCCUPATIONAL SAFETY AND HEALTH REVIEW COMMISSION'));
            options.add(new SelectOption('ADMINISTRATIVE CONFERENCE OF THE UNITED STATES','ADMINISTRATIVE CONFERENCE OF THE UNITED STATES'));
            options.add(new SelectOption('ADVISORY COMMITTEE ON FEDERAL PAY','ADVISORY COMMITTEE ON FEDERAL PAY'));
            options.add(new SelectOption('COMMISSION ON CIVIL RIGHTS','COMMISSION ON CIVIL RIGHTS'));
            options.add(new SelectOption('COMMISSION FOR PURCHASE FROM BLIND AND OTHER SEVERELY HANDICAPPED','COMMISSION FOR PURCHASE FROM BLIND AND OTHER SEVERELY HANDICAPPED'));
            options.add(new SelectOption('INTELLIGENCE COMMUNITY OVERSIGHT','INTELLIGENCE COMMUNITY OVERSIGHT'));
            options.add(new SelectOption('COMMISSION OF FINE ARTS','COMMISSION OF FINE ARTS'));
            options.add(new SelectOption('PANAMA CANAL COMMISSION','PANAMA CANAL COMMISSION'));
            options.add(new SelectOption('ARCHITECTURAL AND TRANSPORTATION BARRIERS COMPLIANCE BOARD','ARCHITECTURAL AND TRANSPORTATION BARRIERS COMPLIANCE BOARD'));
            options.add(new SelectOption('PROSPECTIVE PAYMENT ASSESSMENT COMMISSION','PROSPECTIVE PAYMENT ASSESSMENT COMMISSION'));
            options.add(new SelectOption('NATIONAL MEDIATION BOARD','NATIONAL MEDIATION BOARD'));
            options.add(new SelectOption('PRESIDENTS CRIME PREVENTION COUNCIL','PRESIDENTS CRIME PREVENTION COUNCIL'));
            options.add(new SelectOption('WHITE HOUSE CONFERENCE ON LIBRARY AND INFORMATION SERVICES','WHITE HOUSE CONFERENCE ON LIBRARY AND INFORMATION SERVICES'));
            options.add(new SelectOption('UNITED STATES HOLOCAUST MEMORIAL COUNCIL','UNITED STATES HOLOCAUST MEMORIAL COUNCIL'));
            options.add(new SelectOption('NATIONAL COMMISSION ON LIBRARIES AND INFORMATION SCIENCE','NATIONAL COMMISSION ON LIBRARIES AND INFORMATION SCIENCE'));
            options.add(new SelectOption('NATIONAL COUNCIL ON DISABILITY','NATIONAL COUNCIL ON DISABILITY'));
            options.add(new SelectOption('UNITED STATES INSTITUTE OF PEACE','UNITED STATES INSTITUTE OF PEACE'));
            options.add(new SelectOption('NATIONAL AFRO-AMERICAN HISTORY AND CULTURE COMMISSION','NATIONAL AFRO-AMERICAN HISTORY AND CULTURE COMMISSION'));
            options.add(new SelectOption('INSTITUTE OF AMERICAN INDIAN ARTS','INSTITUTE OF AMERICAN INDIAN ARTS'));
            options.add(new SelectOption('BARRY GOLDWATER SCHOLARSHIP AND EXCELLENCE IN EDUCATION FOUNDATION','BARRY GOLDWATER SCHOLARSHIP AND EXCELLENCE IN EDUCATION FOUNDATION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON MIGRANT EDUCATION','NATIONAL COMMISSION ON MIGRANT EDUCATION'));
            options.add(new SelectOption('PRESCRIPTION DRUG PAYMENT REVIEW COMMISSION','PRESCRIPTION DRUG PAYMENT REVIEW COMMISSION'));
            options.add(new SelectOption('NATIONAL COMMISSION ON ACQUIRED IMMUNE DEFICIENCY SYNDROME','NATIONAL COMMISSION ON ACQUIRED IMMUNE DEFICIENCY SYNDROME'));
            options.add(new SelectOption('COMMISSION FOR THE PRESERVATION OF AMERICAS HERITAGE ABROAD','COMMISSION FOR THE PRESERVATION OF AMERICAS HERITAGE ABROAD'));
            options.add(new SelectOption('DEFENSE NUCLEAR FACILITIES SAFETY BOARD','DEFENSE NUCLEAR FACILITIES SAFETY BOARD'));
            options.add(new SelectOption('UNITED STATES COURT OF VETERANS APPEALS','UNITED STATES COURT OF VETERANS APPEALS'));
            options.add(new SelectOption('NEIGHBORHOOD REINVESTMENT CORPORATION','NEIGHBORHOOD REINVESTMENT CORPORATION'));
            options.add(new SelectOption('JAMES MADISON MEMORIAL FELLOWSHIP FOUNDATION','JAMES MADISON MEMORIAL FELLOWSHIP FOUNDATION'));
            options.add(new SelectOption('OFFICE OF GOVERNMENT ETHICS','OFFICE OF GOVERNMENT ETHICS'));
            options.add(new SelectOption('FEDERAL FINANCIAL INSTITUTIONS EXAMINATION COUNCIL','FEDERAL FINANCIAL INSTITUTIONS EXAMINATION COUNCIL'));
            options.add(new SelectOption('COMPETITIVENESS POLICY COUNCIL','COMPETITIVENESS POLICY COUNCIL'));
            options.add(new SelectOption('COMMISSION ON NATIONAL AND COMMUNITY SERVICE','COMMISSION ON NATIONAL AND COMMUNITY SERVICE'));
            options.add(new SelectOption('NATIONAL ADVISORY COUNCIL ON THE PUBLIC SERVICE ACT OF 1990','NATIONAL ADVISORY COUNCIL ON THE PUBLIC SERVICE ACT OF 1990'));
            options.add(new SelectOption('COMMISSION ON IMMIGRATION REFORM','COMMISSION ON IMMIGRATION REFORM'));
            options.add(new SelectOption('UNITED STATES ENRICHMENT','UNITED STATES ENRICHMENT'));
            options.add(new SelectOption('MORRIS K. UDALL SCHOLARSHIP AND EXCELLENCE IN NATIONAL ENVIRONMENTAL POLICY FOUNDATION','MORRIS K. UDALL SCHOLARSHIP AND EXCELLENCE IN NATIONAL ENVIRONMENTAL POLICY FOUNDATION'));
            options.add(new SelectOption('CHEMICAL SAFETY BOARD','CHEMICAL SAFETY BOARD'));
            options.add(new SelectOption('DIRECTOR OF NATIONAL INTELLIGENCE','DIRECTOR OF NATIONAL INTELLIGENCE'));
            options.add(new SelectOption('PRESIDIO SAN FRANCISCO','PRESIDIO SAN FRANCISCO'));
            options.add(new SelectOption('CONGRESSIONAL EXECUTIVE COMMISSION ON CHINA','CONGRESSIONAL EXECUTIVE COMMISSION ON CHINA'));
            options.add(new SelectOption('CONSUMER FINANCIAL PROTECTION BUREAU','CONSUMER FINANCIAL PROTECTION BUREAU'));
            options.add(new SelectOption('ELECTION ASSISTANCE COMMISSION','ELECTION ASSISTANCE COMMISSION'));
            options.add(new SelectOption('COURT SERVICES & OFFENDER SUPERVISION AGENCY (DC)','COURT SERVICES & OFFENDER SUPERVISION AGENCY (DC)'));
            options.add(new SelectOption('PUBLIC DEFENDERS SERVICE FOR THE DISTRICT OF COLUMBIA','PUBLIC DEFENDERS SERVICE FOR THE DISTRICT OF COLUMBIA'));
            options.add(new SelectOption('FEDERAL COORDINATOR ALASKA NATURAL GAS TRANSPORTATION PROJECTS','FEDERAL COORDINATOR ALASKA NATURAL GAS TRANSPORTATION PROJECTS'));
            options.add(new SelectOption('DENALI COMMISSION','DENALI COMMISSION'));
            options.add(new SelectOption('BROADCASTING BOARD OF GOVERNORS','BROADCASTING BOARD OF GOVERNORS'));
            options.add(new SelectOption('PRETRIAL SERVICES AGENCY','PRETRIAL SERVICES AGENCY'));
            options.add(new SelectOption('DELTA REGIONAL AUTHORITY','DELTA REGIONAL AUTHORITY'));
            options.add(new SelectOption('COMMISSION ON THE NATIONAL MOMENT OF REMEMBRANCE','COMMISSION ON THE NATIONAL MOMENT OF REMEMBRANCE'));
            options.add(new SelectOption('VIETNAM EDUCATION FOUNDATION','VIETNAM EDUCATION FOUNDATION'));
            options.add(new SelectOption('MILLENIUM CHALLENGER CORPORATION','MILLENIUM CHALLENGER CORPORATION'));
            options.add(new SelectOption('FEDERAL HOUSING FINANCE AGENCY','FEDERAL HOUSING FINANCE AGENCY'));
            options.add(new SelectOption('COUNCIL OF INSPECTOR GENERAL ON INTEGRITY AND EFFICIENCY','COUNCIL OF INSPECTOR GENERAL ON INTEGRITY AND EFFICIENCY'));
            options.add(new SelectOption('NORTHERN BORDER REGIONAL COMMISSION','NORTHERN BORDER REGIONAL COMMISSION'));
            options.add(new SelectOption('D.C. SUPERIOR COURT','D.C. SUPERIOR COURT'));
            //case# 26791- added below bureau
            options.add(new SelectOption('NATIONAL ENDOWMENT FOR THE ARTS','NATIONAL ENDOWMENT FOR THE ARTS'));
        }
        else if(agency == 'U.S. ARMY CORPS OF ENGINEERS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CORPS OF ENGINEERS, CIVIL','CORPS OF ENGINEERS, CIVIL'));
            options.add(new SelectOption('US ARMY ENGINEERING AND SUPPORT CENTER','US ARMY ENGINEERING AND SUPPORT CENTER'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, MEMPHIS','US ARMY CORPS OF ENGINEERS DISTRICT, MEMPHIS'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, NEW ORLEANS','US ARMY CORPS OF ENGINEERS DISTRICT, NEW ORLEANS'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, ST. LOUIS','US ARMY CORPS OF ENGINEERS DISTRICT, ST. LOUIS'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, VICKSBURG','US ARMY CORPS OF ENGINEERS DISTRICT, VICKSBURG'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, ROCK ISLAND','US ARMY CORPS OF ENGINEERS DISTRICT, ROCK ISLAND'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, BALTIMORE','US ARMY CORPS OF ENGINEERS DISTRICT, BALTIMORE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, NEW YORK','US ARMY CORPS OF ENGINEERS DISTRICT, NEW YORK'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, NORFOLK','US ARMY CORPS OF ENGINEERS DISTRICT, NORFOLK'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, PHILADELPHIA','US ARMY CORPS OF ENGINEERS DISTRICT, PHILADELPHIA'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, NEW ENGLAND','US ARMY CORPS OF ENGINEERS DISTRICT, NEW ENGLAND'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, PORTLAND','US ARMY CORPS OF ENGINEERS DISTRICT, PORTLAND'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, SEATTLE','US ARMY CORPS OF ENGINEERS DISTRICT, SEATTLE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, WALLA WALLA','US ARMY CORPS OF ENGINEERS DISTRICT, WALLA WALLA'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, KANSAS CITY','US ARMY CORPS OF ENGINEERS DISTRICT, KANSAS CITY'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, OMAHA','US ARMY CORPS OF ENGINEERS DISTRICT, OMAHA'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, HUNTINGTON','US ARMY CORPS OF ENGINEERS DISTRICT, HUNTINGTON'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, LOUISVILLE','US ARMY CORPS OF ENGINEERS DISTRICT, LOUISVILLE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, NASHVILLE','US ARMY CORPS OF ENGINEERS DISTRICT, NASHVILLE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, PITTSBURGH','US ARMY CORPS OF ENGINEERS DISTRICT, PITTSBURGH'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, BUFFALO','US ARMY CORPS OF ENGINEERS DISTRICT, BUFFALO'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, CHICAGO','US ARMY CORPS OF ENGINEERS DISTRICT, CHICAGO'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, DETROIT','US ARMY CORPS OF ENGINEERS DISTRICT, DETROIT'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, ALASKA','US ARMY CORPS OF ENGINEERS DISTRICT, ALASKA'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, CHARLESTON','US ARMY CORPS OF ENGINEERS DISTRICT, CHARLESTON'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, JACKSONVILLE','US ARMY CORPS OF ENGINEERS DISTRICT, JACKSONVILLE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, MOBILE','US ARMY CORPS OF ENGINEERS DISTRICT, MOBILE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, SAVANNAH','US ARMY CORPS OF ENGINEERS DISTRICT, SAVANNAH'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, WILMINGTON','US ARMY CORPS OF ENGINEERS DISTRICT, WILMINGTON'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, LOS ANGELES','US ARMY CORPS OF ENGINEERS DISTRICT, LOS ANGELES'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, SACRAMENTO','US ARMY CORPS OF ENGINEERS DISTRICT, SACRAMENTO'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, SAN FRANCISCO','US ARMY CORPS OF ENGINEERS DISTRICT, SAN FRANCISCO'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, ALBUQUERQUE','US ARMY CORPS OF ENGINEERS DISTRICT, ALBUQUERQUE'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, FORT WORTH','US ARMY CORPS OF ENGINEERS DISTRICT, FORT WORTH'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, GALVESTON','US ARMY CORPS OF ENGINEERS DISTRICT, GALVESTON'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, LITTLE ROCK','US ARMY CORPS OF ENGINEERS DISTRICT, LITTLE ROCK'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS DISTRICT, TULSA','US ARMY CORPS OF ENGINEERS DISTRICT, TULSA'));
            options.add(new SelectOption('US ARMY CONSTRUCTION ENGINEERING RESEARCH LABORATORY','US ARMY CONSTRUCTION ENGINEERING RESEARCH LABORATORY'));
            options.add(new SelectOption('US ARMY COLD REGIONS RESEARCH AND ENGINEERING LABORATORY','US ARMY COLD REGIONS RESEARCH AND ENGINEERING LABORATORY'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, FAR EAST DISTRICT','US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, FAR EAST DISTRICT'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, HONOLULU DISTRICT','US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, HONOLULU DISTRICT'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, JAPAN DISTRICT','US ARMY CORPS OF ENGINEERS, PACIFIC OCEAN DIVISION, JAPAN DISTRICT'));
            options.add(new SelectOption('US ARMY CORPS OF ENGINEERS, EUROPE DISTRICT','US ARMY CORPS OF ENGINEERS, EUROPE DISTRICT'));
        }
        else if(agency == 'DEPARTMENT OF DEFENSE (OFFICE OF THE SECRETARY OF DEFENSE)') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY OF DEFENSE','OFFICE OF THE SECRETARY OF DEFENSE'));
            options.add(new SelectOption('JOINTS CHIEFS OF STAFF','JOINTS CHIEFS OF STAFF'));
            options.add(new SelectOption('NATIONAL SECURITY AGENCY/CENTRAL SECURITY SERVICE','NATIONAL SECURITY AGENCY/CENTRAL SECURITY SERVICE'));
            options.add(new SelectOption('DEFENSE POW/MISSING PERSONNEL OFFICE','DEFENSE POW/MISSING PERSONNEL OFFICE'));
            options.add(new SelectOption('OFFICE OF ECONOMIC ADJUSTMENT','OFFICE OF ECONOMIC ADJUSTMENT'));
            options.add(new SelectOption('OFFICE OF THE SECRETARY OF DEFENSE','OFFICE OF THE SECRETARY OF DEFENSE'));
            options.add(new SelectOption('UNITED STATES COURT OF MILITARY APPEALS','UNITED STATES COURT OF MILITARY APPEALS'));
            options.add(new SelectOption('OFFICE OF INSPECTOR GENERAL','OFFICE OF INSPECTOR GENERAL'));
            options.add(new SelectOption('DEPARTMENT OF DEFENSE EDUCATION ACTIVITY','DEPARTMENT OF DEFENSE EDUCATION ACTIVITY'));
            options.add(new SelectOption('DEFENSE LOGISTICS AGENCY','DEFENSE LOGISTICS AGENCY'));
            options.add(new SelectOption('NATIONAL GEOSPATIAL INTELLIGENCE AGENCY','NATIONAL GEOSPATIAL INTELLIGENCE AGENCY'));
            options.add(new SelectOption('DEFENSE LEGAL SERVICES AGENCY','DEFENSE LEGAL SERVICES AGENCY'));
            options.add(new SelectOption('DEFENSE SECURITY SERVICE','DEFENSE SECURITY SERVICE'));
            options.add(new SelectOption('DEFENSE INTELLIGENCE AGENCY','DEFENSE INTELLIGENCE AGENCY'));
            options.add(new SelectOption('DEFENSE INFORMATION SYSTEMS AGENCY','DEFENSE INFORMATION SYSTEMS AGENCY'));
            options.add(new SelectOption('DEFENSE CONTRACT AUDIT AGENCY','DEFENSE CONTRACT AUDIT AGENCY'));
            options.add(new SelectOption('DEFENSE CONTRACT MANAGEMENT AGENCY','DEFENSE CONTRACT MANAGEMENT AGENCY'));
            options.add(new SelectOption('DEFENSE FINANCE AND ACCOUNTING SERVICE','DEFENSE FINANCE AND ACCOUNTING SERVICE'));
            options.add(new SelectOption('STRATEGIC COMMAND','STRATEGIC COMMAND'));
            options.add(new SelectOption('DEFENSE COMMISSARY AGENCY','DEFENSE COMMISSARY AGENCY'));
            options.add(new SelectOption('SOUTHERN COMMAND','SOUTHERN COMMAND'));
            options.add(new SelectOption('MISSILE DEFENSE AGENCY','MISSILE DEFENSE AGENCY'));
            options.add(new SelectOption('DEFENSE TECHNOLOGY SECURITY ADMINISTRATION','DEFENSE TECHNOLOGY SECURITY ADMINISTRATION'));
            options.add(new SelectOption('PACIFIC COMMAND','PACIFIC COMMAND'));
            options.add(new SelectOption('DEFENSE TECHNICAL INFORMATION CENTER','DEFENSE TECHNICAL INFORMATION CENTER'));
            options.add(new SelectOption('DEFENSE ADVANCED RESEARCH PROJECTS AGENCY','DEFENSE ADVANCED RESEARCH PROJECTS AGENCY'));
            options.add(new SelectOption('DEPARTMENT OF DEFENSE TEST RESOURCE MANAGEMENT CENTER','DEPARTMENT OF DEFENSE TEST RESOURCE MANAGEMENT CENTER'));
            options.add(new SelectOption('WASHINGTON HEADQUARTERS SERVICES','WASHINGTON HEADQUARTERS SERVICES'));
            options.add(new SelectOption('AFRICA COMMAND','AFRICA COMMAND'));
            options.add(new SelectOption('CENTRAL COMMAND','CENTRAL COMMAND'));
            options.add(new SelectOption('EUROPEAN COMMAND','EUROPEAN COMMAND'));
            options.add(new SelectOption('DEFENSE MEDIA ACTIVITY','DEFENSE MEDIA ACTIVITY'));
            options.add(new SelectOption('TRICARE MANAGEMENT ACTIVITY','TRICARE MANAGEMENT ACTIVITY'));
            options.add(new SelectOption('SPECIAL OPS COMMAND','SPECIAL OPS COMMAND'));
            options.add(new SelectOption('U.S. TRANSPORTATION COMMAND','U.S. TRANSPORTATION COMMAND'));
            options.add(new SelectOption('NORTHERN COMMAND','NORTHERN COMMAND'));
            options.add(new SelectOption('NATIONAL RECONNNAISSANCE OFFICE','NATIONAL RECONNNAISSANCE OFFICE'));
            options.add(new SelectOption('DEFENSE SECURITY COOPERATION AGENCY','DEFENSE SECURITY COOPERATION AGENCY'));
            options.add(new SelectOption('DEFENSE THREAT REDUCTION AGENCY','DEFENSE THREAT REDUCTION AGENCY'));
            options.add(new SelectOption('PENTAGON FORCE PROTECTION AGENCY','PENTAGON FORCE PROTECTION AGENCY'));
            options.add(new SelectOption('DEFENSE ACQUISITION UNIVERSITY','DEFENSE ACQUISITION UNIVERSITY'));
        }
        else if(agency == 'DISTRICT OF COLUMBIA') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('DISTRICT OF COLUMBIA','DISTRICT OF COLUMBIA'));
            options.add(new SelectOption('DEPARTMENT OF CONSUMER AND REGULATORY AFFAIRS','DEPARTMENT OF CONSUMER AND REGULATORY AFFAIRS'));
            options.add(new SelectOption('DEPARTMENT OF PUBLIC WORKS','DEPARTMENT OF PUBLIC WORKS'));
            options.add(new SelectOption('EMERGENCY MANAGEMENT ADMINISTRATION','EMERGENCY MANAGEMENT ADMINISTRATION'));
            options.add(new SelectOption('CHIEF MEDICAL EXAMINER','CHIEF MEDICAL EXAMINER'));
            options.add(new SelectOption('OFFICE OF THE CORPORATION COUNSEL','OFFICE OF THE CORPORATION COUNSEL'));
            options.add(new SelectOption('DEPARTMENT OF CORRECTIONS','DEPARTMENT OF CORRECTIONS'));
            options.add(new SelectOption('PUBLIC SCHOOLS','PUBLIC SCHOOLS'));
            options.add(new SelectOption('EXECUTIVE OFFICE OF THE MAYOR','EXECUTIVE OFFICE OF THE MAYOR'));
            options.add(new SelectOption('FIRE AND EMERGENCIES MEDICAL SERVICES','FIRE AND EMERGENCIES MEDICAL SERVICES'));
            options.add(new SelectOption('OFFICE OF CHIEF TECHNOLOGY OFFICER','OFFICE OF CHIEF TECHNOLOGY OFFICER'));
            options.add(new SelectOption('DEPARTMENT OF INSURANCE & SECURITIES REGULATION','DEPARTMENT OF INSURANCE & SECURITIES REGULATION'));
            options.add(new SelectOption('OFFICE OF CHIEF FINANCIAL OFFICER','OFFICE OF CHIEF FINANCIAL OFFICER'));
            options.add(new SelectOption('MINIMUM WAGE AND INDUSTRIAL SAFETY BOARD','MINIMUM WAGE AND INDUSTRIAL SAFETY BOARD'));
            options.add(new SelectOption('DEPARTMENT OF MOTOR VEHICLES','DEPARTMENT OF MOTOR VEHICLES'));
            options.add(new SelectOption('DEPARTMENT OF HEALTH','DEPARTMENT OF HEALTH'));
            options.add(new SelectOption('OFFICE OF ZONING','OFFICE OF ZONING'));
            options.add(new SelectOption('METROPOLITAN POLICE DEPARTMENT','METROPOLITAN POLICE DEPARTMENT'));
            options.add(new SelectOption('PUBLIC LIBRARIES','PUBLIC LIBRARIES'));
            options.add(new SelectOption('DEPARTMENT OF HUMAN SERVICES','DEPARTMENT OF HUMAN SERVICES'));
            options.add(new SelectOption('DC DEPARTMENT OF RECREATION','DC DEPARTMENT OF RECREATION'));
            options.add(new SelectOption('DC SUPERIOR COURT (USE 95 95)','DC SUPERIOR COURT (USE 95 95)'));
            options.add(new SelectOption('BOARD OF APPEALS AND REVIEW','BOARD OF APPEALS AND REVIEW'));
            options.add(new SelectOption('NATIONAL GUARD OF THE DISTRICT OF COLUMBIA','NATIONAL GUARD OF THE DISTRICT OF COLUMBIA'));
            options.add(new SelectOption('ARMORY BOARD','ARMORY BOARD'));
            options.add(new SelectOption('PLANNING AND ECONOMIC DEVELOPMENT','PLANNING AND ECONOMIC DEVELOPMENT'));
            options.add(new SelectOption('BOARD OF ELECTIONS AND ETHICS','BOARD OF ELECTIONS AND ETHICS'));
            options.add(new SelectOption('WASHINGTON METROPOLITAN AREA TRANSIT AUTHORITY','WASHINGTON METROPOLITAN AREA TRANSIT AUTHORITY'));
            options.add(new SelectOption('PUBLIC SERVICE COMMISSION','PUBLIC SERVICE COMMISSION'));
            options.add(new SelectOption('DC GOVERNMENT, CHILD & FAMILY SERVICES AGENCY','DC GOVERNMENT, CHILD & FAMILY SERVICES AGENCY'));
            options.add(new SelectOption('WASHINGTON CONVENTION CENTER AUTHORITY','WASHINGTON CONVENTION CENTER AUTHORITY'));
            options.add(new SelectOption('WATER AND SEWER AUTHORITY','WATER AND SEWER AUTHORITY'));
            options.add(new SelectOption('DC PRETRIAL SERVICES AGENCY','DC PRETRIAL SERVICES AGENCY'));
            options.add(new SelectOption('DC COURT OF APPEALS','DC COURT OF APPEALS'));
            options.add(new SelectOption('DC HOUSING AUTHORITY','DC HOUSING AUTHORITY'));
            options.add(new SelectOption('DC RETIREMENT BOARD','DC RETIREMENT BOARD'));
            options.add(new SelectOption('DC HEALTH PUBLIC BENEFIT CORPORATION','DC HEALTH PUBLIC BENEFIT CORPORATION'));
            options.add(new SelectOption('DC DEPARTMENT OF MENTAL HEALTH','DC DEPARTMENT OF MENTAL HEALTH'));
            options.add(new SelectOption('DC GOVERNMENT, UNIVERSITY OF DISTRICT OF COLUMBIA','DC GOVERNMENT, UNIVERSITY OF DISTRICT OF COLUMBIA'));
        }
        else if(agency == 'CORPORATION FOR NATIONAL AND COMMUNITY SERVICE') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CORPORATION FOR NATIONAL AND COMMUNITY SERVICE','CORPORATION FOR NATIONAL AND COMMUNITY SERVICE'));
        }
        else if(agency == 'NATIONAL TRANSPORTATION SAFETY BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL TRANSPORTATION SAFETY BOARD','NATIONAL TRANSPORTATION SAFETY BOARD'));
            // for version 1.7
            options.add(new SelectOption('OFFICE OF MARINE SAFETY','OFFICE OF MARINE SAFETY'));
        }
        else if(agency == 'CONSUMER FINANCIAL PROTECTION BUREAU') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('CONSUMER FINANCIAL PROTECTION BUREAU','CONSUMER FINANCIAL PROTECTION BUREAU'));
        }
        else if(agency == 'FEDERAL ENERGY REGULATORY COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL ENERGY REGULATORY COMMISSION','FEDERAL ENERGY REGULATORY COMMISSION'));
        }
        else if(agency == 'BROADCASTING BOARD OF GOVERNORS') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('BROADCASTING BOARD OF GOVERNORS','BROADCASTING BOARD OF GOVERNORS'));
        }
        else if(agency == 'PENSION BENEFIT GUARANTY CORPORATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('PENSION BENEFIT GUARANTY CORPORATION','PENSION BENEFIT GUARANTY CORPORATION'));
        }
        else if(agency == 'NATIONAL MEDIATION BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL MEDIATION BOARD','NATIONAL MEDIATION BOARD'));
        }
        else if(agency == 'COMMODITY FUTURES TRADING COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('COMMODITY FUTURES TRADING COMMISSION','COMMODITY FUTURES TRADING COMMISSION'));
        }
        // for version 1.3
        else if(agency == 'MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION','MEDICAID AND CHIP PAYMENT AND ACCESS COMMISSION'));
        }
        else if(agency == 'VOICE OF AMERICA') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('IBB/BBG','IBB/BBG'));
        }
        else if(agency == 'FEDERAL HOUSING FINANCE AGENCY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('FEDERAL HOUSING FINANCE AGENCY','FEDERAL HOUSING FINANCE AGENCY'));
        }
        else if(agency == 'COURT SERVICES AND OFFENDER SUPERVISION AGENCY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('PRETRIAL SERVICES AGENCY','PRETRIAL SERVICES AGENCY'));
        }
        else if(agency == 'OVERSEAS PRIVATE INVESTMENT CORPORATION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('OVERSEAS PRIVATE INVESTMENT CORPORATION','OVERSEAS PRIVATE INVESTMENT CORPORATION'));
        }
        else if(agency == 'U.S. CHEMICAL SAFETY BOARD') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('U.S. CHEMICAL SAFETY BOARD','U.S. CHEMICAL SAFETY BOARD'));
        }
        // - 20550 - begin
        else if(agency == 'NATIONAL ENDOWMENT FOR THE HUMANITIES') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL ENDOWMENT FOR THE HUMANITIES','NATIONAL ENDOWMENT FOR THE HUMANITIES'));
        }
        else if(agency == 'U.S. TRADE AND DEVELOPMENT AGENCY') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('U.S. TRADE AND DEVELOPMENT AGENCY','U.S. TRADE AND DEVELOPMENT AGENCY'));
        }
        else if(agency == 'NATIONAL CAPITAL PLANNING COMMISSION') {
            options.clear();
            options.add(new SelectOption('','--Select Bureau--'));
            options.add(new SelectOption('NATIONAL CAPITAL PLANNING COMMISSION','NATIONAL CAPITAL PLANNING COMMISSION'));
        }
        // - 20550 - end
        else {
            options.clear();
        }
        options.sort();
        return options;
    }

    // action for the previous button for wizard
    public PageReference previous() {
       return Page.TSSSurveyWizard1;
       //return null;
    }

    //Added by Ramesh Dugar to set navigation to Mobile page on clicking next button for screen readers
    public void flagForDisabled(){
        flag=true;
    }
    // action for the next button for wizard
    //Modified by Ramesh Dugar
   public PageReference next() {
        ServerSideDeviceDetection();
        if(flag || isMobile){
             return Page.TSSSurveyWizardMobilePage2;
        }
        else{
            return Page.TSSSurveyWizard2;
        }
       //return null;
    }

    // action for submit button of the survey
    public PageReference save() {
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the overall satisfaction'));
        /*
        TSS_Survey__c survey = new TSS_Survey__c();
        List<TSS_Response__c> responses = new List<TSS_Response__c>();
        List<TSS_Survey__c> exsurveys = new List<TSS_Survey__c>();

        //removed by Brad Smith
        exsurveys = (cId == null)? new List<TSS_Survey__c>(): [SELECT Id, Name FROM TSS_Survey__c
                                                               WHERE FY__c ='FY16'
                                                               AND Contact__c = :cId
                                                               AND IsDeleted = false ALL ROWS];
        */

        // for telework = yes
        if(virtbuilding != null && telework == 'Yes'){
            survey = new TSS_Survey__c();
            survey.TSS_Result_Action_Plan__c = virtbuilding;
            if(cId!=null){survey.Contact__c = cId;}
            survey.FY__c='FY'+String.valueOf(Date.today().year()).right(2);
            //next line modified by Brad Smith
            survey.ResponseId__c = virtbuilding.substring(12)+Crypto.getRandomInteger();
            survey.Virtual_Employee__c = telework;
            //-- inserting the survey record for the respective contact or survey taker.
            try {
                insert survey;
            }
            catch(System.DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating a new survey,'+e));
                //ApexPages.addMessages(e);
                return null;
            }
        }
        system.debug('building*'+building);
        system.debug('telework*'+telework);
        system.debug('overallsat*'+overallsat);
        //prepating the survey record first for non telework responses
        if(building != null && telework == 'No' && overallsat !=null) {
            survey = new TSS_Survey__c();
            survey.TSS_Result_Action_Plan__c = building;
            survey.Contact__c = cId;
            survey.FY__c='FY'+String.valueOf(Date.today().year()).right(2);
            //next line modified by Brad Smith
            survey.ResponseId__c = building.substring(12)+Crypto.getRandomInteger();
            survey.Virtual_Employee__c = telework;
            survey.Personal_Workspace_Demographics__c= wkspacetype;
            /*
            if(agency == 'GOVERNMENT ACCOUNTABILITY OFFICE')
                agency = 'GENERAL ACCOUNTING OFFICE';
            */
            survey.Agency_txt__c = agency;
            survey.Bureau_txt__c = bureau;
            //Mapping city and state values for building not Listed -Ramesh Dugar
            survey.City__c= city;
            survey.State__c= state;
            survey.Other_Unidentified_Agency__c = bldngntlisted;
            // for debug purpose - developer
            System.debug('Building:'+survey.TSS_Result_Action_Plan__c);
            System.debug('ResponseId:'+survey.ResponseId__c);
            System.debug('Contact Id:'+cId);
            System.debug('Contact Found:'+contactfound);
            //insert survey;

            //-- inserting the survey record for the respective contact or survey taker.
            try {
                //Database.SaveResult srList = Database.insert(survey, false);
                insert survey;
            }
            catch(System.DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating a new survey,'+e));
                //ApexPages.addMessages(e);
                return null;
            }
        }
        // prepare the respective response records for bulk insert
        if(survey.id != null && telework == 'No' && overallsat != null) {
            Integer counter = 1;
            // for overall satisfaction rating
            TSS_Response__c osres = new TSS_Response__c();
            osres.TSS_Survey__c = survey.Id;
            osres.Name='TSSR-'+counter;
            osres.Question__c = 'Overall Satisfaction';
            osres.Response_Score__c=Integer.valueOf(overallsat);
            osres.Service_Category__c='Overall Satisfaction';
            osres.Type_of_Response__c='Scale';
            osres.Min__c=1;
            osres.Max__c=5;
            counter = counter + 1;
            responses.add(osres);

            // for overall satisfaction comments
            if(comments != null && String.isNotBlank(comments.trim()) )  {
                TSS_Response__c ocres = new TSS_Response__c();
                ocres.TSS_Survey__c = survey.Id;
                ocres.Name='TSSR-'+counter;
                ocres.Question__c = 'Overall Satisfaction';
                //ocres.Response_Score__c=Integer.valueOf(overallsat);
                ocres.Service_Category__c='Overall Satisfaction';
                ocres.Type_of_Response__c='Comment';
                ocres.Response_Text__c=comments;
                counter = counter + 1;
                responses.add(ocres);
            }
            // for condition of facility questions
            if(condcat1 != null) {
                TSS_Response__c res1 = new TSS_Response__c();
                res1.TSS_Survey__c = survey.Id;
                res1.Name='TSSR-'+counter;
                res1.Question__c = 'Condition-Building exterior and grounds';
                res1.Response_Score__c=Integer.valueOf(condcat1);
                res1.Service_Category__c='Condition of Facility';
                res1.Type_of_Response__c='Scale';
                res1.Min__c=0;
                res1.Max__c=5;
                counter = counter + 1;
                responses.add(res1);
            }
            if(condcat2 != null) {
                TSS_Response__c res2 = new TSS_Response__c();
                res2.TSS_Survey__c = survey.Id;
                res2.Name='TSSR-'+counter;
                res2.Question__c = 'Condition-Interior common areas';
                res2.Response_Score__c=Integer.valueOf(condcat2);
                res2.Service_Category__c='Condition of Facility';
                res2.Type_of_Response__c='Scale';
                res2.Min__c=0;
                res2.Max__c=5;
                counter = counter + 1;
                responses.add(res2);
            }
            if(condcat3 != null) {
                TSS_Response__c res3 = new TSS_Response__c();
                res3.TSS_Survey__c = survey.Id;
                res3.Name = 'TSSR-'+counter;
                res3.Question__c = 'Condition-Restrooms';
                res3.Response_Score__c=Integer.valueOf(condcat3);
                res3.Service_Category__c='Condition of Facility';
                res3.Type_of_Response__c='Scale';
                res3.Min__c=0;
                res3.Max__c=5;
                counter = counter + 1;
                responses.add(res3);
            }
            if(condcat4 != null) {
                TSS_Response__c res4 = new TSS_Response__c();
                res4.TSS_Survey__c = survey.Id;
                res4.Name= 'TSSR-'+counter;
                res4.Question__c = 'Condition-Personal Workspace';
                res4.Response_Score__c=Integer.valueOf(condcat4);
                res4.Service_Category__c='Condition of Facility';
                res4.Type_of_Response__c='Scale';
                res4.Min__c=0;
                res4.Max__c=5;
                counter = counter + 1;
                responses.add(res4);
            }
            // for quality of cleanliness questions
            if(cleancat1 != null) {
                TSS_Response__c qres1 = new TSS_Response__c();
                qres1.TSS_Survey__c = survey.Id;
                qres1.Name='TSSR-'+counter;
                qres1.Question__c = 'Cleanliness-Building exterior and grounds';
                qres1.Response_Score__c=Integer.valueOf(cleancat1);
                qres1.Service_Category__c='Quality of Cleanliness';
                qres1.Type_of_Response__c='Scale';
                qres1.Min__c=0;
                qres1.Max__c=5;
                counter = counter + 1;
                responses.add(qres1);
            }
            if(cleancat2 != null) {
                TSS_Response__c qres2 = new TSS_Response__c();
                qres2.TSS_Survey__c = survey.Id;
                qres2.Name='TSSR-'+counter;
                qres2.Question__c = 'Cleanliness-Interior common areas';
                qres2.Response_Score__c=Integer.valueOf(cleancat2);
                qres2.Service_Category__c='Quality of Cleanliness';
                qres2.Type_of_Response__c='Scale';
                qres2.Min__c=0;
                qres2.Max__c=5;
                counter = counter + 1;
                responses.add(qres2);
            }
            if(cleancat3 != null) {
                TSS_Response__c qres3 = new TSS_Response__c();
                qres3.TSS_Survey__c = survey.Id;
                qres3.Name='TSSR-'+counter;
                qres3.Question__c = 'Cleanliness-Restrooms';
                qres3.Response_Score__c=Integer.valueOf(cleancat3);
                qres3.Service_Category__c='Quality of Cleanliness';
                qres3.Type_of_Response__c='Scale';
                qres3.Min__c=0;
                qres3.Max__c=5;
                counter = counter + 1;
                responses.add(qres3);
            }
            if(cleancat4 != null) {
                TSS_Response__c qres4 = new TSS_Response__c();
                qres4.TSS_Survey__c = survey.Id;
                qres4.Name='TSSR-'+counter;
                qres4.Question__c = 'Cleanliness-Personal Workspace';
                qres4.Response_Score__c=Integer.valueOf(cleancat4);
                qres4.Service_Category__c='Quality of Cleanliness';
                qres4.Type_of_Response__c='Scale';
                qres4.Min__c=0;
                qres4.Max__c=5;
                counter = counter + 1;
                responses.add(qres4);
            }
            // for elevators question
            if(elevator != null) {
                TSS_Response__c eres = new TSS_Response__c();
                eres.TSS_Survey__c = survey.Id;
                eres.Name='TSSR-'+counter;
                eres.Question__c = 'How satisfied are you with how well the elevators operate?';
                eres.Response_Score__c=Integer.valueOf(elevator);
                eres.Service_Category__c='Elevators';
                eres.Type_of_Response__c='Scale';
                eres.Min__c=0;
                eres.Max__c=5;
                counter = counter + 1;
                responses.add(eres);
            }
            // for meeting spaces question
            if(meetspace != null) {
                TSS_Response__c mres = new TSS_Response__c();
                mres.TSS_Survey__c = survey.Id;
                mres.Name='TSSR-'+counter;
                mres.Question__c = 'How satisfied are you with the availability of meeting spaces?';
                mres.Response_Score__c=Integer.valueOf(meetspace);
                mres.Service_Category__c= 'Meeting Space';
                mres.Type_of_Response__c='Scale';
                mres.Min__c=0;
                mres.Max__c=5;
                counter = counter + 1;
                responses.add(mres);
            }
            // for Personal Workspace questions
            if(workcat1 != null) {
                TSS_Response__c pres1 = new TSS_Response__c();
                pres1.TSS_Survey__c = survey.Id;
                pres1.Name='TSSR-'+counter;
                pres1.Question__c = 'Personal Workspace-Temperature';
                pres1.Response_Score__c=Integer.valueOf(workcat1);
                pres1.Service_Category__c= 'Personal Workspace';
                pres1.Type_of_Response__c='Scale';
                pres1.Min__c=0;
                pres1.Max__c=5;
                counter = counter + 1;
                responses.add(pres1);
            }
            if(workcat2 != null) {
                TSS_Response__c pres2 = new TSS_Response__c();
                pres2.TSS_Survey__c = survey.Id;
                pres2.Name='TSSR-'+counter;
                pres2.Question__c = 'Personal Workspace-Air Quality';
                pres2.Response_Score__c=Integer.valueOf(workcat2);
                pres2.Service_Category__c= 'Personal Workspace';
                pres2.Type_of_Response__c='Scale';
                pres2.Min__c=0;
                pres2.Max__c=5;
                counter = counter + 1;
                responses.add(pres2);
            }
            if(workcat3 != null) {
                TSS_Response__c pres3 = new TSS_Response__c();
                pres3.TSS_Survey__c = survey.Id;
                pres3.Name='TSSR-'+counter;
                pres3.Question__c = 'Personal Workspace-Amount of Light';
                pres3.Response_Score__c=Integer.valueOf(workcat3);
                pres3.Service_Category__c= 'Personal Workspace';
                pres3.Type_of_Response__c='Scale';
                pres3.Min__c=0;
                pres3.Max__c=5;
                counter = counter + 1;
                responses.add(pres3);
            }
            if(workcat4 != null) {
                TSS_Response__c pres4 = new TSS_Response__c();
                pres4.TSS_Survey__c = survey.Id;
                pres4.Name='TSSR-'+counter;
                pres4.Question__c = 'Personal Workspace-Noise Levels';
                pres4.Response_Score__c=Integer.valueOf(workcat4);
                pres4.Service_Category__c= 'Personal Workspace';
                pres4.Type_of_Response__c='Scale';
                pres4.Min__c=0;
                pres4.Max__c=5;
                counter = counter + 1;
                responses.add(pres4);
            }
            // for building management questions
            if(bldgmgmt1 != null) {
                TSS_Response__c bmres1 = new TSS_Response__c();
                bmres1.TSS_Survey__c = survey.Id;
                bmres1.Name='TSSR-'+counter;
                bmres1.Question__c = 'Do you know who to contact if you notice an issue in your building?';
                bmres1.Response_Score__c=Integer.valueOf(bldgmgmt1);
                bmres1.Service_Category__c= 'Know who to call Building Issues';
                bmres1.Type_of_Response__c='Scale';
                bmres1.Min__c=0;
                bmres1.Max__c=1;
                counter = counter + 1;
                responses.add(bmres1);
            }
            if(bldgmgmt2 != null) {
                TSS_Response__c bmres2 = new TSS_Response__c();
                bmres2.TSS_Survey__c = survey.Id;
                bmres2.Name='TSSR-'+counter;
                bmres2.Question__c = 'Do you know how to get an issue corrected in your building?';
                bmres2.Response_Score__c=Integer.valueOf(bldgmgmt2);
                bmres2.Service_Category__c= 'Know who to call Building Issues';
                bmres2.Type_of_Response__c='Scale';
                bmres2.Min__c=0;
                bmres2.Max__c=1;
                counter = counter + 1;
                responses.add(bmres2);
            }
            // for building security question1 How satisfied are you with the security presence and measures in your building
            if(security != null) {
                TSS_Response__c bsres = new TSS_Response__c();
                bsres.TSS_Survey__c = survey.Id;
                bsres.Name='TSSR-'+counter;
                bsres.Question__c = 'How satisfied are you with the security presence and measures in your building?';
                bsres.Response_Score__c=Integer.valueOf(security);
                bsres.Service_Category__c= 'Security';
                bsres.Type_of_Response__c='Scale';
                bsres.Min__c=0;
                bsres.Max__c=5;
                counter = counter + 1;
                responses.add(bsres);
            }

             // for building security question2 How satisfied are you with the professionalism of the Federal Protective Service officers and security personnel
            if(security != null) {
                TSS_Response__c bsres2 = new TSS_Response__c();
                bsres2.TSS_Survey__c = survey.Id;
                bsres2.Name='TSSR-'+counter;
                bsres2.Question__c = 'How satisfied are you with the professionalism of the Federal Protective Service officers and security personnel?';
                bsres2.Response_Score__c=Integer.valueOf(securityPersonnel);
                bsres2.Service_Category__c= 'Security';
                bsres2.Type_of_Response__c='Scale';
                bsres2.Min__c=0;
                bsres2.Max__c=5;
                counter = counter + 1;
                responses.add(bsres2);
            }
            /* NOT REQUIRED - it was added at survey level
            // for personal workspace type question
            if(wkspacetype != null || wkspacetype != '') {
                TSS_Response__c bsres = new TSS_Response__c();
                bsres.TSS_Survey__c = survey.Id;
                bsres.Question__c = 'Which of the following best describes your personal workspace?';
                bsres.Response_Text__c = wkspacetype;
                //bsres.Service_Category__c= need to get the category;
                bsres.Type_of_Response__c='Text';
                responses.add(bsres);
            }
            */

            // -- inserting associated responses of the survey taker under respective survey record.
            System.debug('Survey record inserted:'+survey.Id);
            System.debug('Comments:'+comments);
            try {
                insert responses;
            }
            catch(System.DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating survey responses,'+e));
                //ApexPages.addMessages(e);
                return null;
            }
            // for the debug log - developer usage
            for(TSS_Response__c r: responses)
                System.debug('Response record inserted:'+r.Id);
            //next 3 lines removed by Brad Smith
            //System.debug('Existing number of surveys:'+exsurveys.size());
            //for(TSS_Survey__c s: exsurveys)
            //    System.debug('Survey record deleted:'+s.Id);
        }

        // -- deleting the existing entries of the same survey taker.
        /*
        //next 10 lines removed by Brad Smith
        if(!exsurveys.isEmpty() && survey.id != null) {
            try {
                delete exsurveys;
            }
            catch(System.DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error deleting existing surveys,'+e));
                //ApexPages.addMessages(e);
                return null;
            }
        }
        */
        system.debug('testing save method');
        PageReference finalPage = Page.TSSSurveyThankyou;
        //finalPage.setRedirect(true);
        return finalPage;
    }
    /*
    // action for the display - internal usage for the developer
    public PageReference show() {
        Id bId = Id.valueOf(building);
        selectedValues =    'RAP:'+bId+
                            ',cId:'+cId+', agency:'+agency+', bureau:'+bureau+
                            ',Contact:'+contact+', State: '+state+' ,City: '+city+
                            ' , Building: '+building+', Telework: '+telework+
                            ', CleanCat1: '+ cleancat1+', CleanCat2: '+ cleancat2+', CleanCat3: '+ cleancat3+
                            ', CleanCat4: '+ cleancat4+', condcat1:'+condcat1+', condcat2:'+condcat2+
                            ', condcat3:'+condcat3+', condcat4:'+condcat4+', workcat1:'+workcat1+', workcat2:'+workcat2+
                            ', workcat3:'+workcat3+', workcat4:'+workcat4+', comments:'+comments+', elevator:'+elevator+
                            ', overallsat:'+ overallsat+', bldgmgmt1:'+bldgmgmt1+', bldgmgmt2:'+bldgmgmt2+
                            ', security:'+security+', wkspacetype:'+wkspacetype+', meetspace:'+meetspace;
        return null;
    }
    */
}