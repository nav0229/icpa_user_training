@isTest(SeeAllData=true)
private class PDE_TestCcRecipientsController {
    
    
    private static testmethod void test_get_name(){
        List<User> contacts = [Select Id,  Name From User where (not email like '%=%') and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true];
        
        Test.startTest();
        
        String ret = PDE_CcRecipientsController.getCurrentValue(null, null);
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.getCurrentValue('INVALID_OBJECT', 'INVALID_ID');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.getCurrentValue('INVALID_OBJECT', '000000000000000');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.getCurrentValue('User', '000000000000000');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.getCurrentValue('User', contacts[0].Id);
        System.assert(ret.contains(contacts[0].Name), 'Should return '+contacts[0].Name+ ' ['+ret+']');
            
        Test.stopTest();
    }
    
    private static testmethod void testSearchSObjectNullType(){
        String ret = PDE_CcRecipientsController.searchSObject(null, null);
        System.assert(ret==null);    
    }
    
    private static testmethod void testSearchSObjectInvalidType(){
        String ret = PDE_CcRecipientsController.searchSObject('fsdfsdfs', 'fsdfsd');
        System.assert(ret==null);    
    }
    
    private static testmethod void testSearchSObjectValid(){
        User u = [Select Id, Name From User where (not email like '%=%') and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true limit 1];
        String ret = PDE_CcRecipientsController.searchSObject('USER', u.Name);
        System.assert(ret!=null);    
    }

    private static testmethod void test_search(){
        List<User> contacts = [Select Id, Name From User where (not email like '%=%') and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true];
        Test.startTest();
        
        String ret = PDE_CcRecipientsController.searchSObject(null, null);
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.searchSObject('INVALID_OBJECT', 'NO_RESULT_SEARCH_STRING');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = PDE_CcRecipientsController.searchSObject('User', 'NO_RESULT_SEARCH_STRING');
        System.assert(String.isNotBlank(ret), 'Should return non null string ['+ret+']');
        List<PDE_CcRecipientsController.SearchResult> sResList = (List<PDE_CcRecipientsController.SearchResult>)JSON.deserialize(ret, 
        List<PDE_CcRecipientsController.SearchResult>.class);
        System.assert(sResList.isEmpty(), 'Why not empty list? ['+sResList.size()+' instead]');
        
        //Test.setFixedSearchResults(new List<String>{contacts[0].Id,contacts[1].Id,contacts[2].Id});
        Test.setFixedSearchResults(new List<String>{contacts[0].Id});
        ret = PDE_CcRecipientsController.searchSObject('User', 'Test');
        System.assert(String.isNotBlank(ret), 'Should return a serialized list string ['+ret+']');
        sResList = (List<PDE_CcRecipientsController.SearchResult>)JSON.deserialize(ret, 
            List<PDE_CcRecipientsController.SearchResult>.class);
        //System.assert(sResList.size() == 3, 'Why not 3 items found? ['+sResList.size()+' instead]');
        System.assert(sResList.size() == 1, 'Why not 1 items found? ['+sResList.size()+' instead]');
        Test.stopTest();
    }
}