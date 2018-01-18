<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>GSA_IT_Opportunity_Submission_email_to_Applicant</fullName>
        <description>GSA IT Opportunity Submission email to Applicant</description>
        <protected>false</protected>
        <recipients>
            <field>Applicant_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GSA_IT_Hire/GSA_IT_Opportunity_Submitted</template>
    </alerts>
    <alerts>
        <fullName>GSA_IT_new_application_notification_for_Hiring_Managers</fullName>
        <description>GSA IT new application notification for Hiring Managers</description>
        <protected>false</protected>
        <recipients>
            <recipient>GSA_IT_Hire_Hiring_Managers</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>GSA_IT_Hire/GSA_IT_Application_to_Hiring_Managers</template>
    </alerts>
    <fieldUpdates>
        <fullName>GSA_IT_Hire_Update_Veteran_Status</fullName>
        <description>The Veteran Status (US Armed Forces) field will be checked if any value is entered into the Veterans&apos; Preference Claim field</description>
        <field>Veteran_Status_US_Armed_Forces__c</field>
        <literalValue>1</literalValue>
        <name>GSA IT Hire - Update Veteran Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GSA IT Hire Email to Directors</fullName>
        <actions>
            <name>GSA_IT_new_application_notification_for_Hiring_Managers</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>GSA_IT_Applications__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>GSA IT Hiring Managers team will receive an email notification when a new application is submitted</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GSA IT Hire New Application Submitted</fullName>
        <actions>
            <name>GSA_IT_Opportunity_Submission_email_to_Applicant</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GSA_IT_Applications__c.Applicant_Email_Address__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <description>Will identify any new applications that have a valid email address and send a corresponding email after a application has been submitted successfully</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GSA IT Hire Veteran Status</fullName>
        <actions>
            <name>GSA_IT_Hire_Update_Veteran_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GSA_IT_Applications__c.Veterans_Preference_Claim__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>The Veteran Status (US Armed Forces) field will be checked if any value is entered into the Veterans&apos; Preference Claim field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
