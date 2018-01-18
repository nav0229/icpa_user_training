public with sharing class GITGOTargetExtension {
    private final Target__c t; //targets object
    
    //initializes the private member variable t by using the getRecord method from the standard controller
    public GITGOTargetExtension(ApexPages.StandardController stdController) {
        this.t = (Target__c)stdController.getRecord();
    }
    
    //builds a unique picklist of Organizations based on the Organizations listed in Contact_Organization object
    public List<SelectOption> getOrgs() {
        List<SelectOption> options = new List<SelectOption>(); //new list for holding all of the picklist options
        Set<String> uniqueCustomObjectSet = new Set<String>(); //new set for holding unique list of picklist options
            for(Contact sl:[Select s.MAJOR_ORG_DESCRIPTION__c From Contact s where s.MAJOR_ORG_DESCRIPTION__c <> null]) //for each record in contact object select organization
            {
            uniqueCustomObjectSet.add(sl.MAJOR_ORG_DESCRIPTION__c); //add organization to set if it is new and does not duplicate another organization
            }
            List<String> uniqueCustomObjectList = new List<String>(uniqueCustomObjectSet); //declare new unique list with the same values as unique set 
            options.add(new SelectOption('','')); // add the first option of the unique list as None
            for(integer i=0; i<uniqueCustomObjectList.size(); i++) //loop through unique list and add each item to the original options list
            {
            options.add(new SelectOption(uniqueCustomObjectList[i],uniqueCustomObjectList[i]));
            }
            SelectOptionSorter.doSort(options, SelectOptionSorter.FieldToSort.Label);
            return options;
        }
     
     }