<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Default_Processed_Date_IBAA</fullName>
        <description>If Processed Date in IBAA is NULL, Default to Effective Date</description>
        <field>ProcessedDate__c</field>
        <formula>EffectiveDate__c</formula>
        <name>GLXY_Default Processed Date (IBAA)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_set_authorized_amount</fullName>
        <description>Sets authorized Amount on IBAA for edit</description>
        <field>AuthorizedAmount__c</field>
        <formula>TotalMonthlyAmount_Calc__c</formula>
        <name>GLXY_set authorized amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28IBAA%29</fullName>
        <actions>
            <name>Default_Processed_Date_IBAA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Processed Date in IBAA is NULL, Default to Effective Date</description>
        <formula>ISBLANK(ProcessedDate__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_set authorized amount</fullName>
        <actions>
            <name>GLXY_set_authorized_amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>sets the authorized amount value based on updates made to monthly impact</description>
        <formula>AND(ISCHANGED( TotalMonthlyAmount_Calc__c ), LastModifiedDate &gt; CreatedDate )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
