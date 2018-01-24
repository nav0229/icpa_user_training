/****************************************************************
 Name: LossVerificationDAO
============================================================
Author: 
Purpose: Data Access Object for Loss_Verification_Inspections__c
============================================================

****************************************************************/

public interface LossVerificationDAO {
    List<Loss_Verification_Inspections__c> getLossVerificationsByLoanIds(Set<Id> loanIds);
    List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationId(ID applicationId);
    List<Loss_Verification_Inspections__c> getLossVerificationsByApplicationIds(Set<Id> applicationIds); 
    List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationId(Id applicationId);
    List<Loss_Verification_Inspections__c> getLossVerificationsAndRelatedUPCodesByApplicationIds(List<Id> applicationIds);
}