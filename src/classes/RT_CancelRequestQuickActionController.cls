public class RT_CancelRequestQuickActionController {
	@AuraEnabled
	Public static Boolean UpdateRequestTrackerStatusField(String Id){
        Boolean buttonEnableDisable=False ;
        String UserId=UserInfo.getUserId();
        Request_Tracker__c requestRecord=[Select id,OwnerId,Request_Tracker__c.Name from Request_Tracker__c where id=:Id];
        system.debug('The Request Tracker value is------------------>'+ requestRecord);   
        User u = [select id,Name,FirstName,LastName from User where Id=:requestRecord.OwnerId];
        string OwnerName=u.Name;
        system.debug('**'+OwnerName);
        if(UserId==requestRecord.OwnerId){
            requestRecord.Status__c='Cancelled';
            Update requestRecord;
        }
        else {
            buttonEnableDisable= True;
        }
    	return buttonEnableDisable;
	}
    
    @AuraEnabled
    Public static string ReturnOwnerName(String Id){
        Request_Tracker__c requestRecord=[Select id,OwnerId,Owner.Name from Request_Tracker__c where id=:Id];
        return requestRecord.Owner.Name;
    }
}