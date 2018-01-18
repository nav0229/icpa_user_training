public with sharing class GLXY_clsDuplicates {
    
	public String strFiscalYear     {get; set;}
    public String strRegion         {get; set;}
    public String strRegionDisplay  {get; set;}
    
    public String GroupByCriteria1  {get; set;}
    public String GroupByCriteria2  {get; set;}
    public String GroupByCriteria3  {get; set;}
    public String GroupByCriteria4  {get; set;}
    public String GroupByCriteria5  {get; set;}
    public String GroupByCriteria6  {get; set;}
    
    public decimal GroupByCriteria7 {get; set;}
    public String  GroupByCriteria8 {get; set;}
    public String  GroupByCriteria9 {get; set;}
    
    public String AggregateRowCount {get; set;}
    public String RecordLink        {get; set;}
    
    String strSOQL;
        
    public GLXY_clsDuplicates(){
    	strRegion = '';
      	strRegionDisplay = '';
      	strFiscalYear = '';
      	//Default Year and Region values, if not supplied ...
      	if (System.currentPageReference().getParameters().get('Region')!=null){
	    	strRegion = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('Region'));
	    	strRegionDisplay = strRegion.Replace('\\','');                             
        	strFiscalYear = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('FY'));            
      	}else{
        	strRegion = '\'3\'';
        	strFiscalYear = '2013';
      	}
    }
    
    public GLXY_clsDuplicates(string strGroupByCriteria1, string strGroupByCriteria2, string strGroupByCriteria3, string strGroupByCriteria4, string strAggregateRowCount, string strRecordLink, string strGroupByCriteria5,
                              string strGroupByCriteria6, decimal dblGroupByCriteria7, string strGroupByCriteria8, string strGroupByCriteria9){
    	this.GroupByCriteria1 = strGroupByCriteria1;
        this.GroupByCriteria2 = strGroupByCriteria2;
        this.GroupByCriteria3 = strGroupByCriteria3;
        this.GroupByCriteria4 = strGroupByCriteria4;
        this.GroupByCriteria5 = strGroupByCriteria5;
        this.GroupByCriteria6 = strGroupByCriteria6;
        this.GroupByCriteria7 = dblGroupByCriteria7;
        this.GroupByCriteria8 = strGroupByCriteria8;
        this.GroupByCriteria9 = strGroupByCriteria9;
        this.AggregateRowCount = strAggregateRowCount;
        this.RecordLink = strRecordLink;
    }
    
    public List<GLXY_clsDuplicates> objDataset = new List<GLXY_clsDuplicates>();
    public List<GLXY_clsDuplicates> objDataset1 = new List<GLXY_clsDuplicates>();
    public List<GLXY_clsDuplicates> objDataset2 = new List<GLXY_clsDuplicates>();
    public List<GLXY_clsDuplicates> objDataset3 = new List<GLXY_clsDuplicates>();
    
    public List<GLXY_clsDuplicates> getDatasetCPIDups(){
    	
    	List<ID> PotentialDuplicateCPIKey = new List<ID>();
    	Date dtProcessedDate;
        string strID;
        string strProcessedDate;
    	string strLoopPreviousKey = '-';
        string strLoopCurrentKey;
        GLXY_clsDuplicates objPreviousLine;
    	
		strSOQL =   'Select LeaseNumber__r.ID, LeaseNumber__r.Name  ' + 
	                'From   Glxy_ConsumerPriceIndex__c  ' +
	                'Where  ProcessedDateFY__c = :strFiscalYear ' +
	                'And    LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
	                'And    BDGFlag__c = True ' +
	                'Group by LeaseNumber__r.ID, LeaseNumber__r.Name ' +
	                'Having Count(Name) > 1 ' +
	                'Order by LeaseNumber__r.Name ';
        strSOQL = strSOQL.Replace('\\','');         

        AggregateResult[] AgR = Database.Query(strSOQL);
        
        for (AggregateResult RowData : AgR) { 
                strID = string.valueOf(RowData.get('ID'));
                PotentialDuplicateCPIKey.add(strID);
        }
        
	    List<Glxy_ConsumerPriceIndex__c> objPotentialDuplicateCPI = [
	    	Select LeaseNumber__r.ID, LeaseNumber__r.Name,  EscalationType__c, ProcessedDate__c , LeaseNumber__r.RegionCD__c, EffectiveDate__c, LeaseNumber__r.TeamCode__c, AnnualAmount__c, RecordType.DeveloperName, StatusCD__c  
	        From   Glxy_ConsumerPriceIndex__c  
	        Where  LeaseNumber__r.ID= :PotentialDuplicateCPIKey 
	        And    ProcessedDateFY__c = :strFiscalYear 
	        And    BDGFlag__c = True
	        Order by LeaseNumber__r.Name, EscalationType__c, ProcessedDate__c];
	      
	    for (Glxy_ConsumerPriceIndex__c objCPI : objPotentialDuplicateCPI) { 
	    	dtProcessedDate = Date.ValueOf(objCPI.ProcessedDate__c);
            strProcessedDate = String.valueOf(dtProcessedDate.Year()) + String.valueOf(dtProcessedDate.Month()) + String.valueOf(dtProcessedDate.Day());
            strLoopCurrentKey = (String.valueOf(objCPI.LeaseNumber__r.Name) + String.valueOf(objCPI.EscalationType__c) + strProcessedDate);

          	If (strLoopCurrentKey == strLoopPreviousKey){
            	objDataset.add(objPreviousLine);  
            	objDataset.add(new GLXY_clsDuplicates(
              		String.valueOf(objCPI.LeaseNumber__r.Name),
              		String.valueOf(objCPI.EscalationType__c),
		            String.valueOf(objCPI.ProcessedDate__c),
		            String.valueOf(objCPI.EffectiveDate__c),
		            '',
		            String.valueOf(objCPI.LeaseNumber__r.ID),
		            String.valueOf(objCPI.LeaseNumber__r.RegionCD__c),
		            String.valueOf(objCPI.LeaseNumber__r.TeamCode__c),
		            (Decimal) (objCPI.AnnualAmount__c),
		            String.valueOf(objCPI.RecordType.DeveloperName),
		            String.valueOf(objCPI.StatusCD__c)
            	));
          	}
          	objPreviousLine = New GLXY_clsDuplicates(
            	String.valueOf(objCPI.LeaseNumber__r.Name),
              	String.valueOf(objCPI.EscalationType__c),
             	String.valueOf(objCPI.ProcessedDate__c),
              	String.valueOf(objCPI.EffectiveDate__c),
              	'',
              	String.valueOf(objCPI.LeaseNumber__r.ID),
              	String.valueOf(objCPI.LeaseNumber__r.RegionCD__c),
              	String.valueOf(objCPI.LeaseNumber__r.TeamCode__c),
              	(Decimal) (objCPI.AnnualAmount__c),
              	String.valueOf(objCPI.RecordType.DeveloperName),
              	String.valueOf(objCPI.StatusCD__c)
          	);
          	strLoopPreviousKey = strLoopCurrentKey;
        }
        return objDataset;
    }
    
    /*
    public List<GLXY_clsDuplicates> getDatasetCPI(){
    
    	strSOQL =   'Select LeaseNumber__r.ID, LeaseNumber__r.Name,  EscalationType__c, ProcessedDate__c , count(Name) DupCount  ' + 
                    'From   Glxy_ConsumerPriceIndex__c  ' +
                    'Where  ProcessedDateFY__c = :strFiscalYear ' +
                    'And    LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'Group by LeaseNumber__r.ID, LeaseNumber__r.Name, EscalationType__c, ProcessedDate__c ' +
                    'Having Count(Name) > 1 ' +
                    'Order by LeaseNumber__r.Name, ProcessedDate__c ';
        strSOQL = strSOQL.Replace('\\','');         

        AggregateResult[] AgR = Database.Query(strSOQL);
                                        
        for (AggregateResult RowData : AgR) { 
            objDataset.add(new GLXY_clsDuplicates(
                String.valueOf(RowData.get('Name')),  String.valueOf(RowData.get('EscalationType__c')), 
                Date.valueOf(RowData.get('ProcessedDate__c')).format(),  '', 
                String.valueOf(RowData.get('DupCount')), String.valueOf(RowData.get('ID')),
                ''
            ));
        }
        return objDataset;
    }
    */
    
    public List<GLXY_clsDuplicates> getDatasetLumpSumDups(){
    	
		List<ID> PotentialDuplicateLumpSumKey = new List<ID>();
		Date dtEffectiveDate;
	    string strID;
	    string strEffectiveDate;
		string strLoopPreviousKey = '-';
	    string strLoopCurrentKey;
	    GLXY_clsDuplicates objPreviousLine;
    	
    	strSOQL =   'Select LeaseNumber__r.ID, LeaseNumber__r.Name  ' + 
                    'From   Glxy_LumpSum__c  ' +
                    'Where  ProcessedDateFY__c = :strFiscalYear ' +
                    'And    LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    BDGFlag__c = True ' +
                    'Group by LeaseNumber__r.ID, LeaseNumber__r.Name  ' +
                    'Having Count(Name) > 1 ' +
                    'Order by LeaseNumber__r.Name ';
        strSOQL = strSOQL.Replace('\\','');         

        AggregateResult[] AgR = Database.Query(strSOQL);
        
        for (AggregateResult RowData : AgR) { 
                strID = string.valueOf(RowData.get('ID'));
                PotentialDuplicateLumpSumKey.add(strID);
        }
        
        List<Glxy_LumpSum__c> objPotentialDuplicateLumpSum = [
	    	Select LeaseNumber__r.ID, LeaseNumber__r.Name, LumSumType__c, ProcessedDate__c, LeaseNumber__r.RegionCD__c, EffectiveDate__c, LeaseNumber__r.TeamCode__c, Amount__c, RecordType.DeveloperName, StatusCd__c  
	        From   Glxy_LumpSum__c  
	        Where  LeaseNumber__r.ID= :PotentialDuplicateLumpSumKey 
	        And    ProcessedDateFY__c = :strFiscalYear 
	        And    BDGFlag__c = True
	        Order by LeaseNumber__r.Name, LumSumType__c, EffectiveDate__c];
	      
	    for (Glxy_LumpSum__c objLumpSum : objPotentialDuplicateLumpSum) { 
	    	dtEffectiveDate = Date.ValueOf(objLumpSum.EffectiveDate__c);
	        strEffectiveDate = String.valueOf(dtEffectiveDate.Year()) + String.valueOf(dtEffectiveDate.Month()) + String.valueOf(dtEffectiveDate.Day());
	        strLoopCurrentKey = (String.valueOf(objLumpSum.LeaseNumber__r.Name) + String.valueOf(objLumpSum.LumSumType__c) + strEffectiveDate);

        	If (strLoopCurrentKey == strLoopPreviousKey){
            	objDataset.add(objPreviousLine);  
            	objDataset.add(new GLXY_clsDuplicates(
	            	String.valueOf(objLumpSum.LeaseNumber__r.Name),
		            String.valueOf(objLumpSum.LumSumType__c),
		            String.valueOf(objLumpSum.ProcessedDate__c),
		            String.valueOf(objLumpSum.EffectiveDate__c),
		            '',
		            String.valueOf(objLumpSum.LeaseNumber__r.ID),
		            String.valueOf(objLumpSum.LeaseNumber__r.RegionCD__c),
		            String.valueOf(objLumpSum.LeaseNumber__r.TeamCode__c),
		            (Decimal) (objLumpSum.Amount__c),
		            String.valueOf(objLumpSum.RecordType.DeveloperName),
		            String.valueOf(objLumpSum.StatusCd__c)
            	));
          	}
          	objPreviousLine = New GLXY_clsDuplicates(
            	String.valueOf(objLumpSum.LeaseNumber__r.Name),
              	String.valueOf(objLumpSum.LumSumType__c),
              	String.valueOf(objLumpSum.ProcessedDate__c),
              	String.valueOf(objLumpSum.EffectiveDate__c),
             	'',
              	String.valueOf(objLumpSum.LeaseNumber__r.ID),
              	String.valueOf(objLumpSum.LeaseNumber__r.RegionCD__c),
              	String.valueOf(objLumpSum.LeaseNumber__r.TeamCode__c),
              	(Decimal) (objLumpSum.Amount__c),
              	String.valueOf(objLumpSum.RecordType.DeveloperName),
              	String.valueOf(objLumpSum.StatusCd__c)
          	);
          	strLoopPreviousKey = strLoopCurrentKey;
        }
        return objDataset;
    }
    
    /*
    public List<GLXY_clsDuplicates> getDatasetLumpSum(){
    
    	strSOQL =   'Select LeaseNumber__r.ID, LeaseNumber__r.Name,  LumSumType__c, ProcessedDate__c , count(Name) DupCount ' + 
                    'From   Glxy_LumpSum__c  ' +
                    'Where  ProcessedDateFY__c = :strFiscalYear ' +
                    'And    LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'Group by LeaseNumber__r.ID, LeaseNumber__r.Name, LumSumType__c, ProcessedDate__c  ' +
                    'Having Count(Name) > 1 ' +
                    'Order by LeaseNumber__r.Name, ProcessedDate__c ';
        strSOQL = strSOQL.Replace('\\','');             

        AggregateResult[] AgR = Database.Query(strSOQL);
                                        
        for (AggregateResult RowData : AgR) { 
            objDataset.add(new GLXY_clsDuplicates(
                String.valueOf(RowData.get('Name')),  String.valueOf(RowData.get('LumSumType__c')), 
                Date.valueOf(RowData.get('ProcessedDate__c')).format(), '', 
                String.valueOf(RowData.get('DupCount')), String.valueOf(RowData.get('ID')),
                '','',null,''
            ));
        }
        return objDataset;
    }
    */
    
    public List<GLXY_clsDuplicates> getDatasetStepRentDups(){
    	
        List<ID> PotentialDuplicateStepRentKey = new List<ID>();
    	Date dtProcessedDate;
        string strID;
        string strProcessedDate;
    	string strLoopPreviousKey = '-';
        string strLoopCurrentKey;
        GLXY_clsDuplicates objPreviousLine;
    	
    	strSOQL =   'Select LeaseNumber__r.ID, LeaseNumber__r.Name ' + 
                    'From   Glxy_StepRent__c  ' +
                    'Where  ProcessedDateFY__c = :strFiscalYear ' +
                    'And    LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    BDGFlag__c = True ' +
                    'Group by LeaseNumber__r.ID, LeaseNumber__r.Name ' +
                    'Having Count(Name) > 1 ' +
                    'Order by LeaseNumber__r.Name ';
        strSOQL = strSOQL.Replace('\\','');         

        AggregateResult[] AgR = Database.Query(strSOQL);
        
        for (AggregateResult RowData : AgR) { 
                strID = string.valueOf(RowData.get('ID'));
                PotentialDuplicateStepRentKey.add(strID);
        }
        
        List<Glxy_StepRent__c> objPotentialDuplicateStepRent = [
	        Select LeaseNumber__r.ID, LeaseNumber__r.Name, PaymentType__c, ProcessedDate__c , LeaseNumber__r.RegionCD__c, EffectiveDate__c, LeaseNumber__r.TeamCode__c, Amount__c, RecordType.DeveloperName, StatusCode__c  
	        From   Glxy_StepRent__c  
	        Where  LeaseNumber__r.ID= :PotentialDuplicateStepRentKey 
	        And    ProcessedDateFY__c = :strFiscalYear 
	        And    BDGFlag__c = True
	        Order by LeaseNumber__r.Name, PaymentType__c, ProcessedDate__c];
	      
	    for (Glxy_StepRent__c objStepRent : objPotentialDuplicateStepRent) { 
	      	dtProcessedDate = Date.ValueOf(objStepRent.ProcessedDate__c);
	        strProcessedDate = String.valueOf(dtProcessedDate.Year()) + String.valueOf(dtProcessedDate.Month()) + String.valueOf(dtProcessedDate.Day());
	        strLoopCurrentKey = (String.valueOf(objStepRent.LeaseNumber__r.Name) + String.valueOf(objStepRent.PaymentType__c) + strProcessedDate);

        	If (strLoopCurrentKey == strLoopPreviousKey){
            	objDataset.add(objPreviousLine);  
            	objDataset.add(new GLXY_clsDuplicates(
	            	String.valueOf(objStepRent.LeaseNumber__r.Name),
	                String.valueOf(objStepRent.PaymentType__c),
	                String.valueOf(objStepRent.ProcessedDate__c),
	                String.valueOf(objStepRent.EffectiveDate__c),
	                '',
	                String.valueOf(objStepRent.LeaseNumber__r.ID),
	                String.valueOf(objStepRent.LeaseNumber__r.RegionCD__c),
	                String.valueOf(objStepRent.LeaseNumber__r.TeamCode__c),
	                (Decimal) (objStepRent.Amount__c),
	                String.valueOf(objStepRent.RecordType.DeveloperName),
	                String.valueOf(objStepRent.StatusCode__c)
            	));
          	}
          	objPreviousLine = New GLXY_clsDuplicates(
            	String.valueOf(objStepRent.LeaseNumber__r.Name),
	            String.valueOf(objStepRent.PaymentType__c),
	            String.valueOf(objStepRent.ProcessedDate__c),
	            String.valueOf(objStepRent.EffectiveDate__c),
	            '',
	            String.valueOf(objStepRent.LeaseNumber__r.ID),
	            String.valueOf(objStepRent.LeaseNumber__r.RegionCD__c),
	            String.valueOf(objStepRent.LeaseNumber__r.TeamCode__c),
	            (Decimal) (objStepRent.Amount__c),
	            String.valueOf(objStepRent.RecordType.DeveloperName),
	            String.valueOf(objStepRent.StatusCode__c)
          	);
          	strLoopPreviousKey = strLoopCurrentKey;
        }
        return objDataset;
    }
    
    /*
    public List<GLXY_clsDuplicates> getDatasetStepRent(){
    
    	strSOQL =   'Select   LeaseNumber__r.ID, LeaseNumber__r.Name,  ProcessedDate__c , count(Name) DupCount ' + 
        	        'From     Glxy_StepRent__c  ' +
                    'Where    ProcessedDateFY__c = :strFiscalYear ' +
                    'And      LeaseNumber__r.RegionCD__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'Group by LeaseNumber__r.ID, LeaseNumber__r.Name, ProcessedDate__c  ' +
                    'Having Count(Name) > 1 ' +
                    'Order by LeaseNumber__r.Name, ProcessedDate__c ';
      	strSOQL = strSOQL.Replace('\\',''); 

      	AggregateResult[] AgR = Database.Query(strSOQL);
                                        
      	for (AggregateResult RowData : AgR) { 
        	objDataset.add(new GLXY_clsDuplicates(
          		String.valueOf(RowData.get('Name')),  Date.valueOf(RowData.get('ProcessedDate__c')).format(), 
          		'', '', String.valueOf(RowData.get('DupCount')), String.valueOf(RowData.get('ID')),
          		'','',null,''
        	));
      	}
      	return objDataset;
    }
    */
    
    /*
    public List<GLXY_clsDuplicates> getDatasetProject(){
    
    	strSOQL =   'Select   Min(Project__r.ID) ID, Project__r.Name Name, Project__r.Project_Type__c ProjectType, ' +  
        	        '         Project__r.ProcessedDate__c  ProcessedDate, Lease__r.Name LeaseNumber, ' +
                    '         count(ID) DupCount ' + 
                    'From     Glxy_AssociatedLeases__c   ' +
                    'Where    Project__r.ProcessedDateFY__c = :strFiscalYear ' +
                    'And      Project__r.RegionCd__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'Group by Project__r.Name, Project__r.Project_Type__c , Project__r.ProcessedDate__c , Lease__r.Name ' +
                    'Having Count(Project__r.Project_Type__c) > 1 ' +
                    'Order by Project__r.Name, Project__r.Project_Type__c , Project__r.ProcessedDate__c , Lease__r.Name';
      	strSOQL = strSOQL.Replace('\\',''); 
      	System.debug('MyDebug = ' + strSOQL);
      	AggregateResult[] AgR = Database.Query(strSOQL);
                                        
      	for (AggregateResult RowData : AgR) { 
        	objDataset.add(new GLXY_clsDuplicates(
          		String.valueOf(RowData.get('Name')), 
          		String.valueOf(RowData.get('ProjectType')), 
          		Date.valueOf(RowData.get('ProcessedDate')).format(), 
          		String.valueOf(RowData.get('LeaseNumber')),
          		String.valueOf(RowData.get('DupCount')),
          		String.valueOf(RowData.get('ID'))
        	));
      	}
      	return objDataset;
    }
    */
    
    public List<GLXY_clsDuplicates> getDatasetProjectDups1(){

    	//List<String> PotentialDuplicateProjectsKey = new List<String>();
      	List<ID> PotentialDuplicateProjectsKey = new List<ID>();
      	Date dtEffectiveDate;
      	string strID;
      	string strEffectiveDate;
      	string strLoopPreviousKey = '-';
      	string strLoopCurrentKey;
      	GLXY_clsDuplicates objPreviousLine;
    
	  	//strSOQL =   'Select NewLease__c, ' +  
	  	//            '       count(ID) DupCount ' + 
	  	//            'From   Glxy_LeaseProjects__c ' +
	  	//            'Where  ProcessedDateFY__c = :strFiscalYear ' +
	  	//            'And    RegionCd__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
	  	//            'And    NewLease__c != Null ' +  
	  	//            'And    BDGFlag__c = true ' +    
	  	//            'Group by NewLease__c ' +
	  	//            'Having Count(ID) > 1 ' +
	  	//            'Order by NewLease__c';
                    
      	strSOQL =  'Select   Lease__c ' +  
              	   'From     Glxy_AssociatedLeases__c ' +
                   'Where    Project__r.ProcessedDateFY__c = :strFiscalYear ' +
                   'And      Project__r.RegionCd__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                   'And      Project__r.BDGFlag__c = true ' +    
                   'Group by Lease__c ' +
                   'Having Count(Lease__c) > 1 ' +
                   'Order by Lease__c';
                                
      	strSOQL = strSOQL.Replace('\\',''); 
      	AggregateResult[] AgR = Database.Query(strSOQL);
                                        
      	for (AggregateResult RowData : AgR) { 
        	strID = string.valueOf(RowData.get('Lease__c'));
        	PotentialDuplicateProjectsKey.add(strID);
      	}
        
      	//List<Glxy_LeaseProjects__c> objPotentialDuplicateProjects = [
      	//   Select   ID, Name, Project_Type__c, NewLease__c, EffectiveDate__c
      	//   From     Glxy_LeaseProjects__c 
      	//   Where    NewLease__c in :PotentialDuplicateProjectsKey 
      	//   And      EffectiveDate__c != Null
      	//   And      BDGFlag__c = true 
      	//   Order by NewLease__c, EffectiveDate__c
      	//   Limit    3000];
      
      	List<Glxy_AssociatedLeases__c> objPotentialDuplicateProjects = [
        	Select   Project__r.ID, Project__r.Name, Project__r.Project_Type__c, Lease_Num_lkp__c, Project__r.EffectiveDate__c, Project__r.ProcessedDate__c, Project__r.RegionCd__c, Project__r.TeamCode__c
            From     Glxy_AssociatedLeases__c 
            Where    Lease__c in :PotentialDuplicateProjectsKey 
            And      Project__r.EffectiveDate__c != Null
            And      Project__r.BDGFlag__c = true 
          	Order by Lease_Num_lkp__c, Project__r.EffectiveDate__c
           	Limit    3000];    
      
       	for (Glxy_AssociatedLeases__c objProject : objPotentialDuplicateProjects) { 
       		dtEffectiveDate = Date.ValueOf(objProject.Project__r.EffectiveDate__c);
         	strEffectiveDate = String.valueOf(dtEffectiveDate.Year()) + String.valueOf(dtEffectiveDate.Month()) + String.valueOf(dtEffectiveDate.Day());
         	strLoopCurrentKey = (String.valueOf(objProject.Lease_Num_lkp__c) + strEffectiveDate);

        	If (strLoopCurrentKey == strLoopPreviousKey){
           		objDataset1.add(objPreviousLine);  
           		objDataset1.add(new GLXY_clsDuplicates(
             		String.valueOf(objProject.Project__r.Name),
             		String.valueOf(objProject.Project__r.Project_Type__c),
             		String.valueOf(objProject.Lease_Num_lkp__c),
             		String.valueOf(objProject.Project__r.EffectiveDate__c),
             		'',
             		String.valueOf(objProject.Project__r.ID),
             		'',
             		String.valueOf(objProject.Project__r.ProcessedDate__c),
           			null,
           			String.valueOf(objProject.Project__r.RegionCd__c),
           			String.valueOf(objProject.Project__r.TeamCode__c)
           		));
         	}
         	objPreviousLine = New GLXY_clsDuplicates(
           		String.valueOf(objProject.Project__r.Name),
           		String.valueOf(objProject.Project__r.Project_Type__c),
           		String.valueOf(objProject.Lease_Num_lkp__c),
           		String.valueOf(objProject.Project__r.EffectiveDate__c),
           		'',
           		String.valueOf(objProject.Project__r.ID),
           		'',
           		String.valueOf(objProject.Project__r.ProcessedDate__c),
           		null,
           		String.valueOf(objProject.Project__r.RegionCd__c),
           		String.valueOf(objProject.Project__r.TeamCode__c)
         	);
         	strLoopPreviousKey = strLoopCurrentKey;
      	}
      	return objDataset1;
    }
    
    public List<GLXY_clsDuplicates> getDatasetProjectDups2(){

    	List<ID> PotentialDuplicateProjectsKey = new List<ID>();
      	Date dtEffectiveDate;
      	string strID;
      	string strEffectiveDate;
      	Set<id> objDataset2Set = new Set<id>();
    
      	strSOQL =  'Select   Lease__c ' +  
                   'From     Glxy_AssociatedLeases__c ' +
                   'Where    Project__r.ProcessedDateFY__c = :strFiscalYear ' +
                   'And      Project__r.RegionCd__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                   'And      Project__r.BDGFlag__c = true ' +    
                   'Group by Lease__c ' +
                   'Having Count(Lease__c) > 1 ' +
                   'Order by Lease__c';
                   
      	strSOQL = strSOQL.Replace('\\',''); 
      	AggregateResult[] AgR = Database.Query(strSOQL);
                                        
      	for (AggregateResult RowData : AgR) { 
        	strID = string.valueOf(RowData.get('Lease__c'));
        	PotentialDuplicateProjectsKey.add(strID);
      	}

      	List<Glxy_AssociatedLeases__c> objPotentialDuplicateProjects = [
        	Select   Project__r.ID, id, Project__r.Name, Project__r.Project_Type__c, Lease_Num_lkp__c, Project__r.EffectiveDate__c,  
            	     Project__r.SquareFeet__c, Project__r.Old_Square_Feet__c, Project__r.NetChngInSqFt__c, Project__r.ProcessedDate__c, Project__r.RegionCd__c, Project__r.TeamCode__c
        	From     Glxy_AssociatedLeases__c 
        	Where    Lease__c in :PotentialDuplicateProjectsKey 
        	And      Project__r.EffectiveDate__c != Null
        	And      Project__r.BDGFlag__c = true 
        	Order by Lease_Num_lkp__c, Project__r.EffectiveDate__c
        	Limit  3000];    
        
      	for (Integer i=0; i < objPotentialDuplicateProjects.size()-1 ;i++) { 
        	Glxy_AssociatedLeases__c newProject = objPotentialDuplicateProjects[i];
      		Glxy_AssociatedLeases__c OldProject = objPotentialDuplicateProjects[i+1];
          
        	if(newProject.Lease_Num_lkp__c == OldProject.Lease_Num_lkp__c){
	        	if(Math.ABS(newProject.Project__r.Old_Square_Feet__c - OldProject.Project__r.SquareFeet__c) >= 10000){
	          		if(!objDataset2Set.contains(newProject.id)) { 
	          			objDataset2.add(new GLXY_clsDuplicates(
		            		String.valueOf(newProject.Project__r.Name),
		            		String.valueOf(newProject.Project__r.Project_Type__c),
		            		String.valueOf(newProject.Lease_Num_lkp__c),
		            		String.valueOf(newProject.Project__r.SquareFeet__c),
		            		String.valueOf(newProject.Project__r.Old_Square_Feet__c),
		            		String.valueOf(newProject.Project__r.ID),
		            		String.valueOf(newProject.Project__r.EffectiveDate__c),
		            		String.valueOf(newProject.Project__r.ProcessedDate__c),
		           			null,
		           			String.valueOf(newProject.Project__r.RegionCd__c),
		           			String.valueOf(newProject.Project__r.TeamCode__c)
		          		));
		          		objDataset2Set.add(newProject.id);
	        		}
	        		if(!objDataset2Set.contains(OldProject.id)) {
			        	objDataset2.add(new GLXY_clsDuplicates(
			          		String.valueOf(OldProject.Project__r.Name),
			          		String.valueOf(OldProject.Project__r.Project_Type__c),
			          		String.valueOf(OldProject.Lease_Num_lkp__c),
			          		String.valueOf(OldProject.Project__r.SquareFeet__c),
			          		String.valueOf(OldProject.Project__r.Old_Square_Feet__c),
			          		String.valueOf(OldProject.Project__r.ID),
			          		String.valueOf(OldProject.Project__r.EffectiveDate__c),
			          		String.valueOf(OldProject.Project__r.ProcessedDate__c),
			           		null,
			           		String.valueOf(OldProject.Project__r.RegionCd__c),
			           		String.valueOf(OldProject.Project__r.TeamCode__c)
			        	));
			        	objDataset2Set.add(OldProject.id);
	        		}
	        	}
        	}
      	}
      	return objDataset2;
    }
    
    public List<GLXY_clsDuplicates> getDatasetProjectDups3(){

    	List<String> PotentialDuplicateProjectsKey = new List<String>();
      	Date dtEffectiveDate;
      	string strID;
      	string strEffectiveDate;
      	Set<id> objDataset3Set = new Set<id>();
    
      	strSOQL =  'Select   Lease__c ' +  
              	   'From     Glxy_AssociatedLeases__c ' +
                   'Where    Project__r.ProcessedDateFY__c = :strFiscalYear ' +
                   'And      Project__r.RegionCd__c in (' + String.escapeSingleQuotes(strRegion) + ') ' +
                   'And      Project__r.BDGFlag__c = true ' +    
                   'Group by Lease__c ' +
                   'Having Count(Lease__c) > 1 ' +
                   'Order by Lease__c';
                   
      	strSOQL = strSOQL.Replace('\\',''); 
      	AggregateResult[] AgR = Database.Query(strSOQL);
                                        
      	for (AggregateResult RowData : AgR) { 
        	strID = string.valueOf(RowData.get('Lease__c'));
        	PotentialDuplicateProjectsKey.add(strID);
      	}
        
      	List<Glxy_AssociatedLeases__c> objPotentialDuplicateProjects = [
        	Select   Project__r.ID,id, Project__r.Name, Project__r.Project_Type__c, Lease_Num_lkp__c, Project__r.EffectiveDate__c,  
          		     Project__r.AnnualRent__c, Project__r.Old_Annual_Rent__c, Project__r.NetChangeInAnnualRent__c, Project__r.ProcessedDate__c, Project__r.RegionCd__c, Project__r.TeamCode__c
        	From     Glxy_AssociatedLeases__c 
        	Where    Lease__c in :PotentialDuplicateProjectsKey 
        	And      Project__r.EffectiveDate__c != Null
        	And      Project__r.BDGFlag__c = true 
        	Order by Lease_Num_lkp__c, Project__r.EffectiveDate__c
        	Limit    3000];  
        
      	for (Integer i=0; i < objPotentialDuplicateProjects.size()-1 ;i++) { 
      		Glxy_AssociatedLeases__c newProject = objPotentialDuplicateProjects[i];
      		Glxy_AssociatedLeases__c OldProject = objPotentialDuplicateProjects[i+1];
        	
        	if(newProject.Lease_Num_lkp__c == OldProject.Lease_Num_lkp__c){
	        	if(Math.ABS(newProject.Project__r.Old_Annual_Rent__c - OldProject.Project__r.AnnualRent__c) >= 50000)
	        	{
	       			if(!objDataset3Set.contains(newProject.id)) {
		          		objDataset3.add(new GLXY_clsDuplicates(
		            		String.valueOf(newProject.Project__r.Name),
		            		String.valueOf(newProject.Project__r.Project_Type__c),
		            		String.valueOf(newProject.Lease_Num_lkp__c),
		            		String.valueOf(newProject.Project__r.AnnualRent__c),
		            		String.valueOf(newProject.Project__r.Old_Annual_Rent__c),
		            		String.valueOf(newProject.Project__r.ID),
		            		String.valueOf(newProject.Project__r.EffectiveDate__c),
		            		String.valueOf(newProject.Project__r.ProcessedDate__c),
		           			null,
		           			String.valueOf(newProject.Project__r.RegionCd__c),
		           			String.valueOf(newProject.Project__r.TeamCode__c)
		          		));
		          		objDataset3Set.add(newProject.id);
	       			}
	       			if(!objDataset3Set.contains(OldProject.id)) {
	          			objDataset3.add(new GLXY_clsDuplicates(
		            		String.valueOf(OldProject.Project__r.Name),
		            		String.valueOf(OldProject.Project__r.Project_Type__c),
		            		String.valueOf(OldProject.Lease_Num_lkp__c),
		            		String.valueOf(OldProject.Project__r.AnnualRent__c),
		            		String.valueOf(OldProject.Project__r.Old_Annual_Rent__c),
		            		String.valueOf(OldProject.Project__r.ID),
		            		String.valueOf(OldProject.Project__r.EffectiveDate__c),
		            		String.valueOf(OldProject.Project__r.ProcessedDate__c),
		           			null,
		           			String.valueOf(OldProject.Project__r.RegionCd__c),
		           			String.valueOf(OldProject.Project__r.TeamCode__c)
		          		));
	          			objDataset3Set.add(OldProject.id);
	       			}
	        	}
        	}
      	}
      	return objDataset3;
    }
    
    // **** RUN all the TEST methods for code coverage ... ****//    
    @istest(SeeAllData=false) private static void testclsDuplicatesController() {
    	
		test.starttest();
		
		ID RexusRecordTypeID  = Schema.SObjectType.Glxy_LeaseProjects__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
      	ID RexusRecordTypeID1 = Schema.SObjectType.Glxy_ConsumerPriceIndex__c.getRecordTypeInfosByName().get('Placeholder').getRecordTypeId();
      	ID RexusRecordTypeID2 = Schema.SObjectType.Glxy_LumpSum__c.getRecordTypeInfosByName().get('Placeholder').getRecordTypeId();
      	ID RexusRecordTypeID3 = Schema.SObjectType.Glxy_StepRent__c.getRecordTypeInfosByName().get('Placeholder').getRecordTypeId();
      	
    	//Lease Project
    	List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
    	
      	Glxy_LeaseProjects__c objProject = new Glxy_LeaseProjects__c();
	    	objProject.Name = '123456789';
	    	objProject.NewLease__c = 'LDEWWWA';
	    	objProject.RecordTypeID = RexusRecordTypeID;
		    objProject.EffectiveDate__c = Datetime.Now().Date();
		    objProject.ProcessedDate__c = Datetime.Now().Date();
		    objProject.SquareFeet__c = 15000;
		    objProject.Old_Square_Feet__c = 10000;
		    objProject.RegionCd__c = '1';
		    ObjProject.BDGFlag__c = true;
		    objProject.ProjectStatus__c = 'Active';
		    objProject.AnnualRent__c = 25000.0;
		    objProject.Old_Annual_Rent__c = 80000.0;
		    objProject.Project_Type__c = 'New/Replacing';
      	objLeaseProjectsRecords.Add(objProject);
      
      	Glxy_LeaseProjects__c objProject2 = new Glxy_LeaseProjects__c();
		    objProject2.Name = '1234567';
		    objProject2.NewLease__c = 'LDEWWWA';
		    objProject2.RecordTypeID = RexusRecordTypeID;
		    objProject2.EffectiveDate__c = Datetime.Now().Date();
		    objProject2.ProcessedDate__c = Datetime.Now().Date();
		    objProject2.SquareFeet__c = 15000;
		    objProject2.Old_Square_Feet__c = 10000;
		    objProject2.RegionCd__c = '1';
		    objProject2.ProjectStatus__c = 'Active';
		    ObjProject2.BDGFlag__c = true;
		    objProject2.AnnualRent__c = 25000.0;
		    objProject2.Old_Annual_Rent__c = 80000.0;
		    objProject2.Project_Type__c = 'New/Replacing';
      	objLeaseProjectsRecords.Add(objProject2);
      	
      	Insert objLeaseProjectsRecords;
      
      	// Lease
      	Glxy_Lease__c ObjLease = new Glxy_Lease__c();
	        ObjLease.Name = 'LVA12345';
	        ObjLease.StatusCode__c = 'Active';
	        Date myDate = date.newinstance(Datetime.Now().Date().Year(), 2, 17);
	        Date myDate1 = date.newinstance(Datetime.Now().Date().addyears(+1).Year(), 2, 17);
	        ObjLease.BaseLeaseEffectiveDate__c = myDate ;
	        ObjLease.ExpirationDateofLease__c = myDate1 ;
	        ObjLease.BaseAnnualRent__c = 1000;
	        ObjLease.RegionCD__c = '1';
	        ObjLease.TeamCode__c = '';
	        ObjLease.Total_NOA_Sq_feet__c = 4444;
	        ObjLease.Total_IA_Sq_feet__c = 3333333;
      	insert ObjLease;
           
      	myDate = date.newinstance(Datetime.Now().Date().Year(), 1, 1); 
           
      	// CPI
      	List<Glxy_ConsumerPriceIndex__c> objCPIRecords = New List<Glxy_ConsumerPriceIndex__c>();
      	
	  	Glxy_ConsumerPriceIndex__c objTest1 = new Glxy_ConsumerPriceIndex__c ();
		    objTest1.LeaseNumber__c = objLease.id;
		    objTest1.RecordTypeID = RexusRecordTypeID1;
		    objTest1.EscalationType__c = 'Operating Cost Lump Sum Only';
		    objTest1.ProcessedDate__c = myDate;
		    objTest1.EffectiveDate__c = myDate;
		    objTest1.StatusCD__c = 'Estimate';
		    objTest1.AnnualAmount__c = 10000;
		    objTest1.BDGFlag__c = True;
		    objTest1.FY_Obligation__c = 0;
	  	objCPIRecords.Add(objTest1);  
	  
	  	Glxy_ConsumerPriceIndex__c objTest11 = new Glxy_ConsumerPriceIndex__c ();
		    objTest11.LeaseNumber__c = objLease.id;
		    objTest11.RecordTypeID = RexusRecordTypeID1;
		    objTest11.EscalationType__c = 'Operating Cost Lump Sum Only';
		    objTest11.ProcessedDate__c = myDate;
		    objTest11.EffectiveDate__c = myDate;
		    objTest11.StatusCD__c = 'Estimate';
		    objTest11.AnnualAmount__c = 20000;
		    objTest11.BDGFlag__c = True;
		    objTest11.FY_Obligation__c = 0;
	  	objCPIRecords.Add(objTest11);
	  	System.AssertNotEquals(objTest11,NULL);

	  	Insert objCPIRecords;
	  	
	  	// LS
	  	List<Glxy_LumpSum__c> objLSRecords = New List<Glxy_LumpSum__c>();
      	Glxy_LumpSum__c objTest3 = new Glxy_LumpSum__c ();
	        objTest3.LeaseNumber__c = objLease.id;
	        objTest3.RecordTypeID = RexusRecordTypeID2;
	        objTest3.LumSumType__c = 'Bid Tax';
	        objTest3.ProcessedDate__c = myDate;
	        objTest3.EffectiveDate__c = myDate;
	        objTest3.ExpirationDate__c = myDate;
	        objTest3.StatusCD__c = 'Estimate';
		    objTest3.Amount__c = 10000;
		    objTest3.BDGFlag__c = True;
	        objTest3.FY_Obligation__c = 0;
      	objLSRecords.Add(objTest3);  
      
      	Glxy_LumpSum__c objTest31 = new Glxy_LumpSum__c ();
	        objTest31.LeaseNumber__c = objLease.id;
	        objTest31.RecordTypeID = RexusRecordTypeID2;
	        objTest31.LumSumType__c = 'Bid Tax';
	        objTest31.ProcessedDate__c = myDate;
	        objTest31.EffectiveDate__c = myDate;
	        objTest31.ExpirationDate__c = myDate;
	        objTest31.StatusCD__c = 'Estimate';
		    objTest31.Amount__c = 20000;
		    objTest31.BDGFlag__c = True;
	        objTest31.FY_Obligation__c = 0;
	    objLSRecords.Add(objTest31);  
	    
      	Insert objLSRecords;
      	
      	//SR
      	List<Glxy_StepRent__c> objSRRecords = New List<Glxy_StepRent__c>();
      	Glxy_StepRent__c objTest4 = new Glxy_StepRent__c ();
	        objTest4.LeaseNumber__c = objLease.id;
	        objTest4.RecordTypeID = RexusRecordTypeID3;
	        objTest4.PaymentType__c = 'Land';
	        objTest4.ProcessedDate__c = myDate;
	        objTest4.EffectiveDate__c = myDate;
	        objTest4.Amount__c = 10000;
	        objTest4.BDGFlag__c = True;
		    objTest4.StatusCode__c = 'Estimate';
      	objSRRecords.Add(objTest4);
      
      	Glxy_StepRent__c objTest41 = new Glxy_StepRent__c ();
	        objTest41.LeaseNumber__c = objLease.id;
	        objTest41.RecordTypeID = RexusRecordTypeID3;
	        objTest41.PaymentType__c = 'Land';
	        objTest41.ProcessedDate__c = myDate;
	        objTest41.EffectiveDate__c = myDate;
	        objTest41.Amount__c = 20000;
	        objTest41.BDGFlag__c = True;
		    objTest41.StatusCode__c = 'Estimate';
		objSRRecords.Add(objTest41);
		    
      	insert objSRRecords;
      	
      	//AssociateLease
      	List<Glxy_AssociatedLeases__c> objALRecords = New List<Glxy_AssociatedLeases__c>();
      	
      	Glxy_AssociatedLeases__c ObjTest5 = New Glxy_AssociatedLeases__c();
      	ObjTest5.Project__c = objProject.ID;
      	ObjTest5.Lease__c = ObjLease.ID;
      	ObjTest5.Lease_Annual_Rent__c = 80000;
      	objALRecords.Add(ObjTest5);
      	
      	Glxy_AssociatedLeases__c ObjTest51 = New Glxy_AssociatedLeases__c();
      	ObjTest51.Project__c = objProject2.ID;
      	ObjTest51.Lease__c = ObjLease.ID;
      	ObjTest51.Lease_Annual_Rent__c = 50000;
      	objALRecords.Add(ObjTest51);
      	
      	insert objALRecords;
      
      	PageReference pageRef = Page.GLXY_DuplicateCPI;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('FY', String.valueOf((date.today()+92).Year()));
        pageRef.getParameters().put('Region', '\'1\'');
        
        GLXY_clsDuplicates objConstructor = new GLXY_clsDuplicates('','','','','','','','',null,'','');
        GLXY_clsDuplicates objTest = new GLXY_clsDuplicates();
        List<GLXY_clsDuplicates> objDataSet;
        objDataSet = objTest.getDatasetCPIDups();
                
	    System.Assert(objDataSet!=NULL);
	    objDataSet = objTest.getDatasetLumpSumDups();
	    System.Assert(objDataSet!=NULL);
	    objDataSet = objTest.getDatasetStepRentDups();
	    System.Assert(objDataSet!=NULL);
	    //objDataSet = objTest.getDatasetproject();
	    //System.Assert(objDataSet!=NULL);
	    objDataSet = objTest.getDatasetProjectDups1();
	    System.Assert(objDataSet!=NULL);
	    objDataSet = objTest.getDatasetProjectDups2();
	    System.Assert(objDataSet!=NULL);
	    objDataSet = objTest.getDatasetProjectDups3();
	    System.Assert(objDataSet!=NULL);
	  
	  	test.stoptest();
    }
}