<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Ethics_manager_email_alert_for_form_ready_for_final_review</fullName>
        <description>Ethics manager email alert for form ready for final review.</description>
        <protected>false</protected>
        <recipients>
            <recipient>OGC_Ethics_278_Ethics_Law_Team_Mgrs</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Ethics_Law_Team_Emails/Ethics_278_Form_ready_for_final_review_from_Manager</template>
    </alerts>
    <alerts>
        <fullName>Ethics_team_email_notification_to_alert_forms_for_review</fullName>
        <description>Ethics team email notification to alert forms for review.</description>
        <protected>false</protected>
        <recipients>
            <recipient>OGC_Ethics_278_Ethics_Law_Team</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Ethics_Law_Team_Emails/Ethics_Queue_Alert_for_Form_Ready_for_Review</template>
    </alerts>
    <fieldUpdates>
        <fullName>Ethics_Form_in_Queue_for_Review</fullName>
        <field>OwnerId</field>
        <lookupValue>FormsforReview</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics Form in Queue for Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Ethics 278 Form Final Review Status Alert</fullName>
        <actions>
            <name>Ethics_manager_email_alert_for_form_ready_for_final_review</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_Form__c.Ethics_Review_Status__c</field>
            <operation>equals</operation>
            <value>Final Review</value>
        </criteriaItems>
        <description>This workflow will be used to send an email alert to the manager of the Ethics Law team when a 278 form is ready for final review from the manager.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forms for Review Notification</fullName>
        <actions>
            <name>Ethics_team_email_notification_to_alert_forms_for_review</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Ethics_Form_in_Queue_for_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will alert the ethics law team members when a new form is ready for review.</description>
        <formula>ISBLANK( Ethics_Date_Signed_by_Employee__c )  = FALSE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
