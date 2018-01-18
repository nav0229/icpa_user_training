/**
 * [SurveyIndividualAnswer Manage Trigger Timings for Helper execution]
 * @author Justin Lyon
 * @date 6/29/2015
 *
 * @param  insert [before insert]
 */
trigger SurveyIndividualAnswerTrigger on SurveyIndividualAnswer__c (before insert) {

	if(Trigger.isBefore && Trigger.isInsert) {
		SurveyIndividualAnswerHelper.relateToQuestions(Trigger.new);
	}
}