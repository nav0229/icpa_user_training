public with sharing class PropTrackProjectProposalController {
  public String orgID {get; set;}
    public String retURL {get; set;}
    public String wtlURL {get; set;}
    
    public PropTrackProjectProposalController (){
        orgID = UserInfo.getOrganizationId();
        retURL = getRetUrl();
        wtlURL = getWebToLeadURL();
    }
    
    public String getRetUrl () {
    return (Site.getBaseURL() + '/PropTrackProjectProposalConfirmation');
    }
    
    private String getWebToLeadURL() {
        String instance = isSandbox() ? 'test' : 'www';
        return ('https://' + instance + '.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8');
    } 
    
    public Boolean isSandbox() {
      return [SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox;
  }
}