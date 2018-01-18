public with sharing class IDP_SF182EditController {

	public String instr {get; set;}
	public String instrSupervisor {get; set;}
	
	public IDP_SF182EditController(ApexPages.StandardController stdController){
		Schema.DescribeFieldResult dfr = Form_SF_182__c.SF_182_Instructions__c.getDescribe();
		instr = String.valueOf(dfr.getDefaultValueFormula());
		instr = instr.substring(1, instr.length() - 1);

		Schema.DescribeFieldResult dfr_sprv = Form_SF_182__c.Supervisor_SF_182_Instructions__c.getDescribe();
		instrSupervisor = String.valueOf(dfr_sprv.getDefaultValueFormula());
		instrSupervisor = instrSupervisor.substring(1, instrSupervisor.length() - 1);

	}

}