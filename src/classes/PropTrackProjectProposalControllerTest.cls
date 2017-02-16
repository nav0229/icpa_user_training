@isTest
public class PropTrackProjectProposalControllerTest {
    static testMethod void testReturnsCorrectURL () {
        PropTrackProjectProposalController c = new PropTrackProjectProposalController();
        String expectedURL = Site.getBaseURL()+'/PropTrackProjectProposalConfirmation';
        String actualURL = c.getRetUrl();        
        System.assertEquals(expectedURL, actualURL);
    }
    
    static testMethod void testChecksSandbox () {
        PropTrackProjectProposalController c = new PropTrackProjectProposalController();
        System.assertEquals(c.isSandbox(),[SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox);
    }
}