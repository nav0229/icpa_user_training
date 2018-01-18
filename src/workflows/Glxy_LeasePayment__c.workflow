<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Withhold_Months_Default</fullName>
        <field>WithHoldMonths__c</field>
        <formula>1</formula>
        <name>Withhold Months Default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Withhold Month Default</fullName>
        <actions>
            <name>Withhold_Months_Default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LeasePayment__c.WithHoldMonths__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Withhold Month Default to &quot;1&quot; when no value is specified</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
