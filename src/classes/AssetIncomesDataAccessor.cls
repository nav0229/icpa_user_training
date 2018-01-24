/****************************************************************
 Name: AssetIncomesDataAccessor
============================================================
Author: Kevin
Purpose: Data Accessor for Asset_Incomes__c
============================================================

****************************************************************/
public with sharing class AssetIncomesDataAccessor implements AssetIncomesDAO {

	private final String ASSET_INCOMES = 'Asset_Incomes__c';

	private Set<String> assetIncomeFields;

	public AssetIncomesDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		this.assetIncomeFields = schemaMap.get(ASSET_INCOMES).getDescribe().fields.getMap().keySet();
	}

	public List<Asset_Incomes__c> getAssetIncomesByApplicationId(Id applicationId){
		QueryBuilder assetIncomesQueryBuilder = new QueryBuilder(ASSET_INCOMES);
		assetIncomesQueryBuilder.addSelectField(this.assetIncomeFields);
		assetIncomesQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		return Database.query(assetIncomesQueryBuilder.generateQuery());
	}
}