<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Glxy_BudgetReason_ProjectLumpSum_FU</fullName>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <field>Budget_Exclusion_Reason__c</field>
        <name>Glxy_BudgetReason_ProjectLumpSum_FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Glxy_BudgetReason_ProjectLumpSum</fullName>
        <actions>
            <name>Glxy_BudgetReason_ProjectLumpSum_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LPLumpSum__c.BDGFlag__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
