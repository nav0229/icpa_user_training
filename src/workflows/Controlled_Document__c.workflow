<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CDT_set_Controlled_Document_Date_Close</fullName>
        <description>This sets the Date Closed to today&apos;s date.</description>
        <field>Date_Closed__c</field>
        <formula>today()</formula>
        <name>CDT - set Controlled Document Date Close</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CDT - set Controlled Document Date Closed</fullName>
        <actions>
            <name>CDT_set_Controlled_Document_Date_Close</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Controlled_Document__c.Stage__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>This workflow sets the Date Closed to today when Controlled Document stage = closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
