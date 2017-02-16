<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Chat_survey_workflow_action</fullName>
        <description>Chat survey workflow action</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>USAGov/Chat_Survey_Text</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_1</fullName>
        <description>Email Queue 1</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_1</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_2</fullName>
        <description>Email Queue 2</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_2</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_3</fullName>
        <description>Email Queue 3</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_3</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_4</fullName>
        <description>Email Queue 4</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_4</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_5</fullName>
        <description>Email Queue 5</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_5</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Queue_6</fullName>
        <description>Email Queue 6</description>
        <protected>false</protected>
        <recipients>
            <recipient>FCIC_Assignment_Rule_Group_6</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Feedback_Creator_Rule</fullName>
        <description>Feedback Creator Rule</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>fcicsfsupport@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Feedback_Case_Closed</template>
    </alerts>
    <alerts>
        <fullName>Feedback_Email_Task_Ru</fullName>
        <ccEmails>shennessey@acumensolutions.com</ccEmails>
        <description>Feedback Email Task Ru</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>gsafcictest@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Article_Feedback_Assignment_Template</template>
    </alerts>
    <alerts>
        <fullName>Immediate_Survey_Action_Chat</fullName>
        <description>Immediate Survey Action - Chat</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email_address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>USAGov/Chat_Survey_Text</template>
    </alerts>
    <alerts>
        <fullName>Immediate_Webform_Survey</fullName>
        <description>Immediate Webform Survey</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email_address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>USAGov/Webform_Survey_Text</template>
    </alerts>
    <alerts>
        <fullName>Survey_Feedback_Test</fullName>
        <description>Survey Feedback Test</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Sample_Survey_Template</template>
    </alerts>
    <alerts>
        <fullName>Urgent_Tech_Email_to_BUSA</fullName>
        <ccEmails>forwardto@businessusa.gov</ccEmails>
        <description>Urgent Tech Email to BUSA</description>
        <protected>false</protected>
        <senderAddress>business.usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Urgent_Tecnical_Feedback</template>
    </alerts>
    <alerts>
        <fullName>Urgent_Tech_Email_to_ExIm</fullName>
        <ccEmails>webteam@exim.gov</ccEmails>
        <description>Urgent Tech Email to ExIm</description>
        <protected>false</protected>
        <senderAddress>exim.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Urgent_Tecnical_Feedback</template>
    </alerts>
    <alerts>
        <fullName>Urgent_Tech_Email_to_USA_Kids_Gob</fullName>
        <ccEmails>fcicwebopps@gsa.gov</ccEmails>
        <description>Urgent Tech Email to USA/Kids/Gob</description>
        <protected>false</protected>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Urgent_Tecnical_Feedback</template>
    </alerts>
    <alerts>
        <fullName>Webform_survey_email_action</fullName>
        <description>Webform survey email action</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email_address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>usa.gov1@mail.fedinfo.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>USAGov/Webform_Survey_Text</template>
    </alerts>
    <fieldUpdates>
        <fullName>In_Progress_Owner_Content_Feedback_Chang</fullName>
        <description>Updates the field to in progress when an agent takes over the field</description>
        <field>Status</field>
        <literalValue>In Progress</literalValue>
        <name>In Progress Owner Content Feedback Chang</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_FWL_Case_For_Survey_Request</fullName>
        <field>Transfer_Action_Request__c</field>
        <formula>&quot;Transfer to Phone Survey Voicemail&quot;</formula>
        <name>Mark FWL Case For Survey Request</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Escalated_Checkbox</fullName>
        <field>IsEscalated</field>
        <literalValue>0</literalValue>
        <name>Reset Escalated Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_1BD_Escalation_Level</fullName>
        <field>Escalation_Level__c</field>
        <literalValue>1 Business Day Open</literalValue>
        <name>Set 1BD Escalation Level</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_4hr_Escalation_Level</fullName>
        <field>Escalation_Level__c</field>
        <literalValue>4 Business Hours Open</literalValue>
        <name>Set 4hr Escalation Level</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spam_Cases_Field_Update_Case_Dispositio</fullName>
        <field>Call_Disposition__c</field>
        <literalValue>Case Completed</literalValue>
        <name>Spam Cases Field Update (Case Dispositio</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spam_Cases_Field_Update_Case_Topic</fullName>
        <field>Call_Topic__c</field>
        <literalValue>Not Relevant / Spam</literalValue>
        <name>Spam Cases Field Update (Case Topic)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spam_Cases_Field_Update_Status</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Spam Cases Field Update (Status)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Team_Lead_Supervisor_Assistance_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Team_Lead_Supervisor_Assistance_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Team Lead/Supervisor Assistance Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Threatening_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Threatening_Language_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Threatening Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Disposition_Field</fullName>
        <field>Call_Disposition__c</field>
        <literalValue>Not relevant / spam</literalValue>
        <name>Update Case Disposition Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Topic</fullName>
        <field>Call_Topic__c</field>
        <literalValue>Not Relevant / Spam</literalValue>
        <name>Update Case Topic</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Transfer_Phone_Request</fullName>
        <field>Transfer_Action_Request1__c</field>
        <formula>&quot;&lt;p style= color:red;font-size:200%&gt;Transfer to Phone Survey Voicemail&lt;/p&gt;&lt;p style= color:red;font-size:100%&gt;Beginning of Call: Before we continue, I want to let you know that you have been selected to provide us with feedback about your experience today. So before we hang up, please remind me to transfer your call into our voice mail box where you can leave comments about our service. No one will ask you any questions; you’ll simply be able to leave whatever comment you choose after the tone.&lt;/p&gt;&lt;p style= color:red;font-size:100%&gt;End of Call: Thank you for calling the U.S. Fish and Wildlife Service. I am transferring you to our comments voicemail. Just a reminder, this is just a voicemail box! No one will ask you any questions. When you hear the tone, you may go ahead and leave your comments.&lt;/p&gt;&quot;</formula>
        <name>Update Transfer Phone Request</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Case Feedback Email Rule</fullName>
        <actions>
            <name>Feedback_Email_Task_Ru</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>As a Topics desk user, I want to receive an email when a new Article feedback record is assigned to me so I don’t have to search for or run a report to receive the feedback.</description>
        <formula>ISCHANGED( OwnerId ) &amp;&amp;   RecordType.Name  = &quot;Content Feedback&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Chat Survey</fullName>
        <actions>
            <name>Chat_Survey_Email_Sent</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Chat</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Email_address__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>USA.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Call_Disposition__c</field>
            <operation>notEqual</operation>
            <value>Forward to BUSA Tier2 - business content issue,Forward to BUSA Tier2 - website technical issue,Forwarded to Tier 2 - Email,Forwarded to Tier 2 - Phone Transfer,Not Relevant / Spam</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Call_Topic__c</field>
            <operation>notEqual</operation>
            <value>Not Relevant / Spam</value>
        </criteriaItems>
        <description>Immediate chat survey workflow.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Immediate_Survey_Action_Chat</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Chat Survey 1</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Chat</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Email_address__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>USA.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Call_Disposition__c</field>
            <operation>notEqual</operation>
            <value>Forward to BUSA Tier2 - business content issue,Forward to BUSA Tier2 - website technical issue,Forwarded to Tier 2 - Email,Forwarded to Tier 2 - Phone Transfer,Not/Relevant Spam</value>
        </criteriaItems>
        <description>Chat survey workflow.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Chat_survey_workflow_action</name>
                <type>Alert</type>
            </actions>
            <timeLength>72</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Closed Feedback Creator rule</fullName>
        <actions>
            <name>Feedback_Creator_Rule</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Once the feedback record (case) is closed, a notification email will be sent to the agent who submitted the feedback.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Escalation WorkFlow 1BD - FCIC</fullName>
        <actions>
            <name>Reset_Escalated_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_1BD_Escalation_Level</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsEscalated</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Escalation_Level__c</field>
            <operation>equals</operation>
            <value>4 Business Hours Open</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Escalation WorkFlow 4hrs - FCIC</fullName>
        <actions>
            <name>Reset_Escalated_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_4hr_Escalation_Level</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsEscalated</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Escalation_Level__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FWL Case Survey Prompt</fullName>
        <actions>
            <name>Update_Transfer_Phone_Request</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF((OR( (RIGHT(CaseNumber,1) = &apos;2&apos;),(RIGHT(CaseNumber,1) = &apos;8&apos;))&amp;&amp;(Site__c = &apos;FWS.gov&apos; )),     true,      false )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>In Progress Owner Content Feedback Change</fullName>
        <actions>
            <name>In_Progress_Owner_Content_Feedback_Chang</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Automatically changes the case that is taken over by an agent to in progress</description>
        <formula>AND( RecordType.Name = &apos;Content Feedback&apos;,  ISCHANGED( Agent__c ), NOT (OR(ISPICKVAL(Status,&apos;Completed&apos;),(ISPICKVAL(Status,&apos;In progress&apos;)))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Queue 1 Emails</fullName>
        <actions>
            <name>Email_Queue_1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 1</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue 2 Emails</fullName>
        <actions>
            <name>Email_Queue_2</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 2</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue 3 Emails</fullName>
        <actions>
            <name>Email_Queue_3</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 3</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue 4 Emails</fullName>
        <actions>
            <name>Email_Queue_4</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 4</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue 5 Emails</fullName>
        <actions>
            <name>Email_Queue_5</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 5</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue 6 Emails</fullName>
        <actions>
            <name>Email_Queue_6</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Queue 6</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Spam Cases Workflow</fullName>
        <actions>
            <name>Spam_Cases_Field_Update_Case_Dispositio</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spam_Cases_Field_Update_Case_Topic</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spam_Cases_Field_Update_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Customer_Email_address__c</field>
            <operation>equals</operation>
            <value>usa@gov.com</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Team Lead%2FSupervisor Queue</fullName>
        <actions>
            <name>Team_Lead_Supervisor_Assistance_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Team Lead/Supervisor Assistance</value>
        </criteriaItems>
        <description>This workflow will send a case to the Team Lead and Supervisor Queue when a status of &quot;Team Lead/Supervisor&quot; is selected.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Tech Feedback BUSA</fullName>
        <actions>
            <name>Urgent_Tech_Email_to_BUSA</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>business.usa.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Urgent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Tech_Feedback_Text__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Urgent Tech Email to BUSA</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Tech Feedback ExIm</fullName>
        <actions>
            <name>Urgent_Tech_Email_to_ExIm</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>ExIm.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Urgent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Tech_Feedback_Text__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Tech Feedback USA%2Egov Kids%2Egov GobiernoUSA%2Egov</fullName>
        <actions>
            <name>Urgent_Tech_Email_to_USA_Kids_Gob</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3) AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>USA.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>kids.usa.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>GobiernoUSA.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Urgent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Tech_Feedback_Text__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Urgent Technical Feedback email sent to USA.gov Kids.gov GobiernoUSA.gov</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Threatening Language</fullName>
        <actions>
            <name>Threatening_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Threatening_Language__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Urgent</value>
        </criteriaItems>
        <description>This workflow rule sends urgent, threatening language cases to the Threatening Language queue.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Disposition</fullName>
        <actions>
            <name>Update_Case_Disposition_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Case_Topic</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Reason</field>
            <operation>equals</operation>
            <value>Not Relevant / Spam</value>
        </criteriaItems>
        <description>Will set the Case Disposition to Not Relevant / Spam, whenever the case is closed for that reason</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Webform Survey</fullName>
        <actions>
            <name>Webform_Survey_Email_Sent</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Misdirect Program,Postal,Web</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Email_address__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>USA.gov</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Call_Disposition__c</field>
            <operation>notEqual</operation>
            <value>Forward to BUSA Tier2 - business content issue,Forward to BUSA Tier2 - website technical issue,Forwarded to Tier 2 - Email,Forwarded to Tier 2 - Phone Transfer,Not Relevant / Spam</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Call_Topic__c</field>
            <operation>notEqual</operation>
            <value>Not Relevant / Spam</value>
        </criteriaItems>
        <description>Webform survey workflow.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Webform_survey_email_action</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Chat_Survey_Email_Sent</fullName>
        <assignedTo>clicktoolssurveyuser@gsa.gov.peo</assignedTo>
        <assignedToType>user</assignedToType>
        <description>This tracks when a chat survey is sent out. This task is created at the same time the email is sent out.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.ClosedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Chat Survey - Email Sent</subject>
    </tasks>
    <tasks>
        <fullName>Webform_Survey_Email_Sent</fullName>
        <assignedTo>clicktoolssurveyuser@gsa.gov.peo</assignedTo>
        <assignedToType>user</assignedToType>
        <description>This tracks all surveys sent out after emails. This task is created at the same time the webform survey is sent out.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.ClosedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Webform Survey - Email Sent</subject>
    </tasks>
</Workflow>
