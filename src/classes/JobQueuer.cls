/****************************************************************
 Name:  JobQueuer
============================================================
Author: Lenny
Responsible for performing enqueuing Queueables to the job
queue
============================================================

****************************************************************/
public with sharing class JobQueuer implements JobQueuerInterface{

	public void queueJob(Queueable queueableJob){
		System.enqueueJob(queueableJob);
	}
}