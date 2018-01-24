public with sharing class DrawloopDocumentPackagesDataAccessor implements DrawloopDocumentPackagesDAO {
	private final String DDP = 'Loop__DDP__c';
	private Set<String> ddpFields;

	public DrawloopDocumentPackagesDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.ddpFields = schemaMap.get(DDP).getDescribe().fields.getMap().keySet();
	}

	public List<Loop__DDP__c> getAllDocumentPackages(){
		QueryBuilder ddpQueryBuilder = new QueryBuilder(DDP);
		ddpQueryBuilder.addSelectField(this.ddpFields);
		return Database.query(ddpQueryBuilder.generateQuery());
	}
}