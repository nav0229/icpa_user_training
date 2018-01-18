global with sharing class GLXY_BC_AggregateResultIterableFY1IA implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorAggregatorFY1IA(); 
	}
}