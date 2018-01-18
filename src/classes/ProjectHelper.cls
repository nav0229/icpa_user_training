/*-------------------------------------------------------------------------------------------------*
  Apex helper class for GPM_Project__c object trigger
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          02/17/2015    1.0       Initial version.
  Rajakumar          03/18/2015    1.1       Commented code- remove the executive summary section
 *-------------------------------------------------------------------------------------------------*
 
 *-------------------------------------------------------------------------------------------------*/

public class ProjectHelper {
    // on after insert - for updating the PMO Lead and Project Managers in milestone records
    /*
    public static void onAfterInsert(List<GPM_Project__c> triggerNew, Map<Id, GPM_Project__c> triggerNewMap) {
        Set<Id> projIds = new Set<Id>();
        List<GPM_Milestone__c> milestones = new List<GPM_Milestone__c>();
        
        for(GPM_Project__c pr: triggerNew) {
            if(pr.Project_Tier__c == 'Tier 1' && (pr.Project_Manager__c != null || pr.PMO_Lead__c != null)) {
                projIds.add(pr.Id);
            }
        }
        milestones = [SELECT Id, Project_Manager__c, PMO_Lead__c, GPM_Project__c, Milestone_Progress__c FROM GPM_Milestone__c
                                    WHERE GPM_Project__c IN :projIds AND Milestone_Progress__c != 'Completed'];
        for(GPM_Milestone__c gm: milestones) {
            gm.Project_Manager__c = triggerNewMap.get(gm.GPM_Project__c).Project_Manager__c;
            gm.PMO_Lead__c = triggerNewMap.get(gm.GPM_Project__c).PMO_Lead__c;
        }
        try {
            if(!milestones.isEmpty()) {
                 update milestones;
            } 
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.ERROR,'Error while updating the milestone records with Project Manager and PMO Lead :' +e.getMessage());    
        }         
        
    }
    */
    // on after update - for updating the PMO Lead and Project Managers in respective milestone records
    public static void onAfterUpdate(List<GPM_Project__c> triggerNew, Map<Id, GPM_Project__c> triggerOldMap, 
                                        Map<Id, GPM_Project__c> triggerNewMap) {
        Set<Id> projIds = new Set<Id>();
        List<GPM_Milestone__c> milestones = new List<GPM_Milestone__c>();
        
        for(GPM_Project__c pr: triggerNew) {
            if(pr.Project_Tier__c == 'Tier 1' && 
                ((pr.Project_Manager__c != null && pr.Project_Manager__c != triggerOldMap.get(pr.Id).Project_Manager__c) || 
                 (pr.PMO_Lead__c != null && pr.PMO_Lead__c != triggerOldMap.get(pr.Id).PMO_Lead__c)) ) {
                projIds.add(pr.Id);
            }
            if(pr.Project_Tier__c == 'Tier 1' && 
                ((pr.Project_Manager__c == null && pr.Project_Manager__c != triggerOldMap.get(pr.Id).Project_Manager__c) || 
                 (pr.PMO_Lead__c == null && pr.PMO_Lead__c != triggerOldMap.get(pr.Id).PMO_Lead__c)) ) {
                projIds.add(pr.Id);
            }            
        }
        milestones = [SELECT Id, Project_Manager__c, PMO_Lead__c, GPM_Project__c, Milestone_Progress__c FROM GPM_Milestone__c 
                                    WHERE GPM_Project__c IN :projIds AND Milestone_Progress__c != 'Completed'];
        for(GPM_Milestone__c gm: milestones) {
            gm.Project_Manager__c = triggerNewMap.get(gm.GPM_Project__c).Project_Manager__c;
            gm.PMO_Lead__c = triggerNewMap.get(gm.GPM_Project__c).PMO_Lead__c;
        }
        try {
            if(!milestones.isEmpty()) {
                 update milestones;
            } 
        }
        catch(DMLException e) {
            System.debug(LoggingLevel.ERROR,'Error while updating the milestone records with Project Manager and PMO Lead :' +e.getMessage());    
        }
    }  
    /* 1.1 commented - begin
    // before insert - for updating the few multi-select picklist values & objective richtextarea field 
    //                 on the executive section of the project layout 
    public static void onBeforeInsert(List<GPM_Project__c> triggerNew) {
        for(GPM_Project__c pr: triggerNew) {
            if(pr.SSO_Goals_Themes__c != null) {
                pr.SSO_Goals_Themes_formula__c = pr.SSO_Goals_Themes__c;
            }
            if(pr.Project_Description__c != null) {
                pr.Project_Objective_formula__c = pr.Project_Description__c;
            }
            if(pr.OCIO_Strategic_Initiative__c != null) {
                pr.Key_Principles_Initiatives_formula__c = pr.OCIO_Strategic_Initiative__c;
            }
        }
    }
    
    // before update - for updating the few multi-select picklist values & objective richtextarea field 
    //                 on the executive section of the project layout 
    public static void onBeforeUpdate(List<GPM_Project__c> triggerNew, Map<Id, GPM_Project__c> triggerOldMap) {
        for(GPM_Project__c pr: triggerNew) {
            if(pr.SSO_Goals_Themes__c != null && pr.SSO_Goals_Themes__c != triggerOldMap.get(pr.Id).SSO_Goals_Themes__c) {
                pr.SSO_Goals_Themes_formula__c = pr.SSO_Goals_Themes__c;
            }
            if(pr.Project_Description__c != null && pr.Project_Description__c != triggerOldMap.get(pr.Id).Project_Description__c) {
                pr.Project_Objective_formula__c = pr.Project_Description__c;
            }
            if(pr.OCIO_Strategic_Initiative__c != null && pr.OCIO_Strategic_Initiative__c != triggerOldMap.get(pr.Id).OCIO_Strategic_Initiative__c) {
                pr.Key_Principles_Initiatives_formula__c = pr.OCIO_Strategic_Initiative__c;
            }
            if(pr.SSO_Goals_Themes__c == null && triggerOldMap.get(pr.Id).SSO_Goals_Themes__c != null) {
                pr.SSO_Goals_Themes_formula__c = null;
            }
            if(pr.Project_Description__c == null && triggerOldMap.get(pr.Id).Project_Description__c != null) {
                pr.Project_Objective_formula__c = null;
            }
            if(pr.OCIO_Strategic_Initiative__c == null && triggerOldMap.get(pr.Id).OCIO_Strategic_Initiative__c != null) {
                pr.Key_Principles_Initiatives_formula__c = null;
            }    
        }
    } 
    1.1 commented - end */                                 
}