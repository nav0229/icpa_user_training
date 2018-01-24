@isTest
public with sharing class DeliveryOptionDataAccessorMock implements DeliveryOptionDAO {
	public Integer getDeliveryOptionsByDDPIdsCallCount{get; private set;}

	public List<Loop__DDP_Integration_Option__c> getDeliveryOptionsByDDPIdsReturn;

	public DeliveryOptionDataAccessorMock() {
		getDeliveryOptionsByDDPIdsCallCount = 0;

		getDeliveryOptionsByDDPIdsReturn = new List<Loop__DDP_Integration_Option__c>();
	}

	public List<Loop__DDP_Integration_Option__c> getDeliveryOptionsByDDPIds(List<Id> ddpIds){
		getDeliveryOptionsByDDPIdsCallCount++;
		return getDeliveryOptionsByDDPIdsReturn;
	}
}