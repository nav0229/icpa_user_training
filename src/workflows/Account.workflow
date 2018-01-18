<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>VMO_Update_Stratification_Value_Field</fullName>
        <field>Stratification_Value__c</field>
        <formula>TEXT (Stratification_Value_Override__c)</formula>
        <name>VMO_Update Stratification Value Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>VMO_StratificationValueOverride</fullName>
        <actions>
            <name>VMO_Update_Stratification_Value_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Stratification_Value_Override__c</field>
            <operation>contains</operation>
            <value>Standard,Strategic,Critical,Sustaining</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Vendor</value>
        </criteriaItems>
        <description>Overrides the value in the Stratification Value field if the Stratification Value Override field has a value.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
