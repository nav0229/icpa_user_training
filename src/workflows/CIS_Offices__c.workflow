<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CIS_Duplicate_Check</fullName>
        <field>Duplicate_PmoAo_Check__c</field>
        <formula>Region__c +  PMO_AO_Number__c</formula>
        <name>CIS Duplicate Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CIS PmoAo Duplicate Check</fullName>
        <actions>
            <name>CIS_Duplicate_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CIS_Offices__c.PMO_AO_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Check that PmoAo Number is not duplicated across regions.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
