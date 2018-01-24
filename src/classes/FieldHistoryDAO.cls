/****************************************************************
 Name: FieldHistoryDAO
============================================================
Author: 
Purpose: Data Access Object for field history
============================================================

****************************************************************/

public interface FieldHistoryDAO {
	List<SBA_Loan_History__History> getSBAloanHistoryFieldHistoriesInPastFiveMinutes();
	List<Other_Assistance__History> getOtherAssistanceFieldHistoriesInPastFiveMinutes();
}