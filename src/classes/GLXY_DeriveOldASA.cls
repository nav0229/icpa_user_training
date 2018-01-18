public with sharing class GLXY_DeriveOldASA {
    
    public static Set<string> glbMasterIDsToUpdate;
    
    public static void fnUpdateASA(Set<string> MasterIDsToUpdate) {
        System.Debug('MyDebug Inside fnUpdateASA');
        List<Glxy_ProjectRequestASA__c> objListASA = [Select ProjectAgencyID__c, OldASA__c from Glxy_ProjectRequestASA__c 
                                                      Where ProjectAgencyID__c in :MasterIDsToUpdate
                                                      Order By ProjectAgencyID__c];
        
        System.Debug('MyDebug objListASA.Size = ' + objListASA.size());
        List<Glxy_ProjectAgency__c> objAgenciesToUpdate = New List<Glxy_ProjectAgency__c>();    
        string strLoopCurrentAgency;
        string strLoopPreviousAgency = '-';
        string strASAList = '';
        boolean blnHasData = false;                                       
        //Loop through to find the Request ASA's associated with an Agency  
        for (Glxy_ProjectRequestASA__c objASA : objListASA) {
            blnHasData = true;
            strLoopCurrentAgency = objASA.ProjectAgencyID__c;
            System.Debug('MyDebug strLoopPreviousAgency - ' + strLoopPreviousAgency);
            System.Debug('MyDebug strLoopCurrentAgency - ' + strLoopCurrentAgency);
                if ((strLoopCurrentAgency <> strLoopPreviousAgency) && (strLoopPreviousAgency <> '-')){
                    if (strASAList.LastIndexOf(',') > 0)
                        strASAList = strASAList.Left(strASAList.LastIndexOf(', '));
                    objAgenciesToUpdate.Add(new Glxy_ProjectAgency__c(
                        ID = strLoopPreviousAgency,
                        OldASA__c = strASAList
                    ));
                    System.Debug('MyDebug InsertAgency - ' + strLoopPreviousAgency);
                    strASAList = '';    
                }
                strASAList = strASAList + objASA.OldASA__c + ', ';
                strLoopPreviousAgency = strLoopCurrentAgency;
        }   
        
        if (blnHasData = true){
            if (strASAList.LastIndexOf(', ') > 0)
                strASAList = strASAList.Left(strASAList.LastIndexOf(', '));
            objAgenciesToUpdate.Add(new Glxy_ProjectAgency__c(
                ID = (ID) strLoopCurrentAgency,
                OldASA__c = strASAList
            ));
            System.Debug('MyDebug InsertAgency - ' + strLoopCurrentAgency);
        }
        
        try{    
            Database.Update(objAgenciesToUpdate);
        }catch (DmlException e){
            System.debug('GLXY_DeriveOldASA Update error - ' + e.getMessage());
        }
    }
    
    @isTest(SeeAllData=false) Static void  TestTriggerGLXY_DeriveOldASA () {
            Glxy_LeaseProjects__c project = new Glxy_LeaseProjects__c (Name = '6AK0141', NOASquareFeet__c = 1935.45, IASquareFeet__c = 0, 
                Project_Type__c = 'Succeeding', EffectiveDate__c = date.newInstance(2011,2,14), RegionCd__c = '10',
                AnnualRent__c = 0, ProjectStatus__c = 'Active', Old_Annual_Rent__c = 0, SquareFeet__c = 1935.45, eEorA__c = 'Actual');
            insert project;
            System.Assert(project!=NULL);   
            
            PBS_AB_Code__c obAB1 = New PBS_AB_Code__c();
            obAB1.AB_Code__c = '9999';
            obAB1.Agency_Bureau_Name__c = 'test';
            obAB1.Agency_Bureau_Short_Name__c = 'test';
            obAB1.Agency_Code__c = '19';
            obAB1.Bureau_Code__c = '01';
            insert obAB1;
            
            PBS_AB_Code__c obAB2 = New PBS_AB_Code__c();
            obAB2.AB_Code__c = '8888';
            obAB2.Agency_Bureau_Name__c = 'test2';
            obAB2.Agency_Bureau_Short_Name__c = 'test2';
            obAB2.Agency_Code__c = '10';
            obAB2.Bureau_Code__c = '11';
            insert obAB2;
            
            Glxy_ProjectAgency__c objTest1 = new Glxy_ProjectAgency__c();
            objTest1.ProjectNumber__c = project.id;
            objTest1.PBSABCode__c = obAB1.id;
            objtest1.BaseStructuredParkingSpaces__c  = 10;
            objtest1.BaseSurfaceParkingSpace__c = 10;
            insert objTest1;
            
            Glxy_ProjectAgency__c objTest2 = new Glxy_ProjectAgency__c();
            objTest2.ProjectNumber__c = project.id;
            objTest2.PBSABCode__c = obAB2.id;
            objtest2.BaseStructuredParkingSpaces__c  = 10;
            objtest2.BaseSurfaceParkingSpace__c = 10;
            insert objTest2;
            
            Glxy_ProjectRequestASA__c objTest1a =  new Glxy_ProjectRequestASA__c();
            objTest1a.ProjectAgencyID__c = objTest1.id;
            objTest1a.OldASA__c = 'AAAS';
            objTest1a.RequestASAID__c = 1112;
            
            Glxy_ProjectRequestASA__c objTest1b =  new Glxy_ProjectRequestASA__c();
            objTest1b.ProjectAgencyID__c = objTest1.id;
            objTest1b.OldASA__c = 'AAAB';
            objTest1b.RequestASAID__c = 1113;
            
            Glxy_ProjectRequestASA__c objTest2a =  new Glxy_ProjectRequestASA__c();
            objTest2a.ProjectAgencyID__c = objTest2.id;
            objTest2a.OldASA__c = 'AAAD';
            objTest2a.RequestASAID__c = 1114;
            
            List<Glxy_ProjectRequestASA__c> RequestASAs = new List<Glxy_ProjectRequestASA__c> {objTest1a, objTest1b, objTest2a};
            Insert RequestASAs;
            
            Delete objTest1a;

        }
         
    
}