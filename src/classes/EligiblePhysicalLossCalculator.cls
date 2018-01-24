/****************************************************************
 Name:  EligiblePhysicalLossCalculator
============================================================
Author: Matt
Purpose: JIRA#1711
Responsible for calculating the Eligible Physical Loss for home loans
on the Processing Application Review object
============================================================

****************************************************************/

public with sharing class EligiblePhysicalLossCalculator {
    private Decimal LANDSCAPING_LIMIT = 5000;
    private Decimal REAL_ESTATE_LIMIT = 200000;
    private Decimal ADMIN_LIMIT_FOR_CONTENTS_AND_MOTOR_VIHICLES = 40000;

    @TestVisible private static ApplicationDAO applicationDA = new ApplicationDataAccessor();

    @TestVisible private static MapCreator mapCreatorTool = new MapCreator();

    

    public EligiblePhysicalLossCalculator() {}

    public void calculateEligiblePhysicalLoss(List<Processing_Application_Review__c> processingAppReviewList) {
        Map<Id, Application__c> parIdApplicationMap = new Map<Id, Application__c>();
        Map<Id, List<Loss_Verification_Inspections__c>> parIdLossVerificationMap = new Map<Id, List<Loss_Verification_Inspections__c>>();
        Map<Id, List<Other_Assistance__c>> parIdOtherAssistanceMap = new Map<Id, List<Other_Assistance__c>>();
        Map<Id, List<Insurance__c>> parIdInsuranceMap = new Map<Id, List<Insurance__c>>();
        List<Application__c> applicationsToUpdate = new List<Application__c>();


        parIdApplicationMap = mapCreatorTool.createPARIdApplicationMap(processingAppReviewList);
        parIdLossVerificationMap = mapCreatorTool.createPARIdLossVerificationMap(processingAppReviewList);
        parIdOtherAssistanceMap = mapCreatorTool.createPARIdOtherAssistanceMap(processingAppReviewList);
        parIdInsuranceMap = mapCreatorTool.createPARIdInsuranceMap(processingAppReviewList);
     
        for(Processing_Application_Review__c par: processingAppReviewList){

           par = calculateEligiblePhysicalLossForApplication(
                par,
                parIdLossVerificationMap.get(par.Id), 
                parIdOtherAssistanceMap.get(par.Id), 
                parIdInsuranceMap.get(par.Id) 
            );

           par.Total_Real_Estate_Other__c = lossVerificationFieldTotaler(parIdLossVerificationMap.get(par.Id), 'Real_Estate_Other__c');
           par.Total_Real_Estate_Repair_Replace__c = lossVerificationFieldTotaler(parIdLossVerificationMap.get(par.Id), 'Real_Estate_Repair_Replace__c');

           parIdApplicationMap.get(par.Id).Total_Eligible_Physical_Loss__c = par.Total_Eligible_Physical_Loss__c;
           applicationsToUpdate.add(parIdApplicationMap.get(par.Id));
        }

        try{
            applicationDA.updateApplications(applicationsToUpdate);
        }catch(DmlException e){
            throw new EligiblePhysicalLossCalculatorException('An error occurred while updating Applications: '+ e.getMessage()); 
        }
        
    }

    public Processing_Application_Review__c calculateEligiblePhysicalLossForApplication(Processing_Application_Review__c processingAppReview,
                                                             List<Loss_Verification_Inspections__c> lossVerificationList,
                                                             List<Other_Assistance__c> otherAssistanceList,
                                                             List<Insurance__c> insuranceList){

        Decimal verifiedMotorVehicleLoss = lossVerificationFieldTotaler(lossVerificationList, 'Motor_Vehicle_Verified_Loss__c');
        Decimal verifiedRealEstateLoss =  lossVerificationFieldTotaler(lossVerificationList, 'Real_Estate_Verified_Loss__c');
        Decimal verifiedContentsLoss = lossVerificationFieldTotaler(lossVerificationList, 'Contents_Verified_Loss__c');
        Decimal verifiedLandscapeLoss =  lossVerificationFieldTotaler(lossVerificationList, 'Verified_Loss_for_Landscape__c');

        Decimal totalReimbursementAuto = insuranceFieldTotaler(insuranceList, 'Insurance_Reimbursement_for_Auto__c');
        Decimal totalReimbursementContents = insuranceFieldTotaler(insuranceList, 'Insurance_Reimbursement_for_Contents__c');
        Decimal totalReimbursementRealEstate = insuranceFieldTotaler(insuranceList, 'Insurance_Reimbursement_for_Real_Estate__c');

        Decimal totalRealEstateGrant = otherAssistanceFieldTotaler(otherAssistanceList, 'Real_Estate_Grant__c');
        Decimal totalContentsGrant = otherAssistanceFieldTotaler(otherAssistanceList, 'Contents_Grant__c');
        Decimal totalFEMAforRealEstate = otherAssistanceFieldTotaler(otherAssistanceList, 'Total_FEMA_amount_for_Real_Estate__c');

        processingAppReview.Total_Motor_Vehicle_Uncompensated_Loss__c = verifiedMotorVehicleLoss - totalReimbursementAuto;
        processingAppReview.Total_Real_Estate_Uncompensated_Loss__c = verifiedRealEstateLoss - (totalRealEstateGrant + totalFEMAforRealEstate + totalReimbursementRealEstate);
        processingAppReview.Total_Contents_Uncompensated_Loss__c = verifiedContentsLoss - (totalContentsGrant + totalReimbursementContents);
        processingAppReview.Total_Uncompensated_Physical_Loss__c = processingAppReview.Total_Motor_Vehicle_Uncompensated_Loss__c +
            processingAppReview.Total_Real_Estate_Uncompensated_Loss__c + processingAppReview.Total_Contents_Uncompensated_Loss__c;

        Decimal overAdminLimitContentsMotor = calculateOverLimit(ADMIN_LIMIT_FOR_CONTENTS_AND_MOTOR_VIHICLES, (processingAppReview.Total_Motor_Vehicle_Uncompensated_Loss__c +
            processingAppReview.Total_Contents_Uncompensated_Loss__c));
        Decimal overAdminLimitRealEstate = calculateOverLimit(REAL_ESTATE_LIMIT, processingAppReview.Total_Real_Estate_Uncompensated_Loss__c);
        Decimal overLandscapeLimitRealEstate = calculateOverLimit(LANDSCAPING_LIMIT, verifiedLandscapeLoss);

        processingAppReview.Total_Eligible_Physical_Loss_Cont_Motor__c = (processingAppReview.Total_Contents_Uncompensated_Loss__c + 
            processingAppReview.Total_Motor_Vehicle_Uncompensated_Loss__c ) - overAdminLimitContentsMotor;

        processingAppReview.Total_Eligible_Physical_Loss_Real_Estate__c = processingAppReview.Total_Real_Estate_Uncompensated_Loss__c - 
            (overLandscapeLimitRealEstate + overAdminLimitRealEstate);

        processingAppReview.Total_Eligible_Physical_Loss__c = processingAppReview.Total_Eligible_Physical_Loss_Cont_Motor__c + 
            processingAppReview.Total_Eligible_Physical_Loss_Real_Estate__c;

        return processingAppReview;
        
    }

    private Decimal lossVerificationFieldTotaler(List<Loss_Verification_Inspections__c> objectList, String fieldAPIName) {
        Decimal total = 0;

        for(Loss_Verification_Inspections__c lvi : objectList) {
            if(lvi.get(fieldAPIName) != null) {
                total = total + (Decimal)lvi.get(fieldAPIName);
            }
        }
        return total;
    }

    private Decimal otherAssistanceFieldTotaler(List<Other_Assistance__c> objectList, String fieldAPIName) {
        Decimal total = 0;

        for(Other_Assistance__c oa : objectList) {
            if(oa.get(fieldAPIName) != null) {
                total += (Decimal)oa.get(fieldAPIName);
            }
        }
        return total;
    }

    private Decimal insuranceFieldTotaler(List<Insurance__c> objectList, String fieldAPIName) {
        Decimal total = 0;

        for(Insurance__c ins : objectList) {
            if(ins.get(fieldAPIName) != null) {
                total += (Decimal)ins.get(fieldAPIName);
            }
        }
        return total;
    }

    private Decimal calculateOverLimit(Decimal givenLimit, Decimal amount) {
        if (amount != null) {
            if (amount > givenLimit) {
            return (amount - givenLimit);
            }
        }
        return 0;
    }
    
    public class EligiblePhysicalLossCalculatorException extends Exception {}
}