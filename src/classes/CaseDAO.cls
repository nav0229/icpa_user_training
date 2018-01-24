/****************************************************************
 Name: CaseDAO
============================================================
Author: 
Purpose: Data Access Object for Case
============================================================

****************************************************************/

public interface CaseDAO {
	void updateCases(List<Case> cases);
	List<Case> getCasesByCaseIds(List<Id> caseIds);
	List<Case> getCasesByApplicationIdsAndRecordType(List<Id> applicationIds, Id rTypeId);
}