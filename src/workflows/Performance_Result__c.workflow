<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Duplicat_FY_Report</fullName>
        <field>Fiscal_Year_dupe_check__c</field>
        <formula>FY_Formula__c   +   Performance_Measure__r.Name</formula>
        <name>Duplicat FY Report</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PMT_Change_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Performance_Results_Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PMT Change Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PMT_Change_Result_to_Default</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Performance_Result_Default</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PMT Change Result to Default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PMT Duplicat FY Report</fullName>
        <actions>
            <name>Duplicat_FY_Report</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Performance_Result__c.Fiscal_Year__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PMT Performance Results Change Back To Default</fullName>
        <actions>
            <name>PMT_Change_Result_to_Default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Performance_Result__c.Lock_Q4_Actuals__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Changes back to Default</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PMT Performance Results Read Only</fullName>
        <actions>
            <name>PMT_Change_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Performance_Result__c.Lock_Q4_Actuals__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Will lock Record when the Q4 Actual lock button is selcted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
