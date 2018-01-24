/****************************************************************
 Name: MasterChecklistData
============================================================
Author: Lenny
Purpose: Hold Master Checklist information for the setup object
============================================================

****************************************************************/
public class MasterChecklistData {
	@TestVisible private static MasterChecklistDataAccessor masterChecklistDA = new MasterChecklistDataAccessor();

	@TestVisible private static MasterChecklistData masterChecklists;

	@TestVisible private Map<String, Master_Checklist__c> codeToMasterChecklistMap;

	/**
	 * Constructor - Only to be called by getInstance() method as specified by the Singleton design pattern.
	 */
	@TestVisible
	private MasterChecklistData() {
		codeToMasterChecklistMap = new Map<String, Master_Checklist__c>();
	}

	/**
	 * Returns the private instance of this class. If it does not yet exist, it is initialized.
	 * @return The MasterChecklistData instance
	 */
	public static MasterChecklistData getInstance() {
		if(masterChecklists == null) {
			masterChecklists = new MasterChecklistData();
		}
		return masterChecklists;
	}

	/**
	 * Returns the corresponding Master Checklist for a given Checklist Code
	 * @param  checklistCode  String value corresponding to a Checklist_Code__c picklist value
	 * @return                The MasterChecklist for the specified Checklist Code
	 */
	public Master_Checklist__c getMasterChecklistByChecklistCode(String checklistCode) {
		Master_Checklist__c relatedMC = getMasterChecklistsForChecklistCodes(checklistCode);
		if(relatedMC != null){
			return relatedMC;
		}
		throw new InvalidChecklistCodeException('\'' + checklistCode 
			+ '\' is not a valid Checklist Code for the Master Checklist object');
	}

	/**
	 * Retrieves the Master Checklist record for the specified Checklist Code. If the internal map used to retrieve
	 * the requested Master Checklist it not set up, the map is instantiated and then used to retrieve the record.
	 * @param  checklistCode String value corresponding to a Checklist_Code__c picklist value
	 * @return               A MasterChecklist for the specified Checklist Code
	 */
	@TestVisible
	private Master_Checklist__c getMasterChecklistsForChecklistCodes(String checklistCode) {
		if(codeToMasterChecklistMap.isEmpty()) {
			codeToMasterChecklistMap = getCodeToMasterChecklistMap();
		}
		return codeToMasterChecklistMap.get(checklistCode);
	}

	/**
	 * Retrieves all Master Checklist records mapped by their respective Checklist Code
	 * @return             A map of all Master checklists records mapped by Checklist Code
	 */
	@TestVisible
	private Map<String, Master_Checklist__c> getCodeToMasterChecklistMap() {
		Map<String, Master_Checklist__c> codeToMCMap = new Map<String, Master_Checklist__c>();

		List<Master_Checklist__c> allMasterChecklists = masterChecklistDA.getMasterChecklists();

		for(Master_Checklist__c masterChecklist : allMasterChecklists){
			codeToMCMap.put(masterChecklist.Checklist_Code__c, masterChecklist);
		}
		return codeToMCMap;
	}

	public class InvalidChecklistCodeException extends Exception {}
}