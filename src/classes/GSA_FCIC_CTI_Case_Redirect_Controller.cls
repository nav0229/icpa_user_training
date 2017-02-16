public with sharing class GSA_FCIC_CTI_Case_Redirect_Controller {
public string dnis;
  public string ucid;
  public string ani;
  public Case cas {get;set;}
  public boolean rendered {get; set;}

  public GSA_FCIC_CTI_Case_Redirect_Controller() {
	dnis = ApexPages.currentPage().getParameters().get('DNIS');
	ucid = ApexPages.currentPage().getParameters().get('UCID');
	ani = ApexPages.currentPage().getParameters().get('ANI');
	rendered = false;
  }
  public void displayCase(){

	if(dnis =='' || dnis == null){
	  GSA_FCIC_Exception excep = new GSA_FCIC_Exception('DNIS parameter is null');
	  excep.createExceptionRecord();
	} else {

	  CTI_Cases__c cti = CTI_Cases__c.getValues(dnis);
	  String ctiCas = cti.Case_Record_Type_ID__c;
	  // CLC add - DNIS wasn't being stored, and its currently being ingested as a string so we need to convert
	  // in order to store in Avaya_DNIS__c
	  Decimal dnisD = Decimal.valueOf(dnis);

	  case newCase = new Case(Origin='Phone',RecordTypeId=ctiCas,Avaya_ANI__c =ani,Avaya_UCID__c=ucid,Avaya_DNIS__c=dnisD); 
	  
	  try{
		insert newCase;
		cas = [Select Id, CaseNumber from Case where Id = :newCase.Id];
	  } catch(Exception e) {
		GSA_FCIC_Exception excep = new GSA_FCIC_Exception('DNIS Case Creation Error: '+e.getMessage());
		excep.createExceptionRecord();
		cas = newCase;
	  }
	}

	rendered = true;
	system.debug(rendered);
	//PageReference ref = new PageReference('/'+cas.id+'/e?retURL='+cas.id);
	//return ref;
  }
}