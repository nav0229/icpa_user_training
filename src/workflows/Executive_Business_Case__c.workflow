<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EBC_Concept_Email_Executive_Sponsor_for_Approval_Email_Alert</fullName>
        <description>EBC Concept - Email Executive Sponsor for Approval Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Executive_Sponsor_Delegate__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Executive_Sponsor_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Email_Requester_for_Executive_Sponsor_Approval</fullName>
        <description>EBC Concept - Email Requester for Executive Sponsor Approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Executive_Sponsor_Request_Approval</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Email_Requester_for_Executive_Sponsor_Denial</fullName>
        <description>EBC Concept - Email Requester for Executive Sponsor Denial</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Executive_Sponsor_Request_Denial</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Email_Requester_when_P_G_Denied</fullName>
        <description>EBC Concept - Email Requester when P&amp;G Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Planning_and_Governance_Case_Denial</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Email_Requestor_when_P_G_Approved</fullName>
        <description>EBC Concept - Email Requestor when P&amp;G Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Planning_and_Governance_Case_Approval</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Planning_and_Governance_Case_Is_Ready</fullName>
        <description>EBC Concept - Planning and Governance Case Is Ready</description>
        <protected>false</protected>
        <recipients>
            <recipient>EBC_Super_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Planning_and_Governance_Case_Is_Ready</template>
    </alerts>
    <alerts>
        <fullName>EBC_Concept_Request_Submitted_email_to_requester</fullName>
        <description>EBC Concept - Request Submitted email to requester</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Concept_Requester_Initial_Email</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_CFO_for_New_Case</fullName>
        <description>EBC - Email CFO for New Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>EBC_CFO_Users</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>EBC_Super_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_CFO_Case_is_Ready</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_Executive_Sponsor_for_Approval_Email_Alert</fullName>
        <description>EBC - Email Executive Sponsor for Approval Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Executive_Sponsor_Delegate__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Executive_Sponsor_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_P_G_for_New_Case</fullName>
        <description>EBC - Email P&amp;G for New Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>EBC_CFO_Users</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>EBC_Super_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Planning_and_Governance_Case_Is_Ready</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_Requester_for_Executive_Sponsor_Approval</fullName>
        <description>EBC - Email Requester for Executive Sponsor Approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Executive_Sponsor_Request_Approval</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_Requester_for_Executive_Sponsor_Denial</fullName>
        <description>EBC - Email Requester for Executive Sponsor Denial</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Executive_Sponsor_Request_Denial</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_Requester_when_P_G_Denied</fullName>
        <description>EBC - Email Requester when P&amp;G Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Planning_and_Governance_Case_Denial</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_Requestor_when_P_G_Approved</fullName>
        <description>EBC - Email Requestor when P&amp;G Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Planning_and_Governance_Case_Approval</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_for_Final_Status</fullName>
        <ccEmails>IEE-CPICTeam@gsa.gov</ccEmails>
        <description>EBC - Email for Final Status</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Executive_Sponsor_Delegate__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Final_Decision</template>
    </alerts>
    <alerts>
        <fullName>EBC_Email_to_requester_when_Type_of_Funding_Allocated_is_updated</fullName>
        <description>EBC - Email to requester when Type of Funding Allocated is updated</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Funding_Approval_Type</template>
    </alerts>
    <alerts>
        <fullName>EBC_Request_Submitted_email_to_requester</fullName>
        <description>EBC - Request Submitted email to requester</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Executive_Business_Case_Templates/EBC_Requester_Initial_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>EBC_ConceptApproved_False</fullName>
        <description>EBC - Update the Concept Approved checkbox to False</description>
        <field>ConceptApproved__c</field>
        <literalValue>0</literalValue>
        <name>EBC - ConceptApproved - False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_ConceptApproved_True</fullName>
        <description>EBC - Update the Concept Approved checkbox to True</description>
        <field>ConceptApproved__c</field>
        <literalValue>1</literalValue>
        <name>EBC - ConceptApproved - True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Owner_to_Funding_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>EBC_Funding</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>EBC Owner to Funding Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_EBC</fullName>
        <description>Concept stage is updated to &apos;EBC&apos; once approved</description>
        <field>Stage__c</field>
        <literalValue>EBC</literalValue>
        <name>EBC Stage to EBC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_Funding_Approval</fullName>
        <field>Stage__c</field>
        <literalValue>Funding Approval</literalValue>
        <name>EBC Stage to Funding Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_Funding_Decision</fullName>
        <field>Stage__c</field>
        <literalValue>Funding Decision</literalValue>
        <name>EBC Stage to Funding Decision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_Governance_Review</fullName>
        <field>Stage__c</field>
        <literalValue>Governance Review</literalValue>
        <name>EBC Stage to Governance Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_IRB_Review</fullName>
        <field>Stage__c</field>
        <literalValue>IRB Review</literalValue>
        <name>EBC Stage to IRB Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_Internal_Review</fullName>
        <field>Stage__c</field>
        <literalValue>Internal Review</literalValue>
        <name>EBC Stage to Internal Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_New</fullName>
        <field>Stage__c</field>
        <literalValue>New</literalValue>
        <name>EBC Stage to New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_PAB_Review</fullName>
        <field>Stage__c</field>
        <literalValue>PAB Review</literalValue>
        <name>EBC Stage to PAB Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Stage_to_Sponsor_Review</fullName>
        <field>Stage__c</field>
        <literalValue>Executive Sponsor Review</literalValue>
        <name>EBC Stage to Sponsor Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Status_to_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>EBC Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Status_to_Denied</fullName>
        <field>Status__c</field>
        <literalValue>Denied</literalValue>
        <name>EBC Status to Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Status_to_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending</literalValue>
        <name>EBC Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Status_to_Recalled</fullName>
        <field>Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>EBC Status to Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Update_Record_Typ_to_ConceptReview</fullName>
        <description>EBC</description>
        <field>RecordTypeId</field>
        <lookupValue>Concept_Review</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>EBC - Update Record Typ to ConceptReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Update_Record_Type_to_CFO</fullName>
        <description>Update record type to CFO based on Stage value.</description>
        <field>RecordTypeId</field>
        <lookupValue>EBC_CFO_Record_Type</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>EBC - Update Record Type to CFO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Update_Record_Type_to_New</fullName>
        <description>Update Record Type to EBC Initial Request</description>
        <field>RecordTypeId</field>
        <lookupValue>EBC_Initial_Request</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>EBC - Update Record Type to New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Update_Record_Type_to_P_G</fullName>
        <description>Update the record type to Planning and Governance when Stage value changes.</description>
        <field>RecordTypeId</field>
        <lookupValue>EBC_Planning_and_Governance</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>EBC - Update Record Type to P&amp;G</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_Update_Recrd_Typ_to_ConceptInitial</fullName>
        <description>EBC</description>
        <field>RecordTypeId</field>
        <lookupValue>Concept_Initial</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>EBC - Update Recrd Typ to ConceptInitial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>EBC Funding Approval updates to EBC requester</fullName>
        <actions>
            <name>EBC_Email_to_requester_when_Type_of_Funding_Allocated_is_updated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>An email will be sent to the EBC requester every time the Type of Funding Allocated on their EBC request is updated with a new value</description>
        <formula>IF(PRIORVALUE(Type_of_Funding_Allocated__c) !=NULL,      ISCHANGED(Type_of_Funding_Allocated__c), FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
