<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PC_Milestone_1_day_past_due</fullName>
        <description>PC Milestone - 1 day past due email alert</description>
        <protected>false</protected>
        <recipients>
            <field>Owner__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>PMO_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Project_Manager__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Project_central_milestone_after_reminder</template>
    </alerts>
    <alerts>
        <fullName>PC_Milestone_5_day_till_due_email_alert</fullName>
        <description>PC Milestone - 5 day till due email alert</description>
        <protected>false</protected>
        <recipients>
            <field>Owner__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>PMO_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Project_Manager__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Project_central_milestone_before_reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>PC_Milestone_status_to_red</fullName>
        <field>Milestone_Status__c</field>
        <literalValue>Red</literalValue>
        <name>PC Milestone - status to red</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Estimated_End_Date</fullName>
        <field>Estimated_End_Date__c</field>
        <formula>Planned_End_Date__c + (Actual_Start_Date__c - Planned_Start_Date__c)</formula>
        <name>Update Estimated End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PC Mile Calc Tar End Date</fullName>
        <actions>
            <name>Update_Estimated_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculate the Target End Date/Estimated End Date when the Actual Start Date changes on a Milestones</description>
        <formula>ISCHANGED(Actual_Start_Date__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PC Milestone End Date Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>GPM_Project__c.Project_Tier__c</field>
            <operation>equals</operation>
            <value>Tier 1</value>
        </criteriaItems>
        <criteriaItems>
            <field>GPM_Milestone__c.Milestone_Progress__c</field>
            <operation>equals</operation>
            <value>Planned,Active</value>
        </criteriaItems>
        <description>Email 5 days before due, 1 day after due, and change flag to red 1 day after due.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PC_Milestone_1_day_past_due</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>PC_Milestone_status_to_red</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>GPM_Milestone__c.Estimated_End_Date__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PC_Milestone_5_day_till_due_email_alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>GPM_Milestone__c.Estimated_End_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
