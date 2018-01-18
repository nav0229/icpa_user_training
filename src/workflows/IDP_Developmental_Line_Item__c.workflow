<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Certification_Approved</fullName>
        <description>Certification Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>Certification_Rejected</fullName>
        <description>Certification Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Certification_Review_And_Approved</fullName>
        <description>Certification Review And Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>Finance_Approved</fullName>
        <description>Finance Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>Finance_Rejected</fullName>
        <description>Finance Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>IDP_Activity_Approved</fullName>
        <description>IDP Activity Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>IDP_Activity_Rejected</fullName>
        <description>IDP Activity Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>IDP_Request_Approved_Please_schedule_Training_Dates</fullName>
        <description>IDP Request Approved Please schedule Training Dates</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Activity_Approved_Training_Cordinator_Scheduled_Date</template>
    </alerts>
    <alerts>
        <fullName>Scheduled_Training_Date</fullName>
        <description>Scheduled Training Date</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Activity_Scheduled_Date</template>
    </alerts>
    <alerts>
        <fullName>Second_Superviror_Approved</fullName>
        <description>Second Superviror Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>Second_Supervisor_Rejected</fullName>
        <description>Second Supervisor Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Supervior_Rejected</fullName>
        <description>Supervior Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Supervisor_1_Approved</fullName>
        <description>Supervisor 1 Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>Trainee_Officer_Rejected</fullName>
        <description>Trainee Officer Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Acvitivity_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Traininee_officer_Approved</fullName>
        <description>Traininee officer Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Developmental_Activity_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Activity_Request_Submitted</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Request Submitted</literalValue>
        <name>Activity Request Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Acvity_Plan_Approved_After_IDP_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Plan Approved</literalValue>
        <name>Acvity Plan Approved After IDP Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cerfication_Submmited</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Certification Submitted</literalValue>
        <name>Cerfication Submmited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Certification_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Certification Rejected</literalValue>
        <name>Certification Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Activity_Request_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Activity Request Rejected</literalValue>
        <name>Final Activity Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Approval_Action</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Activity Request Approved</literalValue>
        <name>Final Approval Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Financial_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Financial Approved</literalValue>
        <name>Financial Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Financial_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Financial Rejected</literalValue>
        <name>Financial Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Activity_Changed_to_Initial</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>New</literalValue>
        <name>IDP Activity Changed to Initial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Plan_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Plan Approved</literalValue>
        <name>Plan Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Plan_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Plan Rejected</literalValue>
        <name>Plan Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Plan_Submitted</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Plan Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Primary_Supervisor_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Primary  Supervisor Rejected</literalValue>
        <name>Primary Supervisor Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Primary_Supervisor_Request_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Primary  Supervisor Approved</literalValue>
        <name>Primary Supervisor Request Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recal_Certificiation</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Activity Request Approved</literalValue>
        <name>Recal Certificiation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recall_Action</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Plan Approved</literalValue>
        <name>Recall Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Secondary_Supervisor_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Secondary Supervisor Approved</literalValue>
        <name>Secondary Supervisor Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Secondary_Supervisor_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Secondary Supervisor Rejected</literalValue>
        <name>Secondary Supervisor Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Certification_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Certification Approved</literalValue>
        <name>Supervisor Certification Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Training_Officer_Approved</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Training Coordinator Approved</literalValue>
        <name>Training Officer Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Training_Officer_Rejected</fullName>
        <field>IDP_Activity_Status__c</field>
        <literalValue>Training Coordinator Rejected</literalValue>
        <name>Training Officer Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
