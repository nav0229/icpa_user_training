public with sharing class ChecklistItemElementDataAccessor implements ChecklistItemElementDAO {
	
	public ChecklistItemElementDataAccessor() {	}

	public void insertChecklistItemElements(List<Checklist_Item_Element__c> newChecklistItemElements){
		insert newChecklistItemElements;
	}
}