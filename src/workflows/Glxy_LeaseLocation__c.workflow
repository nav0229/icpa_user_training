<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_LeaseLocation_KeyVal</fullName>
        <description>Updates the KeyVal field on Lease Location</description>
        <field>Lease_Location_KeyVal__c</field>
        <formula>LeaseNumber__r.LeaseID__c + BuildingNumber__c</formula>
        <name>GLXY_Update LeaseLocation KeyVal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_LeaseLocation Key enforcement</fullName>
        <actions>
            <name>Update_LeaseLocation_KeyVal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LeaseLocation__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Used to update Lease Location KeyVal, Concatenates lease location and Building number.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
