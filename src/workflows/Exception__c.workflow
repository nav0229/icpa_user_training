<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_email_alert_to_production_support_team</fullName>
        <description>Send email alert to production support team</description>
        <protected>false</protected>
        <recipients>
            <recipient>christian.coleman@peo.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>paul.pick-aluas@peo.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sean.hennessey@peo.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Exception_Generaged</template>
    </alerts>
    <rules>
        <fullName>Send email on Exception</fullName>
        <actions>
            <name>Send_email_alert_to_production_support_team</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR 3 OR 4</booleanFilter>
        <criteriaItems>
            <field>Exception__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>KB Sync Failure</value>
        </criteriaItems>
        <criteriaItems>
            <field>Exception__c.Email_Exception__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Exception__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>CSAT Phone Upload</value>
        </criteriaItems>
        <criteriaItems>
            <field>Exception__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Email Relay Failure</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
