global class ConcurrentSessionsPolicyCondition implements TxnSecurity.PolicyCondition {
public static Decimal MAX_ADMIN_USER_SESSIONS;
public static Decimal MAX_USER_SESSIONS;
public static String PREFERRED_USER_PROFILE_LIST;

    public boolean evaluate(TxnSecurity.Event e){
        List<User> users = [SELECT ProfileId FROM User WHERE Id = :e.UserId];
        String profileId = (String)users.get(0).get('ProfileId');
        List<Profile> profiles = [SELECT Name FROM Profile WHERE Id = :profileId];
        String profileName = (String)profiles.get(0).get('Name');

        SBA_Session_Settings__mdt [] session_settings = [SELECT max_preferred_user_sessions__c, 
                                                                max_std_user_sessions__c,   
                                                                preferred_user_profile_list__c   
                                                                FROM SBA_Session_Settings__mdt 
                                                                WHERE isActive__c=true];
                                                                
        MAX_ADMIN_USER_SESSIONS =(Decimal) session_settings.get(0).get('max_preferred_user_sessions__c');
        MAX_USER_SESSIONS = (Decimal)session_settings.get(0).get('max_std_user_sessions__c');
        PREFERRED_USER_PROFILE_LIST = (String)session_settings.get(0).get('preferred_user_profile_list__c');
        
        System.debug('MAX_ADMIN_USER_SESSIONS: '+MAX_ADMIN_USER_SESSIONS );
        System.debug('MAX_USER_SESSIONS: '+MAX_USER_SESSIONS );
        System.debug('PREFERRED_USER_PROFILE_LIST: '+PREFERRED_USER_PROFILE_LIST );
        
        
        List<AuthSession> sessions
            = [SELECT Id, CreatedDate, LastModifiedDate, NumSecondsValid, SessionType
              FROM AuthSession
              WHERE UsersId = :e.UserId and ParentId = NULL];

        Map<String, String> sessionsToIgnore = (Map<String, String>)Auth.SessionManagement.ignoreForConcurrentSessionLimit(sessions); 
        Integer activeSessions = 0;
        for (AuthSession s : sessions) {
            DateTime d = (DateTime)s.get('LastModifiedDate');
            Integer n = (Integer)s.get('NumSecondsValid');
            String type = (String)s.get('SessionType');
            String sessionId = (String)s.get('Id');
            if(sessionsToIgnore.get(sessionId).equals('false')) {
                if(d.addSeconds(n) >= DateTime.now()) {
                    activeSessions = activeSessions + 1;
                }
                if(isPreferedProfile(profileName, PREFERRED_USER_PROFILE_LIST )) {
                    if(activeSessions >= MAX_ADMIN_USER_SESSIONS) {
                        return true;
                    }
                } else {
                    if(activeSessions >= MAX_USER_SESSIONS) {
                        return true;
                    }
                }
            }
        }
        return false;

    }
    
    private boolean isPreferedProfile( String profileName, String profileList) {
    Boolean matched = false;
    
    for (String prefProfileName : profileList.split(';')) {
    
        if(profileName.equals(prefProfileName )) {
        System.debug('Users profile: '+profileName+' matched preferred profile');
           matched = true;
        }
    
    }
    return matched;
    
    }
}