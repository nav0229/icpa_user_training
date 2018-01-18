public with sharing class GLXY_AccrualReport {
	
	public String 	RecordLink 		{get; set;}
    public String 	Region 			{get; set;}
    public String 	ProjectNumber 	{get; set;}
    public String 	ProjectType 	{get; set;}
    public String 	ProjectStatus	{get; set;}
    public Date	  	EffectiveDate 	{get; set;}
    public String 	EffectiveDateFY	{get; set;}
    public String 	BuildingNumber 	{get; set;}
    public String 	LeaseNumber 	{get; set;}
    public Decimal 	ProjectAccrual 	{get; set;}
    public Decimal 	LumpSumAccrual 	{get; set;}
    public String 	TeamCode 		{get; set;}
    public String 	RealtySpecialist {get; set;}
	public Date   	ProcessDate 	{get; set;}
   	public Decimal	OldAnnualRent 	{get; set;}
   	public Decimal 	NewAnnualRent	{get; set;}
   	public Decimal 	OldSqFt			{get; set;}
   	public Decimal	NewSqFt			{get; set;}
   	public Decimal	OldRate			{get; set;}
   	public Decimal 	NewRate 		{get; set;}

	public String strFiscalYear		{get; set;}
    public String strRegion     	{get; set;}
    public String strRegionDisplay 	{get; set;}
    
	public GLXY_AccrualReport(){
		strRegion = '';
    	strRegionDisplay = '';
    	strFiscalYear = '';
        //Default Year and Region values, if not supplied ...
        if (System.currentPageReference().getParameters().get('pv1')!=null){
			strRegion = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('pv1'));
			strRegionDisplay = strRegion.Replace('\\','');	   			                  
            strFiscalYear = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('pv0'));            
        }else{
            strRegion = '\'3\'';
            strFiscalYear = '2013';
        }
	}
	
	public List<GLXY_AccrualReport> objDataset = new List<GLXY_AccrualReport>();
	
	public List<GLXY_AccrualReport> getAccrualDataset(){
		
		string strLeaseNumber;
		string strEffectiveDateFY;
		Decimal dblProjectLumpSum;
		
		//Create a Map of Lease Locations	
		Map<string, string> MapOfLeaseLocation = New Map<string, string> ();
	 	List<Glxy_LeaseLocation__c> listLeaseLocations = [SELECT LeaseNumber__r.Name, Location_Code__c  FROM Glxy_LeaseLocation__c Limit 20000];
	 	for(Glxy_LeaseLocation__c objItem : listLeaseLocations){
	 		MapOfLeaseLocation.put(objItem.LeaseNumber__r.Name, objItem.Location_Code__c);
	 	}
		
		//Create a Map of Lease Project Associations
		Map<string, string> MapOfLeaseAssociations = New Map<string, string> ();
		List<Glxy_AssociatedLeases__c> listAssociatedLeases = [
			SELECT 	Project__r.Name, Lease_Num_lkp__c FROM Glxy_AssociatedLeases__c
			Where 	Project__r.ProjectStatus__c <> 'Cancelled'
			AND    	Project__r.ProcessedDateFY__c = :strFiscalYear
			And 	Project__r.AccrualAmountCurrentFY__c <> 0
			order 	by Project__r.Name, Lease__r.BaseSquareFeet__c
			Limit 20000];
		for(Glxy_AssociatedLeases__c objItem : listAssociatedLeases){
	 		MapOfLeaseAssociations.put(objItem.Project__r.Name, objItem.Lease_Num_lkp__c);
	 	}
	 	
	 	
	 	//Query the LPLS Accruals and Create a Map of Lease Project Lump Sums
		Map<string, Decimal> MapOfProjectLumpSum = New Map<String, Decimal> ();
		string strSOQL = 'Select ProjectNumber__r.Name Project, Sum(CurrentFYCalculatedValue__c) LumpSumAccrual ' +
               			 'From   Glxy_LPLumpSum__c ' +
 	 					 'Where  ProjectNumber__r.ProjectStatus__c <> \'Cancelled\' ' +
 	 					 'AND    ProcessedDateFY__c = :strFiscalYear ' +
 	 					 'And    ProjectNumber__r.RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
 	 					 'AND    ProjectNumber__r.AccrualAmountCurrentFY__c <> 0 ' +
 	 					 'And 	BDGFlag__c = true ' +	
                         'Group by  ProjectNumber__r.Name ' +
 	 					 'ORDER BY  ProjectNumber__r.Name';
 	 					 
		strSOQL = strSOQL.Replace('\\',''); 
	 	AggregateResult[] AgR = Database.Query(strSOQL);
		for (AggregateResult RowData : AgR) { 
	 		MapOfProjectLumpSum.put(String.valueOf(RowData.get('Project')), (Decimal) RowData.get('LumpSumAccrual'));
	 	}
	 	
		//Query the Projects with Accruals	
		strSOQL = 'Select Max(ID) RecordLink, Max(RegionCd__c) Region, Name ProjectNumber, Max(Project_Type__c) ProjectType, Max(eEorA__c) ProjectStatus, Max(EffectiveDate__c) EffectiveDate, ' +
		        	' 		 Max(NewLease__c) NewLeaseNumber, Max(AccrualAmountCurrentFY__c) ProjectAccrual, Sum(AccrualAmountCurrentFY__c) LumpSumAccrual, Max(TeamCode__c) TeamCode, ' +
					'       Max(RealtySpecialist__c) RealtySpecialist, Max(ProcessedDate__c) ProcessDate, Max(Old_Annual_Rent__c) OldAnnualRent, Max(AnnualRent__c) NewAnnualRent, ' +
                	'       Max(Old_Square_Feet__c) OldSqFt, Max(SquareFeet__c) NewSqFt, Max(OldRate__c) OldRate, Max(NewRate__c) NewRate ' + 
               		'From   Glxy_LeaseProjects__c ' +
 	 				'Where  ProjectStatus__c <> \'Cancelled\' ' +
 	 				'AND    ProcessedDateFY__c >= :strFiscalYear ' +
 	 				'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
 	 				'AND    AccrualAmountCurrentFY__c <> 0 ' +
 	 				'And 	BDGFlag__c = true ' +	
                    'Group by  Name ' +
 	 				'ORDER BY  Name ';
 	 					 
		strSOQL = strSOQL.Replace('\\',''); 
	 	AgR = Database.Query(strSOQL);
	 	
        for (AggregateResult RowData : AgR) { 
        	if (String.valueOf(RowData.get('NewLeaseNumber')) == Null){
        		strLeaseNumber = MapOfLeaseAssociations.get(String.valueOf(RowData.get('ProjectNumber')));
        	} else {
        		strLeaseNumber = String.valueOf(RowData.get('NewLeaseNumber'));
        	}
			
			strEffectiveDateFY = String.valueOf(Date.valueOf(RowData.get('EffectiveDate')).Year());
	        if (Date.valueOf(RowData.get('EffectiveDate')).Month() > 9){
	           strEffectiveDateFY = String.valueOf((Date.valueOf(RowData.get('EffectiveDate')).Year() + 1));
	        }
        	
        	dblProjectLumpSum = MapOfProjectLumpSum.get(String.valueOf(RowData.get('ProjectNumber')));
        	If (dblProjectLumpSum == Null) {dblProjectLumpSum = 0.00;}
        	
        	objDataset.add(new GLXY_AccrualReport(
        	 	String.valueOf(RowData.get('RecordLink')), 
                String.valueOf(RowData.get('Region')), 
               	String.valueOf(RowData.get('ProjectNumber')),
               	String.valueOf(RowData.get('ProjectType')), 
               	String.valueOf(RowData.get('ProjectStatus')), 
               	Date.valueOf(RowData.get('EffectiveDate')), 
               	strEffectiveDateFY,
               	strLeaseNumber,
               	MapOfLeaseLocation.get(strLeaseNumber), 
               	(Decimal) RowData.get('ProjectAccrual'), 
               	dblProjectLumpSum, 
               	String.valueOf(RowData.get('TeamCode')), 
               	String.valueOf(RowData.get('RealtySpecialist')), 
               	Date.valueOf(RowData.get('ProcessDate')), 
                (Decimal) RowData.get('OldAnnualRent'), 
               	(Decimal) RowData.get('NewAnnualRent'), 
               	(Decimal) RowData.get('OldSqFt'), 
               	(Decimal) RowData.get('NewSqFt'), 
               	(Decimal) RowData.get('OldRate'), 
               	(Decimal) RowData.get('NewRate')
            ));
        }

	 	return objDataset; 
	}

  	// Accrual Wrapper ...
    public GLXY_AccrualReport(String RecordLink, String Region, String ProjectNumber, String ProjectType, String ProjectStatus, Date EffectiveDate, string EffectiveDateFY, 
		String LeaseNumber, String BuildingNumber, Decimal projectAccrual, Decimal LumpsumAccrual, String TeamCode, String RealtySpecialist, Date ProcessDate,
		Decimal	OldAnnualRent, Decimal NewAnnualRent, Decimal OldSqFt, Decimal NewSqFt, Decimal	OldRate, Decimal NewRate			
    
    ){
    	this.RecordLink = RecordLink;
        this.Region = Region;
        this.ProjectNumber = ProjectNumber;
		this.ProjectType = ProjectType;
		this.ProjectStatus = ProjectStatus;
		this.EffectiveDate = EffectiveDate;
		this.EffectiveDateFY = EffectiveDateFY;
		this.BuildingNumber = BuildingNumber;
		this.LeaseNumber = LeaseNumber;
		this.ProjectAccrual = ProjectAccrual;
		this.LumpSumAccrual = LumpSumAccrual;
		this.TeamCode = TeamCode;
		this.RealtySpecialist = RealtySpecialist;
		this.ProcessDate = ProcessDate;
		this.OldAnnualRent = OldAnnualRent;
		this.NewAnnualRent = NewAnnualRent;
		this.OldSqFt = OldSqFt;
		this.NewSqFt = NewSqFt;
		this.OldRate = OldRate;
		this.NewRate = NewRate;
    }
	
	
}