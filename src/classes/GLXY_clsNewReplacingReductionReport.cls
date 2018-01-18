public with sharing class GLXY_clsNewReplacingReductionReport {
public map<string,Glxy_LeaseProjects__c> leaseProjectMap{get;set;}
public decimal iaImpactSum          {get;set;}
public decimal noaImpactSum         {get;set;}
public String iaImpactSumFormatted  {get;set;}
public string noaImpactSumformatted {get;set;}

public String strRegion  {get; set;}

public list<Glxy_LeaseProjects__c> leaseProjectlist{get;set;}

    public GLXY_clsNewReplacingReductionReport () { 
        
        if (System.currentPageReference().getParameters().get('Region')!=null){
            strRegion = System.currentPageReference().getParameters().get('Region');
        }else{
            strRegion = '\'3\'';
        }
                
        iaImpactSum = 0;
        noaImpactSum =0;
        String strSOQL;
        
        leaseProjectMap = new map<string,Glxy_LeaseProjects__c>(); 
        leaseProjectList = new list<Glxy_LeaseProjects__c>();
        
        strSOQL = 'Select id, RegionCd__c, BDGFlag__c, Project_Type__c, EffectiveDate__c,TeamCode__c, NewLease__c,Budget_Exclusion_Reason__c,AnnualRent__c,NOASquareFeet__c, IASquareFeet__c,eEorA__c,  AssociatedLeases_lkup__c,ProjectStatus__c, Remarks__c, ChangeinIASQFt__c, ChangeinNOASQFt__c, name ' + 
                    'From Glxy_LeaseProjects__c ' +
                    'Where Project_Type__c = \'Reduction\' ' +
                    'And    RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') ' +
                    'And    ProjectStatus__c <> \'Cancelled\' ' +
                    'Order by RegionCD__c ' ;
                    
        strSOQL = strSOQL.Replace('\\','');             
                           
        list<Glxy_LeaseProjects__c> leaseproj = Database.query(strSOQL);
        for(Glxy_LeaseProjects__c proj :leaseproj){
            if(proj.Remarks__c != null && proj.Remarks__c.contains('created by the system')) {
                //leaseProjectMap.put(proj.Remarks__c.substringBetween('New/Replacing Project ', ' for Prior Lease'),proj);
                if(leaseProjectMap.containsKey(proj.Remarks__c.substringBetween('New/Replacing Project ', ' for Prior Lease'))) {
                
                    string key = proj.Remarks__c.substringBetween('New/Replacing Project ', ' for Prior Lease')+'_d';
                    leaseProjectMap.put(key ,proj);
                
                }
                else if(proj.Remarks__c != null){
                    leaseProjectMap.put(proj.Remarks__c.substringBetween('New/Replacing Project ', ' for Prior Lease'),proj);
                }
            
            }
        }
        //SET<string> keys = leaseProjectMap.keyset();
        list<string> keys = new List<String>(leaseProjectMap.keyset());
        strSOQL = 'select id,RegionCd__c,BDGFlag__c, Project_Type__c, EffectiveDate__c,TeamCode__c, NewLease__c, Budget_Exclusion_Reason__c,AnnualRent__c,NOASquareFeet__c, IASquareFeet__c, eEorA__c,AssociatedLeases_lkup__c,ProjectStatus__c, OldIASqFt__c, OldNOASqFt__c, ChangeinIASQFt__c, ChangeinNOASQFt__c,name ' + 
                   'from Glxy_LeaseProjects__c ' +
                  'where Project_Type__c = \'New/Replacing\' ' +
                    'And RegionCD__c In (' + String.escapeSingleQuotes(strRegion) + ') '  +
                    'and name In :keys ' +
                    'Order by RegionCD__c ' ;
                    
                                            
        strSOQL = strSOQL.Replace('\\',''); 
        
        list<Glxy_LeaseProjects__c> leaseproj1 = Database.query(strSOQL);
        for(Glxy_LeaseProjects__c proj :leaseproj1){
            if(leaseProjectMap.get(proj.name) != null) {
                //if(leaseProjectMap.get(proj.name).EffectiveDate__c == proj.EffectiveDate__c) {
                    leaseProjectList.add(leaseProjectMap.get(proj.name));
                    leaseProjectList.add(proj);   
                //}
                    if(leaseProjectMap.get(proj.name+'_d') != null) {
                       leaseProjectList.add(leaseProjectMap.get(proj.name+'_d'));
                       leaseProjectList.add(proj); 
                    }
            
            }
        
        }
        for(Glxy_LeaseProjects__c  proj1 : leaseProjectList) {
        if(proj1.Project_Type__c =='New/Replacing') {
        iaImpactSum  = iaImpactSum +proj1.OldIASqFt__c;
        noaImpactSum = noaImpactSum +proj1.OldNOASqFt__c;
        }
        else
        {
        iaImpactSum  = iaImpactSum +proj1.ChangeinIASQFt__c;
        noaImpactSum = noaImpactSum +proj1.ChangeinNOASQFt__c;
        }
            
        }
        iaImpactSumFormatted  = iaImpactSum.format();
        noaImpactSumFormatted  = noaImpactSum.format();
    }

}