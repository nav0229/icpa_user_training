/****************************************************************
 Name: AssetIncomesDAO
============================================================
Author: Kevin
Purpose: Data Access Object for Asset_Incomes__c
============================================================

****************************************************************/
public interface AssetIncomesDAO {
	List<Asset_Incomes__c> getAssetIncomesByApplicationId(Id applicationId);
}