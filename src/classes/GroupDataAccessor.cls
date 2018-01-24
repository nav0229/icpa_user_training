/****************************************************************
 Name:  GroupDataAccessor
============================================================
Author: Lenny
Data Accessor for Group object
============================================================

****************************************************************/
public with sharing class GroupDataAccessor implements GroupDAO {

	public GroupDataAccessor(){}

	public Group getGroupByDeveloperNameAndType(String devName, String groupType) {
		return [
			SELECT Id 
			FROM Group 
			WHERE DeveloperName = :devName
			And Type = :groupType
			LIMIT 1
		];
	}
}