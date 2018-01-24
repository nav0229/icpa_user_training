<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>App_Status_In_Approval</fullName>
        <field>Status__c</field>
        <literalValue>In Approval</literalValue>
        <name>App Status - In Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Status_Update</fullName>
        <description>Application status is updated to &quot;In Approval&quot;</description>
        <field>Status__c</field>
        <literalValue>In Approval</literalValue>
        <name>Status: In Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Status_Withdrawn</fullName>
        <field>Status__c</field>
        <literalValue>Withdrawn</literalValue>
        <name>Application Status Withdrawn</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Status_to_Decline</fullName>
        <field>Status__c</field>
        <literalValue>Declined</literalValue>
        <name>Application Status to Decline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Status_to_rejected</fullName>
        <field>Status__c</field>
        <literalValue>Declined</literalValue>
        <name>Status: Declined</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Sub_status_Update</fullName>
        <field>Sub_Status__c</field>
        <literalValue>All Required Approvals Concurred</literalValue>
        <name>Application Sub-status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Auto_Decline</fullName>
        <field>OwnerId</field>
        <lookupValue>Auto_Decline</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign Auto Decline to Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_app_to_Final_Decision_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Final_Decision_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign app to Final Decision queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_app_to_loan_Officer_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Loan_Officer_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign app to loan Officer queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_to_DA_Queue_Date_Update</fullName>
        <description>Enter the date record was assigned to the Drafting Attorney Queue</description>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Assigned to DA Queue Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_to_HL_Queue_Date</fullName>
        <description>Date when application was assigned to the Higher Legal Review Queue</description>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Assigned to HL Queue Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_to_HL_Queue_Date_Update</fullName>
        <description>Date when application was assigned to the Higher Legal Review Queue</description>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Assigned to Queue Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assigned_to_Queue_Date_Update</fullName>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Assigned to Queue Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Awaiting_AADA_Review</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting AADA Review</literalValue>
        <name>Awaiting AADA Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Awaiting_ACDAP_Review</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting ACDAP Review</literalValue>
        <name>Awaiting ACDAP Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Awaiting_CDPDC_Review</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting CDPDC Review</literalValue>
        <name>Awaiting CDPDC Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Awaiting_Higher_Legal_Review</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting Higher Legal Review</literalValue>
        <name>Awaiting Higher Legal Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>Team_Lead_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Record Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Assigned_To_Field</fullName>
        <field>Assigned_To__c</field>
        <name>Clear Assigned To Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Assigned_to_Queue_Time_Stamp</fullName>
        <description>Date/time record was assigned to the Higher Legal Review Queue</description>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Date Assigned to Queue Time Stamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Assigned_to_TL_queue</fullName>
        <field>Assigned_to_Queue__c</field>
        <formula>Now()</formula>
        <name>Date Assigned to TL queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Drafting_Attorney_Review_Required</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting Drafting Attorney Concur</literalValue>
        <name>Drafting Attorney Review Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Approval_Sub_Status</fullName>
        <field>Sub_Status__c</field>
        <literalValue>All Required Approvals Concurred</literalValue>
        <name>Final Approval Sub_Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Higher_Legal_Review_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>All Required Approvals Concurred</literalValue>
        <name>Higher Legal Review Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Higher_Legal_Review_Not_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Higher Legal Not Concur</literalValue>
        <name>Higher Legal Review Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Higher_Legal_Review_Queue_Assignment</fullName>
        <description>Update record owner to Higher Legal Review Queue</description>
        <field>OwnerId</field>
        <lookupValue>Higher_Legal_Review_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Higher Legal Review Queue Assignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Review_Completed</fullName>
        <field>Legal_Review_Completed__c</field>
        <literalValue>1</literalValue>
        <name>Legal Review Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Decline</fullName>
        <field>Milestone__c</field>
        <literalValue>Decline</literalValue>
        <name>Milestone - Decline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Document_Gathering</fullName>
        <field>Milestone__c</field>
        <literalValue>Document Gathering</literalValue>
        <name>Milestone - Document Gathering</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Exception_Testing</fullName>
        <field>Milestone__c</field>
        <literalValue>Exception Testing</literalValue>
        <name>Milestone - Exception Testing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Final_Decisioning</fullName>
        <field>Milestone__c</field>
        <literalValue>Final Decisioning</literalValue>
        <name>Milestone - Final Decisioning</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Obligation</fullName>
        <field>Milestone__c</field>
        <literalValue>Obligation</literalValue>
        <name>Milestone - Obligation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Processing</fullName>
        <field>Milestone__c</field>
        <literalValue>Processing</literalValue>
        <name>Milestone - Processing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Milestone_Summary_Decline_Test</fullName>
        <field>Milestone__c</field>
        <literalValue>Auto Decline Test</literalValue>
        <name>Milestone - Summary Decline Test</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Principal_Amount_Update</fullName>
        <description>Update the Principal Amount field with the value of the Total Eligible Physical Loss</description>
        <field>Principal_Amount__c</field>
        <formula>Total_Eligible_Physical_Loss__c</formula>
        <name>Principal Amount Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Loan_TRUE</fullName>
        <field>Approved_For_Loan__c</field>
        <literalValue>1</literalValue>
        <name>Ready for Loan = TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Application_Status_to_rejected</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Not Concur</literalValue>
        <name>Sub Status to: Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Approval_Status_to_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Set the Approval Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Approval_Status_to_Pending</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Set the Approval Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Approval_Status_to_Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Set the Approval Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Approval_status_to_Open</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Set the Approval status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Assigned_to_queue_to_Drafting_A</fullName>
        <field>Approval_Assigned_To__c</field>
        <literalValue>Drafting Attorney</literalValue>
        <name>Set the Assigned to queue to Drafting A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_Assigned_to_queue_to_Legal</fullName>
        <field>Approval_Assigned_To__c</field>
        <literalValue>Legal Team</literalValue>
        <name>Set the Assigned to queue to Legal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_status_to_legal_review</fullName>
        <field>Status__c</field>
        <literalValue>Legal Review</literalValue>
        <name>Set the status to legal review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_subStat_to_DA_concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting Higher Legal Review</literalValue>
        <name>Higher Legal Review Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_sub_status_to_Drafting_Attorney</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Drafting Attorney In Progress</literalValue>
        <name>Set the sub-status to Drafting Attorney</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_substatus_to_DA_not_concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Drafting Attorney Not Concur</literalValue>
        <name>Set the substatus to DA not concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Statu_s_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status: Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status: Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Update_In_Approval</fullName>
        <description>Field update update sets the value of Application status to &quot;In Approval&quot;</description>
        <field>Status__c</field>
        <literalValue>In Approval</literalValue>
        <name>Status Update: In Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SubStatus_Awaiting_Team_Lead_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Awaiting Team Lead Concur</literalValue>
        <name>SubStatus: Awaiting Team Lead Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SubStatus_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>All Required Approvals Concurred</literalValue>
        <name>SubStatus: Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SubStatus_Higher_Legal_Review_Required</fullName>
        <description>Update the sub-status to Higher Legal Review Required</description>
        <field>Sub_Status__c</field>
        <literalValue>Higher Legal Review Required</literalValue>
        <name>SubStatus - Higher Legal Review Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sub_status_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Concur</literalValue>
        <name>Sub-status Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Substatus_AADA_Not_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>AADA Not Concur</literalValue>
        <name>Substatus: AADA Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Substatus_ACDAP_Not_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>ACDAP Not Concur</literalValue>
        <name>Substatus: ACDAP Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Substatus_CDPDC_Not_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>CDPDC Not Concur</literalValue>
        <name>Substatus: CDPDC Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Substatus_Team_Lead_Not_Concur</fullName>
        <field>Sub_Status__c</field>
        <literalValue>Team Lead Not Concur</literalValue>
        <name>Substatus: Team Lead Not Concur</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Queue_Assignment</fullName>
        <description>Update the Assigned to Queue Date/Time field</description>
        <field>Assigned_to_Queue__c</field>
        <formula>NOW()</formula>
        <name>Time Stamp Queue Assignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_type_to_Read_Only</fullName>
        <field>RecordTypeId</field>
        <lookupValue>New_Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record type to Read Only</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Team_Lead_Approver</fullName>
        <description>This field will track who is the decision maker from Team Lead team</description>
        <field>Team_Lead_Approver__c</field>
        <formula>$User.FirstName&amp;&quot; &quot;&amp;  $User.LastName</formula>
        <name>Update Team Lead Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Team_Lead_Approver_rej</fullName>
        <field>Team_Lead_Approver__c</field>
        <formula>$User.FirstName &amp; &quot; &quot; &amp;  $User.LastName</formula>
        <name>Update Team Lead Approver when rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_secure_flag</fullName>
        <field>Secured__c</field>
        <literalValue>1</literalValue>
        <name>Update the secure flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Auto Decline - Credit%2FRepayment</fullName>
        <actions>
            <name>Assign_Auto_Decline</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Auto Decline – Credit/Repayment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Drafting Attorney%2FHigher Legal Review Queue Time Stamp</fullName>
        <actions>
            <name>Date_Assigned_to_Queue_Time_Stamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Application__c.OwnerId</field>
            <operation>equals</operation>
            <value>Higher Legal Review Queue</value>
        </criteriaItems>
        <criteriaItems>
            <field>Application__c.OwnerId</field>
            <operation>equals</operation>
            <value>Drafting Attorney Queue</value>
        </criteriaItems>
        <description>Workflow time stamps the application record with the date/time it was assigned to the Higher Legal Review Queue or the Drafting Attorney Queue</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Principal Amount</fullName>
        <actions>
            <name>Principal_Amount_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Total_Eligible_Physical_Loss__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Application__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Home Loan Application</value>
        </criteriaItems>
        <description>Workflow rule takes the Total Eligible Physical Loss and updates the Principal Amount on the Application with that amount.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reassign to Team Lead Queue</fullName>
        <actions>
            <name>Assigned_to_Queue_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_Record_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Clear_Assigned_To_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Application__c.Reassign_to_Queue__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>equals</operation>
            <value>Team Lead</value>
        </criteriaItems>
        <description>Workflow reassigns record to the Team Lead Queue</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>STEVE_FWL_TEST</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Mitigation_Disclosure__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Auto Decline</fullName>
        <actions>
            <name>Milestone_Summary_Decline_Test</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Decline</fullName>
        <actions>
            <name>Milestone_Decline</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Auto Decline - Credit,Auto Decline – Credit/Repayment,Auto Decline – Repayment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Document Gathering</fullName>
        <actions>
            <name>Milestone_Document_Gathering</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Document Gathering</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Exception Testing</fullName>
        <actions>
            <name>Milestone_Exception_Testing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Exception Testing</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Final Decisioning</fullName>
        <actions>
            <name>Milestone_Final_Decisioning</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>System Recommended</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Obligation</fullName>
        <actions>
            <name>Milestone_Obligation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Milestone Processing</fullName>
        <actions>
            <name>Milestone_Processing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Application__c.Status__c</field>
            <operation>equals</operation>
            <value>Not System Recommended</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update the Secure flag</fullName>
        <actions>
            <name>Update_the_secure_flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Secure flag when there are active collateral available for a given application.</description>
        <formula>Active_Collateral__c &gt;=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Application_Reviewer_does_not_Concur</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please review the Application as reviewer decided not to Concur with your recommendation</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Application Reviewer does not Concur</subject>
    </tasks>
</Workflow>
