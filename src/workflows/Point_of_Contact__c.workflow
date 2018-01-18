<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>OCM_Req_Tracker_Assignment_Notification_Assignee_Point_of_Contact</fullName>
        <description>OCM Req Tracker-Assignment Notification-Assignee Point of Contact</description>
        <protected>false</protected>
        <recipients>
            <field>Point_of_Contact_Name__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>OCM_Req_Tracker_Email_Templates/OCM_Req_Tracker_Assignment_Notification</template>
    </alerts>
    <alerts>
        <fullName>OCM_Req_Tracker_Customer_Satisfaction_Survey_Notification_POC</fullName>
        <description>OCM Req Tracker-Customer Satisfaction Survey Notification POC</description>
        <protected>false</protected>
        <recipients>
            <field>Point_of_Contact_Name__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>OCM_Req_Tracker_Email_Templates/OCM_Req_Tracker_Customer_Satisfaction_Survey_Notification</template>
    </alerts>
    <rules>
        <fullName>OCM Req Tracker-Assignment Notification-Assignee Point of Contact</fullName>
        <actions>
            <name>OCM_Req_Tracker_Assignment_Notification_Assignee_Point_of_Contact</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Point_of_Contact__c.Assignee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When &quot;Assignee&quot; checkbox is checked on Point of Contact&quot;, an email notification is sent to that Point of Contact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OCM Req Tracker-Customer Satisfaction Survey-Notification to POC Requester</fullName>
        <actions>
            <name>OCM_Req_Tracker_Customer_Satisfaction_Survey_Notification_POC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Point_of_Contact__c.Point_of_Contact_Type__c</field>
            <operation>equals</operation>
            <value>Requester</value>
        </criteriaItems>
        <criteriaItems>
            <field>Point_of_Contact__c.POC_Update_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>When any record is marked completed, a &quot;Customer Satisfaction Survey&quot; is sent to the Point of Contact (Requester&apos;s) of the record.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
