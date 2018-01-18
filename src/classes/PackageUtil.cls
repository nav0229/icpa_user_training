/*
    PackageUtil.cls
    Creates the Timelines that track how long a Package was in each stage.
    -------------------------------------------------------------------------------
    Author                 Date        Version  Description
    -------------------------------------------------------------------------------   
    Raja Nangunoori        11/05/2013   1.0     Re-design of FedRAMP 
*/
public with sharing class PackageUtil {
     //To check if all the package stages are completed before adding the P-ATO Approved date
 
 public static void updatePackage(List<FedRAMP_Package__c> triggernew){
    Set<Id> pkgId = new Set<Id>();
    for(FedRAMP_Package__c pkg : triggerNew){
        pkgId.add(pkg.Id);
    }
        List<FedRAMP_Package_Stage__c> lstpkgstages = [SELECT Id, Status__c, Stages__c FROM FedRAMP_Package_Stage__c WHERE Status__c = 'In Process' AND Package__c IN :pkgId];
        List<FedRAMP_Package_Stage__c> lstSARStages = [SELECT Id, Status__c, Stages__c FROM FedRAMP_Package_Stage__c WHERE Status__c = 'Approved' AND Stages__c = 'SAR' AND Package__c IN :pkgId];
    for(FedRAMP_Package__c pack : triggerNew){
        if(pack.System_Previously_Authorized__c == 'No' && pack.PATO_Approved_Date__c != null){
            if(lstpkgstages.size() > 0 || lstSARStages.isEmpty()){
                Trigger.new[0].addError(' System is not previously Authorized. Please complete all Stages before adding P-ATO Approved Date');
            }
        }
    }
 }
 
  //To update the Package progress field based on the Package Stage status.
 public static void updatePackageProgress(List<FedRAMP_Package_Stage__c> triggerNew){
        system.debug('In Update Package Progress');
    Set<Id> packageId = new Set<Id>();
    Set<String> setFields = new Set<String>();
    Set<sobject> listps = new Set<sobject>();
    List<FedRAMP_Package__c> lstFP = new List<FedRAMP_Package__c>();
    //Get the package id and assign to a variable
    for(FedRAMP_Package_Stage__c ps : triggerNew){
        packageId.add(ps.Package__c);
    }
    //Get the package process to update
    List<FedRAMP_Package__c> getPackage = [SELECT Id, Package_Progress__c FROM FedRAMP_Package__c WHERE Id = :packageId LIMIT 1];
    system.debug('Get package ' + getPackage);
    //List<FedRAMP_Package_Stage__c> lstPkgStage = [SELECT Id, Stages__c, Status__c FROM FedRAMP_Package_Stage__c WHERE (Stages__c != 'SSP' OR Stages__c != 'SAP') AND Package__c IN :packageId ORDER BY LastModifiedDate DESC];
    List<FedRAMP_Package_Stage__c> lstPkgStage = [SELECT Id, Stages__c, Status__c FROM FedRAMP_Package_Stage__c WHERE Stages__c = 'SAR' AND Package__c IN :packageId ORDER BY LastModifiedDate DESC];
    List<FedRAMP_Package_Stage__c> lstSSPStage = [SELECT Id, Stages__c, Status__c FROM FedRAMP_Package_Stage__c WHERE Stages__c = 'SSP' AND Package__c IN :packageId ORDER BY LastModifiedDate DESC];
    List<FedRAMP_Package_Stage__c> lstSAPStage = [SELECT Id, Stages__c, Status__c FROM FedRAMP_Package_Stage__c WHERE Stages__c = 'SAP' AND Package__c IN :packageId ORDER BY LastModifiedDate DESC];
    
        if(lstPkgStage.size() > 0){
            getPackage[0].Package_Progress__c = 'SAR';          
        } else if (lstSSPStage.size() > 0 && lstSAPStage.isEmpty()) { 
            getPackage[0].Package_Progress__c = 'SSP';               
                
        } else if (lstSSPStage.size() > 0 && lstSAPStage.size() > 0) {
                if(lstSSPStage[0].Status__c != 'In Process' && lstSAPStage[0].Status__c == 'In Process'){
                    getPackage[0].Package_Progress__c = 'SSP';
                } else if (lstSSPStage[0].Status__c == 'In Process' && lstSAPStage[0].Status__c == 'In Process') {
                    getPackage[0].Package_Progress__c = 'SSP';
                } else {
                    getPackage[0].Package_Progress__c = 'SAP';
                }
        } else if (lstSSPStage.isEmpty() && lstSAPStage.size() > 0) {
            getPackage[0].Package_Progress__c = 'SAP';
        }
         else {
            getPackage[0].Package_Progress__c = 'Readiness';
        }
        lstFP.add(getPackage[0]);
        update lstFP;
    }
   

//Method to check Package Stage validations
 public static List<FedRAMP_Package_Stage__c> stageValidations(List<FedRAMP_Package_Stage__c> triggerNew) {
    List<FedRAMP_Stage_Activity__c> getActivities;
    Integer estimatedDays;
    //Datetime startDate;
    Date startDate;
    List<FedRAMP_Package_Stage__c> lstPkgStage = new List<FedRAMP_Package_Stage__c>();
    Set<Id> packageId = new Set<Id>();
    String stage;
    String status;
    Set<Id>psId = new Set<Id>();
    
    for(FedRAMP_Package_Stage__c pStage : triggerNew){
        packageId.add(pStage.Package__c);
        stage = pStage.Stages__c;
        status = pStage.Status__c;
        psId.add(pStage.Id);
    }
    //Get the FedRAMP Estimated Days for SAP, SSP, SAR and 3PAO Testing from Custom Settings
    FedRAMP_Estimated_Days__c estDays = FedRAMP_Estimated_Days__c.getValues(stage);
    //System.debug('This is estDays values ===>>>> ' + estDays.Name + ' ===>>> ' + estDays.Estimated_Days__c);
    //Get all the packages that are in "In Process" status
    List<FedRAMP_Package__c> getPackage = [SELECT Id, PATO_Approved_Date__c FROM FedRAMP_Package__c WHERE Id = :packageId];
    List<FedRAMP_Package_Stage__c> getPkgStages = [SELECT Id, Status__c FROM FedRAMP_Package_Stage__c WHERE Status__c = 'In Process' AND Package__c IN :packageId];
        
    if(psId != null) {
        getActivities = [SELECT Id, Status__c FROM FedRAMP_Stage_Activity__c WHERE Status__c = 'In Process' AND Package_Stage__c IN :psId];
    }
    for(FedRAMP_Package_Stage__c ps : triggerNew){
        if(Trigger.isInsert){
            if(getPackage[0].PATO_Approved_Date__c != null){
                Trigger.new[0].addError(' Package is already has "P-ATO Approved Date." To create new Stages please remove "P-ATO Approved Date."');    
            }
            if(ps.Estimated_Total_Days__c == null){
                ps.Estimated_Total_Days__c = Integer.valueOf(estDays.Estimated_Days__c);
            }
        }
        estimatedDays = Integer.valueOf(ps.Estimated_Total_Days__c);
        startDate = ps.Start_Date__c;       
        
        /*If there is a value in the Estimated Total Days then calculate the Estimated end date with considering
          the estimated total days entered are working days. */
          
            if(estimatedDays != null) {
                //Calculates the estimated end date by using the business days calculation method
                //Datetime estimatedEndDate = addBussinessDays(startDate, estimatedDays);
                Datetime estimatedEndDate = DateUtility.getNextBusinessDate(startDate, estimatedDays);
                //Datetime estimatedEndDate = DateUtilityNewClass.getNextBusinessDate(startDate, estimatedDays);
                DateTime Dt = estimatedEndDate;
                Date estDate;
                estDate = Dt.Date();
                ps.Estimated_End_Date__c = estDate;             
            }
              //Check if its a new Package Stage
                if(ps.Id != null && getPkgStages.size() > 0){
                    //system.debug(getPkgStages.size() + ' Package Stage Id is not null == >>>> ' + ps.Id + ' Record Id == >>>> ' + getPkgStages[0].Id);                
                    if(ps.Id != getPkgStages[0].Id && getPkgStages[0].Status__c == status) {
                        //system.debug('Ids do not match ');
                        //Do not allow if there is a Package stage that is already in "In Process" status
                        if(getPkgStages.size() > 0) {
                            Trigger.new[0].addError('Please check all previous Stages have "Approved" or "Denied" Status before creating a new "In Process" Stage.');
                        } 
                    }                    
                }
                //if(ps.Id == getPkgStages[0].Id) {
                        if(getActivities.size() > 0 && (ps.Status__c == 'Approved' || ps.Status__c=='Denied')) {
                            Trigger.new[0].addError('Please check all previous Stages have "Approved" or "Denied" Status before creating a new "In Process" Stage.');
                        }
                  // }
                //Trigger only when inserted.
                if(Trigger.isInsert){
                // Add this back later
                    if(stage == 'SAP' || stage == 'SSP') {
                        if(getPkgStages.size() > 1) {
                                Trigger.new[0].addError('Please check all previous Stages have "Approved" or "Denied" Status before creating a new "In Process" Stage.');
                            }
                    } else {
                        if (getPkgStages.size() > 0 && status == 'In Process' && stage != '3PAO Testing'){
                                Trigger.new[0].addError('Please check all previous Stages have "Approved" or "Denied" Status before creating a new "In Process" Stage.');
                            }
                    }
                // 
                /********** This needs to be removed later -- Begin **********
                if (getPkgStages.size() > 0){
                            Trigger.new[0].addError('Cannot have multiple records with Status In Process.');
                    }
                **********This needs to be removed later -- End **********/
                   
                }
    }
        return null;
 }
  
 //Method to check if an Actor has an Activity already in "In Process" status
 public static void checkActorActivity(List<FedRAMP_Stage_Activity__c>  triggerNew){
    Set<String> actor = new Set<String>();
    String status;
    Set<Id> stageId = new Set<Id>();
    List<RecordType> getStageRecId = [SELECT Name, Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Stage_Activities'];
    for(FedRAMP_Stage_Activity__c sa : triggerNew){
        actor.add(sa.Actors__c);
        //status.add(sa.Status__c);
        status = sa.Status__c;   
        stageId.add(sa.Package_Stage__c);
    }
    //Get the count of activities that with specific actor and status "In Process"
    //Integer getStages = [SELECT count() FROM FedRAMP_Stage_Activity__c WHERE Actors__c = :actor AND Status__c = 'In Process' AND RecordTypeId = :getStageRecId[0].Id AND Package_Stage__c IN :stageId];
    List<FedRAMP_Stage_Activity__c> getStages = [SELECT Id, Status__c FROM FedRAMP_Stage_Activity__c WHERE Actors__c = :actor AND Status__c = 'In Process' AND RecordTypeId = :getStageRecId[0].Id AND Package_Stage__c IN :stageId];    
    //If the count is more than zero then throw error
    if(getStages.size() > 0 && status == 'In Process'){
        Trigger.new[0].addError('Please check all Activities for this actor have "Completed" Status before creating a new Activity.');
        //return false;
    }
    //return true;
    }
    
  //Method to check Dates on Stage activity  
  public static Boolean checkEndDate(List<FedRAMP_Stage_Activity__c>  triggerNew){
    system.debug('In the check end date method');
    Date startDate;
    Date endDate;   
    Set<String> actor = new Set<String>();
    Set<Id> stageId = new Set<Id>();
    //Set<Id> activityId = new Set<Id>(); 
    String activityId;
    //Get the Stage Activity record type
     List<RecordType> getStageRecId = [SELECT Name, Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Stage_Activities'];
    for(FedRAMP_Stage_Activity__c sa : triggerNew){
        stageId.add(sa.Package_Stage__c);
        if(sa.Id != null){
            activityId = sa.Id;
        }       
        startDate = sa.Start_Date__c;
        endDate = sa.End_Date__c;
        system.debug('This is end date ' + endDate);
        actor.add(sa.Actors__c);        
    }                
    //List<Stage_Activity__c> getDates = [SELECT Id, Start_Date__c, End_Date__c FROM Stage_Activity__c WHERE Start_Date__c >= :startDate AND End_Date__c <= :endDate AND Actors__c = :actor AND RecordTypeId = :getStageRecId[0].Id AND Package_Stage__c IN :stageId];
    List<FedRAMP_Stage_Activity__c> getDates = [SELECT Id, Start_Date__c, End_Date__c FROM FedRAMP_Stage_Activity__c WHERE Actors__c = :actor AND ((Start_Date__c = :endDate) OR ((Start_Date__c > :startDate) AND (End_Date__c < :endDate)) OR ((Start_Date__c < :startDate AND End_Date__c > :startDate)) OR ((Start_Date__c < :endDate AND End_Date__c > :endDate))) AND Package_Stage__c IN :stageId];
    system.debug('End Date ' + endDate);          
    system.debug('This is Start Date ' + startDate);      
    
    if(endDate == null) {
        system.debug('End Date is null');
    }                                    
    if(endDate != null) {       
        system.debug('End Date is not null');
        system.debug('This is end date size insert' + getDates.size());
        if(Trigger.isInsert){
            if(getDates.size() > 0) {
                Trigger.new[0].addError('Start Date/End Date conflicts with another Activity for the same Actor. Please check all Activities and select another date.');
            }
        }
        if(Trigger.isUpdate){
            //system.debug(getDates[0].Id + ' This is end date size update ' + getDates.size());
            if(getDates.size() > 0 && getDates[0].Id != activityId) {
                Trigger.new[0].addError('Start Date/End Date conflicts with another Activity for the same Actor. Please check all Activities and select another date.');
            }
        }
    }                                                                                                                                                                                                    return true;
    
    return null;
  }
 
 
}