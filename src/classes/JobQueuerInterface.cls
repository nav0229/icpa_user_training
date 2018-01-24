/****************************************************************
 Name:  JobQueuerInterface
============================================================
Author: Lenny
Interface for JobQueuer
============================================================

****************************************************************/

public interface JobQueuerInterface {

	void queueJob(Queueable queueableJob);
}