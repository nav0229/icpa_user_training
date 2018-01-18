<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_Lease_Asa_KeyVal</fullName>
        <field>Lease_Asa_KeyVal__c</field>
        <formula>LeaseNumber__r.LeaseID__c   +  ASA__c</formula>
        <name>GLXY_Lease Asa KeyVal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TriggerUpdateFieldLease</fullName>
        <description>This is a dummy field that we will use to fire the trigger on this (parent) object when a child (e.g. Lease Agency) record is updated.</description>
        <field>TriggerUpdateField__c</field>
        <formula>Text(NOW())</formula>
        <name>Trigger Update Field Lease</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>LeaseNumber__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Lease Asa KeyVal</fullName>
        <actions>
            <name>GLXY_Lease_Asa_KeyVal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Lease__c.CreatedDate</field>
            <operation>greaterOrEqual</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_TriggerUpdateOnParentObjectLease</fullName>
        <actions>
            <name>TriggerUpdateFieldLease</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LeaseAgencies__c.CreatedById</field>
            <operation>notEqual</operation>
            <value>DUMMY</value>
        </criteriaItems>
        <description>Update a Field on the parent object (Lease - TriggerUpdateField__c field) which will in turn fire the trigger on the parent object.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
