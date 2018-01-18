<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_Set_keval_on_assoc_lease_trans</fullName>
        <description>Sets the external key val Associated Lease Transaction</description>
        <field>AssociatedLeaseTxnId__c</field>
        <formula>Galaxy_Transaction__r.Name + Lease__r.LeaseID__c</formula>
        <name>GLXY_Set keval on assoc lease trans</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_set external ID on Assoc Lease Trans</fullName>
        <actions>
            <name>GLXY_Set_keval_on_assoc_lease_trans</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Associated_Lease_Transaction__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Sets external id on Associated lease Transaction</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
