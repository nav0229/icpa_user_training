/****************************************************************
 Name: CreditBureauLineItemDupeChecker
============================================================
Author: Kevin
Purpose: JIRA#1775
	Identify and Flag duplicate Credit Bureau Line Item Records
============================================================

****************************************************************/
public with sharing class CreditBureauLineItemDupeChecker implements CreditBureauLineItemDupeCheckerInterface {
	@TestVisible private static CreditBureauLineItemDAO creditBureauLineItemDA = new CreditBureauLineItemDataAccessor();
	@TestVisible private static EventRequestDAO eventRequestDA = new EventRequestDataAccessor();

	public CreditBureauLineItemDupeChecker(){}

	public void markDuplicateRelatedCBLineItems(List<Application__c> applicationsForCBLineItemDedupe){
		List<Id> applicationIds = new List<Id>();

		for(Application__c application : applicationsForCBLineItemDedupe){
			applicationIds.add(application.Id);
		}

		List<Credit_Bureau_Line_Item__c> cbLineItems = creditBureauLineItemDA.getActiveCreditBureauLineItemsByApplicationIds(applicationIds);

		if(!cbLineItems.isEmpty()){
			markDuplicates(cbLineItems);

			try {
				creditBureauLineItemDA.updateCreditBureauLineItems(cbLineItems);
				eventRequestDA.insertEventRequests(createReceivedCBRDedupedEventRequests(applicationsForCBLineItemDedupe));
			} catch(DmlException e) {
				System.debug(e.getMessage());
				throw new CreditBureauLineItemDupeCheckerException('Error occurred when attempting to complete Credit Bureau Line Item Deduplication', e);
			}
		}
	}

	private void markDuplicates(List<Credit_Bureau_Line_Item__c> cbLineItems){
		for(Credit_Bureau_Line_Item__c cbLineItem1 : cbLineItems){
			for(Credit_Bureau_Line_Item__c cbLineItem2 : cbLineItems){
				if(cbLineItem1.Id != cbLineItem2.Id
					&& cbLineItem1.Creditor_Name__c == cbLineItem2.Creditor_Name__c
					&& cbLineItem1.Account_Number__c == cbLineItem2.Account_Number__c
					&& cbLineItem1.Monthly_Payments__c == cbLineItem2.Monthly_Payments__c
				){
					if(cbLineItem1.CreatedDate < cbLineItem2.CreatedDate){
						cbLineItem2.Is_Duplicate__c = true;
					} else {
						cbLineItem1.Is_Duplicate__c = true;
					}
				}
			}
		}
	}

	private List<Event_Request__c> createReceivedCBRDedupedEventRequests(List<Application__c> applications){
		List<Event_Request__c> eventRequests = new List<Event_Request__c>();

		for(Application__c application : applications){
			Event_Request__c newRequest = new Event_Request__c(
				Application_Number__c = application.Name,
				Stage__c = EventRequestDataAccessor.STAGE_RECEIVED_CBR_DEDUPED
			);
		}

		return eventRequests;
	}

	public class CreditBureauLineItemDupeCheckerException extends Exception {}
}