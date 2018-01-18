<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>VOE_Survey_Feedback_SurveyName_Field_Upd</fullName>
        <field>Survey_Name__c</field>
        <formula>Survey2__r.Name</formula>
        <name>VOE-Survey Feedback-SurveyName Field Upd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>VOE-Survey Feedback_Populate_SurveyName_Rule</fullName>
        <actions>
            <name>VOE_Survey_Feedback_SurveyName_Field_Upd</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>It will update the survey name field of survey feedback record</description>
        <formula>IF(OR(ISNEW(),ISCHANGED(Survey2__c)), NOT(ISBLANK(Survey2__c)), false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
