@isTest
public with sharing class DrawloopDocumentPackagesDataAccessorMock implements DrawloopDocumentPackagesDAO {
	public Integer getAllDocumentPackagesCallCount {get; private set;}

	public List<Loop__DDP__c> getAllDocumentPackagesReturn;

	public DrawloopDocumentPackagesDataAccessorMock() {
		getAllDocumentPackagesCallCount = 0;

		getAllDocumentPackagesReturn = new List<Loop__DDP__c>();
	}

	public List<Loop__DDP__c> getAllDocumentPackages(){
		getAllDocumentPackagesCallCount++;
		return getAllDocumentPackagesReturn;
	}
}