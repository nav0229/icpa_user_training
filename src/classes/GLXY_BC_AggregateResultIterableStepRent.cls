global with sharing class GLXY_BC_AggregateResultIterableStepRent implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorAggregatorStepRent(); 
	}
}