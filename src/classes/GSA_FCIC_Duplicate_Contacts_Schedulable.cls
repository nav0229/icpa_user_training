global class GSA_FCIC_Duplicate_Contacts_Schedulable implements Schedulable {

// will be scheduled nightly so here's an example of a nightly version at 11:00 PM
// GSA_FCIC_Duplicate_Contacts_Schedulable deleteDupes = new GSA_FCIC_Duplicate_Contacts_Schedulable();
// String schedule = '0 0 23 * * ?';
// System.schedule('Delete duplicated contacts batch', schedule, deleteDupes);

global void execute(SchedulableContext sc){
	Database.executeBatch(new GSA_FCIC_Duplicate_Contacts_Create_Batch());
}

}