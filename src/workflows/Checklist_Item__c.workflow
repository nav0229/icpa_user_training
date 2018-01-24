<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Timestamp_Valid_Date_of_Checklist_Item</fullName>
        <description>Field updates the date when the Checklist was labeled as Valid</description>
        <field>Verified_Date__c</field>
        <formula>NOW()</formula>
        <name>Timestamp Valid Date of Checklist Item</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Generate_Document</fullName>
        <description>Uncheck the generate document field after the document is generated</description>
        <field>Generate_Document__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Generate Document</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Verified_by_Update</fullName>
        <description>Field updates the Verified By field with the full name of the user who changed the status to Valid/Invalid</description>
        <field>Verified_By__c</field>
        <formula>$User.FirstName + &quot; &quot; +  $User.LastName</formula>
        <name>Verified by Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Auto_Generate_Document</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>https://apps.drawloop.com/package/111</endpointUrl>
        <fields>Drawloop_Next__c</fields>
        <fields>Id</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>prathyusha.uppada@sba.gov</integrationUser>
        <name>Auto Generate Document</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Checklist Item Valid%2FInvalid</fullName>
        <actions>
            <name>Timestamp_Valid_Date_of_Checklist_Item</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Verified_by_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Checklist_Item__c.Checklist_Item_Status__c</field>
            <operation>equals</operation>
            <value>Valid,Invalid</value>
        </criteriaItems>
        <description>Workflow time stamps the date a checklist item was labeled as Valid</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Generate Checklist Item Documents</fullName>
        <actions>
            <name>Uncheck_Generate_Document</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Auto_Generate_Document</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Checklist_Item__c.Generate_Document__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Checklist_Item__c.Drawloop_Next__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
