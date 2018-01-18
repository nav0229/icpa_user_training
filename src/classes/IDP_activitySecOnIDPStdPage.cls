public with sharing class IDP_activitySecOnIDPStdPage {

    public String newIDP { get; set; }

    /*public IDP_activitySecOnIDPStdPage() {
        system.debug('-------------------------------------------------------------------------------------------------- Inside Constructor ');
        activityIDPQuerry();
    }*/

    
    public IDP__c currntIDP { get; set; }
    public List<ActivityWrapper> activityWrapperList{ get; set; }
    
    public List<IDP_Developmental_Line_Item__c> activityList = new List<IDP_Developmental_Line_Item__c>();
    
    
    public IDP_activitySecOnIDPStdPage(ApexPages.StandardController controller) {
         system.debug('-------------------------------------------------------------------------------------------------- Inside Constructor ');
         activityIDPQuerry();
    }
    
    public void activityIDPQuerry(){
        // Retrive IDP 
        Id currenIDPId = ApexPages.currentPage().getParameters().get('id');
        system.debug('------------------------------------------------------------------------------- Current IDP Id: ' +currenIDPId );
        String empEmail = UserInfo.getUserEmail();
        currntIDP = new IDP__c();
        currntIDP = [SELECT id, Name, IDP_Status__c 
                     FROM IDP__c
                     WHERE Id = :currenIDPId
                     //WHERE IDP_Status__c = 'New'
                     ORDER By Name DESC
                     LIMIT 1];
        
        //Retrive Activities related to IDP
        activityList = [SELECT id,Name,Priority__c,Total_Cost__c,Assignment_Title__c,Create_Date__c,Planned_Start_Date__c,
                                Training_Need__c,Planned_End_Date__c,Activity_Type__c,Required_Date__c,Series__c,Books_Material_Costs__c,
                                Tuition_Fees__c, Cost_Travel__c, Per_Diem__c, Comments__c, Developmental_Objective__r.Name,  Developmental_Objective__r.Objective__c, 
                                Vendor__c, Location__c, Organization_City__c, RecordTypeId, Related_IDP__c, IDP_ID__c
                        FROM IDP_Developmental_Line_Item__c 
                        WHERE Related_IDP__c = :currntIDP.Name
                        ORDER BY Name ASC];
        system.debug('-------------------------------------------------------------------------------------------------- Activity List Size: ' +activityList.size());                
        prepareActivityWrapperList();
    }
    
    public void prepareActivityWrapperList(){
      List<ActivityWrapper> activityWrapperList = new List<ActivityWrapper>();
      Integer index = 0;
      for(IDP_Developmental_Line_Item__c activity : activityList){
        ActivityWrapper wrapper = new ActivityWrapper(activity,index++);
        activityWrapperList.add(wrapper);
      }
      this.activityWrapperList  = activityWrapperList;
    }
    
    public List<ActivityWrapper> getActivityWrapperList(){
      return activityWrapperList;
    }
    
    public class ActivityWrapper{
      public IDP_Developmental_Line_Item__c activity{get;set;}
      public Integer index{get;set;}
      public Boolean checked{get;set;}
      
      public ActivityWrapper(IDP_Developmental_Line_Item__c activity,Integer index){
        this.activity = activity;
        this.index = index;
        this.checked = false;    
      }
    }
}