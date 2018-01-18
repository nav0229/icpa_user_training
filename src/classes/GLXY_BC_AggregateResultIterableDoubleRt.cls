global with sharing class GLXY_BC_AggregateResultIterableDoubleRt implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorDoubleRent(); 
	}
}