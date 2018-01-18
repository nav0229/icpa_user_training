<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Spend_Tracker_Clone_Clear_Lock</fullName>
        <field>Lock_Spend_Request__c</field>
        <literalValue>0</literalValue>
        <name>Spend Tracker-Clone Clear Lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Clone_Clear_Submit_Date</fullName>
        <field>Submit_for_Approval_Date__c</field>
        <name>Spend Tracker-Clone Clear Submit Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Clone_Fill_Disclaimer</fullName>
        <field>Disclaimer__c</field>
        <formula>&quot;Do NOT enter sensitive data in this system. The GSA Spend Tracker is intended to provide transparency into agency spending while helping GSA reduce costs and ensure procurements are consistent with policy, standards, and strategy. As a result, spend requests may be viewed by all GSA employees. Sensitive information, such as Independent Government Cost Estimates (IGCEs) and statements of work/objectives (SOW/SOOs) for new awards, should only be shared with your SR’s reviewer as an email attachment or access controlled Google Drive file. For more information please get in touch with one of the contacts listed on the GSA Spend Chatter Group.&quot;+BR()+BR()+&quot;Note: Saving the record by the Spend Request owner will be considered as an acknowledgement that he/she has read the above statement and agrees that they will not enter any sensitive data in this system.&quot;</formula>
        <name>Spend Tracker-Clone Fill Disclaimer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Investment_Type</fullName>
        <description>Used for reporting only</description>
        <field>Investment_Type__c</field>
        <formula>CASE( Investment__c ,&quot;Other&quot;, &quot;Other&quot;,&quot;Multiple&quot;, &quot;Multiple&quot;, &quot;Listed Investment&quot;)</formula>
        <name>Spend Tracker Investment Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_PR_Number_Check</fullName>
        <description>Used for reporting purposes</description>
        <field>PR_Number_populated__c</field>
        <literalValue>1</literalValue>
        <name>Spend Tracker PR Number Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Populate_Application_Type</fullName>
        <description>Used for reporting and dashboard</description>
        <field>Application_Type_2__c</field>
        <formula>CASE(Application__c ,&quot;Not Listed&quot;, &quot;Not Listed&quot;,&quot;Not Applicable&quot;,&quot;Not Applicable&quot;, &quot;Unknown&quot;, &quot;Unknown&quot;, &quot;Multiple&quot;, &quot;Multiple&quot;, &quot;Listed Application&quot;)</formula>
        <name>Spend Tracker Populate Application Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Spend Tracker Application Type</fullName>
        <actions>
            <name>Spend_Tracker_Populate_Application_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker Investment Reporting</fullName>
        <actions>
            <name>Spend_Tracker_Investment_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker PR Number</fullName>
        <actions>
            <name>Spend_Tracker_PR_Number_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Spend_Request__c.Pegasys_PR_OR_Credit_Card_Log__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Used for reporting purposes to fill in a checkbox that indicates that the PR# or CC# has been filled so that on reporting we can group by whether the Record has a true value or a false value for the checkbox.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker-Clone Clear Spend Request Fields</fullName>
        <actions>
            <name>Spend_Tracker_Clone_Clear_Lock</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Clone_Clear_Submit_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Spend_Request__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>When a Spend Request is Cloned, &quot;Submit for Approval Date&quot; field is reset to &quot;Null&quot; and &quot;Lock Spend Request&quot; checkbox is reset to false.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
