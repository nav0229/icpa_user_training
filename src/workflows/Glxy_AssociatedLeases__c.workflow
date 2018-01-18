<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>GLXY_SetTerminationDate</fullName>
        <description>For REXUS record Type, when BLANK ONLY, default the Termination Date to REXUS Termination Date</description>
        <field>Termination_Date__c</field>
        <formula>Rexus_Termination_Date__c</formula>
        <name>GLXY_SetTerminationDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_Set_Lease_Annual_Rent</fullName>
        <field>Lease_Annual_Rent__c</field>
        <formula>Lease__r.BaseAnnualRent__c</formula>
        <name>GLXY_Set Lease Annual Rent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_Set_Project_Old_Annual_Rent</fullName>
        <description>Sets Old annual rent from project</description>
        <field>ProjectOldAnnualRent__c</field>
        <formula>Lease__r.BaseAnnualRent__c</formula>
        <name>GLXY_ Set Project Old Annual Rent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GLXY_set_keyval_on_Associated_lease</fullName>
        <description>Sets the KeyVal field</description>
        <field>AssociatedLeaseKeyVal__c</field>
        <formula>Lease__c + Project__c</formula>
        <name>GLXY_set keyval on Associated lease</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_AssociatedLease Key enforcement</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_AssociatedLeases__c.CreatedById</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Unique Lease and project combination</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_Set Project Old annual Rent</fullName>
        <actions>
            <name>GLXY_Set_Project_Old_Annual_Rent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_AssociatedLeases__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Set the project Old Annual Rent from the parent project when the record is created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_SetTerminationDate</fullName>
        <actions>
            <name>GLXY_SetTerminationDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_AssociatedLeases__c.Termination_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Glxy_AssociatedLeases__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Rexus</value>
        </criteriaItems>
        <description>For REXUS record Type, when BLANK ONLY, default the Termination Date to REXUS Termination Date.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_set Lease annual Rent</fullName>
        <actions>
            <name>GLXY_Set_Lease_Annual_Rent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_Lease__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Sets lease annual rent from  lease on create</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_set keyval on Associated lease</fullName>
        <actions>
            <name>GLXY_set_keyval_on_Associated_lease</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_AssociatedLeases__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>Sets the keyval field on associated lease to ensure unique records</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
