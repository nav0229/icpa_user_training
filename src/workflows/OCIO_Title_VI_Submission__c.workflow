<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Preparation_Date</fullName>
        <field>OCR_Preparation_Date__c</field>
        <formula>TODAY()</formula>
        <name>Populate Preparation Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Submission_Date</fullName>
        <field>OCR_Submission_Date__c</field>
        <formula>TODAY()</formula>
        <name>Populate Submission Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>OCR Title VI Populate Preparation Date</fullName>
        <actions>
            <name>Populate_Preparation_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Title_VI_Submission__c.OCR_Preparation_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Title_VI_Submission__c.OCR_Submission_Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>This workflow will populate the &quot;Preparation Date&quot; on Title VI Submissions when the submission is saved into the &quot;Draft&quot; status for the first time.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OCR Title VI Populate Submission Date</fullName>
        <actions>
            <name>Populate_Submission_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Title_VI_Submission__c.OCR_Submission_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Title_VI_Submission__c.OCR_Submission_Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>This workflow will populate the &quot;Submission Date&quot; on Title VI Submissions when the submission is saved into the &quot;Submitted&quot; status for the first time.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
