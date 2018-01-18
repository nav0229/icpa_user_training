/* ----------------------------------------------------------------------------------
   Calculate the roll up summary field on Event Approval record when users 
   insert/update/delete Attendee record 
-------------------------------------------------------------------------------------
    Author        | Date     | Version | Descripton
-------------------------------------------------------------------------------------
    Rajakumar       12/13/12   1.0       Initial Draft
    Rajakumar       05/06/14   2.0       updated for apex sharing for HSSO and Supervisor
    Rajakumar       08/19/14   3.0       Undo the changes made in 2.0
-------------------------------------------------------------------------------------    
*/
public class AttendeeRollUpHelper {
  
  // method will be invoked for roll up summary
  public static void onAfterUpsertorDelete(List<Attendee__c> triggerNeworOld) {
      //Limit the size of list by using Sets which do not contain duplicate elements
      Set<Id> EventApprovalIds = new Set<Id>();
 
      for(Attendee__c a : triggerNeworOld){
          EventApprovalIds.add(a.Event_Number__c);
      }
      
      //Map will contain one Event Approval Id to one sum value
      Map<Id, Double> EventApprovalMap = new Map<Id, Double>();
 
      //Produce a sum of Attendee_Expense__c and add them to the map
      //use group by to have a single Opportunity Id with a single sum value
      for(AggregateResult q : [select Event_Number__c,sum(Total_Estimated_Expenses_t__c) totalExpSum
          from Attendee__c where Event_Number__c IN :EventApprovalIds group by Event_Number__c]){
          EventApprovalMap.put((Id)q.get('Event_Number__c'),(Double)q.get('totalExpSum'));
      }
 
      List<Event_Approval__c> EventApprovalsToUpdate = new List<Event_Approval__c>();
 
      //Run the for loop on Event Approval using the non-duplicate set of Event Approval Ids
      //Get the sum value from the map and create a list of Event Approvals to update
      for(Event_Approval__c a : [Select Id, Total_Estimated_Attendee_Expenses__c from Event_Approval__c where Id IN :EventApprovalIds]){
          Double EstimatedExpSum = EventApprovalMap.get(a.Id);
          a.Total_Estimated_Attendee_Expenses__c = EstimatedExpSum;
          EventApprovalsToUpdate.add(a);
      }
 
      update EventApprovalsToUpdate;
  }
  /* -- Ver 3.0 Comment the code changes made in 2.0 -- BEGIN --
  // -- Ver 2.0 -- Added for the apex Record Sharing -- BEGIN -- //
  // process the records when insert operation is performed.
    public static void recordInsertSharing(List<Attendee__c> triggerNew) {
        List<RecordSharingUtil.RecordSharingDefiniation> newAttShares = new List<recordSharingUtil.RecordSharingDefiniation>();
        String supervisor, hsso, recId;
        // list of new records
        for(Attendee__c attendee: triggerNew) {
            // HSSO field is not null
            if(attendee.HSSO__c != null) {
                hsso = attendee.HSSO__c;
                recId = attendee.Id;
                newAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, hsso, 'Edit', 'HSSO__c'));
            }
            // Supervisor field is not null
            if(attendee.Supervisor__c != null) {
                supervisor = attendee.Supervisor__c;
                recId = attendee.Id;
                newAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, supervisor, 'Edit', 'Supervisor__c'));
            }    
        }
        //insert the apex sharing by using utility
        if(!newAttShares.isEmpty())
            RecordSharingUtil.share(newAttShares);
    }
    
    // process the records when update operation is performed
    public static void recordUpdateSharing(List<Attendee__c> triggerNew, Map<Id, Attendee__c> triggerOldMap) {
        List<RecordSharingUtil.RecordSharingDefiniation> newAttShares = new List<recordSharingUtil.RecordSharingDefiniation>();
        List<RecordSharingUtil.RecordSharingDefiniation> oldAttShares = new List<recordSharingUtil.RecordSharingDefiniation>();
    
        String supervisor, hsso, recId, prevSupervisor, prevHsso;
        // list of updated records
        for(Attendee__c attendee: triggerNew) {
            // HSSO field update
            if(attendee.HSSO__c != null && triggerOldMap.get(attendee.Id).HSSO__c != attendee.HSSO__c) {
                hsso = attendee.HSSO__c;
                recId = attendee.Id;
                newAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, hsso, 'Edit', 'HSSO__c'));
            }
            if(triggerOldMap.get(attendee.Id).HSSO__c != attendee.HSSO__c && 
                triggerOldMap.get(attendee.Id).HSSO__c != null) {
                prevHsso = triggerOldMap.get(attendee.Id).HSSO__c;
                recId = attendee.Id;
                oldAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, prevHsso, 'Edit', 'HSSO__c'));
            }
            //Supervisor field update
            if(attendee.Supervisor__c != null && triggerOldMap.get(attendee.Id).Supervisor__c != attendee.Supervisor__c) {
                supervisor = attendee.Supervisor__c;
                recId = attendee.Id;
                newAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, supervisor, 'Edit', 'Supervisor__c'));
            }
            if(triggerOldMap.get(attendee.Id).Supervisor__c != attendee.Supervisor__c && 
                triggerOldMap.get(attendee.Id).Supervisor__c != null) {
                prevSupervisor = triggerOldMap.get(attendee.Id).Supervisor__c;
                recId = attendee.Id;
                oldAttShares.add(new recordSharingUtil.RecordSharingDefiniation(recId, prevSupervisor, 'Edit', 'Supervisor__c'));
            }
        }
        // insert the apex sharing entries by using utility
        if(!newAttShares.isEmpty())
            RecordSharingUtil.share(newAttShares);
        // delete the apex sharing entries by using utility
        if(!oldAttShares.isEmpty())
            RecordSharingUtil.unshare(oldAttShares);   
    }
    // -- Ver 2.0 -- Added for the apex Record Sharing -- END -- //
       -- Ver 3.0 Comment the code changes made in 2.0 -- END -- */
}