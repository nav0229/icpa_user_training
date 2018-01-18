<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>App_user_access_and_enhancement</fullName>
        <ccEmails>app-support@gsa.gov</ccEmails>
        <description>App user access and enhancement</description>
        <protected>false</protected>
        <recipients>
            <field>ITSD_email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_Access</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_Bug_Question_Email_to_Insite</fullName>
        <description>Application Support Bug/Question Email to Insite</description>
        <protected>false</protected>
        <recipients>
            <field>GSAInsite__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_bug</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_Bug_Question_email_to_Gsadotgov</fullName>
        <description>Application Support Bug/Question email to Gsadotgov</description>
        <protected>false</protected>
        <recipients>
            <field>GSAdotGov_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_bug</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_Request_Bug_Question</fullName>
        <ccEmails>app-support@gsa.gov</ccEmails>
        <description>Application Support Request Bug Question</description>
        <protected>false</protected>
        <recipients>
            <field>ITSD_email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_bug</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_Request_Salesforce_User_access</fullName>
        <description>Application Support Request Salesforce User access</description>
        <protected>false</protected>
        <recipients>
            <field>ITSD_email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_Access</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_Request_salesforce_Bug</fullName>
        <description>Application Support Request salesforce Bug</description>
        <protected>false</protected>
        <recipients>
            <field>ITSD_email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_bug</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_email_to_Insite_and_GSAdotGov</fullName>
        <description>Application Support email to Insite and GSAdotGov</description>
        <protected>false</protected>
        <recipients>
            <field>GSAdotGov_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_Access</template>
    </alerts>
    <alerts>
        <fullName>Application_Support_email_to_insite</fullName>
        <description>Application Support email to insite</description>
        <protected>false</protected>
        <recipients>
            <field>GSAInsite__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Application_Support_Request_Access</template>
    </alerts>
    <alerts>
        <fullName>CM_Controlled_Document_Tracker_CDT</fullName>
        <ccEmails>cdtsupport@gsa.gov</ccEmails>
        <description>CM-Controlled Document Tracker (CDT)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/OCIO_for_CDT_Application</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_App_Owner_About_Cancelled_Case</fullName>
        <description>CM - Email App Owner About Cancelled Case</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>App_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_App_Owner_Cancelled</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_App_Owner_About_Closed_Case</fullName>
        <description>CM - Email App Owner About Closed Case</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_App_Owner_Closed</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_App_Owner_About_Completed_Case</fullName>
        <description>CM - Email App Owner About Completed Case</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>App_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_App_Owner_Closed</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_App_Owner_about_the_Case</fullName>
        <description>CM - Email App Owner about the Case</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_App_Owner</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_Case_assignment</fullName>
        <description>CM - Email Case assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Case_Assigned</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_Submitter_About_App_Owners_Denial</fullName>
        <description>CM - Email Submitter About App Owners Denial</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_AppOwner_Denied</template>
    </alerts>
    <alerts>
        <fullName>CM_Email_Submitter_App_Owner_About_Backlog_Case</fullName>
        <description>CM - Email Submitter App Owner About Backlog Case</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>App_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_Submitter_App_Owner_Backlog</template>
    </alerts>
    <alerts>
        <fullName>CM_Inform_App_Owner_Approved_Already</fullName>
        <description>CM - Inform App Owner Approved Already</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Inform_App_Owner_Approved</template>
    </alerts>
    <alerts>
        <fullName>CM_Inform_QA_Team</fullName>
        <ccEmails>sfreleasemgmt@gsa.gov</ccEmails>
        <description>CM - Inform Deployment Team</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CM_Inform_QA_Team</template>
    </alerts>
    <alerts>
        <fullName>CM_case_Ready_to_Deploy_status</fullName>
        <description>CM case Ready to Deploy status</description>
        <protected>false</protected>
        <recipients>
            <recipient>systemuser@gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Case_Ready_to_Deploy_status</template>
    </alerts>
    <alerts>
        <fullName>CM_case_waiting_on_app_owner_status</fullName>
        <ccEmails>app-support@gsa.gov</ccEmails>
        <description>CM case waiting on app owner status</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Case_Waiting_on_App_Owner_status</template>
    </alerts>
    <alerts>
        <fullName>FTRD_Referral_to_External_Agency_AutoEmail</fullName>
        <description>FTRD Referral to External Agency Auto-Email</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>travelpolicy@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>FTRD_Emails/FTRD_Referral_Agency_Auto_Email</template>
    </alerts>
    <alerts>
        <fullName>FTRD_Referral_to_External_Agency_Auto_Email</fullName>
        <description>FTRD Referral to External Agency Auto-Email</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>travelpolicy@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>FTRD_Emails/FTRD_Referral_Agency_Auto_Email</template>
    </alerts>
    <alerts>
        <fullName>FTRD_Thank_You_for_Submitting_a_Case</fullName>
        <description>FTRD Thank You for Submitting a Case</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <senderAddress>travelpolicy@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>FTRD_Emails/FTRD_Agency_Auto_ThankYou</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_AppOwner_RequestApproval</fullName>
        <description>OCIOTT-AppOwner-RequestApproval</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_AppOwner_RequestApproval</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Case_Owner_Rejected_by_ISSO</fullName>
        <description>OCIOTT-Case Owner-Rejected by ISSO</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_Case_Owner_Rejected_by_ISSO</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Case_Submitter_Rejected_by_ISSO</fullName>
        <description>OCIOTT-Case Submitter-Rejected by ISSO</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_Submitter_Rejected_by_ISSO</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_DepMgrs_ReadyToDeploy</fullName>
        <ccEmails>sfreleasemgmt@gsa.gov</ccEmails>
        <description>OCIOTT-DepMgrs-ReadyToDeploy</description>
        <protected>false</protected>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CM_Case_Ready_to_Deploy_status</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_DeploymentManagers_Review</fullName>
        <ccEmails>sfreleasemgmt@gsa.gov</ccEmails>
        <description>OCIOTT-DeploymentManagers-Review</description>
        <protected>false</protected>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_DeploymentManagers_Review</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_DevMgr_RequestApproval</fullName>
        <description>OCIOTT-DevMgr-RequestApproval</description>
        <protected>false</protected>
        <recipients>
            <recipient>systemuser@gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_DevMg_RequestApproval</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Pending_App_Owner_Appr_from_5_Days</fullName>
        <description>OCIOTT-Pending App Owner Appr from 5 Days</description>
        <protected>false</protected>
        <recipients>
            <field>App_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_2__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_3__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner_4__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Secondary_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_Pending_App_Owner_Appr_from_5_Days</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Pending_App_Owner_Appr_from_6_Days</fullName>
        <description>OCIOTT-Pending App Owner Appr from 6 Days</description>
        <protected>false</protected>
        <recipients>
            <recipient>app-support@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_Pending_App_Owner_Appr_from_6_Days</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Security_Package_Review_Recalled</fullName>
        <description>OCIOTT-Security Package/Review Recalled</description>
        <protected>false</protected>
        <recipients>
            <recipient>systemuser@gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_ISSO_CANCELLED_Security_Review_Package_Request</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_SolArch_RequestApproval</fullName>
        <description>OCIOTT-SolArch-RequestApproval</description>
        <protected>false</protected>
        <recipients>
            <recipient>systemuser@gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_SolArch_RequestApproval</template>
    </alerts>
    <alerts>
        <fullName>OCIOTT_Submitter_New_Case</fullName>
        <description>OCIOTT-Submitter-New Case</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <senderAddress>app-support@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/OCIOTT_CurrentStateNew_Submitter</template>
    </alerts>
    <alerts>
        <fullName>PDE_Assigned_to_PDE_Budget_Analyst_Users</fullName>
        <description>PDE In PDE Budget Analyst Users Queue</description>
        <protected>false</protected>
        <recipients>
            <recipient>PDE CC Recipient</recipient>
            <type>caseTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Assigned_to_PDE_Budget_Analyst_Users</template>
    </alerts>
    <alerts>
        <fullName>PDE_Assigned_to_PDE_CPG_Users</fullName>
        <ccEmails>recurringservices@gsa.gov</ccEmails>
        <description>PDE-Assigned to PDE CPG Users</description>
        <protected>false</protected>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Assigned_to_PDE_CPG_Users</template>
    </alerts>
    <alerts>
        <fullName>PDE_Assigned_to_PDE_Users</fullName>
        <description>PDE Assigned to PDE Users Queue</description>
        <protected>false</protected>
        <recipients>
            <recipient>PDE CC Recipient</recipient>
            <type>caseTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Assigned_to_PDE_Users</template>
    </alerts>
    <alerts>
        <fullName>PDE_Case_Cancelled_Email</fullName>
        <description>PDE-Case Cancelled Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>PDE CC Recipient</recipient>
            <type>caseTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Status_Change_to_Cancelled</template>
    </alerts>
    <alerts>
        <fullName>PDE_Case_Closed_Email</fullName>
        <description>PDE-Case Closed Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>PDE CC Recipient</recipient>
            <type>caseTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Status_Change_to_Closed</template>
    </alerts>
    <alerts>
        <fullName>PDE_Case_In_Progress_Email</fullName>
        <description>PDE Case In Progress Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>PDE CC Recipient</recipient>
            <type>caseTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pegasysdataentrytoolinbox@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>PDE/PDE_Case_Status_Change_to_In_Progress</template>
    </alerts>
    <alerts>
        <fullName>Thank_you_for_contacting_the_GSA</fullName>
        <description>Thank you for contacting the GSA!</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FTRD_Emails/FTRD_Referral_Agency_Auto_ThankYou</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Close_of_Case</fullName>
        <description>This field update changes the Case Status to Closed.</description>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Auto-Close of Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CM_Change_Task_Status_to_Cancelled</fullName>
        <description>CM -Change Task Status to Cancelled</description>
        <field>Task_Status__c</field>
        <literalValue>Canceled</literalValue>
        <name>CM -Change Task Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Owner_Deployment_Manager</fullName>
        <description>The Case is assigned to Deployment Manager Queue after approval.</description>
        <field>OwnerId</field>
        <lookupValue>OCIO_Task_Tracking_Deployment_Managers</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Case Owner Deployment Manager</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LoE_Minutes_Default_to_zero</fullName>
        <description>LoE Minutes Default to zero</description>
        <field>LoE_Minutes__c</field>
        <literalValue>0</literalValue>
        <name>LoE Minutes Default to zero</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CaseOwner_Tier0Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>OCIO_Task_Tracking_Triage</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>OCIOTT-CaseOwner-Tier0Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_NeedAppOwnerAppr</fullName>
        <field>Need_App_Owner_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-NeedAppOwnerAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_NeedSolArchAppr</fullName>
        <field>Need_Sol_Arch_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-NeedSolArchAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_NeedSystemApproval</fullName>
        <field>Need_System_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-NeedSystemApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_ReceivedAutoApprovBySystem</fullName>
        <field>Received_Auto_Approval_by_Sytem__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-ReceivedAutoApprovBySystem</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_ReceivedDevMgrAppr</fullName>
        <field>Received_Dev_Mgr_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-ReceivedDevMgrAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_ReceivedSecurityPackage</fullName>
        <description>Received Security Package field will update once approved by ISSO</description>
        <field>Received_Security_Pkg__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-ReceivedSecurityPackage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_ReceivedSecurityReview</fullName>
        <field>Received_Security_Review__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-ReceivedSecurityReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_ReceivedSolArchApproval</fullName>
        <field>Received_Sol_Arch_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-ReceivedSolArchApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Check_RecievedAppOwnerAppr</fullName>
        <field>Received_App_Owner_Approval__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Check-RecievedAppOwnerAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Cancelled</fullName>
        <field>Current_State__c</field>
        <literalValue>Cancelled</literalValue>
        <name>OCIOTT-CurrentState-Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Closed</fullName>
        <field>Current_State__c</field>
        <literalValue>Closed</literalValue>
        <name>OCIOTT-CurrentState-Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Completed</fullName>
        <field>Current_State__c</field>
        <literalValue>Completed</literalValue>
        <name>OCIOTT-CurrentState-Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_DeniedByAppOwner</fullName>
        <field>Current_State__c</field>
        <literalValue>Denied by App Owner</literalValue>
        <name>OCIOTT-CurrentState-DeniedByAppOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Denied_Re_Submit</fullName>
        <field>Current_State__c</field>
        <literalValue>Denied - Re-Submit</literalValue>
        <name>OCIOTT-CurrentState-Denied-Re-Submit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_DevInProgress</fullName>
        <field>Current_State__c</field>
        <literalValue>Development In Progress</literalValue>
        <name>OCIOTT-CurrentState-DevInProgress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_New</fullName>
        <field>Current_State__c</field>
        <literalValue>New</literalValue>
        <name>OCIOTT-CurrentState-New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_PendPreProdValid</fullName>
        <description>Update Current State to &quot;Pending Pre-Prod Validation&quot; if the OCIO Case Tracker has Resolution Types that require a Security Review</description>
        <field>Current_State__c</field>
        <literalValue>Pending Pre-Prod Validation</literalValue>
        <name>OCIOTT-CurrentState-PendPreProdValid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_PendingAppOwner</fullName>
        <field>Current_State__c</field>
        <literalValue>Pending App Owner</literalValue>
        <name>OCIOTT-CurrentState-PendingAppOwner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_PendingDevMgrAppr</fullName>
        <field>Current_State__c</field>
        <literalValue>Pending Dev Mgr Approval</literalValue>
        <name>OCIOTT-CurrentState-PendingDevMgrAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_PendingSolArchAppr</fullName>
        <field>Current_State__c</field>
        <literalValue>Pending Sol Arch Approval</literalValue>
        <name>OCIOTT-CurrentState-PendingSolArchAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Pending_PostProd</fullName>
        <field>Current_State__c</field>
        <literalValue>Pending Post-Prod Validation</literalValue>
        <name>OCIOTT-CurrentState-Pending PostProd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Pending_Rel_Mgr</fullName>
        <field>Current_State__c</field>
        <literalValue>Pending Rel Mgr Approval</literalValue>
        <name>OCIOTT-CurrentState-Pending Rel. Mgr.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_Pending_SecurityPkg</fullName>
        <description>Current State field will update value to &quot;Pending Security Package&quot; if an OCIO Task Tracker has Resolution Types that require a Security Package</description>
        <field>Current_State__c</field>
        <literalValue>Pending Security Package</literalValue>
        <name>OCIOTT-CurrentState-Pending SecurityPkg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_ReadyToDeploy</fullName>
        <field>Current_State__c</field>
        <literalValue>Ready To Deploy</literalValue>
        <name>OCIOTT-CurrentState-ReadyToDeploy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_ResolTypeAssign</fullName>
        <field>Current_State__c</field>
        <literalValue>Resolution Type Assignment</literalValue>
        <name>OCIOTT-CurrentState-ResolTypeAssign</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_CurrentState_TransferredToBacklog</fullName>
        <field>Current_State__c</field>
        <literalValue>Transferred to Backlog</literalValue>
        <name>OCIOTT-CurrentState-TransferredToBacklog</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Email2Case_FillEmailField</fullName>
        <field>Email__c</field>
        <formula>SuppliedEmail</formula>
        <name>OCIOTT-Email2Case-FillEmailField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Email2Case_FillFirstNameField</fullName>
        <field>First_Name__c</field>
        <formula>Contact.FirstName</formula>
        <name>OCIOTT-Email2Case-FillFirstNameField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Email2Case_FillLastNameField</fullName>
        <field>Last_Name__c</field>
        <formula>Contact.LastName</formula>
        <name>OCIOTT-Email2Case-FillLastNameField</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_OwnertoQueue</fullName>
        <field>OwnerId</field>
        <lookupValue>OCIO_Task_Tracking_Triage</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>OCIOTT-OwnertoQueue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Status_Not_Applicable</fullName>
        <field>Status</field>
        <literalValue>Not Applicable</literalValue>
        <name>OCIOTT-Status-Not Applicable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_TaskStatus_InProgress</fullName>
        <field>Task_Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>OCIOTT-TaskStatus-InProgress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Tier_0</fullName>
        <field>Tier__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-Tier-0</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Tier_1</fullName>
        <field>Tier__c</field>
        <literalValue>1</literalValue>
        <name>OCIOTT-Tier-1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_NeedAppOwnerAppr</fullName>
        <field>Need_App_Owner_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-NeedAppOwnerAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_NeedDevMgrAppr</fullName>
        <field>Need_Dev_Mgr_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-NeedDevMgrAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_NeedSolArchApproval</fullName>
        <field>Need_Sol_Arch_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-NeedSolArchApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedAppOwnerAppr</fullName>
        <field>Received_App_Owner_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedAppOwnerAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedAutoApproBySystem</fullName>
        <field>Received_Auto_Approval_by_Sytem__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedAutoApproBySystem</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedDevMgrAppr</fullName>
        <field>Received_Dev_Mgr_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedDevMgrAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedSecurityPkgAppr</fullName>
        <field>Received_Security_Pkg__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedSecurityPkgAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedSecurityReview</fullName>
        <field>Received_Security_Review__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedSecurityReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_UnCheck_ReceivedSolArchAppr</fullName>
        <field>Received_Sol_Arch_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-UnCheck-ReceivedSolArchAppr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OCIOTT_Uncheck_NeedSystemApproval</fullName>
        <field>Need_System_Approval__c</field>
        <literalValue>0</literalValue>
        <name>OCIOTT-Uncheck-NeedSystemApproval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Assign2PDE_BudgetAnalystUsers</fullName>
        <field>OwnerId</field>
        <lookupValue>PDE_BudgetAnalystUsers_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>PDE-Assign 2 PDE Budget Analyst Users</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Assign_2_PDE_CPG_Users_Queue</fullName>
        <description>PDE Assign 2 PDE CPG Users queue.</description>
        <field>OwnerId</field>
        <lookupValue>PDE_CPGUsersQueue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>PDE-Assign 2 PDE CPG Users Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Assign_to_PDE_Users_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>PDE_Users_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>PDE-Assign to PDE Users Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Change_Record_Type_to_Locked_when_Cl</fullName>
        <description>Updates Record Type to Pegasys Data Entry - Locked</description>
        <field>RecordTypeId</field>
        <lookupValue>Pegasys_Data_Entry_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PDE-Change Record Type to Locked when Cl</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Change_Record_Type_to_Open_when_Cl</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Pegasys_Data_Entry</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PDE-Change Record Type to Open when Cl</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Change_Status_2_Pending_Assig_CPG</fullName>
        <description>PDE Change Status to Pending Assignment for new cases that start with 1B, RB, or EK</description>
        <field>Status</field>
        <literalValue>Pending Assignment</literalValue>
        <name>PDE-Change Status 2 Pending Assig. CPG</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Change_Status_to_Pending_Assignment</fullName>
        <field>Status</field>
        <literalValue>Pending Assignment</literalValue>
        <name>PDE-Change Status to Pending Assignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Status_2Pending_Bud_Analyst_Approval</fullName>
        <field>Status</field>
        <literalValue>Pending Budget Analyst Approval</literalValue>
        <name>PDE-Status 2Pending Bud Analyst Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PDE_Update_Record_Type_from_Locked</fullName>
        <description>PDE change record type to Open Record Type when the Status is moved from Closed</description>
        <field>RecordTypeId</field>
        <lookupValue>Pegasys_Data_Entry</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>PDE-Update Record Type from Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_Prior_notification_to_App_Owner</fullName>
        <field>Prior_notification_to_App_Owner__c</field>
        <literalValue>1</literalValue>
        <name>update Prior notification to App Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>App Support Bug%2FQuestion email to GSAdotGov</fullName>
        <actions>
            <name>Application_Support_Bug_Question_email_to_Gsadotgov</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAdotGov_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to GSAdotGov upon creation of a bug or question Application Support Request for a GSAdotGov subcategory application; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>App Support Bug%2FQuestion email to ITSD</fullName>
        <actions>
            <name>Application_Support_Request_Bug_Question</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov,InSite,Salesforce,Other</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <description>Email notification to ITSD upon creation of a bug or question Application Support Request; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>App Support Bug%2FQuestion email to InSite</fullName>
        <actions>
            <name>Application_Support_Bug_Question_Email_to_Insite</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAInsite__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to Insite upon creation of a bug or question Application Support Request for an InSite subcategory application; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>App Support Enhancement%2FUser Access email to GSAdotGov</fullName>
        <actions>
            <name>Application_Support_email_to_Insite_and_GSAdotGov</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAdotGov_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to GSAdotGov upon creation of an enhancement or user access Application Support Request; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>App Support Enhancement%2FUser Access email to ITSD</fullName>
        <actions>
            <name>App_user_access_and_enhancement</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite,GSAdotGov,Salesforce,Other</value>
        </criteriaItems>
        <description>Email notification to ITSD upon creation of an enhancement or user access Application Support Request; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>App Support Enhancement%2FUser Access email to Insite</fullName>
        <actions>
            <name>Application_Support_email_to_insite</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAInsite__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to InSite upon creation of an enhancement or user access Application Support Request; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support Request bug email</fullName>
        <actions>
            <name>Application_Support_Bug_Question_email_to_Gsadotgov</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAdotGov_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Bug email to GSAdotGov</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support Request bug question</fullName>
        <actions>
            <name>Application_Support_Request_Bug_Question</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov,InSite</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support Request bug%2FQuestion email</fullName>
        <actions>
            <name>Application_Support_Bug_Question_Email_to_Insite</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAInsite__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Bug email to Insite</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support Request forcebug</fullName>
        <actions>
            <name>Application_Support_Request_salesforce_Bug</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Bug / Defect,Application Question</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>Salesforce</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support Request salesforce</fullName>
        <actions>
            <name>Application_Support_Request_Salesforce_User_access</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>Salesforce</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application Support user access</fullName>
        <actions>
            <name>App_user_access_and_enhancement</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite,GSAdotGov</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application support Enhancement%2Fuser access Email</fullName>
        <actions>
            <name>Application_Support_email_to_Insite_and_GSAdotGov</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>GSAdotGov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAdotGov_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>email to GSAdotGov</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Application support email to Insite</fullName>
        <actions>
            <name>Application_Support_email_to_insite</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Issue_Type_del__c</field>
            <operation>equals</operation>
            <value>Enhancement,User Access</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subcategoryapp__c</field>
            <operation>equals</operation>
            <value>InSite</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.GSAInsite__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>email to GSAinsite</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Auto-Close of Case</fullName>
        <actions>
            <name>Auto_Close_of_Case</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Referral Queue</value>
        </criteriaItems>
        <description>This rule will automatically close a Case if the Queue equals Referral Queue.  Supports the FTRD Web-to-Case management process.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CM -  Case Ready to Deploy status</fullName>
        <actions>
            <name>CM_case_Ready_to_Deploy_status</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Email notification sent to Tech Leads when Task Status is set to &quot;Ready to Deploy&quot;; supports the OCIO Task Tracking app</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISPICKVAL(  Current_State__c , &apos;Ready to Deploy&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM -  Case Waiting on App Owner status</fullName>
        <actions>
            <name>CM_case_waiting_on_app_owner_status</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Task_Status__c</field>
            <operation>equals</operation>
            <value>Waiting on App Owner</value>
        </criteriaItems>
        <description>Email notification sent to App Owner and App-Support when Task Status is set to &quot;Waiting on App Owner&quot;; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Cancel Disapproved Case</fullName>
        <actions>
            <name>CM_Change_Task_Status_to_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Disapproved</value>
        </criteriaItems>
        <description>Task Status is updated to &quot;Canceled&quot; when Status is &quot;Disapproved&quot;; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Case Assigment Rule</fullName>
        <actions>
            <name>CM_Email_Case_assignment</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>This rule is executed when Assignment changes</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISCHANGED( Assignment__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CM - Case Assignment Rule</fullName>
        <actions>
            <name>CM_Email_Case_assignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email notification to new Assigned user; supports the OCIO Task Tracking app</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CM - Get App Owner Info</fullName>
        <actions>
            <name>CM_Email_App_Owner_about_the_Case</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Email notification to App Owner when Status is not &quot;Approved&quot;; supports the OCIO Task Tracking app</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; OR( ISNEW(), ISCHANGED(GPM_Project__c )) &amp;&amp; NOT(ISPICKVAL( Status , &apos;Approved&apos;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform App Owner Backlog Case Info</fullName>
        <actions>
            <name>CM_Email_Submitter_App_Owner_About_Backlog_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Transferred to Backlog</value>
        </criteriaItems>
        <description>Email notification to App Owner when Task Status is &quot;Canceled&quot;; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform App Owner Canceled Case Info</fullName>
        <actions>
            <name>CM_Email_App_Owner_About_Cancelled_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <description>Email notification to App Owner when Task Status is &quot;Canceled&quot;; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform App Owner Cancelled Case Info</fullName>
        <actions>
            <name>CM_Email_App_Owner_About_Cancelled_Case</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Task_Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <description>CM - Inform App Owner Cancelled Case Info</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform App Owner Completed Case Info</fullName>
        <actions>
            <name>CM_Email_App_Owner_About_Completed_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Email notification to App Owner when Task Status is &quot;Completed&quot;; supports the OCIO Task Tracking app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform Owner Approved Already</fullName>
        <actions>
            <name>CM_Inform_App_Owner_Approved_Already</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email notification to App Owner upon creation of an approved task; supports the OCIO Task Tracking app</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISNEW() &amp;&amp;  ISPICKVAL( Status , &apos;Approved&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CM - Inform QA Team</fullName>
        <actions>
            <name>CM_Inform_QA_Team</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Case_Owner_Deployment_Manager</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Email notification to Deployment Team when Task Status is set to &quot;Testing&quot;; supports the OCIO Task Tracking app</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISCHANGED( Task_Status__c ) &amp;&amp; ISPICKVAL( Task_Status__c , &apos;Testing&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CM-Controlled Document Tracker %28CDT%29</fullName>
        <actions>
            <name>CM_Controlled_Document_Tracker_CDT</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Hidden_Project_Name__c</field>
            <operation>contains</operation>
            <value>Controlled Document Tracker</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>FTRD Agency Auto-Email</fullName>
        <actions>
            <name>FTRD_Thank_You_for_Submitting_a_Case</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Thank_You_Email_Sent</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>FTRD Queue</value>
        </criteriaItems>
        <description>The workflow rule supports all actions that occur when a Case has been submitted via the web to which the FTRD much respond.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>FTRD Referral Agency Auto-Email</fullName>
        <actions>
            <name>FTRD_Referral_to_External_Agency_AutoEmail</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Thank_you_for_contacting_the_GSA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Auto_Referral_Email</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Thank_You_Email_Sent</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Referral Queue</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>FTRD Web-to-Case</value>
        </criteriaItems>
        <description>This workflow rule sends an email to a referral agency when a question for an outside source is submitted via the FTRD web-to-case process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Make_default_LoE_Minutes_to_zero</fullName>
        <actions>
            <name>LoE_Minutes_Default_to_zero</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Make default LoE to zero</description>
        <formula>$RecordType.Name = &apos;OCIO Task Tracking&apos; &amp;&amp; ISPICKVAL( LoE_Minutes__c , &quot;&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-Application-Change</fullName>
        <actions>
            <name>OCIOTT_CaseOwner_Tier0Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Check_NeedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_CurrentState_New</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_TaskStatus_InProgress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Tier_0</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAutoApproBySystem</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Uncheck_NeedSystemApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Upon Changing Case Type to Application</description>
        <formula>AND (    OR(      ISCHANGED( Application_Module__c ),     ISCHANGED( Case_Type__c )    ),   ISPICKVAL( Case_Type__c , &quot;Application&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-Email2Case-Created</fullName>
        <actions>
            <name>OCIOTT_Email2Case_FillEmailField</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Email2Case_FillFirstNameField</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Email2Case_FillLastNameField</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Status_Not_Applicable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Upon New Case Creation of the Origin: Email</description>
        <formula>AND((CaseNumber != Null),if(ISPICKVAL(Origin,&apos;Email&apos;),True,False),(SuppliedEmail != Null))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-NewCase-Type-Application</fullName>
        <actions>
            <name>OCIOTT_Submitter_New_Case</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>OCIOTT_Check_NeedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_CurrentState_New</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_TaskStatus_InProgress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Tier_0</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAutoApproBySystem</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedDevMgrAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedSolArchAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Uncheck_NeedSystemApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Case_Type__c</field>
            <operation>equals</operation>
            <value>Application</value>
        </criteriaItems>
        <description>Upon New Case Creation of the Type: Application</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-NewCase-Type-System</fullName>
        <actions>
            <name>OCIOTT_Submitter_New_Case</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>OCIOTT_CaseOwner_Tier0Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Check_NeedSystemApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_CurrentState_New</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_TaskStatus_InProgress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Tier_0</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_NeedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAutoApproBySystem</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedDevMgrAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedSolArchAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Case_Type__c</field>
            <operation>equals</operation>
            <value>System</value>
        </criteriaItems>
        <description>Upon New Case Creation of the Type: System</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-OwnertoQueue-Change</fullName>
        <actions>
            <name>OCIOTT_OwnertoQueue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email,IT Service Desk</value>
        </criteriaItems>
        <description>Upon case creation, case owner changes to Triage queue.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-Pending App Owner Appr from 5 Days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Pending App Owner</value>
        </criteriaItems>
        <description>Sends a Notification to App Owner, when a case is waiting for App Owner&apos;s approval from 5 days.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OCIOTT_Pending_App_Owner_Appr_from_5_Days</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OCIOTT-Pending App Owner Appr from 6 Days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Pending App Owner</value>
        </criteriaItems>
        <description>Sends a Notification to App Support Team, when a case is waiting for App Owner&apos;s approval from 6 days.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OCIOTT_Pending_App_Owner_Appr_from_6_Days</name>
                <type>Alert</type>
            </actions>
            <timeLength>6</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OCIOTT-Status-Closed</fullName>
        <actions>
            <name>OCIOTT_CurrentState_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>OCIO Task Tracking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_State__c</field>
            <operation>equals</operation>
            <value>Completed,Cancelled,Transferred to Backlog</value>
        </criteriaItems>
        <description>Upon Closing a Case, Change CurrentState field to Closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OCIOTT-System-Change</fullName>
        <actions>
            <name>OCIOTT_CaseOwner_Tier0Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Check_NeedSystemApproval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_CurrentState_New</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_TaskStatus_InProgress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_Tier_0</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_NeedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAppOwnerAppr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OCIOTT_UnCheck_ReceivedAutoApproBySystem</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Upon Changing Case Type to System</description>
        <formula>AND (    OR(      ISCHANGED( Application_Module__c ),     ISCHANGED( Case_Type__c )    ),   ISPICKVAL( Case_Type__c , &quot;System&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 1a%3A Case Assign to PDE Budget Analyst Queue</fullName>
        <actions>
            <name>PDE_Assign2PDE_BudgetAnalystUsers</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PDE_Status_2Pending_Bud_Analyst_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_Source_Document__c</field>
            <operation>equals</operation>
            <value>Order/Award,Amendment/Mod</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_PDN__c</field>
            <operation>startsWith</operation>
            <value>1B,RB,EK</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_Attachments_To_Load_Counter__c</field>
            <operation>equals</operation>
            <value>-1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry</value>
        </criteriaItems>
        <description>This workflow rule will change status to &quot;Pending Budget Analyst Approval&quot; when the record is created, meets the criteria, and assigns the case to the PDE Budget Analyst Users Queue.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 1b%3A Case Assign to PDE Budget Analyst Users Queue</fullName>
        <actions>
            <name>PDE_Assign2PDE_BudgetAnalystUsers</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow rule will change the owner to PDE Budget Analyst Users and send an email to owners when the status is changed from &quot;Pending Assignment&quot; to &quot;Pending Budget Analyst Approval&quot;.  Will assign the case to the PDE Budget Analyst User Queue.</description>
        <formula>AND(  $RecordType.Name = &quot;Pegasys Data Entry&quot;,  ISCHANGED(Status),  ISPICKVAL(PRIORVALUE(Status),&quot;Pending Assignment&quot;),  ISPICKVAL(Status,&quot;Pending Budget Analyst Approval&quot;), OR(ISPICKVAL(PDE_Source_Document__c,&quot;Order/Award&quot;),  ISPICKVAL(PDE_Source_Document__c,&quot;Amendment/Mod&quot;)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 1c%3A Case Assign to PDE Users Queue</fullName>
        <actions>
            <name>PDE_Assign_to_PDE_Users_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PDE_Change_Status_to_Pending_Assignment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND NOT 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>New,Pending Budget Analyst Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_PDN__c</field>
            <operation>startsWith</operation>
            <value>1B,RB,EK</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_Attachments_To_Load_Counter__c</field>
            <operation>equals</operation>
            <value>-1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry</value>
        </criteriaItems>
        <description>This workflow rule will change status to &quot;Pending Assignment&quot; when the record is created and assign the case to the PDE Users Queue if the PDN does not start with 1B, RB, or EK.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 1d%3A Case Assign to PDE CPG Users Queue</fullName>
        <actions>
            <name>PDE_Assigned_to_PDE_CPG_Users</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PDE_Assign_2_PDE_CPG_Users_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PDE_Change_Status_2_Pending_Assig_CPG</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>startsWith</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_Attachments_To_Load_Counter__c</field>
            <operation>equals</operation>
            <value>-1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_PDN__c</field>
            <operation>startsWith</operation>
            <value>1B,RB,EK</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.PDE_Source_Document__c</field>
            <operation>notEqual</operation>
            <value>Order/Award,Amendment/Mod</value>
        </criteriaItems>
        <description>This workflow rule will change status to &quot;Pending Assignment&quot; when the record is created and assign the case to the PDE CPG Users Queue if the PDN start s with 1B, RB, or EK and the source document is not Order/Award or Amendment/Mod</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 2%3A Case Assign to PDE CPG Users Queue After Pending Approval</fullName>
        <actions>
            <name>PDE_Assigned_to_PDE_CPG_Users</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PDE_Assign_2_PDE_CPG_Users_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will update the case owner to the PDE CPG Queue after the Status is updated from Pending Budget Analyst Approval to Pending Assignment and the PDN starts with 1B, RB, or EK</description>
        <formula>AND(  $RecordType.Name = &quot;Pegasys Data Entry&quot;,  ISCHANGED(Status),  OR(ISPICKVAL(PRIORVALUE(Status),&quot;Pending Budget Analyst Approval&quot;), ISPICKVAL(PRIORVALUE(Status),&quot;Issues&quot;)),  ISPICKVAL(Status,&quot;Pending Assignment&quot;), OR( BEGINS( PDE_PDN__c , &quot;1B&quot;),  BEGINS( PDE_PDN__c , &quot;RB&quot;), BEGINS( PDE_PDN__c , &quot;EK&quot;)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE 3%3A Case In Progress Rule</fullName>
        <actions>
            <name>PDE_Case_In_Progress_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry,Pegasys Data Entry - Locked</value>
        </criteriaItems>
        <description>This workflow rule will send out an email to the record creator and case team when the case is put in progress and assigned to a user.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PDE 4%3A Case Closed Rule</fullName>
        <actions>
            <name>PDE_Case_Closed_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry,Pegasys Data Entry - Locked</value>
        </criteriaItems>
        <description>This workflow sends an email to the record creator and case team when the case is closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PDE 5%3A Case Cancelled Rule</fullName>
        <actions>
            <name>PDE_Case_Cancelled_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Pegasys Data Entry,Pegasys Data Entry - Locked</value>
        </criteriaItems>
        <description>This workflow will send an email to the record creator and case team when the status is changed to cancelled.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PDE Change Record Type to Locked when Closed</fullName>
        <actions>
            <name>PDE_Change_Record_Type_to_Locked_when_Cl</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow rule will change cases in the Pegasys Data Entry record type to the Pegasys Data Entry - Locked record type when the status is changed to Closed.  This is to prevent anyone from editing closed cases.</description>
        <formula>AND(  $RecordType.Name = &quot;Pegasys Data Entry&quot;,  ISCHANGED(Status),  NOT(ISPICKVAL(PRIORVALUE(Status),&quot;Closed&quot;)),  ISPICKVAL(Status,&quot;Closed&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PDE Change Record Type to Open when Previously Closed</fullName>
        <actions>
            <name>PDE_Change_Record_Type_to_Open_when_Cl</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow rule will change cases in the Pegasys Data Entry - Locked record type to the Pegasys Data Entry record type when the status was Closed.  This is to reopen closed cases.</description>
        <formula>AND($RecordType.Name = &quot;Pegasys Data Entry - Locked&quot;,  ISCHANGED(Status),  (ISPICKVAL(PRIORVALUE(Status),&quot;Closed&quot;)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Work flow to select Prior notification to App Owner</fullName>
        <actions>
            <name>update_Prior_notification_to_App_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Iteration__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Auto_Referral_Email</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.ClosedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Auto Referral Email</subject>
    </tasks>
    <tasks>
        <fullName>Thank_You_Email_Sent</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Thank You Email Sent</subject>
    </tasks>
</Workflow>
