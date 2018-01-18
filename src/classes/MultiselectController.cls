/*
 * MultiselectController synchronizes the values of the hidden elements to the
 * SelectOption lists.
 */
public with sharing class MultiselectController {
	// SelectOption lists for public consumption
	public List<SelectOption> leftPicklist { get; set; }
	public List<SelectOption> rightPicklist { get; set; }
	public String label {get; set;}
	public List<SelectOption> searchCriteria {get; private set;}
	public String searchObject {get; set;}
	public String searchString {get; set;}
	public Controlled_Document__c thisControlledDocument {get; set;}
	public Id originatingUser {get; set;}
    public String baseUrl {get; set;}
    public boolean notCollaborator {get; set;}

    public boolean isExecSecOrOwner = false;

	// Backing for hidden text field containing the options from the
	// left list
	public String leftOptionsHidden { get; set {
		   leftOptionsHidden = value;
		   setOptions(leftPicklist, value);
		}
	}
	
	// Backing for hidden text field containing the options from the
	// right list
	public String rightOptionsHidden { get; set {
		   rightOptionsHidden = value;
		   setOptions(rightPicklist, value);
		}
	}

	private Set<Id> existingSelectedUsers {get; private set;}
	private Map<Id, SelectOption> originalSelectedUsers {get; private set;}

	public MultiselectController(){
		thisControlledDocument = [SELECT Id, Name, OwnerId FROM Controlled_Document__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
		originatingUser = UserInfo.getUserId();
		checkForSpecialPrivs();
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();

		rightPicklist = new List<SelectOption>();
		searchCriteria = new List<SelectOption>();
		searchCriteria.add(new SelectOption('Users', 'Users'));
		searchCriteria.add(new SelectOption('Common Users', 'Common Users'));

		findSelectedUsers();
		findUsers();

		// occassionally someone will add a collaborator that doesn't have collaborator access
		// this will break when these individuals try to remove quick shares
		// removing a quick share should remove collaborator access and only collaborators can do this
		notCollaborator = ControlledDocumentAccessDeterminer.checkCollaboratorStatus(thisControlledDocument.Id);	
	}

	public MultiselectController(ApexPages.StandardController controller) {
		thisControlledDocument = [SELECT Id, Name, OwnerId FROM Controlled_Document__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
		originatingUser = UserInfo.getUserId();
		checkForSpecialPrivs();
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();

		rightPicklist = new List<SelectOption>();
		searchCriteria = new List<SelectOption>();
		searchCriteria.add(new SelectOption('Users', 'Users'));
		searchCriteria.add(new SelectOption('Common Users', 'Common Users'));

		findSelectedUsers();
		findUsers();

		// occassionally someone will add a collaborator that doesn't have collaborator access
		// this will break when these individuals try to remove quick shares
		// removing a quick share should remove collaborator access and only collaborators can do this
		notCollaborator = ControlledDocumentAccessDeterminer.checkCollaboratorStatus(thisControlledDocument.Id);
	}

	public void checkForSpecialPrivs(){

		if(originatingUser == thisControlledDocument.OwnerId){
			isExecSecOrOwner = true;
		} else {
			List<PermissionSet> execSecPermissionSet = [
													SELECT Id 
													FROM PermissionSet
													WHERE Name = 'Controlled_Document_Tracker_OAS_Admin_User_CRED'
												];

			List<PermissionSetAssignment> psetAssign = [
													SELECT Id
													FROM PermissionSetAssignment
													WHERE AssigneeId = :originatingUser
													AND PermissionSetId = :execSecPermissionSet[0].Id
												];

			if(!psetAssign.isEmpty()) isExecSecOrOwner = true;
		}

	}

	public void refreshAvailableUserList(){
		if (searchObject == 'Users'){
			findUsers();
		} else if (searchObject == 'Common Users'){
			findCommonUsers();
		}
	}

	public PageReference saveChanges(){

		Map<Id, SelectOption> selectedUsersMap = new Map<Id, SelectOption>();
		Set<Id> userIds = new Set<Id>();

		for (SelectOption selectedOption : rightPicklist){
			userIds.add(selectedOption.getValue());
		}

		if(!userIds.isEmpty()) {
			SupplementaryAccessUserGranterQuickShare.addShareForQuickShareUser(thisControlledDocument.Id, originatingUser, userIds, isExecSecOrOwner);			
		}

		// an empty set here is perfectly fine
		SupplementaryAccessUserGranterQuickShare.disableShareForQuickShareUser(thisControlledDocument.Id, originatingUser, userIds, isExecSecOrOwner);

		PageReference redirectPage = new PageReference(baseUrl + '/' + thisControlledDocument.Id);
		redirectPage.setRedirect(true);
		return redirectPage;
	}
    // case# 31205 - BEGIN
    public Set<Id> validCDTUsers(Set<Id> findIds) {
        Set<Id> userIds = new Set<Id>();
        if(findIds != null && (!findIds.isEmpty())) {
            for(PermissionSetAssignment passign: [SELECT AssigneeId, PermissionSetId FROM PermissionSetAssignment WHERE
                                              PermissionSet.Name LIKE 'Controlled_Document%' AND AssigneeId IN :findIds LIMIT 200]) {
                                                  if(!userIds.contains(passign.AssigneeId))
                                                  	userIds.add(passign.AssigneeId);
                                              }
        } 
        if(findIds == null) {
            for(PermissionSetAssignment passign: [SELECT AssigneeId, PermissionSetId FROM PermissionSetAssignment WHERE
                                              PermissionSet.Name LIKE 'Controlled_Document%' LIMIT 200]) {
                                                  if(!userIds.contains(passign.AssigneeId))
                                                  	userIds.add(passign.AssigneeId);
                                              }
        }
        return ((!userIds.isEmpty()) ? userIds : null);
    }    
    // case# 31205 - END
	public void findUsers(){
		leftPicklist = new List<SelectOption>();
		// case# 31205 - BEGIN
		Set<Id> validuserIds = new Set<Id>();
        validuserIds = validCDTUsers(null);
        Map<Id, User> usersmatchMap = new Map<Id, User>();
		// case# 31205 - END
        List<User> allUsers;
		if (String.isBlank(searchString) && validuserIds != null){
			allUsers = [
				SELECT Id, FirstName, LastName, Name, Username
				FROM User
				WHERE UserType = 'Standard' 
                // case# 31205 - BEGIN
                AND Id IN :validuserIds
                // case# 31205 - END
				AND IsActive = true
				ORDER BY FirstName ASC NULLS LAST, LastName ASC NULLS LAST, Name ASC NULLS LAST
				LIMIT 100
			];
		} else {
			String likeString = '%' + searchString + '%';
			// case# 31202 - BEGIN
            for(User u : [SELECT Id, FirstName, LastName, Name, Username FROM User
                         WHERE UserType = 'Standard' AND IsActive = true
                         AND (FirstName LIKE :likeString OR LastName LIKE :likeString OR Name LIKE :likeString)                        
						ORDER BY FirstName ASC NULLS LAST, LastName ASC NULLS LAST, Name ASC NULLS LAST
						LIMIT 100
                         ]) {
                         	usersmatchMap.put(u.Id, u);   
                         }
            validUserIds = validCDTUsers(usersmatchMap.keySet());
            allUsers = new List<User>();
            if(validuserIds != null && !validUserIds.isEmpty()) {
                for(Id uId : validUserIds) {
                    if(usersmatchMap.containsKey(uId)) {
                        allUsers.add(usersmatchMap.get(uId));
                    }
                }
        	}
            // case# 31205 - END            
            /* commented for case# 31205 -BEGIN
            allUsers = [
				SELECT Id, FirstName, LastName, Name, Username
				FROM User
				WHERE UserType = 'Standard'
				AND IsActive = true
				AND (FirstName LIKE :likeString 
				OR LastName LIKE :likeString
				OR Name LIKE :likeString)
				ORDER BY FirstName ASC NULLS LAST, LastName ASC NULLS LAST, Name ASC NULLS LAST
				LIMIT 100
			];
				commented for case# 31205 - END  */

		}

		getSelectedUserIds();

		// check for similar names list
		Map<String, Integer> nameToOccurrences = new Map<String, Integer>();
		for (User user : allUsers){
			if (!existingSelectedUsers.contains(user.Id)){

				String key = user.FirstName + ' ' + user.LastName;
				if(nameToOccurrences.containsKey(key)){
					Integer tempInt = nameToOccurrences.get(key) + 1;
					nameToOccurrences.put(key, tempInt);
				} else {
					nameToOccurrences.put(key, 1);
				}

				System.debug('SUP DAWG (non common LEFT)' + nameToOccurrences);

			}
		}
		// actually populate list
		for (User user : allUsers){
			if (!existingSelectedUsers.contains(user.Id)){

				String key = user.FirstName + ' ' + user.LastName;
				if(nameToOccurrences.get(key) > 1){
					leftPicklist.add(new SelectOption(user.Id, user.FirstName 
															+ ' ' + user.LastName
															+ ' (' + user.Username + ')'));
				} else {
					leftPicklist.add(new SelectOption(user.Id, user.FirstName 
															+ ' ' + user.LastName));
				}

			}
		}
	}

	public void findCommonUsers(){
        List<Supplementary_Access_User__c> selectedUsers = [
            SELECT Id, User__c, User__r.FirstName, User__r.LastName, User__r.Name, User__r.Username
            FROM Supplementary_Access_User__c
            WHERE Active__c = true 
            AND Origin__c = 'Quick Share'
            AND Controlled_Document__c = :thisControlledDocument.Id
            AND Originating_User__c = :originatingUser
        ];

        Set<Id> existingSupplementUsers = new Set<Id>();
        for(Supplementary_Access_User__c supplement : selectedUsers){
            existingSupplementUsers.add(supplement.User__c);
        }

		leftPicklist = new List<SelectOption>();

		List<Common_Supplementary_User__c> commonUsers;
		if (String.isBlank(searchString)){
			commonUsers = [
				SELECT Id, Group_Member__c, Group_Member__r.FirstName, Group_Member__r.LastName, Group_Member__r.Name, Group_Member__r.Username, Frequency__c
				FROM Common_Supplementary_User__c
				WHERE CreatedById = :originatingUser
                AND Group_Member__c NOT IN :existingSupplementUsers
				ORDER BY Frequency__c DESC NULLS LAST, Group_Member__r.FirstName ASC NULLS LAST, Group_Member__r.LastName ASC NULLS LAST, Group_Member__r.Name ASC NULLS LAST
				LIMIT 100
			];
		} else {
			String likeString = '%' + searchString + '%';
			commonUsers = [
				SELECT Id, Group_Member__c, Group_Member__r.FirstName, Group_Member__r.LastName, Group_Member__r.Name, Group_Member__r.Username, Frequency__c
				FROM Common_Supplementary_User__c
				WHERE CreatedById = :originatingUser
                AND Group_Member__c NOT IN :existingSupplementUsers
				AND (Group_Member__r.FirstName LIKE :likeString 
				OR Group_Member__r.LastName LIKE :likeString
				OR Group_Member__r.Name LIKE :likeString)               
				ORDER BY Frequency__c DESC NULLS LAST, Group_Member__r.FirstName ASC NULLS LAST, Group_Member__r.LastName ASC NULLS LAST, Group_Member__r.Name ASC NULLS LAST
				LIMIT 100
			];
		}

		getSelectedUserIds();
		// check for similar names list
		Map<String, Integer> nameToOccurrences = new Map<String, Integer>();
		for (Common_Supplementary_User__c commonSupplement : commonUsers){
			if (!existingSelectedUsers.contains(commonSupplement.Group_Member__c)){
				
				String key = commonSupplement.Group_Member__r.FirstName + ' ' + commonSupplement.Group_Member__r.LastName;
				if(nameToOccurrences.containsKey(key)){
					Integer tempInt = nameToOccurrences.get(key) + 1;
					nameToOccurrences.put(key, tempInt);
				} else {
					nameToOccurrences.put(key, 1);
				}

				System.debug('SUP DAWG' + nameToOccurrences);

			}
		}
		// actually populate list
		for (Common_Supplementary_User__c commonSupplement : commonUsers){
			if (!existingSelectedUsers.contains(commonSupplement.Group_Member__c)){

				String key = commonSupplement.Group_Member__r.FirstName + ' ' + commonSupplement.Group_Member__r.LastName;
				if(nameToOccurrences.get(key) > 1){
					leftPicklist.add(new SelectOption(commonSupplement.Group_Member__c, commonSupplement.Group_Member__r.FirstName 
																						+ ' ' + commonSupplement.Group_Member__r.LastName 
																						+ ' (' + commonSupplement.Group_Member__r.Username + ')'));
				} else {
					leftPicklist.add(new SelectOption(commonSupplement.Group_Member__c, commonSupplement.Group_Member__r.FirstName 
																						+ ' ' + commonSupplement.Group_Member__r.LastName));
				}

			}
		}
	}

	public void findSelectedUsers(){
		List<Supplementary_Access_User__c> selectedUsers = new List<Supplementary_Access_User__c>();
		if(isExecSecOrOwner) {
			System.debug('AAAAAA');
			selectedUsers = [
				SELECT Id, User__c, User__r.FirstName, User__r.LastName, User__r.Username
				FROM Supplementary_Access_User__c
				WHERE Active__c = true 
				AND Origin__c = 'Quick Share'
				AND Controlled_Document__c = :thisControlledDocument.Id
				ORDER BY User__r.FirstName ASC NULLS LAST, User__r.LastName ASC NULLS LAST, User__r.Name ASC NULLS LAST
			];
		} else {
			System.debug('12312412414');
			selectedUsers = [
				SELECT Id, User__c, User__r.FirstName, User__r.LastName, User__r.Username
				FROM Supplementary_Access_User__c
				WHERE Active__c = true 
				AND Origin__c = 'Quick Share'
				AND Controlled_Document__c = :thisControlledDocument.Id
				AND Originating_User__c = :originatingUser
				ORDER BY User__r.FirstName ASC NULLS LAST, User__r.LastName ASC NULLS LAST, User__r.Name ASC NULLS LAST
			];
		}

		// check for similar names list
		Map<String, Integer> nameToOccurrences = new Map<String, Integer>();
		for (Supplementary_Access_User__c supplement : selectedUsers){

			String key = supplement.User__r.FirstName + ' ' + supplement.User__r.LastName;
			if(nameToOccurrences.containsKey(key)){
				Integer tempInt = nameToOccurrences.get(key) + 1;
				nameToOccurrences.put(key, tempInt);
			} else {
				nameToOccurrences.put(key, 1);
			}

		}

		// actually populate list
		for (Supplementary_Access_User__c supplement : selectedUsers){

			String key = supplement.User__r.FirstName + ' ' + supplement.User__r.LastName;
			if(nameToOccurrences.get(key) > 1){
				rightPicklist.add(new SelectOption(supplement.User__c, supplement.User__r.FirstName
														+ ' ' + supplement.User__r.LastName
														+ ' (' + supplement.User__r.Username + ')'));
			} else {
				rightPicklist.add(new SelectOption(supplement.User__c, supplement.User__r.FirstName
														+ ' ' + supplement.User__r.LastName));
			}

		}
	}

	public void getSelectedUserIds(){
		existingSelectedUsers = new Set<Id>();

		for (SelectOption o : rightPicklist){
			existingSelectedUsers.add(o.getValue());
		}
	}

	// Parse &-separated values and labels from value and 
	// put them in option
	public void setOptions(SelectOption[] options, String value) {
		options.clear();
		String[] parts = value.split('&');
		for (Integer i=0; i<parts.size()/2; i++) {
			options.add(new SelectOption(EncodingUtil.urlDecode(parts[i*2], 'UTF-8'), 
			  EncodingUtil.urlDecode(parts[(i*2)+1], 'UTF-8')));
		}
	}

}