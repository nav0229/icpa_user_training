global with sharing class GLXY_BC_AggregateResultIterable implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorAggregator(); 
	}
}