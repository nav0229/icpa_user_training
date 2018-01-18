/**
 * SurveyIndividualAnswerHelper.cls
 * @author  Justin Lyon
 * @date 6/29/2015
 *
 * Manage methods and logic for the SurveyIndividualAnswerTrigger.trigger.
 */
public with sharing class SurveyIndividualAnswerHelper {

	/**
	 * [relateToQuestions create relationship from Answer to Question
	 * 		by Survey Master Id and Question Name (Number).
	 * @param newAnswers [Trigger.new]
	 */
	public static void relateToQuestions(List<SurveyIndividualAnswer__c> newAnswers) {
		Set<Id> surveyIds = new Set<Id>();
		Set<String> questionNumbers = new Set<String>();

		for(SurveyIndividualAnswer__c a : newAnswers) {
			surveyIds.add(a.Survey2__c);
			questionNumbers.add(a.Question_Number__c);
		}

		// Map Questions to SurveyId and Question Name (Number)
		Map<String, SurveyIndividualQuestion__c> questionMap = new Map<String, SurveyIndividualQuestion__c>();
		for(SurveyIndividualQuestion__c q : [
				SELECT Name, Survey2__c
				FROM SurveyIndividualQuestion__c
				WHERE Survey2__c IN :surveyIds AND Name IN :questionNumbers]) {

			questionMap.put(
				((String)q.Survey2__c).substring(0,15) + q.Name, q);
		}

		// Relate Answer to Question
		for(SurveyIndividualAnswer__c a : newAnswers) {
			a.SurveyIndividualQuestion__c = questionMap.get(a.Survey2__c + a.Question_Number__c).Id;
		}
	}
}