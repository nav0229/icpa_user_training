<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Glxy_BudgetSubmissionUpdateKey</fullName>
        <field>RecordKey__c</field>
        <formula>ReportingFiscalYear__c +  TEXT(SubmissionType__c) +  TEXT(RegionCD__c)</formula>
        <name>Glxy_BudgetSubmissionUpdateKey</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Glxy_BudgetSubmissionUpdateRecordKey</fullName>
        <actions>
            <name>Glxy_BudgetSubmissionUpdateKey</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_BudgetSubmission__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Update the Record Key on the object</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
