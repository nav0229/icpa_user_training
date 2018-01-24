/****************************************************************
 Name: PropertyDataAccessor
============================================================
Author: Lenny
Purpose: Data Accessor for Property
============================================================

****************************************************************/

public with sharing class PropertyDataAccessor implements PropertyDAO {
	public static final String PROPERTY_USE_TYPE_HOMEOWNER='HOME/OWNER';

	public static final String PROPERTY_TYPE_CONDO_TOWNHOUSE='Condo/Townhouse';
	public static final String PROPERTY_TYPE_HOA_OWNED='Homeowners Association';
	public static final String PROPERTY_TYPE_CO_OP='CO-OP';
	public static final String PROPERTY_TYPE_BOAT_REG_WITH_CG ='Boat (Registered with Coast Guard)';
	public static final String PROPERTY_TYPE_VSL_REG_WITH_CG ='Vessel (Registered with Coast Guard)';

	public static final String COLLATERAL_TYPE_RE = 'Real Estate';
	public static final String COLLATERAL_TYPE_MANU_HOME = 'Manufactured Home';
	public static final String COLLATERAL_TYPE_MANU_HOME_TO_PURCH = 'Manufactured Home to be Purchased';
	public static final String COLLATERAL_TYPE_CO_OP = 'CO-OP';
	public static final String COLLATERAL_TYPE_STRUCT_IMPROV = 'Structure and Improvements';
	public static final String COLLATERAL_TYPE_ASSN_LAND = 'Assignment of Land Sales Contract';

	private final String PROPERTY = 'Property__c';
	private final String LOSS_VERIFICATION = 'Loss_Verification_Inspections__c';

	private final String LOSS_VERIFICATION_RELATIONSHIP_NAME = 'Loss_Verifications__r';

	private Set<String> propertyFields;
	private Set<String> lossVerificationFields;

	public PropertyDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.propertyFields = schemaMap.get(PROPERTY).getDescribe().fields.getMap().keySet();
        this.lossVerificationFields = schemaMap.get(LOSS_VERIFICATION).getDescribe().fields.getMap().keySet();
	}

	public List<Property__c> getDamagedPropertiesByApplicationId(Id applicationId){
		QueryBuilder propertyQueryBuilder = new QueryBuilder(PROPERTY);
		propertyQueryBuilder.addSelectField(this.propertyFields);

		propertyQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		propertyQueryBuilder.addWhereCondition('Damaged_Property__c', true, QueryBuilder.ComparisonOperator.EQUALS);

		return Database.query(propertyQueryBuilder.generateQuery());
	}

	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationId(Id applicationId){
		QueryBuilder propertyQueryBuilder = new QueryBuilder(PROPERTY);
		propertyQueryBuilder.addSelectField(this.propertyFields);

		QueryBuilder lossVerificationQueryBuilder = new QueryBuilder(LOSS_VERIFICATION_RELATIONSHIP_NAME);
		lossVerificationQueryBuilder.addSelectField(this.lossVerificationFields);
		propertyQueryBuilder.addSelectField(lossVerificationQueryBuilder);

		propertyQueryBuilder.addWhereCondition('Application__c', applicationId, QueryBuilder.ComparisonOperator.EQUALS);
		propertyQueryBuilder.addWhereCondition('Damaged_Property__c', true, QueryBuilder.ComparisonOperator.EQUALS);

		return Database.query(propertyQueryBuilder.generateQuery());
	}

	public List<Property__c> getDamagedPropertiesAndLossVerificationsByApplicationIds(List<Id> applicationIds){
		QueryBuilder propertyQueryBuilder = new QueryBuilder(PROPERTY);
		propertyQueryBuilder.addSelectField(this.propertyFields);

		QueryBuilder lossVerificationQueryBuilder = new QueryBuilder(LOSS_VERIFICATION_RELATIONSHIP_NAME);
		lossVerificationQueryBuilder.addSelectField(this.lossVerificationFields);
		propertyQueryBuilder.addSelectField(lossVerificationQueryBuilder);

		propertyQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		propertyQueryBuilder.addWhereCondition('Damaged_Property__c', true, QueryBuilder.ComparisonOperator.EQUALS);

		return Database.query(propertyQueryBuilder.generateQuery());
	}

	public Map<Id,Property__c> getDamagedPropertiesByApplicationIds(List<Id> applicationIds){
		QueryBuilder propertyQueryBuilder = new QueryBuilder(PROPERTY);
		propertyQueryBuilder.addSelectField(this.propertyFields);

		propertyQueryBuilder.addWhereCondition('Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		propertyQueryBuilder.addWhereCondition('Damaged_Property__c', true, QueryBuilder.ComparisonOperator.EQUALS);

		return new Map<Id,Property__c>((List<Property__c>)(Database.query(propertyQueryBuilder.generateQuery())));
	}

	public void updateProperties(List<Property__c> properties) {
		update properties;
	}
}