<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>VMO_Mark_Cont_BPA_as_Inactive</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Inactive</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>VMO_Mark Cont/BPA as Inactive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Unique_PIID_BPA</fullName>
        <field>PIID__c</field>
        <formula>Name</formula>
        <name>VMO-Unique-PIID-BPA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VMO_Unique_PIID_Ref_PIID_BPA</fullName>
        <field>PIID_Ref_Contract__c</field>
        <formula>Name &amp; Referenced_Contract__c</formula>
        <name>VMO-Unique-PIID+Ref.PIID-BPA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>VMO Unique for BPA</fullName>
        <actions>
            <name>VMO_Unique_PIID_BPA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>VMO_Unique_PIID_Ref_PIID_BPA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>The PIID+Ref. PIID and PIID fields should be unique</description>
        <formula>ISCHANGED( Name ) || ISCHANGED(Referenced_Contract__c ) || NOT(ISCHANGED( Name )) || NOT(ISCHANGED(Referenced_Contract__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>VMO_Mark BPA Inactive</fullName>
        <actions>
            <name>VMO_Mark_Cont_BPA_as_Inactive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>BPA__c.Mark_Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>BPA__c.Award_Type__c</field>
            <operation>notEqual</operation>
            <value>BPA</value>
        </criteriaItems>
        <description>If the Mark Inactive field is populated, or the Award type is not correct, mark the Rec Type as Inactive</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
