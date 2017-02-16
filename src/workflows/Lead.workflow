<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PropTrack_PIF_Lead_Project_Proposal_Submitted</fullName>
        <description>PropTrack-PIF-Lead Project Proposal Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>PropTrack_PIF_Managers</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Lead_Project_Proposal_Submitted</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Proposal_Submitted_Email_to_PIF_Managers</fullName>
        <description>PropTrack-PIF-Proposal Submitted-Email to PIF Managers</description>
        <protected>false</protected>
        <recipients>
            <recipient>PropTrack_PIF_Managers</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Lead_Project_Proposal_Submitted</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Your_Proposal_Submitted</fullName>
        <description>PropTrack-PIF-Your Proposal Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Your_Project_Proposal</template>
    </alerts>
    <rules>
        <fullName>PropTrack-Lead-18F-BU Acceptance Status</fullName>
        <actions>
            <name>Introduce_Lead_to_BU</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>18F Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>BU Acceptance</value>
        </criteriaItems>
        <description>PropTrack - 18F - generate a task for the Lead Owner to introduce the 18F Lead to the relevant BU once the lead reaches the BU Acceptance status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Lead-18F-Convert Lead task</fullName>
        <actions>
            <name>Convert_Lead</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>18F Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>BU Introductions</value>
        </criteriaItems>
        <description>PropTrack - 18F - generate a task for the Lead Owner to convert the 18F Lead if it&apos;s in &apos;BU Introductions&apos; status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Lead-PIF-Your Proposal Submitted</fullName>
        <actions>
            <name>PropTrack_PIF_Proposal_Submitted_Email_to_PIF_Managers</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PropTrack_PIF_Your_Proposal_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Lead</value>
        </criteriaItems>
        <description>PropTrack - PIF - When a PIF Lead is created from the Web, send email alerts to the submitter and the PIF Managers</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Convert_Lead</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please convert this lead now as it is in &apos;BU Introductions&apos; status</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Convert Lead</subject>
    </tasks>
    <tasks>
        <fullName>Introduce_Lead_to_BU</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please introduce this lead to relevant Business Unit. Please mark this task as completed and update comments.</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Introduce Lead to BU</subject>
    </tasks>
</Workflow>
