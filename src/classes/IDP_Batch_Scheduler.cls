global class IDP_Batch_Scheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        IDP_Email_Batch batchShare = new IDP_Email_Batch();
        // Added for Test Coverage - 4/22/2014  ** BEGIN
        if(Test.isRunningTest()) {
            batchShare.query = 'SELECT Assignee.Id, PermissionSetId from PermissionSetAssignment WHERE PermissionSetId IN (SELECT Id From PermissionSet WHERE Name=\'HR_Access_to_IDP_and_related_Objects\' OR Name=\'IDP_All_Users\') LIMIT 1';
        }
        // Added for Test Coverage - 4/22/2014   ** END
        ID batchprocessid = Database.executeBatch(batchShare,1);  
    }
}