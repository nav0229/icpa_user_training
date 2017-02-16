<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Contains_Error_Update</fullName>
        <description>This workflow action updates the &quot;Contains Error?&quot; field on the Staging object to a value &quot;true&quot; ;when the</description>
        <field>Contains_Error__c</field>
        <literalValue>1</literalValue>
        <name>Contains Error Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Error Check_Staging Object</fullName>
        <actions>
            <name>Contains_Error_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Staging_Record__c.Error__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This rule checks if the Error field on the Staging object contains any character. If it does, it updates the &quot;Contains Error?&quot; checkbox field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
