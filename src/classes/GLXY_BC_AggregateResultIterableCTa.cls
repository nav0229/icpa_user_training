global with sharing class GLXY_BC_AggregateResultIterableCTa implements Iterable<AggregateResult> {
    global Iterator<AggregateResult> Iterator(){ 
        Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
        string strCurrentFY = String.ValueOf(intCurrentFY);
        return new GLXY_BC_QueryLocatorAggregatorCTa(strCurrentFY);  
    }
}