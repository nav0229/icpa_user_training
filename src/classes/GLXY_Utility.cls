public class GLXY_Utility{
 
    public static boolean isUpdating = false;
    public static boolean isCalcUpdating = false;

    public static boolean hasUpdated() {
        return isUpdating;
    }

    public static void setUpdating() {
        isUpdating = true;
    }

public static boolean hasCalcUpdated() {
        return isCalcUpdating;
    }

    public static void setCalcUpdating() {
        isCalcUpdating = true;
    }
    
    private static testmethod void validatefutureUpdate() {
        
        System.assertEquals(false, isUpdating);
        System.assertEquals(false, isCalcUpdating);

        if(!hasUpdated()) {
            setUpdating();
            System.assertEquals(true, isUpdating);
        }
       
if(!hasCalcUpdated()) {
            setCalcUpdating();
            System.assertEquals(true, isCalcUpdating);
        }     

    }
 
}