/*
  OCMRecursionCheck.cls
  Class for avoiding the recursion while updating OCM Comms_Marketing_Service__c object thru trigger.
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Rajakumar              07/04/2014  1.0      Creation
  
  -------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
*/
public class OCMRecursionCheck {
    //Variable to track the recursion in a transaction
    private static boolean alreadyUpdated = false;
    //Method to return the flag value
    public static boolean hasAlreadyUpdated(){
        return alreadyUpdated;
    }
    //Method to set the flag to true
    public static void setAlreadyUpdated(){
        alreadyUpdated = true;
    }
}