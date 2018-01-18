/*-------------------------------------------------------------------------------------------------*
  Apex class for Approval Step Trigger recursive prevention
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*  
  Raja Kumar P       03/10/2016    1.0       Prevent the recursion for case# 22417 (Unable to initiate more than 5 approval steps at the same time) 
 *-------------------------------------------------------------------------------------------------*/
public class ApprovalStepCheckRecursive{
    // flag to identify the execution i.e first time or second time.
    private static Boolean alreadyUpdated = false;
    // method to return the flag value
    public static Boolean hasAlreadyUpdated(){
        return alreadyUpdated;
    }
    // method to set the flag to true
    public static void setAlreadyUpdated(){
        alreadyUpdated = true;
    }    
}