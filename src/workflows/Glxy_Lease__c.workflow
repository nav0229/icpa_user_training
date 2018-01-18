<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_CalculateTotalNOASqFt</fullName>
        <description>Lease - Total NOA Sq. Ft - Base Sq.. ft - Total IA Sq. ft</description>
        <field>Total_NOA_Sq_feet__c</field>
        <formula>BaseSquareFeet__c - Total_IA_Sq_feet__c</formula>
        <name>GLXY_CalculateTotalNOASqFt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_LeaseIAConversionDate</fullName>
        <field>IAConverstionDate__c</field>
        <formula>Date(if( month(TODAY())&lt;=10,year(TODAY()),year(TODAY())+1), 10, 1)</formula>
        <name>GLXY_LeaseIAConversionDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LeaseUpdateIAPercentage</fullName>
        <field>IAPercentage__c</field>
        <formula>(Total_IA_Sq_feet__c/BaseSquareFeet__c)</formula>
        <name>Lease Update IA Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_CalculateTotalNOASqFt</fullName>
        <actions>
            <name>GLXY_CalculateTotalNOASqFt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Lease__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Lease Total NOA Sq Ft = Difference (Total Sq. Ft. - Total IA Sq. ft. )</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_LeaseIAConversionDate</fullName>
        <actions>
            <name>GLXY_LeaseIAConversionDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes values of IA Converstion Date based on change on IA SqFt.</description>
        <formula>AND(ISBLANK( IAConverstionDate__c ), (Total_IA_Sq_feet__c &lt;&gt; 0))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lease Update IA Percentage</fullName>
        <actions>
            <name>LeaseUpdateIAPercentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Lease__c.BaseSquareFeet__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Glxy_Lease__c.BaseSquareFeet__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
