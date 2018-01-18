public class GLXY_clsHelpPageDetails{
public string redirectURL{get;set;}
    public pageReference load() {
        redirectURL = GalaxyHelpContentInGoogleSite__c.getValues('Galaxy Help Site').Galaxy_Help_for_this_Page__c;
        system.debug('redirectURL=='+redirectURL);
        PageReference pageRef = new PageReference(redirectURL );
        return pageRef ;

    }
}