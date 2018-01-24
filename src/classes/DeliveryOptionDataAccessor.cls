public with sharing class DeliveryOptionDataAccessor implements DeliveryOptionDAO {
	private final String DELIVERY_OPTION = 'Loop__DDP_Integration_Option__c';

	private final String ATTACHMENT_ATTACH_AS_TYPE = 'Attachment';

	private Set<String> deliveryOptionFields;

	public DeliveryOptionDataAccessor() {
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.deliveryOptionFields = schemaMap.get(DELIVERY_OPTION).getDescribe().fields.getMap().keySet();
	}

	public List<Loop__DDP_Integration_Option__c> getDeliveryOptionsByDDPIds(List<Id> ddpIds){
		QueryBuilder deliveryOptionQueryBuilder = new QueryBuilder(DELIVERY_OPTION);
		deliveryOptionQueryBuilder.addSelectField(this.deliveryOptionFields);
		deliveryOptionQueryBuilder.addWhereCondition('Loop__DDP__c', ddpIds, QueryBuilder.ComparisonOperator.IN_LIST);
		deliveryOptionQueryBuilder.addWhereCondition('Loop__Attach_As__c', ATTACHMENT_ATTACH_AS_TYPE, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(deliveryOptionQueryBuilder.generateQuery());
	}
}