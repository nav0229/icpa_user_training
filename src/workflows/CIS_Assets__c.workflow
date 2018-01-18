<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CIS_Add_Reporting_Region</fullName>
        <description>When a record is created, fill in the Reporting Region field.</description>
        <field>Reporting_Region__c</field>
        <formula>CIS_Office__r.Region__c</formula>
        <name>CIS Add Reporting Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Clear_Excess_Date_field</fullName>
        <description>Clear the Excess Date field.</description>
        <field>Excess_Date__c</field>
        <formula>Null</formula>
        <name>CIS Clear Excess Date field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Excess_Date</fullName>
        <description>Update CIS Excess Date when moving this asset to Excess.</description>
        <field>Excess_Date__c</field>
        <formula>Today()</formula>
        <name>CIS Update Excess Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Present_Office_Recieved</fullName>
        <description>When the office is changed, update &quot;Date Present Office Received&quot; to be today&apos;s date</description>
        <field>Date_Present_Office_Received__c</field>
        <formula>TODAY()</formula>
        <name>CIS Update Present Office Recieved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Prev_Senator_Name</fullName>
        <description>Update the field &quot;removed from Senator&quot; with the prior value of the Member of Congress&apos; name</description>
        <field>Removed_from_Senator__c</field>
        <formula>PRIORVALUE( Member_of_Congress__c )</formula>
        <name>CIS Update Prev Senator Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Previous_CIS_Office_field</fullName>
        <description>Update the field &quot;Removed from CIS Office&quot; with the previous value of &quot;Current CIS Office&quot;</description>
        <field>Removed_From_PMO_AO__c</field>
        <formula>PRIORVALUE( Current_CIS_Office__c )</formula>
        <name>CIS Update Previous CIS Office field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Reporting_Region</fullName>
        <description>Update the reporting region when an item is moved. If it&apos;s in Storage 77ZA or Excess 66AA then use originating region.</description>
        <field>Reporting_Region__c</field>
        <formula>CASE( CIS_Office__r.PMO_AO_Number__c, &quot;66AA&quot;, PRIORVALUE(Region__c), &quot;77ZA&quot;, PRIORVALUE(Region__c), &quot;EXCS&quot;, PRIORVALUE(Region__c), Region__c)</formula>
        <name>CIS Update Reporting Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_Update_Storage_Date</fullName>
        <description>Update the Storage Date when an item is moved to storage location.</description>
        <field>Storage_Date__c</field>
        <formula>Today()</formula>
        <name>CIS Update Storage Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CIS_clear_Storage_Date_field</fullName>
        <description>When an Asset is moved from Storage back to an office, clear the storage date field.</description>
        <field>Storage_Date__c</field>
        <formula>Null</formula>
        <name>CIS clear Storage Date field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CIS Asset Clear Storage Excess</fullName>
        <actions>
            <name>CIS_Clear_Excess_Date_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIS_clear_Storage_Date_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When PmoAo Office is changed from Storage or Excess to somewhere else, clear the storage and excess date fields.</description>
        <formula>OR(PRIORVALUE( Current_CIS_Office__c ) = &quot;77ZA&quot;,        PRIORVALUE(Current_CIS_Office__c) = &apos;EXCS&apos;,         PRIORVALUE(Current_CIS_Office__c) = &apos;66AA&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CIS Asset Update Excess Date</fullName>
        <actions>
            <name>CIS_Update_Excess_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When PmoAo Office is changed to Excess, update the Excess Date field</description>
        <formula>AND (   OR (CIS_Office__r.PMO_AO_Number__c  = &apos;EXCS&apos;, CIS_Office__r.PMO_AO_Number__c  = &apos;66AA&apos;),   ISCHANGED( CIS_Office__c )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CIS Asset Update Prev Office</fullName>
        <actions>
            <name>CIS_Update_Present_Office_Recieved</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIS_Update_Prev_Senator_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIS_Update_Previous_CIS_Office_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CIS_Update_Reporting_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When PmoAo Office is changed, update the previous Senator&apos;s name and previous PmoAo, Reporting Region fields.</description>
        <formula>ISCHANGED(  CIS_Office__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CIS Assets Update Storage Date</fullName>
        <actions>
            <name>CIS_Update_Storage_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When an asset is moved into PmoAo Office Storage, update the Storage Date field</description>
        <formula>CIS_Office__r.PMO_AO_Number__c = &quot;77ZA&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CIS Update Region when Adding Asset</fullName>
        <actions>
            <name>CIS_Add_Reporting_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update the Reporting Region field when adding an asset.</description>
        <formula>NOT(ISNULL( CIS_Office__r.Region__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
