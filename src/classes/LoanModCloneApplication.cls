public class LoanModCloneApplication {

    @InvocableMethod
    public static void cloneApplicationSystem(List<Id> applicationIds){
        System.debug('In cloneApplicationSystem');
        DeepCloneHelper.clone(applicationIds[0]);
        
    }
    private void cloneApplication(Id applicationId){
        
    }
}