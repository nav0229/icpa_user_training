/* ----------------------------------------------------------------------------------
   Calculate the roll up summary field on Attendee record when users 
   insert/update/delete Attendee Expense record 
-------------------------------------------------------------------------------------
    Author        | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Rajakumar       12/13/12   1.0       Initial Draft
-------------------------------------------------------------------------------------    
*/
public class AttendeeExpenseRollUpHelper {
  
  // method will be invoked after update/insert/delete
  public static void onAfterUpsertorDelete(List<Attendee_Expense__c> triggerNeworOld) {
      //Limit the size of list by using Sets which do not contain duplicate elements
      Set<Id> AttendeeIds = new Set<Id>();
 
      for(Attendee_Expense__c a : triggerNeworOld){
          AttendeeIds.add(a.Attendee__c);
      }
      
      //Map will contain one Attendee Id to one sum value
      Map<Id, Double> AttendeeMap = new Map<Id, Double>();
 
      //Produce a sum of Attendee_Expense__c and add them to the map
      //use group by to have a single Opportunity Id with a single sum value
      for(AggregateResult q : [select Attendee__c,sum(Estimated_Amount__c) totalExpSum
          from Attendee_Expense__c where Attendee__c IN :AttendeeIds group by Attendee__c]){
          AttendeeMap.put((Id)q.get('Attendee__c'),(Double)q.get('totalExpSum'));
      }
 
      List<Attendee__c> AttendeesToUpdate = new List<Attendee__c>();
 
      //Run the for loop on Attendee using the non-duplicate set of Attendee Ids
      //Get the sum value from the map and create a list of Attendees to update
      for(Attendee__c a : [Select Id, Total_Estimated_Expenses_t__c from Attendee__c where Id IN :AttendeeIds]){
          Double EstimatedExpSum = AttendeeMap.get(a.Id);
          a.Total_Estimated_Expenses_t__c = EstimatedExpSum;
          AttendeesToUpdate.add(a);
      }
 
      update AttendeesToUpdate;
  }
}