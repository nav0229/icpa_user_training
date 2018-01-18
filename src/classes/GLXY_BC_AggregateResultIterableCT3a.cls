global with sharing class GLXY_BC_AggregateResultIterableCT3a implements Iterable<AggregateResult> {
  global Iterator<AggregateResult> Iterator(){ 
    Integer intCurrentFY = Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year();
    intCurrentFY += 2;
     string strCurrentFY = String.ValueOf(intCurrentFY);
    return new GLXY_BC_QueryLocatorAggregatorCTa(strCurrentFY); 
  }
}