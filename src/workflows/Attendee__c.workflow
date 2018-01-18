<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_Approval_Moved_to_Next_Step_OSC</fullName>
        <description>EA-Approval Moved to Next Step (OSC)</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Your_Attendee_approval_has_moved_to_the_next_step</template>
    </alerts>
    <alerts>
        <fullName>EA_Attendee_Denied</fullName>
        <description>EA - Attendee Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Approval_Attendee_Rejection</template>
    </alerts>
    <alerts>
        <fullName>EA_Update_OSC_Email_Approval_International</fullName>
        <description>EA Update - OSC Email Approval International</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Attendee_Request_moved_to_next_step</template>
    </alerts>
    <alerts>
        <fullName>Event_Approval_Attendee_Approved</fullName>
        <description>Event Approval - Attendee Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Event_Attendee_Approved</template>
    </alerts>
    <alerts>
        <fullName>Event_Approval_Attendee_Request_Moved_to_next_step</fullName>
        <description>Event Approval Attendee Request Moved to next step;</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Your_Attendee_approval_has_moved_to_the_next_step</template>
    </alerts>
    <alerts>
        <fullName>Event_Approval_Attendee_Submission_Confirmation</fullName>
        <description>Event Approval - Attendee Submission Confirmation</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Attendee_Submission_Conf</template>
    </alerts>
    <alerts>
        <fullName>Event_Tracker_OSC_Info</fullName>
        <ccEmails>press@gsa.gov</ccEmails>
        <description>Event Tracker-OSC-Info</description>
        <protected>false</protected>
        <recipients>
            <recipient>Event_Tracker_OSC_Info</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/Event_Approval_OSC_Info</template>
    </alerts>
    <alerts>
        <fullName>Information_only_email_to_OGC_for_non_federally_funded</fullName>
        <description>Information only email to OGC for non-federally funded Attendee</description>
        <protected>false</protected>
        <recipients>
            <recipient>Event_Tracker_OGC_Info</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/Event_Approval_Attendee_Request_w_non_federal_to_OGC</template>
    </alerts>
    <alerts>
        <fullName>Information_only_email_to_OMA_for_international_travel_attendee_request</fullName>
        <ccEmails>threat-management-office@gsa.gov</ccEmails>
        <description>Information only email to OMA for international travel attendee request</description>
        <protected>false</protected>
        <recipients>
            <recipient>Event_Tracker_OMA_Info</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/Event_Approval_Int_Attendee_Request_to_OMA</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Step_3_update</fullName>
        <description>Will move the approval step hidden field to Approval Step 3 (for workflow rule) upon approval on Step 2</description>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Approval Step 3 - OGC</literalValue>
        <name>Approval Step 3 update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approval_Step_Hidden_Denied</fullName>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Denied</literalValue>
        <name>Approval Step Hidden Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Attendee_Duplicate</fullName>
        <field>Attendee_Duplicate_Hidden__c</field>
        <formula>Attendee_Email_Address__c &amp; &quot; &quot; &amp;  Event_Number__r.Id</formula>
        <name>Attendee Duplicate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Attendee_Move_to_Approve</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Attendee Move to Approve</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Attendee_Move_to_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Attendee Move to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Attendee_Move_to_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Denied</literalValue>
        <name>Attendee Move to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Resubmit_button</fullName>
        <field>Resubmitting_For_Approval__c</field>
        <literalValue>1</literalValue>
        <name>Check Resubmit Button</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_attendee_field_update_status_new</fullName>
        <field>Status__c</field>
        <literalValue>New</literalValue>
        <name>Event attendee field update status new</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HSSO_Approval</fullName>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Approval Step 3 - User Choose</literalValue>
        <name>HSSO Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initialize_Process_Steps</fullName>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Approval Step 1 - User Choose</literalValue>
        <name>Initialize Process Steps</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_OAS_Approval_To_None</fullName>
        <field>OAS_Approval__c</field>
        <literalValue>None</literalValue>
        <name>Move OAS Approval To None</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_Approval_Step_2</fullName>
        <field>Approval_Step_Hidden__c</field>
        <name>Move to Approval Step 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>NextValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_HSSO_Approval</fullName>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Approval Step 3 - User Choose</literalValue>
        <name>Move to HSSO Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_OAS_Approval</fullName>
        <field>OAS_Approval__c</field>
        <literalValue>OAS Approval</literalValue>
        <name>Move to OAS Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_OGC_Approval</fullName>
        <field>Approval_Step_Hidden__c</field>
        <literalValue>Approval Step 4 - OGC</literalValue>
        <name>Move to OGC Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Payment_by_Entity_other_than_GSA_is_FAL</fullName>
        <field>Non_Federally_Funded__c</field>
        <literalValue>0</literalValue>
        <name>Payment by Entity other than GSA? is FAL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Payment_by_Entity_other_than_GSA_is_TRU</fullName>
        <description>Updates &quot;Payment by Entity other than GSA?&quot; to &quot;True&quot; on Attendee request</description>
        <field>Non_Federally_Funded__c</field>
        <literalValue>1</literalValue>
        <name>Payment by Entity other than GSA? is TRU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rescinded_Request_Workflow</fullName>
        <field>Status__c</field>
        <literalValue>Rescinded</literalValue>
        <name>Rescinded Request Workflow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_new</fullName>
        <field>Status__c</field>
        <literalValue>New</literalValue>
        <name>Status to new</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Resubmit</fullName>
        <field>Resubmitting_For_Approval__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Resubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Event Approval - Attendee - Federal Source Update</fullName>
        <actions>
            <name>Payment_by_Entity_other_than_GSA_is_FAL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attendee__c.Attendee_Type_of_Funding_None__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates &quot;Payment by Entity other than GSA?&quot; to FALSE when only federal funding is used</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee - International Travel to OMA</fullName>
        <actions>
            <name>Information_only_email_to_OMA_for_international_travel_attendee_request</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends an information-only email to OMA for all International Travel attendee requests</description>
        <formula>AND(  NOT(ISPICKVAL(PRIORVALUE(Status__c), &quot;In Progress&quot;)) , ISPICKVAL(Status__c, &quot;In Progress&quot;),  RecordType.DeveloperName = &quot;International_Travel&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee - Non Federally Funded</fullName>
        <actions>
            <name>Event_Approval_Attendee_Request_Moved_to_next_step</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Attendee__c.Approval_Step_Hidden__c</field>
            <operation>equals</operation>
            <value>Approval Step 3 - OGC</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Non_Federally_Funded__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Will send an email to the user, when a record is marked as non federally funded and the approval step is 3 so that they will not get the email that says that their record has been aprroved.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee - Non Federally Funded to Attendee</fullName>
        <actions>
            <name>Event_Approval_Attendee_Request_Moved_to_next_step</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Attendee__c.Approval_Step_Hidden__c</field>
            <operation>equals</operation>
            <value>Approval Step 3 - OGC</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Attendee_In_Kind_Travel__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Attendee_Waived_Registration_Fee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Attendee_Discounted_Registration__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Will send an email to the user, when a record is marked as non federally funded and the approval step is 3 so that they will not get the email that says that their record has been aprroved.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee - Non Federally Funded to OGC</fullName>
        <actions>
            <name>Information_only_email_to_OGC_for_non_federally_funded</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an information-only email to OGC if non-federally funded</description>
        <formula>AND(NOT(ISPICKVAL(PRIORVALUE(Status__c), &quot;In Progress&quot;)),  ISPICKVAL(Status__c, &quot;In Progress&quot;), OR ( Attendee_Discounted_Registration__c, Attendee_In_Kind_Travel__c,  Attendee_Waived_Registration_Fee__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee - Non-Federal Source Update</fullName>
        <actions>
            <name>Payment_by_Entity_other_than_GSA_is_TRU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>Attendee__c.Attendee_Discounted_Registration__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Attendee_Waived_Registration_Fee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Attendee_In_Kind_Travel__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates &quot;Payment by Entity other than GSA?&quot; to TRUE when non-federal funding is used</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Attendee Duplicate</fullName>
        <actions>
            <name>Attendee_Duplicate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attendee__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event approval rule attendee status new</fullName>
        <actions>
            <name>Event_attendee_field_update_status_new</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To default the Attendee status to New when the record is cloned from the other record.</description>
        <formula>NOT(ISPICKVAL( Status__c , &quot;New&quot;))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>EventTracker-Attendee-Speaking%2FPresenting-Yes</fullName>
        <actions>
            <name>Event_Tracker_OSC_Info</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Attendee__c.Speaking_presenting_at_conference_event__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Status__c</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Domestic Travel,International Travel</value>
        </criteriaItems>
        <description>Event Tracker - When user chooses &apos;Yes&apos; for &quot;Speaking/presenting at conference/event?&quot; and submits the request for approval to Supervisor, send an email to OSC-Info public group with press@gsa.gov email address</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Rescinded Request</fullName>
        <actions>
            <name>Rescinded_Request_Workflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attendee__c.Request_Rescinded__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updated the status to Rescinded once the Request Rescinded checkbox value is true</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Resubmit For Approval</fullName>
        <actions>
            <name>Status_to_new</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attendee__c.Resubmitting_For_Approval__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attendee__c.Status__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <description>Changes Status to new once Resubmit for approval is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
