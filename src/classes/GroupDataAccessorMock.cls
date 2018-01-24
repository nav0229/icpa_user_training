/****************************************************************
 Name:  GroupDataAccessorMock
============================================================
Author: Lenny
Mock Data Accessor for Group object
============================================================

****************************************************************/

@isTest
public with sharing class GroupDataAccessorMock implements GroupDAO {
	public Integer getGroupByDeveloperNameAndTypeCallCount {get; private set;}

	public Group getGroupByDeveloperNameAndTypeReturn;

	public GroupDataAccessorMock() {
		getGroupByDeveloperNameAndTypeCallCount = 0;

		getGroupByDeveloperNameAndTypeReturn = new Group();
	}

	public Group getGroupByDeveloperNameAndType(String devName, String groupType) {
		getGroupByDeveloperNameAndTypeCallCount++;
		return getGroupByDeveloperNameAndTypeReturn;
	}
}