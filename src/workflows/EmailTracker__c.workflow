<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>VOE_Hiring_Manager_Initial_Send_Email_Alert</fullName>
        <description>VOE - Hiring Manager Initial Send Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>ToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>surveys@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/VOE_Hiring_Manager_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>VOE_Hiring_Manager_Reminders_Email_Alert</fullName>
        <description>VOE - Hiring Manager Reminders Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>ToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>surveys@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/VOE_Hiring_Manager_Reminder_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>VOE_New_Supervisor_Initial_Send_Email_Alert</fullName>
        <description>VOE - New Supervisor Initial Send Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>ToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>surveys@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/VOE_New_Supervisor_Initial_Send_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>VOE_New_Supervisor_Reminder_Email_Alert</fullName>
        <description>VOE - New Supervisor Reminder Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>ToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>surveys@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/VOE_New_Supervisor_Reminder_Email_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>VOE_Email_Tracker_SurveyURL_field_update</fullName>
        <field>SurveyURL__c</field>
        <formula>IF(NOT(ISBLANK(Parent__c)), Parent__r.SurveyURL__c+ Parent__r.Id  , SurveyURL__c +  Id)</formula>
        <name>VOE - Email Tracker SurveyURL field upd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VOE_Hiring_Manager_Field_Update</fullName>
        <field>Status__c</field>
        <literalValue>Sent</literalValue>
        <name>VOE - Hiring Manager Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>VOE_New_Supervisor_Update_Status_Sent</fullName>
        <description>Update Status to Sent</description>
        <field>Status__c</field>
        <literalValue>Sent</literalValue>
        <name>VOE - New Supervisor Update Status Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>VOE_Hiring_Manager_Initial_Send</fullName>
        <apiVersion>40.0</apiVersion>
        <endpointUrl>https://gov1.qualtrics.com/triggers/api/v1/event?eventType=SalesforceOutboundMessage&amp;s=SV_3vZeQXbygLg1fWR&amp;u=UR_5p4Fz98uKlbRfa5&amp;t=OC_2c0I7Avyvwt2z3d&amp;b=cemgsa</endpointUrl>
        <fields>Hired_Employee__c</fields>
        <fields>Id</fields>
        <fields>Supervisor_FirstName__c</fields>
        <fields>Supervisor_LastName__c</fields>
        <fields>ToContact_Email__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>qualtrics_eeo@gsa.gov</integrationUser>
        <name>VOE - Hiring Manager Initial Send</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>VOE_New_Supervisor_Survey_Initial_Send</fullName>
        <apiVersion>40.0</apiVersion>
        <endpointUrl>https://gov1.qualtrics.com/triggers/api/v1/event?eventType=SalesforceOutboundMessage&amp;s=SV_cGDqeUcKYFsIo3X&amp;u=UR_5p4Fz98uKlbRfa5&amp;t=OC_BEVr7wMGl6KUMwN&amp;b=cemgsa</endpointUrl>
        <fields>Hired_Employee__c</fields>
        <fields>Id</fields>
        <fields>Supervisor_FirstName__c</fields>
        <fields>Supervisor_LastName__c</fields>
        <fields>ToContact_Email__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>qualtrics_eeo@gsa.gov</integrationUser>
        <name>VOE - New Supervisor Survey Initial Send</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>VOE - Email Tracker Survey URL rule</fullName>
        <actions>
            <name>VOE_Email_Tracker_SurveyURL_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>EmailTracker__c.SurveyURL__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Type__c</field>
            <operation>equals</operation>
            <value>VOE - Hiring Manager Survey</value>
        </criteriaItems>
        <description>VOE - Populating the Email Tracker Survey URL by using the respective custom settings.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>VOE - Hiring Manager Initial Send</fullName>
        <actions>
            <name>VOE_Hiring_Manager_Initial_Send</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>EmailTracker__c.Type__c</field>
            <operation>equals</operation>
            <value>VOE - Hiring Manager Survey</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Sent</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Purpose__c</field>
            <operation>equals</operation>
            <value>Initial Send</value>
        </criteriaItems>
        <description>VOE - Hiring Manager Initial Email Send</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>VOE - Hiring Manager Reminders</fullName>
        <active>false</active>
        <criteriaItems>
            <field>EmailTracker__c.Type__c</field>
            <operation>equals</operation>
            <value>VOE - Hiring Manager Survey</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Queued</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Purpose__c</field>
            <operation>equals</operation>
            <value>Reminder</value>
        </criteriaItems>
        <description>VOE - Hiring Manager Reminders</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>VOE_Hiring_Manager_Reminders_Email_Alert</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>VOE_Hiring_Manager_Field_Update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>EmailTracker__c.SendDate__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>VOE - New Supervisor Survey Initial Send</fullName>
        <active>true</active>
        <criteriaItems>
            <field>EmailTracker__c.Type__c</field>
            <operation>equals</operation>
            <value>VOE - New Supervisor Survey</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Purpose__c</field>
            <operation>equals</operation>
            <value>Initial Send</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Queued</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.SendDate__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Send initial Survey Email to a New Supervisor 30 Days after their promotion.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>VOE_New_Supervisor_Update_Status_Sent</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>VOE_New_Supervisor_Survey_Initial_Send</name>
                <type>OutboundMessage</type>
            </actions>
            <offsetFromField>EmailTracker__c.SendDate__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>VOE - New Supervisor Survey Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>EmailTracker__c.Type__c</field>
            <operation>equals</operation>
            <value>VOE - New Supervisor Survey</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Purpose__c</field>
            <operation>equals</operation>
            <value>Reminder</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Queued</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailTracker__c.SendDate__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Send reminder emails to New Supervisors who have not responded to their surveys.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>VOE_New_Supervisor_Reminder_Email_Alert</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>VOE_New_Supervisor_Update_Status_Sent</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>EmailTracker__c.SendDate__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
