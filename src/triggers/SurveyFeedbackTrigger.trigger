/**
 * [SurveyFeedback__c Manage Trigger Timings for Helper execution]
 * @author Justin Lyon
 * @date 6/29/2015
 *
 * @param  insert [before insert]
 */
trigger SurveyFeedbackTrigger on SurveyFeedback__c (before insert) {
	if(Trigger.isBefore && Trigger.isInsert) {
		SurveyFeedbackHelper.setOwner(Trigger.new);
	}
}