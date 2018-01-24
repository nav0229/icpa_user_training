/****************************************************************
 Name: FieldHistoryDataAccessor
============================================================
Author: Matt
Purpose: Data Accessor object for field history
============================================================

****************************************************************/

public with sharing class FieldHistoryDataAccessor implements FieldHistoryDAO {

	private static final Datetime LAST_FIVE_MINUTES = Datetime.now().addMinutes(-5);

	public FieldHistoryDataAccessor() {
	}

	public List<SBA_Loan_History__History> getSBAloanHistoryFieldHistoriesInPastFiveMinutes() {
		return [SELECT ParentId, Field, OldValue, NewValue, CreatedById
			 	FROM SBA_Loan_History__History
				WHERE CreatedDate > :LAST_FIVE_MINUTES];
	}

	public List<Other_Assistance__History> getOtherAssistanceFieldHistoriesInPastFiveMinutes() {
		return [SELECT ParentId, Field, OldValue, NewValue, CreatedById
			 	FROM Other_Assistance__History
				WHERE CreatedDate > :LAST_FIVE_MINUTES];
	}
	
}