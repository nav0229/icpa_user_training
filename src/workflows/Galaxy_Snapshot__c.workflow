<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Galaxy_Update_Snapshot_Message</fullName>
        <field>StatusMessage__c</field>
        <formula>&quot;A request for snapshot has been created. The scheduled job will run on the date specified at 11:00 PM EST. For more information, please contact your system Administrator.&quot;</formula>
        <name>Galaxy - Update Snapshot Message</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Galaxy - Update Snapshot Message</fullName>
        <actions>
            <name>Galaxy_Update_Snapshot_Message</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Galaxy_Snapshot__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Update the message when a snapshot has been configured ...</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
