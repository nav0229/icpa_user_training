/*-------------------------------------------------------------------------------------------------*
  Apex class 
  RecursionProcessControl is used for Task object trigger to avoid the recursion updates on a task.
  It can also be used in other application code for avoiding the recursive trigger updates.
 *-------------------------------------------------------------------------------------------------*
  Author           | Date        | Version | Description
 *-------------------------------------------------------------------------------------------------*
  Rajakumar          11/06/2013    1.0       O&M Case # 00009464
 *-------------------------------------------------------------------------------------------------* 
 
 *-------------------------------------------------------------------------------------------------*/
public class RecursionProcessControl {
     public static boolean inFutureContext = false;
}