global with sharing class GLXY_BC_AggregateResultIterableTaxes implements Iterable<AggregateResult> {
	global Iterator<AggregateResult> Iterator(){ 
		  return new GLXY_BC_QueryLocatorTaxes(); 
	}
}