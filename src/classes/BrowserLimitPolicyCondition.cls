/****************************************************************
 Name: BrowserLimitPolicyCondition
============================================================
Author: Bala Rajasekharan
Purpose: This Policy limits the types of Browsers allowed.
============================================================

****************************************************************/
global class BrowserLimitPolicyCondition implements TxnSecurity.PolicyCondition {

    public boolean evaluate(TxnSecurity.Event e){
        
        LoginHistory lh = [SELECT Application, Browser FROM LoginHistory WHERE Id = :e.data.get('LoginHistoryId')];
        
        String application = lh.Application;
        String browser = lh.Browser;
        
        if (application.equals('Browser') && ( browser.startsWith('Chrome') || browser.startsWith('Firefox') || browser.equals('IE 11')  || browser.equals('Edge 14') ) ) {
            
            return false;
  
        }       
        return true;
        
    }
 }