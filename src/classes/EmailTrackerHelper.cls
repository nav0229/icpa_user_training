/*-------------------------------------------------------------------------------------------------*
  Apex class
  Helper class for EmailTracker__c object apex trigger - Contact Manager VOE Surveys
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          08/14/2015    1.0       Initial version.
   GaneshKumar Mandava    08/24/2017     Removed unwanted code
 *-------------------------------------------------------------------------------------------------*
 *-------------------------------------------------------------------------------------------------*/
public class EmailTrackerHelper {
    // begin
    /* before insert -
        FOR EACH record, find related User by ToContact.FederatedID.
        THEN Set the Owner to the User.
     */
    public static void onBeforeInsert(List<EmailTracker__c> triggerNew) {
        // gathering the tocontact ids
        Set<Id> contactIds = new Set<Id>();
        for(EmailTracker__c et : triggerNew) {
            contactIds.add(et.ToContact__c);
        }

        Map<String, Contact> fedIdToContactMap = new Map<String, Contact>();
        Map<String, User> fedIdToUserMap = new Map<String, User>();
        // extract the respective contacts, create the map ( fedid, contact)
        for(Contact c : [SELECT Id, Contact_Federated_ID__c FROM Contact WHERE Id IN :contactIds]) {
            if(c.Contact_Federated_ID__c != null) {
                fedIdToContactMap.put(c.Contact_Federated_ID__c, c);
            }
        }

        // extract the respective standard users of the contacts, create the map ( fedid, user)
        for(User u : [SELECT Id, FederationIdentifier, UserType FROM User WHERE FederationIdentifier IN :fedIdToContactMap.keySet()
                        AND IsActive = true AND Email != null AND UserType='Standard']) {
            fedIdToUserMap.put(u.FederationIdentifier, u);
        }

        // Create the temporaty map of contact to user
        Map<Id, User> contactIdToUserMap = new Map<Id, User>();
        for(Contact c : fedIdToContactMap.values()) {
            if(fedIdToUserMap.containsKey(c.Contact_Federated_ID__c)) {
                contactIdToUserMap.put(c.Id, fedIdToUserMap.get(c.Contact_Federated_ID__c));
            }
        }

        // for each To_contact, change Email Tracker's Owner to respective user of the contact.
        if(!contactIdToUserMap.isEmpty()) {
            for(EmailTracker__c et : triggerNew) {
                if(contactIdToUserMap.containsKey(et.ToContact__c)) {
                    et.OwnerId = contactIdToUserMap.get(et.ToContact__c).Id;
                }
            }
        }
    }
}