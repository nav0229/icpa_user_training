public with sharing class IDP_ClonePlusController {

    public IDP_ClonePlusController(IDP_Details controller) {

    }

    private final IDP__c idp;
    public IDP_ClonePlusController(ApexPages.StandardController stdc){
        this.idp = (IDP__c)stdc.getRecord();
    
    }
    
    public IDP_ClonePlusController(String idpId, String fiscalYear) {
        this.idp = new IDP__c(Id = idpId, Fiscal_Year_pick__c = fiscalYear);
    }
    
    public PageReference initialiseObjectsForCloning(string fiscalYear){
        Map<id,Developmental_Objective__c> devlopObj = new Map<id,Developmental_Objective__c>();
        Map<id,IDP_Developmental_Line_Item__c> activityObj = new Map<id,IDP_Developmental_Line_Item__c>();
        Map<id, Developmental_Competency__c> compAct = new Map<id, Developmental_Competency__c>();
        set<string> devIds = new set<string>();
        set<string> actIds = new set<string>();
        set<string> compIds = new set<string>();
        IDP__c idpc = [select id,IDP_Status__c,IDP_Names__c,Director__c,Series__c,Career_Goals_Short_Run__c,office_Symbol__c,Career_Goals_Long_Run__c,GSA_Organization__c,Position_Levels__c,Developmental_Objectives_del__c,Employee_Email__c,Employee_Name__c,Supervisor__c,Fiscal_Year_pick__c,
                        Grade__c, Payplan__c, Specialization__c from IDP__c where id=:idp.id];
        IDP__c idpNew = new IDP__c();
        idpNew.IDP_Status__c = 'Resubmit';
        //idpNew.IDP_Name__c = idpc.IDP_Name__c;
        //idpNew.Director__c = idpc.Director__c;
        //idpNew.Supervisor__c = idpc.Supervisor__c;
        idpNew.Series__c = idpc.Series__c;
        idpNew.Career_Goals_Long_Run__c= idpc.Career_Goals_Long_Run__c;
        idpNew.Career_Goals_Short_Run__c = idpc.Career_Goals_Short_Run__c;
        idpNew.Developmental_Objectives_del__c = idpc.Developmental_Objectives_del__c;
        //idpNew.Fiscal_Year_pick__c = idpc.Fiscal_Year_pick__c;    
        idpNew.Fiscal_Year_pick__c = fiscalYear;  
        idpNew.Grade__c = idpc.Grade__c;
        idpNew.Payplan__c = idpc.Payplan__c;
        idpNew.Specialization__c = idpc.Specialization__c;   
        insert idpNew;
        
        IDP__Share IDPShare1 = New IDP__Share();
        IDPShare1.ParentID = idpNew.ID;
        IDPShare1.UserOrGroupId = idpNew.Supervisor__c;
        IDPShare1.AccessLevel = 'Read';
        Database.SaveResult sr = Database.insert(IDPShare1, false);
        
        
        IDP__Share IDPShare2 = New IDP__Share();
        IDPShare2.ParentID = idpNew.ID;
        IDPShare2.UserOrGroupId = idpNew.Director__c;
        IDPShare2.AccessLevel = 'Read';
        Database.SaveResult sr2 = Database.insert(IDPShare2, false);     
        
        
        List<Developmental_Objective__c> existingObjectiveList = [SELECT id,Name,IDP__c,Objective_Title__c, Objective__c,CreatedDate 
                                                                    FROM Developmental_Objective__c
                                                                    //WHERE IDP__c =:idp.id ORDER BY Name DESC];
                                                                    WHERE IDP__r.Id =:idp.id ORDER BY Name DESC]; //Nithin Changed on 09/27/2013
      
        List<String> objectiveIDs = new List<String>();
        for(Developmental_Objective__c objectiveID : existingObjectiveList){
              devIds.add(objectiveID.id); 
              Developmental_Objective__c objNew = new Developmental_Objective__c();              
              objNew.IDP__c = idpNew.id;
              objNew.Objective_Title__c = objectiveID.Objective_Title__c;
              objNew.Objective__c = objectiveID.Objective__c;              
              devlopObj.put(objectiveID.id,objNew);
         }
         if(!devlopObj.isEmpty()){
             insert devlopObj.values();
         }
        List<IDP_Developmental_Line_Item__c> existingActivityList=[SELECT id,Name,Developmental_Objective__c,Vendor__c,Location__c,Total_Cost__c,Required_Date__c,Priority__c,Planned_Start_Date__c,Planned_End_Date__c,Training_Need__c,Cost_Travel__c,Per_Diem__c,Cost_Material__c ,Comments__c, Tuition_Fees__c,
                                                                   Activity_Type_List__c, Books_Material_Costs__c,Activity_Type__c,Assignment_Title__c,Series__c, Organization_City__c, IDP_Activity_Status__c, Completed_Date__c, Supervisor_Comments__c, Expected_Outcomes__c, RecordTypeId FROM IDP_Developmental_Line_Item__c
                                                                    WHERE Developmental_Objective__c In :devIds];
                                                                    //WHERE Developmental_Objective__r.IDP__r.Id = :idp.id]; //Nithin Changed on 09/27/2013
        
        //System.Debug('------------------------------------------------------------------------------------------------------- Activity Record Type: ' +existingActivityList[0].RecordTypeId);
        
        for(IDP_Developmental_Line_Item__c objectiveID:existingActivityList){
             if(devlopObj.containsKey(objectiveID.Developmental_Objective__c) != null){
               actIds.add(objectiveID.id);
               Developmental_Objective__c devRel = devlopObj.get(objectiveID.Developmental_Objective__c);
               IDP_Developmental_Line_Item__c objActive = new IDP_Developmental_Line_Item__c();
               objActive.Developmental_Objective__c = devRel.id;                             
               //objActive.RecordTypeId = objectiveID.RecordTypeId;               
               objActive.IDP_Activity_Status__c = objectiveID.IDP_Activity_Status__c;
               objActive.Assignment_Title__c = objectiveID.Assignment_Title__c;              
               objActive.Books_Material_Costs__c= objectiveID.Books_Material_Costs__c;               
               objActive.Comments__c = objectiveID.Comments__c;               
               objActive.Cost_Material__c = objectiveID.Cost_Material__c;
               objActive.Per_Diem__c = objectiveID.Per_Diem__c;
               objActive.Cost_Travel__c = objectiveID.Cost_Travel__c;               
               objActive.Training_Need__c = objectiveID.Training_Need__c;                              
               objActive.Organization_City__c = objectiveID.Organization_City__c;               
               objActive.Planned_End_Date__c= objectiveID.Planned_End_Date__c;
               objActive.Planned_Start_Date__c= objectiveID.Planned_Start_Date__c;
               objActive.Completed_Date__c= objectiveID.Completed_Date__c;               
               objActive.Supervisor_Comments__c= objectiveID.Supervisor_Comments__c;
               objActive.Expected_Outcomes__c= objectiveID.Expected_Outcomes__c;
               objActive.Priority__c= objectiveID.Priority__c;               
               objActive.Required_Date__c= objectiveID.Required_Date__c;              
               objActive.Series__c= objectiveID.Series__c;               
               objActive.Location__c= objectiveID.Location__c;
               objActive.Vendor__c= objectiveID.Vendor__c;   
			   objActive.Tuition_Fees__c = objectiveID.Tuition_Fees__c;       
			   objActive.Activity_Type_List__c = objectiveID.Activity_Type_List__c;                                             
               activityObj.put(objectiveID.id,objActive);               
             }
        }
        if(!activityObj.isEmpty()){
             insert activityObj.values();
         }
         
       List<Developmental_Competency__c> existingCompList = [SELECT Id, Activity_Name__c, Developmental_Activity__c, Competency_Model__c, Competency_Area__c, Competency__c FROM Developmental_Competency__c  WHERE Developmental_Activity__c In :actIds];
       for(Developmental_Competency__c compActId:existingCompList){
       		if(activityObj.containsKey(compActId.Developmental_Activity__c) != null){
       			compIds.add(compActId.Id);
       			IDP_Developmental_Line_Item__c actRel = activityObj.get(compActId.Developmental_Activity__c);
       			Developmental_Competency__c compActive = new Developmental_Competency__c();
       			compActive.Developmental_Activity__c = actRel.Id;
       			compActive.Competency_Model__c = compActId.Competency_Model__c;
       			compActive.Competency_Area__c = compActId.Competency_Area__c;
       			compActive.Competency__c = compActId.Competency__c;
       			compAct.put(compActId.id, compActive);       			
       		}
       }
         if(!compAct.isEmpty()){
         	system.debug('These are Comp Values ' + compAct.values());
             insert compAct.values();
         }
         PageReference  pagRef = new PageReference('/'+idpNew.id); 
         return  pagRef;              
    } 
}