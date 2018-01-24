/****************************************************************
 Name: ChecklistItemDrawloopNextPopulator
============================================================
Author: Lenny
Purpose: DCMM-? / Drawloop technical task
============================================================

****************************************************************/
public with sharing class ChecklistItemDrawloopNextPopulator implements ChecklistItemDrawloopNextPopInterface{
	@TestVisible private static ChecklistItemDAO checklistItemDA = new ChecklistItemDataAccessor();
	@TestVisible private static MasterChecklistDAO masterChecklistDA = new MasterChecklistDataAccessor();
	@TestVisible private static DrawloopDocumentPackagesDAO ddpDA = new DrawloopDocumentPackagesDataAccessor();
	@TestVisible private static DeliveryOptionDAO deliveryOptionDA = new DeliveryOptionDataAccessor();

	public ChecklistItemDrawloopNextPopulator() {}

	public void populateDrawloopNext(List<Checklist_Item__c> checklistItems) {
		List<Id> masterChecklistIds = new List<Id>();
		for(Checklist_Item__c checklistItem : checklistItems){
			masterChecklistIds.add(checklistItem.Master_Checklist__c);
		}

		Map<Id, Master_Checklist__c> idToMasterChecklistMap = masterChecklistDA.getMasterChecklistsMapById(masterChecklistIds);

		List<Loop__DDP__c> allDDPs = ddpDA.getAllDocumentPackages();
		Map<String, Id> ddpNameToIdMap = buildDDPNameToIdMap(allDDPs);

		List<Loop__DDP_Integration_Option__c> relatedAttachmentOptions = deliveryOptionDA.getDeliveryOptionsByDDPIds(ddpNameToIdMap.values());
		Map<Id, Id> ddpIdToRelatedAttachmentOptionIdMap = buildDDPIdToRelatedAttachmentOptionIdMap(relatedAttachmentOptions);
		
		List<Checklist_Item__c> checklistItemsToPopulate = new List<Checklist_Item__c>();
		for(Checklist_Item__c checklistItem : checklistItems){
			Master_Checklist__c relatedMC = idToMasterChecklistMap.get(checklistItem.Master_Checklist__c);
			if(ddpNameToIdMap.containsKey(relatedMC.Name)){
				Id relatedDDPId = ddpNameToIdMap.get(relatedMC.Name);
				if(ddpIdToRelatedAttachmentOptionIdMap.containsKey(relatedDDPId)){
					checklistItem.Drawloop_Next__c = buildDrawLoopString(
						checklistItem.Id,
						relatedDDPId,
						ddpIdToRelatedAttachmentOptionIdMap.get(relatedDDPId)
					);
				}	
			}

			if(checklistItem.Drawloop_Next__c != null){
				checklistItemsToPopulate.add(checklistItem);
			}
		}

		try{
			checklistItemDA.updateChecklistItems(checklistItemsToPopulate);
		} catch(DmlException e) {
			System.debug(e);
			throw new ChecklistItemDrawloopNextPopulatorException('Error updating the Drawloop Next field on Checklist Items.' , e);
		}
	}

	private String buildDrawLoopString(Id checklistId, Id ddpId, Id attachmentOptionId) {
		return 'SFChecklist_Item__c:' + checklistId + ';DDPId:' + ddpId + ';Deploy:' + attachmentOptionId;
	}

	private Map<String, Id> buildDDPNameToIdMap(List<Loop__DDP__c> allDDPs){
		Map<String, Id> ddpNameToIdMap = new Map<String, Id>();

		for(Loop__DDP__c ddp : allDDPs){
			ddpNameToIdMap.put(ddp.Name, ddp.Id);
		}

		return ddpNameToIdMap;
	}

	private Map<Id, Id> buildDDPIdToRelatedAttachmentOptionIdMap(List<Loop__DDP_Integration_Option__c> attachmentOptions) {
		Map<Id, Id> ddpIdToRelatedAttachmentOptionIdMap = new Map<Id, Id>();

		for(Loop__DDP_Integration_Option__c option : attachmentOptions) {
			ddpIdToRelatedAttachmentOptionIdMap.put(option.Loop__DDP__c, option.Id);
		}

		return ddpIdToRelatedAttachmentOptionIdMap;
	}

	public class ChecklistItemDrawloopNextPopulatorException extends Exception {}
}