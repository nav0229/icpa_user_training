<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>Application_Auto_Decline</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>https://biztalk/placeholder/autodecline</endpointUrl>
        <fields>Application_Number__c</fields>
        <fields>Auto_Decline_Reason__c</fields>
        <fields>Id</fields>
        <fields>SObject_ID__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>dcms2.systemuser@sba.gov</integrationUser>
        <name>Application Auto Decline</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Get_SBA_Loan_History_rerun</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>http://test</endpointUrl>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>matthew.anielski@sba.gov</integrationUser>
        <name>Get SBA Loan History rerun</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Get_other_assistance_rerun</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>http://test</endpointUrl>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>matthew.anielski@sba.gov</integrationUser>
        <name>Get other assistance rerun</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Obligate_Loan_ETRAN</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>https://biztalk.tspi.net/DCMS2/ETRANObligation/ETRANObligation.svc</endpointUrl>
        <fields>Application_Number__c</fields>
        <fields>Id</fields>
        <fields>SObject_ID__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>dcms2.systemuser@sba.gov</integrationUser>
        <name>Obligate Loan ETRAN</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Request_LV_Initial_Inspection</fullName>
        <apiVersion>41.0</apiVersion>
        <endpointUrl>https://odabiztstws01.sba.gov/DCMS2/LV/Notification.svc</endpointUrl>
        <fields>Application_Number__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>dcms2.systemuser@sba.gov</integrationUser>
        <name>Request LV Initial Inspection</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Request_SBA_Loan_History</fullName>
        <apiVersion>41.0</apiVersion>
        <description>Event Request Trigger SBA Loan History</description>
        <endpointUrl>https://biztalk.tspi.net/DCMS2/SBALoanHistory/SBALoanHistory.svc</endpointUrl>
        <fields>Application_Number__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>kenn.kipchillat@sba.gov</integrationUser>
        <name>Request SBA Loan History</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>EventRequest_OrderLVInspection</fullName>
        <actions>
            <name>Request_LV_Initial_Inspection</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Request__c.Stage__c</field>
            <operation>equals</operation>
            <value>Order LV Inspection</value>
        </criteriaItems>
        <description>Order LV Initial Inspection integration when status is set to order LV integration</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>EventRequest_SubmitAutoDecline</fullName>
        <actions>
            <name>Application_Auto_Decline</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Request__c.Stage__c</field>
            <operation>equals</operation>
            <value>Submit Auto Decline</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EventRequest_SubmitETRANOBL</fullName>
        <actions>
            <name>Obligate_Loan_ETRAN</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Request__c.Stage__c</field>
            <operation>equals</operation>
            <value>Submit ETRAN OBL</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Loan History ReRun</fullName>
        <actions>
            <name>Get_SBA_Loan_History_rerun</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Event_Request__c.Name</field>
            <operation>equals</operation>
            <value>Order Loan History ReRun</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Awaiting interface data</value>
        </criteriaItems>
        <description>Invoke interface for &apos;Order Loan History ReRun&apos; event requests</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Other Assistance ReRun</fullName>
        <actions>
            <name>Get_other_assistance_rerun</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Event_Request__c.Name</field>
            <operation>equals</operation>
            <value>Order Other Assistance ReRun</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Awaiting interface data</value>
        </criteriaItems>
        <description>Invoke interface for &apos;Order Other Assistance ReRun&apos; event requests</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request SBA Loan History</fullName>
        <actions>
            <name>Request_SBA_Loan_History</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <description>When the application receives a status of “Pass” for the Credit and Repayment tests, the system will initiate a request of SBA Loan History data from the SBA Loan History Warehouse</description>
        <formula>ISPICKVAL( Stage__c , &apos;Order Loan History&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>STEVE_TEST_SBALOANHIST</fullName>
        <actions>
            <name>Request_SBA_Loan_History</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Request__c.Name</field>
            <operation>contains</operation>
            <value>steve</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
