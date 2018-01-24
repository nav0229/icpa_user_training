/****************************************************************
 Name: CaseDataAccessorMock
============================================================
Author: 
Purpose: Mock Data Accessor Class for Case
============================================================

****************************************************************/

@isTest
public with sharing class CaseDataAccessorMock implements CaseDAO {
	public Integer getCasesByApplicationIdsAndRecordTypeCallCount {get; private set;}
	public Integer getCasesByCaseIdsCallCount {get; private set;}
	public Integer updateCasesCallCount {get; private set;}

	public List<Case> getCasesByApplicationIdsAndRecordTypeReturn;
	public List<Case> getCasesByCaseIdsReturn;

	public CaseDataAccessorMock() {
		getCasesByApplicationIdsAndRecordTypeCallCount = 0;
		getCasesByCaseIdsCallCount = 0;
		updateCasesCallCount = 0;

		getCasesByApplicationIdsAndRecordTypeReturn = new List<Case>();
		getCasesByCaseIdsReturn = new List<Case>();
	}

	public List<Case> getCasesByApplicationIdsAndRecordType(List<Id> applicationIds, Id rTypeId){
		getCasesByApplicationIdsAndRecordTypeCallCount++;
		return getCasesByApplicationIdsAndRecordTypeReturn;
	}

	public List<Case> getCasesByCaseIds(List<Id> caseIds) {
		getCasesByCaseIdsCallCount++;
		return getCasesByCaseIdsReturn;
	}

	public void updateCases(List<Case> cases) {
		updateCasesCallCount++;
	}
}