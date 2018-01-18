<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval_Supervisor_Notification</fullName>
        <description>Approval Supervisor Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Supervisor_Notification</template>
    </alerts>
    <alerts>
        <fullName>Approver_1_Email_Notification</fullName>
        <description>Approver 1 Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Approver_1__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver1_Notification</template>
    </alerts>
    <alerts>
        <fullName>Approver_2_Notification</fullName>
        <description>Approver 2 Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Approver_2__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver2_Notification</template>
    </alerts>
    <alerts>
        <fullName>Approver_3_Email_Notification</fullName>
        <description>Approver 3 Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Approver_3__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver3_Notification</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Approved_and_founded</fullName>
        <description>SF 182 Approved and founded</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Purchasing_Training_Coordinator__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Purchasing_Training_Coordinator_Attention</fullName>
        <description>SF 182 Purchasing Training Coordinator Attention</description>
        <protected>false</protected>
        <recipients>
            <field>Purchasing_Training_Coordinator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Purchasing_Training_Coordinator_Notification</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Purchasing_Training_Coordinator_Attention_Rejection</fullName>
        <description>SF 182 Purchasing Training Coordinator Attention Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Purchasing_Training_Coordinator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/SF_182_Purchasing_Training_Coordinator_Notification_Rejection</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Purchasing_Training_Coordinator_Group_Attention</fullName>
        <description>SF 182 Purchasing Training Coordinator Group Attention</description>
        <protected>false</protected>
        <recipients>
            <recipient>IDP_IMS_Program_Support</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/SF_182_Purchasing_Training_Coordinator_Notification_Rejection</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Rejected_Status</fullName>
        <description>SF 182 Rejected Status</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Rejected</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Rejected_Status1</fullName>
        <description>SF 182 Rejected Status</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Rejected</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Request_Data_into_Pegasys</fullName>
        <description>SF 182 Request Data into Pegasys</description>
        <protected>false</protected>
        <recipients>
            <field>Purchasing_Training_Coordinator__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Pegasys_Information</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Request_Email_Reminder_to_Mark_Complete</fullName>
        <description>SF 182 Request Email Reminder to Mark Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>IDP_Email_Templates/SF_182_Notify_Employee_To_Mark_Training_Complete</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Supervisor_Review</fullName>
        <description>SF 182 Supervisor Review</description>
        <protected>false</protected>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approval_Process_Email</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Training_End_Date_to_Complete_Training_Check</fullName>
        <description>SF 182 Training End Date to Complete Training Check</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_for_Training_End_Date</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Training_End_Date_to_Complete_Training_Check_box</fullName>
        <description>SF 182 Training End Date to Complete Training Check box</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_for_Training_End_Date</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Training_End_Date_to_Complete_Training_Check_box_OLD</fullName>
        <description>SF 182 Training End Date to Complete Training Check box OLD</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_for_Training_End_Date</template>
    </alerts>
    <alerts>
        <fullName>SF_182_Upcoming_Training_Reminder</fullName>
        <description>SF 182 Upcoming Training Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/SF_182_for_Training_Reminder</template>
    </alerts>
    <alerts>
        <fullName>SF_182_email_alert_to_Owner_on_Resubmit_for_Approval</fullName>
        <description>SF 182 email alert to Owner on Resubmit for Approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF182_for_Resubmit_Approval</template>
    </alerts>
    <alerts>
        <fullName>Sf_182_Training_Completed_Check_for_10days</fullName>
        <description>Sf 182 Training Completed Check for 10days</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_for_Training_End_Date</template>
    </alerts>
    <alerts>
        <fullName>Sf_182_Training_Completed_Check_for_10days_OLD</fullName>
        <description>Sf 182 Training Completed Check for 10days OLD</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_for_Training_End_Date</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_10_Days_Approver_2_Email_Notification</fullName>
        <description>Time Trigger 10 Days Approver 2 Email Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_2__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver2_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_10_days_Approver1_Email_notification</fullName>
        <description>Time Trigger 10 days  Approver1 Email notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_1__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver1_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_10_days_Email_to_Supervisor</fullName>
        <description>Time Trigger 10 days Email to Supervisor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Supervisor_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_5_Day_s_Email_Notification_to_Approver_3</fullName>
        <description>Time Trigger 5 Day&apos;s Email Notification to Approver 3</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_3__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver3_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_5_day_Email_to_Supervisor</fullName>
        <description>Time Trigger  5 day Email to Supervisor</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Supervisor_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_5_days_Approver_2_Email_Notification</fullName>
        <description>Time Trigger 5 days Approver 2 Email Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_2__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver2_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_Trigger_for_10_days_Email_Notification_to_Approver_3</fullName>
        <description>Time Trigger for 10 days Email Notification to Approver 3</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_3__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver3_Notification</template>
    </alerts>
    <alerts>
        <fullName>Time_trigger_Approver_1_email_notification</fullName>
        <description>Time trigger Approver 1 email notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Approver_1__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Approver1_Notification</template>
    </alerts>
    <alerts>
        <fullName>User_Notification</fullName>
        <description>User Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_User_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>App1_Final_step_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App1 Final step Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Recall_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App1 Recall Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App1 Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Step_1_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App1 Step 1 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Step_2_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App1 Step 2 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Step_3_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App1 Step 3 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Step_4_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App1 Step 4 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>App1 Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_for_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Approval Process in Progress</literalValue>
        <name>App1 for Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App1_update_Resume_field</fullName>
        <field>Resubmit_Approval_Process__c</field>
        <literalValue>0</literalValue>
        <name>App1 update Resume field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App2_Recall_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App2 Recall Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App2_Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App2 Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App2_Step_1_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App2 Step 1 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App2_Step_2_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>App2 Step 2 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App2_on_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Approval Process in Progress</literalValue>
        <name>App2 on Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App3_Field_update_on_Resume_Approval</fullName>
        <field>Resubmit_Approval_Process__c</field>
        <literalValue>0</literalValue>
        <name>App3 Field update on Resume Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App3_Final_Step_Update_Final_Approver</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>App3 Final Step Update Final Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App3_Final_Step_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App3 Final Step Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App3_Recall_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App3 Recall Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App3_Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App3 Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App4_Final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>App4 Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App4_Recall_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App4 Recall Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App4_Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App4 Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App4_Update_Final_Approver</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>App4 Update Final Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App4_Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>App4 Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_1_Recall_update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Correction</literalValue>
        <name>App 1 Recall update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_2_Final_Step_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>App 2 Final Step Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_2_Recall_Action</fullName>
        <field>Request_Status__c</field>
        <literalValue>Correction</literalValue>
        <name>App 2 Recall Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_2_update_resume_approval</fullName>
        <field>Resubmit_Approval_Process__c</field>
        <literalValue>0</literalValue>
        <name>App 2 update resume approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_3_Final_step_update_Final_Approver</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>App 3 Final step update Final Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_3_Recall_Action</fullName>
        <field>Request_Status__c</field>
        <literalValue>Correction</literalValue>
        <name>App 3 Recall Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_3_on_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Approval Process in Progress</literalValue>
        <name>App 3 on Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_3_update_on_Resume_Approval</fullName>
        <field>Resubmit_Approval_Process__c</field>
        <literalValue>0</literalValue>
        <name>App 3 update on Resume Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_4_Final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>App 4 Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_4_Recall_Action</fullName>
        <field>Request_Status__c</field>
        <literalValue>Correction</literalValue>
        <name>App 4 Recall Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_4_on_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Approval Process in Progress</literalValue>
        <name>App 4 on Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_4_update_on_Resume_Approval</fullName>
        <field>Resubmit_Approval_Process__c</field>
        <literalValue>0</literalValue>
        <name>App 4 update on Resume Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_4_field_Update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approver 4 Approved</literalValue>
        <name>Approval 4 field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_status_app2_update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approver 2 Review</literalValue>
        <name>Approval status app2 update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved_2_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Reviewed by Approver 2</literalValue>
        <name>Approved 2 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver1_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sf_182_Approver_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approver1 Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver2_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sf_182_Approver_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approver2 Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver3_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sf_182_Approver_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approver3 Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver4_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sf_182_Approver_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approver4 Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_1_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Reviewed by Approver 1</literalValue>
        <name>Approver 1 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_1_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approver 1 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_2_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approver 2 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_2_Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Approver 2 Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_2_final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Approver 2 final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_3_Final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Approver 3 Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_3_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approver 3 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_3_Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Approver 3 Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_3_field_update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Reviewed by Approver 3</literalValue>
        <name>Approver 3 field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_4_rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Approver 4 rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approver_4_update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approver 4 update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cancelation_Update_for_book_and_maretial</fullName>
        <field>Books_and_Materials__c</field>
        <name>Cancelation Update for book and maretial</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cancellation_Update_for_Tuition_Fee</fullName>
        <field>Tuition_and_Fee__c</field>
        <name>Cancellation Update for Tuition Fee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_Supervisor</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Supervisor Review</literalValue>
        <name>Field Update Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Approval_check</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>Final Approval check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Approver_check</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>Final Approver check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Rejection_By_Approver4</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Final Rejection By Approver4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Rejection_by_Approver1</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Final Rejection by Approver1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Rejection_by_Approver2</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Final Rejection by Approver2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Rejection_by_Approver3</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Final Rejection by Approver3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Status_at_Approver1</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>Final Status at Approver1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_approver_update</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>Final approver update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_check_box_update</fullName>
        <field>Final_Approver__c</field>
        <literalValue>1</literalValue>
        <name>Final check box update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_field_Update</fullName>
        <field>Final_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Final field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_status</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>Final status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recordtype_update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sf_182_Approver_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Recordtype update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_by_Supervisor1</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected by Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_by_supervisor</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected by supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Cancel_Obligated_Updated</fullName>
        <field>Cancel_Obligated__c</field>
        <literalValue>1</literalValue>
        <name>SF 182 Cancel Obligated Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Cancelled_Not_Obligated_update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Cancelled Not Obligated</literalValue>
        <name>SF 182 Cancelled Not Obligated update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Cancelled_Obligated_update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Cancelled Obligated</literalValue>
        <name>SF 182 Cancelled Obligated update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Cumulative_Amount_Update</fullName>
        <field>Total_Cumulative_Amount__c</field>
        <formula>0</formula>
        <name>SF 182 Cumulative Amount Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_I_am_final_approver</fullName>
        <field>Final_Approver__c</field>
        <literalValue>0</literalValue>
        <name>SF 182 I am final approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Reject_Status_update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>SF 182 Reject Status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Roll_up_update</fullName>
        <field>SF182_Training_Total__c</field>
        <formula>Tuition_and_Fee__c + Books_and_Materials__c</formula>
        <name>SF 182 Roll up update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Update_Total_Cumulative</fullName>
        <field>Total_Cumulative_Amount__c</field>
        <formula>Appropriation_Fund_Direct_Cost__c</formula>
        <name>SF 182 Update Total Cumulative</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Update_Training_Total</fullName>
        <field>SF182_Training_Total__c</field>
        <formula>0</formula>
        <name>SF 182 Update Training Total</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_cancel_roll_up_update</fullName>
        <field>SF182_Training_Total__c</field>
        <formula>0</formula>
        <name>SF 182 cancel roll up update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_reject_approval_status</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>SF 182 reject approval status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf182_Recordtype_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sf182 Recordtype Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_Training_Approval_Status</fullName>
        <field>Approval_Status__c</field>
        <literalValue>New</literalValue>
        <name>Sf 182 Training Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_Training_Request_status_Update</fullName>
        <field>Request_Status__c</field>
        <literalValue>Cancellation</literalValue>
        <name>Sf 182 Training Request status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_Training_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sf 182 Training Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_Update_Grand_Total</fullName>
        <field>SF182_Training_Total__c</field>
        <name>Sf 182 Update Grand Total</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_approver4</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Reviewed by Approver 4</literalValue>
        <name>Sf 182 approver4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sf_182_update_TC_exp_date</fullName>
        <field>Continued_Srvc_Agreement_Accepted_Date__c</field>
        <formula>TODAY()</formula>
        <name>Sf 182 update TC exp date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Step_2_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Step 2 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Step_3_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Step 3 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Step_4_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Step 4 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Sup Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Final_Approval_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Purchasing_Training_Coordinator</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sup Final Approval Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Recall_Actions</fullName>
        <field>Request_Status__c</field>
        <literalValue>Correction</literalValue>
        <name>Sup Recall Actions</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Recall_update_on_Approver_Process</fullName>
        <field>Approval_Status__c</field>
        <literalValue>New</literalValue>
        <name>Sup Recall update on Approver Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Sup Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Rejected_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sup Rejected Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Rejection_Update_on_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sup Rejection Update on Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Step_1_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Sup Step 1 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Step_5_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Sup Step 5 Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sup_Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_RecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Sup Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Reviewed by Supervisor</literalValue>
        <name>Supervisor Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Final_Approval_update</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Supervisor Final Approval update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Rejected</fullName>
        <field>Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Supervisor Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Approval Process in Progress</literalValue>
        <name>Supervisor Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Supervisor_Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Supervisor Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Appropriation_Fund</fullName>
        <field>Appropriation_Fund_Direct_Cost__c</field>
        <formula>0</formula>
        <name>Update Appropriation Fund</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approver_Status</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Update Approver Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approver_Status_for</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Update Approver Status for</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Update Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Request_Status_for</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Update Request Status for</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_on_approval_status_1</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approver 1 Review</literalValue>
        <name>Update on approval status 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Training_Completed</fullName>
        <field>RecordTypeId</field>
        <lookupValue>SF_182_Training_Completed</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update to Training Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>approval_app4_in_Step4</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approver 4 Review</literalValue>
        <name>approval app4 in Step4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>approver_2_on_final_status</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>approver 2 on final status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>approver_3_on_final_status</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>approver 3 on final status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>approver_4_on_final_status</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>approver 4 on final status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>sf_182_Approver1</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approver 1 Approved</literalValue>
        <name>sf 182 Approver1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>sf_182_Approver2</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approver 2 Approved</literalValue>
        <name>sf 182 Approver2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>sf_182_Approver_3</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approver 3 Approved</literalValue>
        <name>sf 182 Approver 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>sf_182_Supervisor_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Supervisor Approved -Approver 1 Review</literalValue>
        <name>sf 182 Supervisor Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>supervisor_on_final_status</fullName>
        <field>Final_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>supervisor on final status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_app3_on_approval</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending Approver 3 Review</literalValue>
        <name>update app3 on approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SF 182</fullName>
        <actions>
            <name>SF_182_Cumulative_Amount_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_cancel_roll_up_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Cancelled Not Obligated</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_Obligated__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Cancelled Not Obligated</fullName>
        <actions>
            <name>SF_182_Cancelled_Not_Obligated_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_cancel_roll_up_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Was_Money_Obligated__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Cancelled Obligated</fullName>
        <actions>
            <name>SF_182_Cancelled_Obligated_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Was_Money_Obligated__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Rejected</fullName>
        <actions>
            <name>SF_182_Rejected_Status</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Rejected_Update_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_Reject_Status_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_Update_Training_Total</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_reject_approval_status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Request Approved and Funded</fullName>
        <actions>
            <name>SF_182_Approved_and_founded</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>SF_182_Request_Data_into_Pegasys</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Appropriation_Fund_Direct_Cost__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Resubmit for Approval</fullName>
        <actions>
            <name>SF_182_email_alert_to_Owner_on_Resubmit_for_Approval</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SF_182_Training__c.Resubmit_Approval_Process__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Training Completed</fullName>
        <actions>
            <name>Update_to_Training_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>SF_182_Training__c.Appropriation_Fund_Direct_Cost__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Training Completed Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Training_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Training_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SF_182_Training_End_Date_to_Complete_Training_Check_box</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Sf_182_Training_Completed_Check_for_10days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SF_182_Training_End_Date_to_Complete_Training_Check</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF 182 Training Completed Date OLD</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SF_182_Training__c.Training_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>notEqual</operation>
            <value>Rejected,Cancelled Obligated,Cancelled Not Obligated</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Training_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sf_182_Training_Completed_Check_for_10days_OLD</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SF_182_Training_End_Date_to_Complete_Training_Check_box_OLD</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF 182 Training Request Mark Complete Reminder</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Training_Completed__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>notEqual</operation>
            <value>Rejected,Cancelled Obligated,Cancelled Not Obligated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SF_182_Request_Email_Reminder_to_Mark_Complete</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_End_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF 182 Upcoming Training</fullName>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Training_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>notEqual</operation>
            <value>Rejected,Cancelled Obligated,Cancelled Not Obligated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SF_182_Upcoming_Training_Reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.Training_Start_Date__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF 182 Update Actual Cumulative Amount</fullName>
        <actions>
            <name>SF_182_Update_Total_Cumulative</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_Obligated__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Update Roll up</fullName>
        <actions>
            <name>SF_182_Roll_up_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Approval Process in Progress,Final Approval,Initiating,Correction</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 to Notify Purchasing Training Coordinator Group</fullName>
        <actions>
            <name>SF_182_Purchasing_Training_Coordinator_Group_Attention</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Approver_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Request_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>SF_182_Training__c.Purchasing_Training_Coordinator_Group__c</field>
            <operation>equals</operation>
            <value>IDP-IMS Program Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Books_and_Materials__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Tuition_and_Fee__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SF182 Approver1 Approval Notification</fullName>
        <actions>
            <name>Approver_1_Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c = &quot;&quot; ,Approver_3__c = &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False,ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 1&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Time_trigger_Approver_1_email_notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_10_days_Approver1_Email_notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF182 Approver2 Approval Notification</fullName>
        <actions>
            <name>Approver_2_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c != &quot;&quot; ,Approver_3__c = &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False,  ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 2&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_10_Days_Approver_2_Email_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_5_days_Approver_2_Email_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF182 Approver3 Approval Notification</fullName>
        <actions>
            <name>Approver_3_Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c != &quot;&quot; ,Approver_3__c != &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False,  ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 3&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_5_Day_s_Email_Notification_to_Approver_3</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_for_10_days_Email_Notification_to_Approver_3</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF182 Supervisor Approval Notification</fullName>
        <actions>
            <name>Approval_Supervisor_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND (Supervisor__c != &quot;&quot;,Approver_1__c = &quot;&quot; ,Approver_2__c = &quot;&quot; ,Approver_3__c = &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False,  ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Supervisor&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_5_day_Email_to_Supervisor</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Time_Trigger_10_days_Email_to_Supervisor</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SF_182_Training__c.LastModifiedDate</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SF182 Training Total cost</fullName>
        <actions>
            <name>SF_182_Cancel_Obligated_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_182_cancel_roll_up_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3) OR (1 AND 4)</booleanFilter>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Was_Money_Obligated__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Is_the_Money_Refundable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Was_Money_Obligated__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF182 User Approval Notification</fullName>
        <actions>
            <name>User_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>OR (  AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c = &quot;&quot; ,Approver_3__c = &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False,  ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Supervisor&apos;), Resubmit_Approval_Process__c = True),    AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c != &quot;&quot; ,Approver_3__c = &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False, ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 1&apos;),Resubmit_Approval_Process__c = True),    AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c != &quot;&quot; ,Approver_3__c != &quot;&quot;,Approver_4__c =&quot;&quot;,Final_Approver__c =False, ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 2&apos;),Resubmit_Approval_Process__c = True),    AND (Supervisor__c != &quot;&quot;,Approver_1__c != &quot;&quot; ,Approver_2__c != &quot;&quot; ,Approver_3__c != &quot;&quot;,Approver_4__c !=&quot;&quot;,Final_Approver__c =False, ISPICKVAL(Request_Status__c, &apos;Approval Process in Progress&apos;),ISPICKVAL( Approval_Status__c , &apos;Reviewed by Approver 3&apos;),Resubmit_Approval_Process__c = True)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sf 182 Training Update for Cancel</fullName>
        <actions>
            <name>Sf_182_Training_Request_status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SF_182_Training__c.Cancel_My_Training__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sf 182 Training update TC date</fullName>
        <actions>
            <name>Sf_182_update_TC_exp_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Terms_and_Conditions__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sf 182 to Notify Purchasing Training Coordinator</fullName>
        <actions>
            <name>SF_182_Purchasing_Training_Coordinator_Attention</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Approver_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Request_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>SF_182_Training__c.Purchasing_Training_Coordinator__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Books_and_Materials__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Tuition_and_Fee__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sf182 Record type update</fullName>
        <actions>
            <name>Sf182_Recordtype_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Approver_Status_for</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Request_Status_for</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SF_182_Training__c.Final_Approver__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Training_Completed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>SF_182_Training__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Approval Process in Progress</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
