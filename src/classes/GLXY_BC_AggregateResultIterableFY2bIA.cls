global with sharing class GLXY_BC_AggregateResultIterableFY2bIA implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorAggregatorFY2bIA(); 
	}
}