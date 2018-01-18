<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Region_Match</fullName>
        <field>Region_Check__c</field>
        <formula>TEXT( RegionCd__c )</formula>
        <name>GLXY_Set Region Match</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_ Set Region Value on Allowance</fullName>
        <actions>
            <name>Set_Region_Match</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Used to prevent more the one record per Region</description>
        <formula>ischanged( RegionCd__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
