trigger IDP_Trigger on IDP__c (After Update, before Insert,before Update) {

Map<Id,String> CreatedUserId=new Map<Id,String>();
List<IDP__c> updateIdps=new List<IDP__c>();
Map<Id,List<IDP__c>> CreatedUserIdFiscalMap=new Map<Id,List<IDP__c>>();
Map<Id,String> IdCreatedUserMap=new Map<Id,String>();

    if(Trigger.isBefore)
        {
            if(Trigger.isInsert || Trigger.isUpdate)
            {               
            }
        }

    if(Trigger.isAfter && Trigger.isUpdate)
        {
            String recordId;
            String oldSupervisor;
            String OldOtherViewer;
            String supervisor;
            String otherViewer;
            String status;     
            Date sdate = Date.today();
            Integer year = sdate.year();
            String curFiscalYear = 'FY '+String.valueOf(year);      
            String userId = userInfo.getUserId();
            String fy;
            String createdId;
            
            for(IDP__c idp : Trigger.new)
            {    
                recordId = idp.Id;               
                supervisor = idp.Supervisor__c;
                otherViewer = idp.Director__c;
                status = idp.IDP_Status__c;      
                createdId = idp.CreatedById;
                fy = idp.Fiscal_Year_pick__c;        
                if(Trigger.oldMap.get(idp.id).IDP_Status__c!='Approved' && idp.IDP_Status__c=='Approved')
                {
                    CreatedUserId.put(idp.id,idp.CreatedById);
                    IdCreatedUserMap.put(idp.CreatedById,idp.id);
                }
            }           
            if(status == 'New') {
            List<RecordSharingUtil.RecordSharingDefiniation> ors = new List<recordSharingUtil.RecordSharingDefiniation>{
                new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                new recordSharingUtil.RecordSharingDefiniation(recordId, otherViewer, 'Read', 'Other_Viewer_Access__c')
                };
             RecordSharingUtil.unshare(ors);  
               }
               /*
                if(status == 'Resubmit') {
                    //System.debug('In Resubmit Status' + ' Record ID ' + recordID + ' Supervisor ' + supervisor + ' Otherviewer ' + otherViewer);
            List<RecordSharingUtil.RecordSharingDefiniation> ors1 = new List<recordSharingUtil.RecordSharingDefiniation>{
                new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Read', 'Manual'),
                new recordSharingUtil.RecordSharingDefiniation(recordId, otherViewer, 'Read', 'Manual')
                };
             RecordSharingUtil.unshare(ors1);  
               }*/
             
            if(status == 'Supervisor Review') {
            List<RecordSharingUtil.RecordSharingDefiniation> nrs = new List<recordSharingUtil.RecordSharingDefiniation>{
                new recordSharingUtil.RecordSharingDefiniation(recordId, supervisor, 'Edit', 'Supervisor_Access__c'),
                new recordSharingUtil.RecordSharingDefiniation(recordId, otherViewer, 'Read', 'Other_Viewer_Access__c')
                };
            RecordSharingUtil.share(nrs);
            }
            
            List<IDP__c> approvedIDPs = [SELECT Id,Fiscal_Year_pick__c,CreatedById FROM IDP__c WHERE CreatedById IN :CreatedUserId.values() AND IDP_Status__c = 'Approved'];           
            Map<String, List<IDP__c>> createdByIdpMap =new Map<String, List<IDP__c>>();                  
            for(IDP__c idp : approvedIDPs )
            {
                if(createdByIdpMap!=null || createdByIdpMap.size()!=0)
                {
                    List<IDP__c> tempIdp=new List<IDP__c>();
                    Map<String,List<IDP__c>> tempMap=new map<String,List<IDP__c>>();
                    map<String,List<IDP__c>> NewMap=new map<String,List<IDP__c>>();
                    if(CreatedUserIdFiscalMap.containsKey(idp.CreatedById)) 
                    {
                        tempIdp=CreatedUserIdFiscalMap.get(idp.CreatedById);
                        String createdby=IdCreatedUserMap.get(idp.CreatedById);
                        IDP__c actualIdp=Trigger.newMap.get(createdby);
                        if(actualIdp.Fiscal_Year_pick__c==idp.Fiscal_Year_pick__c)
                        {
                            tempIdp.add(idp);
                        }
                    }
                    else
                    {
                    tempIdp=new List<IDP__c>();
                    
                    system.debug('out shree fiscal map'+NewMap);
                    String createdby=IdCreatedUserMap.get(idp.CreatedById);
                    IDP__c actualIdp=Trigger.newMap.get(createdby);
                        if(actualIdp.Fiscal_Year_pick__c==idp.Fiscal_Year_pick__c)
                        {
                            tempIdp.add(idp);
                        }
                    }
                    CreatedUserIdFiscalMap.put(idp.CreatedById,tempIdp);
                }
            } 
            system.debug('shree 0'+CreatedUserIdFiscalMap);
            for(String cId:CreatedUserIdFiscalMap.keyset())
            {
            system.debug('shree 1'+cId);
                List<IDP__c> tempIdpMap=CreatedUserIdFiscalMap.get(cId);
                system.debug('shree 2'+tempIdpMap.size());
                for(IDP__c tempIdp:tempIdpMap)
                {              
                            String createdby=IdCreatedUserMap.get(tempIdp.CreatedById);
                            IDP__c actualIdp=Trigger.newMap.get(createdby);
                            system.debug('Inside'+actualIdp);
                            if(actualIdp.Fiscal_Year_pick__c==tempIdp.Fiscal_Year_pick__c)
                            {
                                if(!CreatedUserId.containsKey(tempIdp.id))
                                {
                                    
                                    tempIdp.IDP_Status__c = 'Archived';
                                    updateIdps.add(tempIdp);
                                }
                            }
                        
                    }                
                }
                
             
            if(updateIdps.size()!=0)
            {
                update updateIdps;
            }   
            /* 
            List<Form_SF_182__c> formSF182 = new List<Form_SF_182__c>();
            system.debug('Logged In User ' + userId);
            List<IDP__c> lstIDP = [SELECT Id, IDP_Status__c, OwnerId, Fiscal_Year_pick__c FROM IDP__c WHERE IDP_Status__c = 'Archived' AND Fiscal_Year_pick__c = :fy AND OwnerId = :createdId AND Id != :recordId ORDER BY CreatedDate DESC];
            system.debug('IDP Status =============== ' + status);   
            system.debug('List of IDPs ' + lstIDP);
            if(!lstIDP.isEmpty()){
            List<Form_SF_182__c> lstSF182 = [SELECT Id, IDP__c FROM Form_SF_182__c WHERE IDP__c = :lstIDP[0].Id AND OwnerId = :createdId];
            system.debug('List of SF 182 ' + lstSF182);                     
            if(!lstSF182.isEmpty()){
            		for(Form_SF_182__c sf : lstSF182){
            				if(status == 'Approved'){
            					system.debug('This is FORM SF 182' + formSF182);
            					sf.IDP__c = recordId;
            					formSF182.add(sf);            					
            				}
            		}
            	}
            }
            
            update formSF182;
           */
        }


}