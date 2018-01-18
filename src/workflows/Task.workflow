<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Task_email_reminder_field_update</fullName>
        <field>Email_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Task email reminder field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Task email reminder rule</fullName>
        <active>true</active>
        <formula>AND(  NOT(ISBLANK(Email_Reminder_Date__c)), (Email_Reminder_Date__c &gt;= NOW()), NOT(ISPICKVAL(Status, &apos;Completed&apos;)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Task_email_reminder_field_update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Task.Email_Reminder_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
