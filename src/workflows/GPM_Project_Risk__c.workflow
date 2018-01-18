<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Probability</fullName>
        <field>Probability__c</field>
        <name>Update Probability</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PC Risk Update Probability</fullName>
        <actions>
            <name>Update_Probability</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GPM_Project_Risk__c.Risk_or_Issue__c</field>
            <operation>equals</operation>
            <value>Issue</value>
        </criteriaItems>
        <description>Probability should be set to None when the Risk type is Issue</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
