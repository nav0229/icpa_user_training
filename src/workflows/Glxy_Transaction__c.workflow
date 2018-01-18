<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_ConversionDateLoad</fullName>
        <field>IA_NOA_Conversion_Date__c</field>
        <formula>Digest_IA_NOA_Conversion_date__c</formula>
        <name>GLXY_ConversionDateLoad</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_IASqFTLoad</fullName>
        <field>IA_RSF__c</field>
        <formula>Digest_IA_Sq_Ft__c</formula>
        <name>GLXY_IASqFTLoad</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_Set_EstimagtedIAAmount</fullName>
        <field>EstimatedIAAmount__c</field>
        <formula>Estimated_IA_Amount__c</formula>
        <name>GLXY_Set EstimagtedIAAmount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_IASqFT%26ConversionDateLoad</fullName>
        <actions>
            <name>GLXY_ConversionDateLoad</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>GLXY_IASqFTLoad</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Transaction__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>Glxy_Transaction__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Lease Action</value>
        </criteriaItems>
        <description>Loads Galaxy Transaction IA Sq Ft and IA/NOA Conversion Date with Rollups for Max date and SqFt from Digest Records</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_set estimatedIAAmount</fullName>
        <actions>
            <name>GLXY_Set_EstimagtedIAAmount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>sets rollup summary value on fixed field.</description>
        <formula>ISCHANGED( Estimated_IA_Amount__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
