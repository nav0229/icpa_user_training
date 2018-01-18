<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>FedRAMP_Director_Assign_to_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>FedRAMP_Director</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>FedRAMP Director Assign to Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FedRAMP_Package_progress_to_ConMon</fullName>
        <description>FedRAMP Package progress to ConMon</description>
        <field>Package_Progress__c</field>
        <literalValue>ConMon</literalValue>
        <name>FedRAMP Package progress to ConMon</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FedRAMP_Package_progress_update_to_NA</fullName>
        <description>FedRAMP Package progress update to NA</description>
        <field>Package_Progress__c</field>
        <literalValue>N/A</literalValue>
        <name>FedRAMP Package progress update to NA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>FedRAMP Package progress update to ConMon</fullName>
        <actions>
            <name>FedRAMP_Package_progress_to_ConMon</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FedRAMP_Package__c.PATO_Approved_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>FedRAMP_Package__c.Package_Status__c</field>
            <operation>equals</operation>
            <value>Authorized</value>
        </criteriaItems>
        <criteriaItems>
            <field>FedRAMP_Package__c.Review_Category__c</field>
            <operation>equals</operation>
            <value>JAB</value>
        </criteriaItems>
        <description>FedRAMP Package progress update to ConMon</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FedRAMP Package progress update to NA</fullName>
        <actions>
            <name>FedRAMP_Package_progress_update_to_NA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>FedRAMP_Package__c.Package_Status__c</field>
            <operation>equals</operation>
            <value>ATO Cancelled,Removed,Package Exception</value>
        </criteriaItems>
        <criteriaItems>
            <field>FedRAMP_Package__c.Review_Category__c</field>
            <operation>equals</operation>
            <value>CSP,Agency</value>
        </criteriaItems>
        <description>FedRAMP Package progress update to NA</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FedRAMP Packages Queue Assignment</fullName>
        <actions>
            <name>FedRAMP_Director_Assign_to_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FedRAMP_Package__c.OwnerId</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify Package Owner upon Owner change</fullName>
        <active>true</active>
        <description>Send email notifications to the new owner any time Package Owner is changed.</description>
        <formula>ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
