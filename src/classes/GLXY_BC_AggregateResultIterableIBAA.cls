global with sharing class GLXY_BC_AggregateResultIterableIBAA implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorIBAA(); 
	}
}