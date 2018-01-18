<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PMT_Change_Indicator_Record_Type</fullName>
        <description>Changes Indicator to Read Only</description>
        <field>RecordTypeId</field>
        <lookupValue>Perf_Indicator_Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PMT Change Indicator Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PMT_Perf_Indicator_Dup_Field_Update</fullName>
        <field>Perf_Indicator_Duplicate_Hidden__c</field>
        <formula>Name</formula>
        <name>PMT Perf Indicator Dup Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Perf_Indicator_back_to_default</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Performance_Indicator_Default</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Perf Indicator back to default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PMT Change Indicator Back To Default</fullName>
        <actions>
            <name>Perf_Indicator_back_to_default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Performance_Indicator__c.Publish__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Changes the record type to Default once the &quot;Publish&quot; field is Unchecked</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PMT Change Indicator Record Type</fullName>
        <actions>
            <name>PMT_Change_Indicator_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Performance_Indicator__c.Publish__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Changes the record type to Read only once the &quot;Publish&quot; field is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PMT Performance Indicator Duplicate</fullName>
        <actions>
            <name>PMT_Perf_Indicator_Dup_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Prevent the duplicate performance indicator</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
