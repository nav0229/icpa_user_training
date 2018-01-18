<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_to_Zone_admin</fullName>
        <description>Email Notification to Zone admin</description>
        <protected>false</protected>
        <recipients>
            <recipient>anne.weigle@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>stephanie.teague@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Salesforce_Idea_email_notification</template>
    </alerts>
    <rules>
        <fullName>Email Notification of new Idea</fullName>
        <actions>
            <name>Email_Notification_to_Zone_admin</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Idea.CommunityId</field>
            <operation>equals</operation>
            <value>R10 PBS Town Hall Ideas Quest</value>
        </criteriaItems>
        <description>ServiceNow ticket: STASK0328431; Zone admin needs to be notified whenever there is a new idea posted in the Zone (R10 PBS Town Hall Ideas Quest)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
