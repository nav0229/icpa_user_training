<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_PCO_after_four_day_to_CAV_Date</fullName>
        <description>PCO Notification to Complete the Survey after four day to CAV Date</description>
        <protected>false</protected>
        <recipients>
            <field>PCO_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PCO_Notification_to_take_the_Survey_after_four_day_to_CAV_Date</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_PCO_after_one_day_of_CAV_Date</fullName>
        <description>PCO Notification to Complete the Survey after one day to CAV Date</description>
        <protected>false</protected>
        <recipients>
            <field>PCO_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PCO_Notification_to_take_the_Survey_after_one_day_to_CAV_Date</template>
    </alerts>
    <alerts>
        <fullName>Email_Allert_to_PCO_after_one_day_of_CAV_Date</fullName>
        <description>PCO Notification to Complete the Survey</description>
        <protected>false</protected>
        <recipients>
            <field>PCO_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PCO_Notification_to_take_the_Survey</template>
    </alerts>
    <alerts>
        <fullName>Email_Allert_to_PCO_after_three_day_to_CAV_Date</fullName>
        <description>PCO Notification to Complete the Survey after three day to CAV Date</description>
        <protected>false</protected>
        <recipients>
            <field>PCO_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PCO_Notification_to_take_the_Survey_after_three_day_to_CAV_Date</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_to_Admin_Managers</fullName>
        <description>Email Notification to Admin Managers</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notification_to_Admin_Managers</template>
    </alerts>
    <alerts>
        <fullName>Email_to_IOAs</fullName>
        <description>Email to IOAs</description>
        <protected>false</protected>
        <recipients>
            <field>IOA_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_IOAs</template>
    </alerts>
    <alerts>
        <fullName>Email_to_SIOAs</fullName>
        <description>Email to SIOAs</description>
        <protected>false</protected>
        <recipients>
            <field>SIOA_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notification_to_SIOAs</template>
    </alerts>
    <alerts>
        <fullName>PCO_Remainder_Email</fullName>
        <description>PCO Remainder Email</description>
        <protected>false</protected>
        <recipients>
            <field>PCO_Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reminder_Email_to_PCOs</template>
    </alerts>
    <fieldUpdates>
        <fullName>Survey_Status_Update</fullName>
        <field>Survey_Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Survey Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Notifications to IOAs and SIOAs</fullName>
        <actions>
            <name>Email_Notification_to_Admin_Managers</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_to_IOAs</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_to_SIOAs</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>RAP_Survey__c.Survey_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>This rule will fire emails to the IOAs and SIOAs assigned to a particular Survey.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sending Survey to PCOs after CAV Date</fullName>
        <actions>
            <name>Email_Allert_to_PCO_after_one_day_of_CAV_Date</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send ing the link to PCOs to complete the survey after one day to the CAV date.</description>
        <formula>AND( NOT(ISBLANK(PCO_Name__c )),  (CAV_Date__c  + 1) =  TODAY() )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sending Survey to PCOs after one and four day to CAV Date</fullName>
        <active>true</active>
        <description>Sending the link to PCOs to complete the survey after one and four day to the CAV date.</description>
        <formula>AND(NOT(ISPICKVAL(Survey_Status__c , &apos;Completed&apos;)), NOT(ISBLANK(PCO_Name__c )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Alert_to_PCO_after_four_day_to_CAV_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>RAP_Survey__c.CAV_Date__c</offsetFromField>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Alert_to_PCO_after_one_day_of_CAV_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>RAP_Survey__c.CAV_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Sending Survey to PCOs after three day to CAV Date</fullName>
        <active>true</active>
        <description>Sending the link to PCOs to complete the survey after three day to the CAV date.</description>
        <formula>AND(NOT(ISPICKVAL(Survey_Status__c , &apos;Completed&apos;)), NOT(ISBLANK(PCO_Name__c )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Allert_to_PCO_after_three_day_to_CAV_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>RAP_Survey__c.CAV_Date__c</offsetFromField>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Updating the Survey Status</fullName>
        <actions>
            <name>Survey_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10) AND 11</booleanFilter>
        <criteriaItems>
            <field>RAP_Survey__c.Pre_trip_meeting__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Locations_and_Logistics__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.IOA_Role__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Experience_for_Job_Performance__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Future_RAP_Opportunities__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Recommend_RAP__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.IOA_Information_Seeking__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Interest_in_other_Opportunity__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Why__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Why_do_you__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>RAP_Survey__c.Survey_Completed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>This rule updates the Survey Status to &quot;In Progress&quot; when Some of the Questions are answered.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
