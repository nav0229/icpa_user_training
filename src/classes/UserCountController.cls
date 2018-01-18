/*
  UserCountController.cls
  Class for displaying the user count by permission set
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Rajakumar              09/04/2012  1.0      Creation
  Rajakumar              01/16/2013  1.1      Included filter to count the active users
  --------------------------------------------------------------------------------
  
*/
public with sharing class UserCountController {

    public List<AggregateResult> usrCount = new List<AggregateResult>();
    public List<PermissionSet> pSet = new List<PermissionSet>();
    public Map<String, String> countMap = new Map<String, String>();
    public Map<String, Integer> extractMap = new Map<String, Integer>();
    
    public String sfhost;
    
    public String getSfhost()
    {
        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        sfhost = 'https://'+hostname+'/apex/UserCountByPermissionSetExcel';
        return sfhost;
    }    
    
    public void setSfhost()
    {
        sfhost = null;
    }    
    
    public UserCountController() {
        usrCount = [SELECT PermissionSet.Id PermId, PermissionSet.Label PermSetName, Count(AssigneeId) Total FROM PermissionSetAssignment  
                    WHERE (NOT PermissionSet.Name LIKE 'X00%') AND Assignee.IsActive = true GROUP BY PermissionSet.Label, PermissionSet.Id];
        pSet = [SELECT Id, Label, Name FROM PermissionSet WHERE (NOT Name Like 'X00%') ORDER BY Label];
        /*
        for(PermissionSet p: pSet) {
            countMap.put(String.valueOf(p.get('Id')),String.valueOf(p.get('Name')));
        } */         
        for(AggregateResult ar: usrCount) {
            extractMap.put(String.valueOf(ar.get('PermId')),Integer.valueOf(ar.get('Total')));
        }
             
    }
    
    public List<CountClass> getResults() {
        List<CountClass> lstResult = new List<CountClass>();
        /*
        for (AggregateResult ar: usrCount) {
                    CountClass cntRcd = new CountClass(ar);
                    lstResult.add(cntRcd);
        }
        */        
        for(PermissionSet p: pSet) {
            if(!extractMap.containsKey(p.Id)){
                CountClass cntRcd2 = new CountClass(p.Label, 0);
                lstResult.add(cntRcd2);
            }
            else {
                 CountClass cntRcd = new CountClass(p.Label,extractMap.get(p.Id));
                 lstResult.add(cntRcd);
                
            }       
        }
        return lstResult;
    }

    class CountClass {
        
        public Integer TotalUsers { get;set; }

        public String PermSetName { get;set; }
        /*
        public CountClass(AggregateResult ar) {
            TotalUsers = (Integer)ar.get('Total');
            PermSetName = (String)ar.get('PermSetName');
        }
        */
        public CountClass(String pName, Integer cnt) {
            TotalUsers = cnt;
            PermSetName = pName;
        }
    }
}