/****************************************************************
 Name:  JobQueuerMock
============================================================
Author: Lenny
Mock for JobQueuer
============================================================

****************************************************************/

@isTest
public with sharing class JobQueuerMock implements JobQueuerInterface {
	public Integer queueJobCallCount { get; private set; }

	public JobQueuerMock() {
		queueJobCallCount = 0;
	}

	public void queueJob(Queueable queueableJob){
		queueJobCallCount++;
	}
}