<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Default_Processed_Date_RWA</fullName>
        <description>If Processed Date in RWA is NULL, Default to Effective Date</description>
        <field>ProcessedDate__c</field>
        <formula>EffectiveDate__c</formula>
        <name>GLXY_Default Processed Date (RWA)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28RWA%29</fullName>
        <actions>
            <name>Default_Processed_Date_RWA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Processed Date in RWA is NULL, Default to Effective Date</description>
        <formula>ISBLANK(ProcessedDate__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
