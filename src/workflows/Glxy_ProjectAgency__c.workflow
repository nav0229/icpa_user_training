<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_UpdateFieldOnParentObject</fullName>
        <field>TriggerUpdateField__c</field>
        <formula>Text(NOW())</formula>
        <name>GLXY_UpdateFieldOnParentObject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ProjectNumber__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_TriggerUpdateOnParentObject</fullName>
        <actions>
            <name>GLXY_UpdateFieldOnParentObject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_ProjectAgency__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>DUMMY</value>
        </criteriaItems>
        <description>Update a Field on the parent object (Lease Projects - TriggerUpdateField__c field) which will in turn fire the trigger on the parent object.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
