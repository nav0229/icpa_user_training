<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Loan_Condition_Name</fullName>
        <description>Update Loan condition name with the loan name</description>
        <field>Name</field>
        <formula>Master_Checklist__r.Name</formula>
        <name>Update Loan Condition Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Loan Condition Name</fullName>
        <actions>
            <name>Update_Loan_Condition_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Loan_Condition_Checklist__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update Loan Condition Name to be the master list name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
