<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assigned_to_LAT</fullName>
        <field>Assigned__c</field>
        <literalValue>1</literalValue>
        <name>Assigned to LAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_Assigned_to_field</fullName>
        <field>Assigned_To__c</field>
        <name>Blank &quot;Assigned to&quot; field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_Time_for_Assigned_to</fullName>
        <field>Time_Assigned_to_LAT_Member__c</field>
        <formula>Now()</formula>
        <name>Capture Time for Assigned to</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deadline_to_Submit_Documents</fullName>
        <field>Deadline_to_Submit_Documents__c</field>
        <formula>CreatedDate + 7</formula>
        <name>Deadline to Submit Documents</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_Document_Case_Closed</fullName>
        <field>Status</field>
        <literalValue>Valid</literalValue>
        <name>Mark Document Case Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Assigned_checkbox_to_false</fullName>
        <field>Assigned__c</field>
        <literalValue>0</literalValue>
        <name>Set Assigned checkbox to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_case_record_type_to_Document_Request</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Document_Request</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set case record type to Document Request</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_ownership_back_to_the_LAT_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Loan_Assistance_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Set the ownership back to the LAT queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Assigned_to_Queue</fullName>
        <field>Time_Assigned_to_Queue__c</field>
        <formula>Now()</formula>
        <name>Time Stamp -Assigned to Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Assigned</fullName>
        <field>Status</field>
        <literalValue>Assigned</literalValue>
        <name>Update Status to Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>blank_the_Date_assigned_to_member</fullName>
        <field>Time_Assigned_to_LAT_Member__c</field>
        <name>blank the Date assigned to member</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_ownership_to_LAT_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Loan_Assistance_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>change ownership to LAT queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>All Documents Confirmed</fullName>
        <actions>
            <name>Mark_Document_Case_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Number_of_Documents_Requested__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Remaining_Documents_to_Receive__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Document Request</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Manager Notification</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.No_of_Documents_Pending__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Workflow notifies the Case owner through a new task if there are any documents pending by the deadline when the documents are due.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Pending_Documents_Requested</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Case.Deadline_to_Submit_Documents__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Change the ownership back to LAT queue upon reassignment</fullName>
        <actions>
            <name>Blank_Assigned_to_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Assigned_checkbox_to_false</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_the_ownership_back_to_the_LAT_queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Time_Stamp_Assigned_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>blank_the_Date_assigned_to_member</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Reassign</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task for LAT queue</fullName>
        <actions>
            <name>You_have_a_new_application_assignment_for_LAT</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>Owner:Queue.Id =&apos;00Gr0000000wQuO&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task to - %22Assigned To%22 field</fullName>
        <actions>
            <name>New_Application_for_your_review</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assigned_To__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>00Gr0000000wQuO</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TimeStamp- %22Assigned To%22 field</fullName>
        <actions>
            <name>Capture_Time_for_Assigned_to</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assigned_To__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case from Queue to Owner</fullName>
        <actions>
            <name>Assigned_to_LAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
ISCHANGED(OwnerId),
PRIORVALUE(OwnerId) = &quot;00Gr0000000wQuO&quot;,
NOT(BEGINS(OwnerId, &quot;00G&quot;))
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update record type</fullName>
        <actions>
            <name>Set_case_record_type_to_Document_Request</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Update_Record_Type__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Application_pending_your_review</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Time_Assigned_to_LAT_Member__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Application pending your review</subject>
    </tasks>
    <tasks>
        <fullName>Documents_Overdue</fullName>
        <assignedToType>owner</assignedToType>
        <description>The requested documents for the related Request have not been submitted or validates.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Documents Overdue</subject>
    </tasks>
    <tasks>
        <fullName>Documents_Pending</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Deadline_to_Submit_Documents__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Documents Pending</subject>
    </tasks>
    <tasks>
        <fullName>Documents_Requested_Overdue</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Deadline_to_Submit_Documents__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Documents Requested Overdue</subject>
    </tasks>
    <tasks>
        <fullName>New_Application_for_your_review</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Time_Assigned_to_LAT_Member__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>New Application for your review</subject>
    </tasks>
    <tasks>
        <fullName>Pending_Documents_Requested</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Deadline_to_Submit_Documents__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Pending Documents Requested</subject>
    </tasks>
    <tasks>
        <fullName>Pending_Documents_are_Due</fullName>
        <assignedToType>owner</assignedToType>
        <description>There is an open case with pending documents due today</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Pending Documents are Due</subject>
    </tasks>
    <tasks>
        <fullName>Requested_Documents_Overdue</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Deadline_to_Submit_Documents__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Requested Documents Overdue</subject>
    </tasks>
    <tasks>
        <fullName>You_have_a_new_application_assignment_for_LAT</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Time_Assigned_to_Queue__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>You have a new application assignment for LAT</subject>
    </tasks>
</Workflow>
