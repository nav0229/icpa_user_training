trigger SurveyTrigger on Survey__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        SurveyController.updateOwner(Trigger.New);
    }

}