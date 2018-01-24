<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Time_Stamp_Verified_Date</fullName>
        <description>Action updates the Verified Date with the Date/Time when a Document Line Item record has a Document Status of Valid</description>
        <field>Verified_Date__c</field>
        <formula>NOW()</formula>
        <name>Time Stamp Verified Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Document Status Valid</fullName>
        <actions>
            <name>Time_Stamp_Verified_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Document_Line_Items__c.Document_Status__c</field>
            <operation>equals</operation>
            <value>Valid</value>
        </criteriaItems>
        <description>Workflow time stamps the date/time of whenever a Document Line Item record has Status of Valid</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
