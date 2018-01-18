<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Glxy_BudgetSubmissionDataUpdateKey</fullName>
        <field>RecordKey__c</field>
        <formula>BudgetSubmissionID__r.Name +  FiscalYear__c + Text(DataFormat__c)</formula>
        <name>Glxy_BudgetSubmissionDataUpdateKey</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_UpdateTracking</fullName>
        <field>RecordLastModifiedBy__c</field>
        <formula>LastModifiedBy.FirstName + &apos; &apos; +  LastModifiedBy.LastName + &apos; (&apos; +  Text(LastModifiedDate) + &apos;)&apos;</formula>
        <name>Glxy_UpdateTracking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Glxy_BudgetSubmissionDataUpdateRecordKey</fullName>
        <actions>
            <name>Glxy_BudgetSubmissionDataUpdateKey</name>
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
    <rules>
        <fullName>Glxy_LastUpdatedUser</fullName>
        <actions>
            <name>Glxy_UpdateTracking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_BudgetSubmission__c.LastModifiedById</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>The Last user who edited the record ...</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
