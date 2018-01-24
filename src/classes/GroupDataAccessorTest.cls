@isTest
private class GroupDataAccessorTest {
	
	@isTest static void getGroupByDeveloperNameAndType_givenADeveloperNameAndType_shouldRetrieveGroup() {
		GroupDataAccessor groupDA = new GroupDataAccessor();

		Group testGroup = new Group(
			Name = 'Test Group',
			DeveloperName = 'Test_Group',
			Type = 'Queue'
		);
		insert testGroup;

		Test.startTest();
			Group retrievedGroup = groupDA.getGroupByDeveloperNameAndType(testGroup.DeveloperName, testGroup.Type);
		Test.stopTest();

		System.assert(
			retrievedGroup != null,
			'With the given DeveloperName and Type, a Group should have been retrieved.'
		);

		System.assertEquals(
			testGroup.Id,
			retrievedGroup.Id,
			'With the given DeveloperName and Type, the test group that was inserted should have been retrieved.'
		);
	}
	
}