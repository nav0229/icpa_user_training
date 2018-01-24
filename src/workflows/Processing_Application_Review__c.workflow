<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>App_Sub_Status_to_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Concur</literalValue>
        <name>App Sub Status to Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_owner_to_Final_decision_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Final_Decision_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>App owner to Final decision queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <targetObject>Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AutoApprovalUpdate</fullName>
        <field>AutoApprovalTest__c</field>
        <literalValue>1</literalValue>
        <name>AutoApprovalUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_Time_stamp_Applicant_ET</fullName>
        <field>Applicant_Eligibility_Test_Time__c</field>
        <formula>NOW()</formula>
        <name>Capture Time stamp- Applicant ET</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_Time_stamp_Eligibility_Test</fullName>
        <field>Eligibility_Test_Result_Date__c</field>
        <formula>NOW()</formula>
        <name>Capture Time stamp- Eligibility Test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_Time_stamp_Miscellaneous_ET</fullName>
        <field>Miscellaneous_Exceptions_Test_Time__c</field>
        <formula>NOW()</formula>
        <name>Capture Time stamp- Miscellaneous  ET</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_loan</fullName>
        <field>Approved_For_Loan__c</field>
        <literalValue>1</literalValue>
        <name>Ready for loan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Eligibility_Test_Results</fullName>
        <field>Eligibility_Test_Result__c</field>
        <formula>IF(AND(
Miscellaneous_Exceptions_Test__c = &quot;Pass&quot;, 
Applicant_Eligibility_Test__c = &quot;Pass&quot;, 
Property_Eligibility_Test__c = &quot;Pass&quot;),

&quot;Pass&quot;, 

IF(AND(
OR(Miscellaneous_Exceptions_Test__c = &quot;Pass&quot;, Miscellaneous_Exceptions_Test__c = &quot;Mitigated&quot;),
OR(Applicant_Eligibility_Test__c = &quot;Pass&quot;, Applicant_Eligibility_Test__c = &quot;Mitigated&quot;),
OR(Property_Eligibility_Test__c = &quot;Pass&quot;, Property_Eligibility_Test__c = &quot;Mitigated&quot;)),

&quot;Mitigated&quot;,

&quot;Fail&quot;))</formula>
        <name>Set Eligibility Test Results</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_CET_Result_Date</fullName>
        <description>Action time stamps the date/time when the Credit Elsewhere Test (CET) is completed</description>
        <field>Credit_Elsewhere_Test_Result_Date__c</field>
        <formula>NOW()</formula>
        <name>Time Stamp CET Result Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Property_Eligibility_test</fullName>
        <field>Property_Eligibility_Test_Time__c</field>
        <formula>Now()</formula>
        <name>Time Stamp - Property Eligibility test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approval_Status_to_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_status_to_Team_Lead_Review</fullName>
        <field>Status__c</field>
        <literalValue>Team Lead Review</literalValue>
        <name>Update the status to Team Lead Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Application__c</targetObject>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Request_FEMA_Info</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>http://placeholder/URL/fake</endpointUrl>
        <fields>Application_Number__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>dcms2.systemuser@sba.gov</integrationUser>
        <name>Request FEMA Info</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Request FEMA Info</fullName>
        <actions>
            <name>Request_FEMA_Info</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Processing_Application_Review__c.Credit_Analysis_Test__c</field>
            <operation>equals</operation>
            <value>Pass</value>
        </criteriaItems>
        <criteriaItems>
            <field>Processing_Application_Review__c.Repayment_Test__c</field>
            <operation>equals</operation>
            <value>Pass</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Eligibility Test Result</fullName>
        <actions>
            <name>Set_Eligibility_Test_Results</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(
ISCHANGED( Miscellaneous_Exceptions_Test__c ),
ISCHANGED( Applicant_Eligibility_Test__c ),
ISCHANGED( Property_Eligibility_Test__c )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp - Credit Elsewhere Test</fullName>
        <actions>
            <name>Time_Stamp_CET_Result_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Processing_Application_Review__c.Credit_Elsewhere_Test__c</field>
            <operation>equals</operation>
            <value>Market Rate</value>
        </criteriaItems>
        <criteriaItems>
            <field>Processing_Application_Review__c.Credit_Elsewhere_Test__c</field>
            <operation>equals</operation>
            <value>Below Market Rate</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time stamp Overall Eligibility test</fullName>
        <actions>
            <name>Capture_Time_stamp_Eligibility_Test</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISNEW()||
ISCHANGED( Eligibility_Test_Result__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Time stamp Property Eligibility test</fullName>
        <actions>
            <name>Time_Stamp_Property_Eligibility_test</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNEW()||
ISCHANGED( Property_Eligibility_Test__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update the Status to TL concur</fullName>
        <actions>
            <name>App_Sub_Status_to_Concur</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>App_owner_to_Final_decision_queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_for_loan</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_the_status_to_Team_Lead_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Processing_Application_Review__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
