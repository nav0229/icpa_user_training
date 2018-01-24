/****************************************************************
 Name: ClosingDocumentsGeneratorMock
============================================================
Author: 
Purpose: Mock for ClosingDocumentsGenerator
============================================================

****************************************************************/

@isTest
public with sharing class ClosingDocumentsGeneratorMock implements ClosingDocumentsGeneratorInterface {
	public Integer generateClosingDocumentsCallCount {get; private set;}

	public ClosingDocumentsGeneratorMock() {
		generateClosingDocumentsCallCount = 0;
	}

	public void generateClosingDocuments(List<Case> cases){
		generateClosingDocumentsCallCount++;
	}
}