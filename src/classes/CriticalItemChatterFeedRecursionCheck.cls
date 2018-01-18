/*
  CriticalItemChatterFeedRecursionCheck.cls
  Class for avoiding the recursion while updating FeedItem or FeedComment object thru trigger.
  -------------------------------------------------------------------------------
  Author                 Date        Version  Description
  -------------------------------------------------------------------------------
  Rajakumar              04/30/2014  1.0      Creation - Task #00012362
  
*/
public class CriticalItemChatterFeedRecursionCheck {
    //Variable to track the recursion in a transaction
    private static boolean alreadyInserted = false;
    
    //Method to return the flag value
    public static boolean hasAlreadyInserted(){
        return alreadyInserted;
    }
    
    //Method to set the flag to true
    public static void setAlreadyInserted(){
        alreadyInserted = true;
    }
}