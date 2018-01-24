/****************************************************************
Name: ChecklistItemGenerator
============================================================
Author: Lenny
Purpose: JIRA#1293                                                                                                            
============================================================

****************************************************************/
public abstract class ChecklistItemGenerator implements ChecklistItemGeneratorInterface{

    @TestVisible public static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();

    abstract void handleChecklistGeneration(List<SObject> sObjects);
    abstract void generateChecklistItems(List<Case> cases);

    protected Map<String, Master_Checklist__c> buildChecklistCodeToMasterChecklistMap(){
        Map<String, Master_Checklist__c> checklistCodeToMasterChecklistMap = new Map<String, Master_Checklist__c>();
        List<String> checklistCodes = new List<String>();
        checklistCodes.addAll(MasterChecklistDataAccessor.CHECKLIST_CODES);
        List<Master_Checklist__c> masterChecklists = masterChecklistDA.getMasterChecklistsByChecklistCodes(checklistCodes);
        for(Master_Checklist__c checklist : masterChecklists) {
            checklistCodeToMasterChecklistMap.put(checklist.Checklist_Code__c, checklist);
        }
        return checklistCodeToMasterChecklistMap;
    }

    protected Checklist_Item__c generateNewApplicationLevelChecklistItem(
        Master_Checklist__c masterChecklist,
        Case cas, 
        Application__c application,
        String status,
        String checklistType
    ){
        return new Checklist_Item__c(
            Name = masterChecklist.Name + '-' + application.Name,
            Application__c = application.Id,
            Master_Checklist__c = masterChecklist.Id,
            Case__c = cas.Id,
            Loan__c = cas.Loan__c,
            Checklist_Item_Status__c = status,
            Checklist_Item_Text__c = masterChecklist.Checklist_Description__c,
            Type__c = checklistType,
            Last_Action_Date__c = System.Now()
        );
    }
}