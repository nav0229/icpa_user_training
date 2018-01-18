<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>TSS_Survey_building_LCP_field_update</fullName>
        <field>Building_LCP__c</field>
        <formula>TEXT(TSS_Result_Action_Plan__r.Fiscal_Year__c) &amp; &apos; &apos; &amp; TSS_Result_Action_Plan__r.Location_Code_Plus__c &amp; &apos; &apos; &amp; TSS_Result_Action_Plan__r.Building_Name__c</formula>
        <name>TSS Survey building LCP field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Survey_name_field_update</fullName>
        <field>Name</field>
        <formula>ResponseId__c</formula>
        <name>TSS Survey name field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>TSS Survey name rule to external ResponseId</fullName>
        <actions>
            <name>TSS_Survey_building_LCP_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>TSS_Survey_name_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the TSS Survey name to external ResponseId</description>
        <formula>NOT(ISBLANK(ResponseId__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
