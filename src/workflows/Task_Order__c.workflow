<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Task_Order_Stratification_Rating_Trackin</fullName>
        <field>Stratification_Rating_Tracking__c</field>
        <formula>BR()+&apos;Prior Value:&apos;+PRIORVALUE(Stratification_Value__c)+&apos;&apos;+BR()+ Stratification_Rating_Tracking__c+BR()</formula>
        <name>Task Order Stratification Rating Trackin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Mark_Task_Order_as_Inactive</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Inactive</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>VMO_Mark Task Order as Inactive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Unique_PIID_Ref_PIID_Task_Order</fullName>
        <field>PIID_Ref_Contract__c</field>
        <formula>Name &amp; Referenced_Contract__c</formula>
        <name>VMO-Unique-PIID+Ref.PIID-Task Order</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>VMO Task Order Stratification Rating Tracking</fullName>
        <actions>
            <name>Task_Order_Stratification_Rating_Trackin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task_Order__c.Stratification_Value__c</field>
            <operation>notEqual</operation>
            <value>PRIORVALUE(Stratification_Value__c)</value>
        </criteriaItems>
        <description>Tracks the Stratification Rating history on Task Orders</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>VMO Unique ID for Task Order</fullName>
        <actions>
            <name>VMO_Unique_PIID_Ref_PIID_Task_Order</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>The PIID+Ref. PIID field should be unique</description>
        <formula>ISCHANGED( Name ) || ISCHANGED(Referenced_Contract__c ) || NOT(ISCHANGED( Name )) || NOT(ISCHANGED(Referenced_Contract__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>VMO_Mark Task Order as Inactive</fullName>
        <actions>
            <name>VMO_Mark_Task_Order_as_Inactive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Task_Order__c.Mark_Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task_Order__c.Award_Type__c</field>
            <operation>notEqual</operation>
            <value>Delivery Order</value>
        </criteriaItems>
        <description>If the Mark Inactive field is populated, or the Award type is not correct, mark the Rec Type as Inactive</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
