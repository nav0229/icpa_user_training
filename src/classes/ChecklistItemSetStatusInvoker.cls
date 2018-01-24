/****************************************************************
 Name:  ChecklistItemSetStatusInvoker
============================================================
Author: Matt
Purpose: JIRA#1771
This class is to be called by ProcessBuilder to set the checklist 
item status to Pending Borrower's Verification
============================================================

****************************************************************/
public with sharing class ChecklistItemSetStatusInvoker {

	@TestVisible
	private static ChecklistItemDAO checklistDA = new ChecklistItemDataAccessor();

	@TestVisible
	private static CaseDAO caseDA = new CaseDataAccessor();

	@TestVisible
	private static LoanDAO loanDA = new LoanDataAccessor();

	private static final String FINALIZED = 'Finalized';

	@InvocableMethod(label='Set Checklist Item Status' description='Runs method that sets \'Checklist_Item_Status__c\' and \'Case\' to \'Pending Borrower\'s Verification\' and \'Loan__c\' to \'Closing Docs - Verification\'')
	public static void setStatusOfChecklistItem (List<Id> caseIdList) {
		List<Checklist_Item__c> checklistItems;
		List<Case> cases;
		List<Loan__c> loans;
		List<Id> applicationIds = new List<Id>();

        try{
            cases = caseDA.getCasesByCaseIds(caseIdList);
            checklistItems = checklistDA.getChecklistItemsByCaseIds(caseIdList);  
        }catch(QueryException e){
            throw new ChecklistItemSetStatusInvokerException('An error occurred while retrieving Checklist Items and Requests: ' + e.getMessage()); 
        }

        for(Case c : cases) {
        	applicationIds.add(c.Application__c);
        }

        try{
			loans = loanDA.getLoansByApplicationIds(applicationIds); 
        }catch(QueryException e){
            throw new ChecklistItemSetStatusInvokerException('An error occurred while retrieving Loans: ' + e.getMessage()); 
        }

		for(Checklist_Item__c cli: checklistItems) {
			if(cli.Checklist_Item_Status__c != FINALIZED){
				cli.Checklist_Item_Status__c = ChecklistItemDataAccessor.PENDING_BORROWERS_VERIFICATION_STATUS;
			}
		}

		for(Case c: cases) {
			c.Status = ChecklistItemDataAccessor.PENDING_BORROWERS_VERIFICATION_STATUS;
		}

		for(Loan__c loan: loans) {
			loan.Status__c = LoanDataAccessor.CLOSING_DOCS_VERIFICATION_STATUS;
		}
		

		try{
			checklistDA.updateChecklistItems(checklistItems);
			caseDA.updateCases(cases);
			loanDA.updateLoans(loans);
		}catch(DmlException e) {
            throw new ChecklistItemSetStatusInvokerException('Error updating Checklist Items, Requests, and Loans: ' + e.getMessage());
		}	
	}

	public class ChecklistItemSetStatusInvokerException extends Exception {}
}