global with sharing class GLXY_BC_AggregateResultIterableProjectSR implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorProjectStepRent(); 
	}
}