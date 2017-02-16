public with sharing class GSA_FCIC_CTI_Case_Creation {


     public string dnis;
     public string ucid;
     public string ani;
     public Case cas {get;set;}
        
        public PageReference displayCase(){
        
               dnis = ApexPages.currentPage().getParameters().get('DNIS');
               ucid = ApexPages.currentPage().getParameters().get('UCID');
               ani = ApexPages.currentPage().getParameters().get('ANI'); 
               
               if(dnis ==''){
                system.debug('############'+dnis );
                  GSA_FCIC_KBArticles_Exception excep = new GSA_FCIC_KBArticles_Exception('DNIS parameter is null');
                  excep.createExceptionRecord();
                  
               }else{
              // if(dnis!=null && ucid!=null && ani!=null){
               CTI_Cases__c cti = CTI_Cases__c.getValues(dnis);
               if(cti!=null){
               String ctiCas = cti.Case_Record_Type_ID__c;
                   cas = new Case(Origin='Phone',RecordTypeId=ctiCas,Avaya_ANI__c =ani,Avaya_UCID__c=ucid); 
                  insert cas;
                PageReference ref = new PageReference('/'+cas.id+'/e?retURL='+cas.id);
                return ref;
               }
             } 
          
            PageReference ref = new PageReference('/'+500);
             return ref;
       
        }
}