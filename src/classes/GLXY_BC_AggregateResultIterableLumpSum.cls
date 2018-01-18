global with sharing class GLXY_BC_AggregateResultIterableLumpSum implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorLumpSum(); 
	}
}