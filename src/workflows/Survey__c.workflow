<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Employee_Email_SurveyUpdate_Rating_Field</fullName>
        <field>Rating__c</field>
        <formula>VALUE(LEFT( Answer_1__c , 1))</formula>
        <name>Employee Email SurveyUpdate Rating Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Employee Email Survey Update Rating Field</fullName>
        <actions>
            <name>Employee_Email_SurveyUpdate_Rating_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Survey__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employee Email Survey</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
