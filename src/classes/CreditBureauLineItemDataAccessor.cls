/****************************************************************
 Name: CreditBureauLineItemDataAccessor
============================================================
Author: Kevin/Lenny
Purpose: Data Accessor for Credit_Bureau_Line_Item__c
============================================================

****************************************************************/
public with sharing class CreditBureauLineItemDataAccessor implements CreditBureauLineItemDAO {
	private static final String CREDIT_BUREAU_LINE_ITEM = 'Credit_Bureau_Line_Item__c';

	private Set<String> creditBureauLineItemFields;

	public CreditBureauLineItemDataAccessor(){
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.creditBureauLineItemFields = schemaMap.get(CREDIT_BUREAU_LINE_ITEM).getDescribe().fields.getMap().keySet();
	}

	public void insertCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem){
		insert cbrLineItem;
	}

	public void updateCreditBureauLineItem(Credit_Bureau_Line_Item__c cbrLineItem){
		update cbrLineItem;
	}

	public void updateCreditBureauLineItems(List<Credit_Bureau_Line_Item__c> cbrLineItems){
		update cbrLineItems;
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> applicationIds){
		QueryBuilder creditBureauLineItemQueryBuilder = new QueryBuilder(CREDIT_BUREAU_LINE_ITEM);
		creditBureauLineItemQueryBuilder.addSelectField(this.creditBureauLineItemFields);
		creditBureauLineItemQueryBuilder.addSelectField('Credit_Bureau__r.Application__c');
		creditBureauLineItemQueryBuilder.addWhereCondition('Credit_Bureau__r.Application__c', applicationIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(creditBureauLineItemQueryBuilder.generateQuery());
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicantId(List<Id> applicantIds){
		QueryBuilder creditBureauLineItemQueryBuilder = new QueryBuilder(CREDIT_BUREAU_LINE_ITEM);
		creditBureauLineItemQueryBuilder.addSelectField(this.creditBureauLineItemFields);
		creditBureauLineItemQueryBuilder.addSelectField('Credit_Bureau__r.Applicant_Name__c');
		creditBureauLineItemQueryBuilder.addWhereCondition('Is_Duplicate__c', false, QueryBuilder.ComparisonOperator.EQUALS);
		creditBureauLineItemQueryBuilder.addWhereCondition('Credit_Bureau__r.Active__c', true, QueryBuilder.ComparisonOperator.EQUALS);
		creditBureauLineItemQueryBuilder.addWhereCondition('Credit_Bureau__r.Applicant_Name__c', applicantIds, QueryBuilder.ComparisonOperator.IN_LIST);
		return Database.query(creditBureauLineItemQueryBuilder.generateQuery());
	}

	public List<Credit_Bureau_Line_Item__c> getActiveCreditBureauLineItemsByApplicationIds(List<Id> applicationIds, Set<String> purposeOfAccountCodes, 
		Set<String> paymentStatusCodes, Set<String> accountConditionCodes, String paymentStatusForeclose) 
	{
		return new List<Credit_Bureau_Line_Item__c>([
        	SELECT	Purpose_of_Account_Code__c,Payment_Status_Code__c,Account_Condition_Code__c,
					Public_Record_Satisified_Date__c,Balance_Date__c,Account_Balance__c,Credit_Bureau_Line_Item_Type__c,
					Credit_Bureau__r.Application__c
			FROM Credit_Bureau_Line_Item__c 
			WHERE (Credit_Bureau__r.Active__c =true) 
			AND (Credit_Bureau__r.Application__c in:applicationIds) 
			AND (Purpose_of_Account_Code__c in:purposeOfAccountCodes
			OR Payment_Status_Code__c in:paymentStatusCodes
			OR Payment_Status_Code__c =:paymentStatusForeclose
			OR Account_Condition_Code__c in:accountConditionCodes)
		]);
	}
}