<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Contract_Stratification_Rating_Tracking</fullName>
        <field>Stratification_Rating_Tracking__c</field>
        <formula>BR()+&apos;Prior  Value:&apos;+PRIORVALUE(Stratification_Value__c)+&apos;&apos;+BR()+  Stratification_Rating_Tracking__c+BR()</formula>
        <name>Contract Stratification Rating Tracking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Mark_Contract_as_Inactive</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Inactive</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>VMO_Mark Contract as Inactive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Unique_PIID_Ref_PIID_Contract</fullName>
        <field>PIID_Ref_Contract__c</field>
        <formula>Name</formula>
        <name>VMO-Unique-PIID+Ref.PIID-Contract</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>VMO Contract Stratification Rating Tracking</fullName>
        <actions>
            <name>Contract_Stratification_Rating_Tracking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contract__c.Stratification_Value__c</field>
            <operation>notEqual</operation>
            <value>PRIORVALUE(Stratification_Value__c)</value>
        </criteriaItems>
        <description>Tracks the Stratification Rating on the Contract object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>VMO Unique ID for Contract</fullName>
        <actions>
            <name>VMO_Unique_PIID_Ref_PIID_Contract</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>The PIID+Ref. PIID field should be unique</description>
        <formula>ISCHANGED( Name ) || NOT(ISCHANGED( Name ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>VMO_Mark Contract as Inactive</fullName>
        <actions>
            <name>VMO_Mark_Contract_as_Inactive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Contract__c.Mark_Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract__c.Award_Type__c</field>
            <operation>notEqual</operation>
            <value>Definitive Contract,IDC,Purchase Order</value>
        </criteriaItems>
        <description>If the Mark Inactive field is populated, or the Award type is not correct, mark the Rec Type as Inactive</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
