<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Review_Completion_Date</fullName>
        <field>OCR_Review_Completion_Date__c</field>
        <formula>Today()</formula>
        <name>Populate Review Completion Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>OCR Title VI Populate Review Completion Date</fullName>
        <actions>
            <name>Populate_Review_Completion_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Title_VI_Review__c.OCR_Review_Completion_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Title_VI_Review__c.OCR_REVIEW_RESULTS__c</field>
            <operation>equals</operation>
            <value>Compliant</value>
        </criteriaItems>
        <description>This workflow will populate the &quot;Review Completion Date&quot; on Title VI Reviews when the review is saved into the &quot;Compliant&quot; status for the first time.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
