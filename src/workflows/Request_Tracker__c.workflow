<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_back_to_user_and_supervisor_telling_request_is_approved</fullName>
        <description>Email back to user and supervisor telling request is approved</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Blog_RequesterSupervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Final_approved_email_to_Requester_and_Supervisor</template>
    </alerts>
    <alerts>
        <fullName>Email_to_requester_and_supervisor_telling_it_rejected</fullName>
        <description>Email to requester and supervisor telling it rejected</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Blog_RequesterSupervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Requester_Tracker_rejected_email_to_requester_supervisor</template>
    </alerts>
    <alerts>
        <fullName>Final_Approval_email_to_requester_and_supervisor</fullName>
        <description>Final Approval email to requester and supervisor</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Blog_RequesterSupervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Final_approved_email_to_Requester_and_Supervisor</template>
    </alerts>
    <alerts>
        <fullName>Notify_EARC_Approver_of_new_IT_Standard_Request</fullName>
        <description>Request Tracker - ITS Notify EARC Approver</description>
        <protected>false</protected>
        <recipients>
            <field>ITS_EARC_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Notify_Approvers</template>
    </alerts>
    <alerts>
        <fullName>REQ_WF_EM_ALL_Approved</fullName>
        <description>REQ_WF_EM_ALL_Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Supervisor_approved_email_to_Requester</template>
    </alerts>
    <alerts>
        <fullName>REQ_WF_EM_ALL_Submission</fullName>
        <description>REQ_WF_EM_ALL_Submission</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Submission_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Cancel_notification</fullName>
        <description>Request Tracker Cancel notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>gokul.ramamoorthy@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ITS_Compliance_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_EARC_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Legal_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Security_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>it-standards@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Cancel_Notification</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Approval_Notification</fullName>
        <description>Request Tracker - ITS Approval Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gokul.ramamoorthy@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ITS_Compliance_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_EARC_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Legal_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Security_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Request_Approval</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_New_Request_Submitted</fullName>
        <description>Request Tracker - ITS - New Request Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>Request_Tracker_ITS_Solution_Strategy</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>it-standards@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Solution_Strategy_Notification</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Notify_Compliance_Approver</fullName>
        <description>Request Tracker - ITS Notify Compliance Approver</description>
        <protected>false</protected>
        <recipients>
            <field>ITS_Compliance_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Notify_Approvers</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Notify_Legal_Approver</fullName>
        <description>Request Tracker - ITS Notify Legal Approver</description>
        <protected>false</protected>
        <recipients>
            <field>ITS_Legal_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Notify_Approvers</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Notify_Security_Approver</fullName>
        <description>Request Tracker - ITS Notify Security Approver</description>
        <protected>false</protected>
        <recipients>
            <field>Security_Reviewer_Group__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Security_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Notify_Approvers</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Notify_Troux_for_record_creation</fullName>
        <description>Request Tracker - ITS Notify Troux for record creation</description>
        <protected>false</protected>
        <recipients>
            <recipient>gokul.ramamoorthy@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Request_Create_Troux_Record</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Rejection_Notification</fullName>
        <description>Request Tracker - ITS Rejection Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gokul.ramamoorthy@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ITS_Compliance_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_EARC_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Legal_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Security_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Request_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Rejection_Notification_LEGAL</fullName>
        <description>Request Tracker - ITS Rejection Notification - LEGAL</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Legal_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Send_Request_Template</fullName>
        <description>Request Tracker - ITS Send Request Template</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Request_Template</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Stalled_Notification</fullName>
        <description>Request Tracker - ITS Stalled Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gokul.ramamoorthy@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>richard.apple@gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>ITS_Compliance_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_EARC_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Legal_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ITS_Security_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Request_Stalled</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_ITS_Your_Request_Submitted_Successfully</fullName>
        <description>Request Tracker - ITS - Your Request Submitted Successfully</description>
        <protected>false</protected>
        <recipients>
            <field>RequestingFor__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>it-standards@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_ITS_Submission_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Notify_record_owner_archive_is_completed</fullName>
        <description>Request Tracker - Notify record owner archive is completed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Notify_record_owner_archive_is_completed</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Notify_supervisor_on_arrival_of_new_record</fullName>
        <description>Request Tracker - Notify supervisor on arrival of new record.</description>
        <protected>false</protected>
        <recipients>
            <recipient>Request_Tracker_EPR_Supervisor</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_EPR_NewRequest</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Partially_Compliant_for_Section_508_Accessibility</fullName>
        <description>Request Tracker - Partially Compliant for Section 508 Accessibility</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Partially_Compliant_for_Section_508_Accessibility</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Send_notification_to_the_assignee</fullName>
        <description>Request Tracker - Send notification to the assignee</description>
        <protected>false</protected>
        <recipients>
            <field>Assignee__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Work_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Request_Tracker_Work_Completion_Other</fullName>
        <description>Notification to requester telling Request is completed..Other</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Work_Completion_Other</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_to_submitter_on_to_confirm_the_request_is_created</fullName>
        <description>Request Tracker - Send Notification to submitter on to confirm the request is created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Submission_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Send_a_note_that_request_is_completed</fullName>
        <description>Send a note that request is completed</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Work_Completion</template>
    </alerts>
    <alerts>
        <fullName>Send_an_email_to_requester_telling_your_request_is_approved_by_supervisor</fullName>
        <description>Send an email to requester telling your request is approved by supervisor.</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Supervisor_approved_email_to_Requester</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_supervisor_for_approval</fullName>
        <description>Send email to supervisor for approval</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Blog_RequesterSupervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Notify_to_Supervisor_for_approval</template>
    </alerts>
    <alerts>
        <fullName>Send_notification_to_requester_telling_the_task_is_competed</fullName>
        <description>Request Tracker - Send notification to requester telling the task is completed</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Work_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Supervisor_rejected</fullName>
        <description>Supervisor rejected</description>
        <protected>false</protected>
        <recipients>
            <field>OCIO_Requester__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>office-of-communications-and-marketing-survey@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Request_Tracker_Emails/Request_Tracker_Rejection_by_Supervisor_email_to_Requester</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Blog_Final_Approvers</fullName>
        <description>Assign final approvers for Blog request</description>
        <field>OwnerId</field>
        <lookupValue>Request_Tracker_Blog</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign Blog Final Approvers</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assignee_to_be_Editable</fullName>
        <description>Upon 2nd Approval from Blog, set Hidden Field for Enabling Assignee = &quot;ALLOW EDIT&quot; so we can make it editable</description>
        <field>Hidden_Field_for_Enabling_Assignee__c</field>
        <formula>&quot;ALLOW EDIT&quot;</formula>
        <name>Assignee to be Editable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EPR_updateFirstName</fullName>
        <field>First_Name__c</field>
        <formula>Username__r.FirstName</formula>
        <name>EPR - updateFirstName</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EPR_updateLastName</fullName>
        <field>Last_Name__c</field>
        <formula>Username__r.LastName</formula>
        <name>EPR - updateLastName</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_Completion_Date</fullName>
        <description>The Field Date Completed will be time stamped when the Status is set to Completed</description>
        <field>Date_Completed__c</field>
        <formula>NOW ()</formula>
        <name>Request Tracker Completion Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_EPR_DataReleaseToCour</fullName>
        <field>Date_Release_to_Court__c</field>
        <name>Request Tracker EPR DataReleaseToCour</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_EPR_DateLitigation</fullName>
        <field>Date_Litigation_Lifted__c</field>
        <name>Request Tracker EPR DateLitigation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Compliance_In_Prog</fullName>
        <field>ITS_Compliance_Approver_Decision__c</field>
        <literalValue>In progress</literalValue>
        <name>Request Tracker - ITS Compliance In Prog</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_EARC_In_Prog</fullName>
        <description>Sets the EARC approver&apos;s decision drop-down to &quot;Proposed&quot; when the approval process is started. (Request has been approved by both Legal and Security team, and reviewed by Compliance)</description>
        <field>ITS_EARC_Approver_Decision__c</field>
        <literalValue>Proposed</literalValue>
        <name>Request Tracker - ITS EARC In Prog</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Legal_In_Prog</fullName>
        <field>ITS_Legal_Approver_Decision__c</field>
        <literalValue>In progress</literalValue>
        <name>Request Tracker - ITS Legal In Prog</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Security_in_Prog</fullName>
        <field>ITS_Security_Approver_Decision__c</field>
        <literalValue>In progress</literalValue>
        <name>Request Tracker - ITS Security in Prog</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_ServiceNow_UCASE</fullName>
        <description>Converts entry of ServiceNow Catalog number to uppercase.</description>
        <field>ITS_ServiceNow_Ticket__c</field>
        <formula>UPPER( ITS_ServiceNow_Ticket__c )</formula>
        <name>Request Tracker - ITS ServiceNow UCASE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Status_Alt_Product</fullName>
        <description>For IT Standard Request, set status to &quot;Alternative Product Found&quot; if an existing standard can be used.</description>
        <field>Status__c</field>
        <literalValue>Alternative product found</literalValue>
        <name>Request Tracker - ITS Status Alt Product</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Status_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Request Tracker - ITS Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Status_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Request Tracker - ITS Status In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_ITS_Status_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Request Tracker - ITS Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Tracker_Mark_Completed</fullName>
        <description>Request Tracker- Mark Completed</description>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Request Tracker - Mark Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requester_Tracker_Date_Assigned</fullName>
        <field>Date_Assigned__c</field>
        <formula>IF(ISBLANK(Assignee__c), NULL, Today())</formula>
        <name>Requester Tracker - Date Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Pending_Supervisor_Review</fullName>
        <description>Update the status pick list value to Pending Supervisor Review</description>
        <field>Status__c</field>
        <literalValue>Pending Supervisor Review</literalValue>
        <name>Status - Pending Supervisor Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Approved_by_Final_Team</fullName>
        <field>Status__c</field>
        <literalValue>Approved by Final Team</literalValue>
        <name>Update Status Approved by Final Team</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Pending_Final_Review</fullName>
        <field>Status__c</field>
        <literalValue>Pending Final Review</literalValue>
        <name>Update Status Pending Final Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Rejected_by_Final_Team</fullName>
        <field>Status__c</field>
        <literalValue>Rejected by Final Team</literalValue>
        <name>Update Status Rejected by Final Team</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Rejected_by_Supervisor</fullName>
        <field>Status__c</field>
        <literalValue>Rejected by Supervisor</literalValue>
        <name>Update Status Rejected by Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>owner_change</fullName>
        <field>OwnerId</field>
        <lookupValue>Request_Tracker_Blog</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>owner change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>First Email Notification</fullName>
        <active>false</active>
        <formula>Date_Completed__c &gt; Now()+7</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - Assign Blog Final Approvers</fullName>
        <actions>
            <name>Assign_Blog_Final_Approvers</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Blog Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending Supervisor Review</value>
        </criteriaItems>
        <description>Assign Blog Final Approvers</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - Date Assigned</fullName>
        <actions>
            <name>Requester_Tracker_Date_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule will update the date assigned when assigned is added</description>
        <formula>(ISCHANGED(Assignee__c ) || NOT ISBLANK(Assignee__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - IT Standard Request - Partially Compliant for Section 508 Accessibility</fullName>
        <actions>
            <name>Request_Tracker_Partially_Compliant_for_Section_508_Accessibility</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Compliance_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Partially Compliant</value>
        </criteriaItems>
        <description>This rule sends an email to the requester when the software requested is Partially Compliant for Section 508 Accessibility</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS - In Progress 10 Days</fullName>
        <active>true</active>
        <booleanFilter>1 AND( 2 OR (3 AND (4 OR 5 OR 6))) AND 7 AND 8</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>In progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver_Decision__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Compliance_Approver_Decision__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Security_Approver_Decision__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Security_Approver_Decision__c</field>
            <operation>notEqual</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>notEqual</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Request_Tracker_ITS_Stalled_Notification</name>
                <type>Alert</type>
            </actions>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Alternative Product Found</fullName>
        <actions>
            <name>Request_Tracker_ITS_Status_Alt_Product</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Alternative_Available__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>If an existing product is found in the IT Standards profile that can satisfy this request, set the Status field to &quot;Alternative Product Found&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Convert ServiceNow to UCASE</fullName>
        <actions>
            <name>Request_Tracker_ITS_ServiceNow_UCASE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Converts any alpha entries in the Service Now Catalog number to uppercase.</description>
        <formula>AND( OR( ISCHANGED( ITS_ServiceNow_Ticket__c ) , ISNEW()),  RecordType.DeveloperName =&quot;IT_Standard_Request&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Initiate Compliance Approval</fullName>
        <actions>
            <name>Request_Tracker_ITS_Notify_Compliance_Approver</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Compliance_In_Prog</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Compliance_Approver__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Initiate EARC  Approval</fullName>
        <actions>
            <name>Notify_EARC_Approver_of_new_IT_Standard_Request</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_EARC_In_Prog</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 5 AND (4 OR 6)</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Exception,Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Security_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Exception,Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Compliance_Approver_Decision__c</field>
            <operation>contains</operation>
            <value>compliant,Exception</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.Category__c</field>
            <operation>equals</operation>
            <value>Building Automation</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Initiate Legal Approval</fullName>
        <actions>
            <name>Request_Tracker_ITS_Notify_Legal_Approver</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Legal_In_Prog</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND  3 AND 4 AND (2 OR 5 OR 6)</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_TOS_EULA_Attached__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Request_Form_Attached_c__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Negotiated_ToS_EULA_Attached__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Other_ToS_EULA_Attached__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Initiate Security Approval</fullName>
        <actions>
            <name>Request_Tracker_ITS_Notify_Security_Approver</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Security_in_Prog</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR ( NOT ( ISBLANK ( ITS_Security_Approver__c ) ) , NOT ( ISBLANK ( Security_Reviewer_Group__c ) ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Notify Troux</fullName>
        <actions>
            <name>Request_Tracker_ITS_Notify_Troux_for_record_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <description>This rule sends an email with the key request information to Aaron Trionfi when a new IT Standard Request is created.  Information will be entered into Troux.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Request Submission</fullName>
        <actions>
            <name>Request_Tracker_ITS_New_Request_Submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Your_Request_Submitted_Successfully</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.Input__c</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <description>Request Tracker - ITS - Sends out 2 email alerts to the requestor and the solutions strategy team</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Reset Status to In Progress</fullName>
        <actions>
            <name>Request_Tracker_ITS_Status_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISPICKVAL(  PRIORVALUE( ITS_Legal_Approver_Decision__c ), &quot;Rejected&quot; ),  NOT(ISPICKVAL(ITS_Legal_Approver_Decision__c , &quot;Rejected&quot;)), NOT(ISPICKVAL( ITS_Security_Approver_Decision__c , &quot;Rejected&quot;)),  RecordType.DeveloperName  = &quot;IT_Standard_Request&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Send IT Standard Request Template</fullName>
        <actions>
            <name>Request_Tracker_ITS_Send_Request_Template</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Alternative_Available__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>This rule sends an email with the IT Standard Request Template attached to the requester and the RISSO if no alternative is found for the requested product (Alternative Available = NO).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Status Approved</fullName>
        <actions>
            <name>Request_Tracker_ITS_Approval_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Status_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Exception,Approved - Remove,Approved - Preferred,Approved - Maintain</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <description>Updates status to Approved when IT Standard request receives final approval from the EARC and sends notification of approval.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Status Rejected</fullName>
        <actions>
            <name>Request_Tracker_ITS_Rejection_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Status_Rejected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>2 AND (1 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Security_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <description>Updates status to REJECTED when IT Standard request is not approved.   Notifies other approvers that the request has been rejected.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Status Rejected - Legal</fullName>
        <actions>
            <name>Request_Tracker_ITS_Rejection_Notification_LEGAL</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_ITS_Status_Rejected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <description>Updates status to REJECTED when IT Standard request has not been approved by the Legal reviewer.  Triggers legal-specific email alert to requester.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker - ITS Status in Progress</fullName>
        <actions>
            <name>Request_Tracker_ITS_Status_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR  5) AND (6 OR 7)</booleanFilter>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>IT Standard Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Legal_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>In progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Compliance_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>In progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_Security_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>In progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.ITS_EARC_Approver_Decision__c</field>
            <operation>equals</operation>
            <value>In progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Alternative product found</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker EPR ArchiveCompleted</fullName>
        <actions>
            <name>Request_Tracker_Notify_record_owner_archive_is_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.Date_Archive_Completed__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker EPR DateLitigationLifted</fullName>
        <actions>
            <name>Request_Tracker_EPR_DateLitigation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule will black out the date litigation lifted.</description>
        <formula>AND ($RecordType.Name =&quot;Evidence Preservation Requests&quot;, NOT(INCLUDES( Litigation_Status__c , &quot;Litigation has been Lifted&quot;)  ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker EPR DateReleaseToCourt</fullName>
        <actions>
            <name>Request_Tracker_EPR_DataReleaseToCour</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule will black out the Date Release To Court</description>
        <formula>AND ($RecordType.Name =&quot;Evidence Preservation Requests&quot;, NOT(INCLUDES( Litigation_Status__c , &quot;Data Release to Court&quot;)  ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker EPR FNameLName</fullName>
        <actions>
            <name>EPR_updateFirstName</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EPR_updateLastName</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Evidence Preservation Requests</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker EPR NewRecordArrived</fullName>
        <actions>
            <name>Request_Tracker_Notify_supervisor_on_arrival_of_new_record</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Evidence Preservation Requests</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker Status Completed in Other</fullName>
        <actions>
            <name>Request_Tracker_Work_Completion_Other</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Request_Tracker_Completion_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Request_Tracker_Mark_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Other</value>
        </criteriaItems>
        <description>Send a notification when task is completed to Requester</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker- Mark Completed</fullName>
        <actions>
            <name>Request_Tracker_Mark_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Request Tracker- Mark Completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker_Save_Confirmation</fullName>
        <actions>
            <name>Send_Notification_to_submitter_on_to_confirm_the_request_is_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Blog Request,Other</value>
        </criteriaItems>
        <description>Send a notification to submitter confirming that requested has been created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Request Tracker_Status Cancelled</fullName>
        <actions>
            <name>Request_Tracker_Cancel_notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Request_Tracker__c.Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <description>send a note to requester.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request_Tracker_Email_to_Assignment</fullName>
        <actions>
            <name>Request_Tracker_Send_notification_to_the_assignee</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Gets triggered when Assignee field value changes.</description>
        <formula>$RecordType.Name =&quot;Blog Request&quot; || $RecordType.Name =&quot;Evidence Preservation Requests&quot; &amp;&amp; ISNEW( ) || ISCHANGED(Assignee__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
