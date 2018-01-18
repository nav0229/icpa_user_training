public with sharing class SDRespondentListController {

	public List<Suspension_and_Debarment_Case__c> respondentCases { get; set; }
	public List<RespondentLineItem> respondentLineItems { get; set; }
	public String baseURL { get; set; }

	private final Suspension_and_Debarment_Case__c SDObj;

	public SDRespondentListController(ApexPages.StandardController controller) {
		baseURL = System.URL.getSalesforceBaseUrl().toExternalForm();
		SDObj = (Suspension_and_Debarment_Case__c) controller.getRecord();
		respondentCases = [
				// any queried fields need to be added to wrapper class at the end
				SELECT 	Id
						, Name
						, Respondent_Name__c
						, Case_Closed__c
						, Suspension_Date__c
						, Proposal_for_Debarment_Date__c
						, Debarment_Decision_Date__c
						, Comments_for_SDO__c
						, Case_Status__c
						, Case_Name__c
						, Integrity_Officer_Name__c
						, OwnerId
						, Owner.Name
				FROM Suspension_and_Debarment_Case__c
				WHERE General_Case_Information__c = :SDObj.id
				ORDER BY id
		];
		respondentLineItems = populaterespondentLineItems(respondentCases);
	}

	public List<RespondentLineItem> populaterespondentLineItems(List<Suspension_and_Debarment_Case__c> sdCases){
		List<RespondentLineItem> tempRespondentLineItems = new List<RespondentLineItem>();
		for(Suspension_and_Debarment_Case__c sdCase : sdCases){
			tempRespondentLineItems.add(new RespondentLineItem(sdCase));
		}
		return tempRespondentLineItems;
	}

	public class RespondentLineItem{
		public String id { get; set; }
		public String name { get; set; }
		public String respondentName { get; set; }
		public Boolean closeCase { get; set; }
		public Date suspensionDate { get; set; }
		public Date proposalForDebarmentDate { get; set; }
		public Date debarmentDecisionDate { get; set; }
		public String commentsForSDO { get; set; }
		public String caseStatus { get; set; }
		public String ownerName { get; set; }

		public RespondentLineItem(Suspension_and_Debarment_Case__c sdCase){
			this.id = sdCase.Id;
			this.name = sdCase.Name;
			this.respondentName = sdCase.Respondent_Name__c;
			if(sdCase.Case_Closed__c == 'Yes'){
				this.closeCase = true;
			} else {
				this.closeCase = false;
			}
			this.suspensionDate = sdCase.Suspension_Date__c;
			this.proposalForDebarmentDate = sdCase.Proposal_for_Debarment_Date__c;
			this.debarmentDecisionDate = sdCase.Debarment_Decision_Date__c;
			this.commentsForSDO = sdCase.Comments_for_SDO__c;
			if(sdCase.Owner.Name == null && sdCase.OwnerId != null){
				User u = [SELECT Id, Name FROM User WHERE Id = :sdCase.OwnerId];
				this.caseStatus = addOwnerToStatus(sdCase.Case_Status__c, u.Name);
			} else {
				this.caseStatus = addOwnerToStatus(sdCase.Case_Status__c, sdCase.Owner.Name);
			}
			this.ownerName = sdCase.Owner.Name;
		}

		private String addOwnerToStatus(String oldStatus, String owner){
			if(owner == null) return oldStatus;
			if(oldStatus.contains('IO')){
				return oldStatus.replace('IO', owner);
			} else if (oldStatus.contains('Integrity Officer')){
				return oldStatus.replace('Integrity Officer', owner);
			} else {
				return oldStatus;
			}
		}
	}
}