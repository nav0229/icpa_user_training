<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_Set_Lease_Accrual_Keyval</fullName>
        <field>PDNKey__c</field>
        <formula>Accrual_PDN_Key__c</formula>
        <name>GLXY_Set Lease Accrual Keyval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Set Lease Accrual Key val</fullName>
        <actions>
            <name>GLXY_Set_Lease_Accrual_Keyval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LeaseAccrual__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Helps prevent use of duplicate PBN on lease accruals</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
