public interface DeliveryOptionDAO {
	List<Loop__DDP_Integration_Option__c> getDeliveryOptionsByDDPIds(List<Id> ddpIds);
}