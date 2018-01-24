@isTest
public with sharing class DisasterDataAccessorMock implements DisasterDAO {
	public Integer getDisasterByIdCallCount {get; private set;}

	public Disaster__c getDisasterByIdReturn;

	public DisasterDataAccessorMock() {
		getDisasterByIdCallCount = 0;

		getDisasterByIdReturn = new Disaster__c();
	}

	public Disaster__c getDisasterById(Id disasterId){
		getDisasterByIdCallCount++;
		return getDisasterByIdReturn;
	}
}