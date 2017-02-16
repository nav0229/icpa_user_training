<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PropTrack_PIF_New_PIF_Team_Member</fullName>
        <description>PropTrack-PIF-New PIF Team Member</description>
        <protected>false</protected>
        <recipients>
            <field>UserId</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_New_Team_Member</template>
    </alerts>
    <rules>
        <fullName>PropTrack-OpportunityTeamMember-PIF-Added</fullName>
        <actions>
            <name>PropTrack_PIF_New_PIF_Team_Member</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityTeamMember.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>PropTrack - PIF - When a user is added to the PropTrack Project Opportunity, send an email to this user notifying that he/she has been added as a team member</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
