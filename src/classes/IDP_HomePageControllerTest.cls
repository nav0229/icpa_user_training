@isTest
public class IDP_HomePageControllerTest{

	static testMethod void testController(){

		IDP_HomePageController newController = new IDP_HomePageController();
		newController.createIDP();
		System.assert(newController != null);

	}

}