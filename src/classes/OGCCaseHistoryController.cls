/*
    OGCCaseHistoryController.cls
    Purpose of this controller is to automatically take the user to the 
    Case History create page based on the record type - Personnel or 
    Non-Personnel. 
    -------------------------------------------------------------------
    Author                Date        Version  Description
    -------------------------------------------------------------------
    Acumen Solutions      2/1/2012     1.0.0   Creation
*/
public with sharing class OGCCaseHistoryController {
    private OCIO_OGC_Case_Tracking__c ogcCase { get; set; }
    private OCIO_OGC_Case_History_Data__c ogcCaseHist { get; set; }

    public OGCCaseHistoryController() {
        //System.debug('************** ID: ' + ApexPages.currentPage().getParameters().get('parentId'));
        ogcCase = [select ID, Name, RecordTypeId from OCIO_OGC_Case_Tracking__c where id = :ApexPages.currentPage().getParameters().get('parentId') ];
    }
    
    public PageReference doRedirect() {
        String recordType = [select Name from RecordType where Id = :ogcCase.RecordTypeId].Name;
        
        Id recordTypeId = [select Id from RecordType where Name = :recordType + ' History Data'].Id; 
        
        //From Dev        
        //String url = '/a0j/e?CF00NS0000000ykTJ=' + ogcCase.Name + '&CF00NS0000000ykTJ_lkid=' + ogcCase.ID + '&retURL=%2F' + ogcCase.ID + '&ent=01IS00000000zn9&RecordType=' + recordTypeId;
        
        //From UAT
      //  String url = '/a0T/e?CF00NS0000000h6vL=' + ogcCase.Name + '&CF00NS0000000h6vL_lkid=' + ogcCase.ID + '&retURL=%2F' + ogcCase.ID + '&ent=01IS00000004qip&RecordType=' + recordTypeId;
        
         //From PROD
        String url = '/a0t/e?CF00N30000009kWfN=' + ogcCase.Name + '&CF00N30000009kWfN_lkid=' + ogcCase.ID + '&retURL=%2F' + ogcCase.ID + '&ent=01I30000002FFFV&RecordType=' + recordTypeId;
        //System.debug('************** URL: ' + url);
                
        return new PageReference(url);
    }        
}