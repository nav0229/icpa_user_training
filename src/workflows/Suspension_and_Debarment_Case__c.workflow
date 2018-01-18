<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_Owner_informing_them_their_record_has_been_recalled</fullName>
        <description>Email to Owner informing them their record has been recalled.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SD_Recalled_Record</template>
    </alerts>
    <alerts>
        <fullName>SDO_180_day_email_alert</fullName>
        <description>SDO 180 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_SDOReminder</template>
    </alerts>
    <alerts>
        <fullName>SDO_30_day_email_alert</fullName>
        <description>SDO 30 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SDO</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_SDOReminder</template>
    </alerts>
    <alerts>
        <fullName>SDO_60_day_email_alert</fullName>
        <description>SDO 60 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SDO</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_SDOReminder</template>
    </alerts>
    <alerts>
        <fullName>SDO_Legal_180_days_email_alert</fullName>
        <description>SDO Legal 180 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SDO_Legal_30_day_email_alert</fullName>
        <description>SDO Legal 30 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SDO_Legal_60_day_email_alert</fullName>
        <description>SDO Legal 60 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_Approval_Assigned</fullName>
        <description>SD Approval Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_Approval</template>
    </alerts>
    <alerts>
        <fullName>SD_Legal_Approval_Assigned</fullName>
        <description>SD Legal Approval Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_Approval</template>
    </alerts>
    <alerts>
        <fullName>SD_Respondent_30_day_email_alert</fullName>
        <description>SD Respondent 30 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SDO</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_Respondent_SDOReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_Respondent_60_day_email_alert</fullName>
        <description>SD Respondent 60 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SDO</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_Respondent_SDOReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_Respondent_Legal_30_day_email_alert</fullName>
        <description>SD Respondent Legal 30 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_Respondent_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_Respondent_Legal_60_day_email_alert</fullName>
        <description>SD Respondent Legal 60 day email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_Respondent_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>Suspension_and_Debarment_Legal_Reject_Email</fullName>
        <description>Suspension and Debarment Legal Reject Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_Reject</template>
    </alerts>
    <alerts>
        <fullName>Suspension_and_Debarment_Senior_Approved_Email</fullName>
        <description>Suspension and Debarment Senior Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_Approved</template>
    </alerts>
    <alerts>
        <fullName>Suspension_and_Debarment_Senior_Reject_Email</fullName>
        <description>Suspension and Debarment Senior Reject Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_SuspenDebar_Reject</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Start_Date_Update</fullName>
        <description>Field Change to update the Approval Start Date</description>
        <field>Approval_Start_Date__c</field>
        <formula>TODAY()</formula>
        <name>Approval Start Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DateofTransferBlank</fullName>
        <description>Update Date of Transfer to Blank</description>
        <field>Date_of_Transfer__c</field>
        <name>DateofTransferBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LeadAgencyBlank</fullName>
        <description>Make LeadAgencyBlank when Lead Agency Necessary is No</description>
        <field>Lead_Agency__c</field>
        <name>LeadAgencyBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Approval_Date_Clear</fullName>
        <description>Clears approval date</description>
        <field>SDO_Approval_Date__c</field>
        <name>SDO Approval Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Approval_Date_Populate</fullName>
        <description>Populates the SDO Approval Date</description>
        <field>SDO_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>SDO Approval Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Approval_Reject_Date_Clear</fullName>
        <description>Clears the SDO Approval Reject Date</description>
        <field>SDO_Approval_Reject_Date__c</field>
        <name>SDO Approval Reject Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Approval_Reject_Date_Populate</fullName>
        <description>Populates the SDO Approval Reject Date</description>
        <field>SDO_Approval_Reject_Date__c</field>
        <formula>Today()</formula>
        <name>SDO Approval Reject Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Legal_Approval_Date_Clear</fullName>
        <field>SDO_Legal_Approval_Date__c</field>
        <name>SDO Legal Approval Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Legal_Approval_Date_rejection_update</fullName>
        <description>SDO Approval Date field is updated when SDO Legal Approval rejection happens in the Approval processes.</description>
        <field>SDO_Approval_Date__c</field>
        <name>SDO Legal Approval Date rejection update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Legal_Approval_Date_update</fullName>
        <description>Populates the SDO Legal Approval Date</description>
        <field>SDO_Legal_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>SDO Legal Approval Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Legal_Reject_Date_Clear</fullName>
        <description>Clears the SDO Legal Reject Date</description>
        <field>SDO_Legal_Reject_Date__c</field>
        <name>SDO Legal Reject Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Legal_Reject_Date_Update</fullName>
        <description>Populates the SDO Legal Reject Date</description>
        <field>SDO_Legal_Reject_Date__c</field>
        <formula>Today()</formula>
        <name>SDO Legal Reject Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Submit_forApproval_rejection_update</fullName>
        <description>SDO Submit for Approval field is updated when SDO Legal Approval happens in the Approval processes.</description>
        <field>SDO_Submit_for_Approval__c</field>
        <name>SDO Submit for Approval rejection update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Submit_for_Approval_Date_Clear</fullName>
        <description>Clears the SDO Approval Date field.</description>
        <field>SDO_Submit_for_Approval__c</field>
        <name>SDO Submit for Approval Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Submit_for_Approval_update</fullName>
        <description>SDO Submit for Approval field is updated when Submit for Approval happens in the Approval processes.</description>
        <field>SDO_Submit_for_Approval__c</field>
        <formula>Today()</formula>
        <name>SDO Submit for Approval update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Submit_for_Legal_Clear</fullName>
        <field>SDO_Submit_for_Legal__c</field>
        <name>SDO Submit for Legal Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SDO_Submit_for_Legal_Populate</fullName>
        <field>SDO_Submit_for_Legal__c</field>
        <formula>Today()</formula>
        <name>SDO Submit for Legal Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Case_Status_Update_Pending_Legal_Rev</fullName>
        <description>Updates the Case Status field to the &quot;Pending Legal Review&quot; value.</description>
        <field>Case_Status__c</field>
        <formula>&quot;Pending Legal Review&quot;</formula>
        <name>SD Case Status Update Pending Legal Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Case_Status_Update_Pending_SDO_Rev</fullName>
        <description>Updates the Case Status field to either the &quot;Pending Legal Review&quot; value or the &quot;With Integrity Officer&quot; value</description>
        <field>Case_Status__c</field>
        <formula>IF( ISBLANK( SDO_Legal_Reject_Date__c ) , &quot;Pending SDO Review&quot;, &quot;With Integrity Office&quot;)</formula>
        <name>SD Case Status Update Pending SDO Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Case_Status_Update_With_IO</fullName>
        <description>Updates the Case Status with the &quot;With Integrity Officer&quot; value.</description>
        <field>Case_Status__c</field>
        <formula>&quot;With Integrity Officer&quot;</formula>
        <name>SD Case Status Update With IO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Mark_for_Deletion_Update</fullName>
        <description>Suspension and Debarment Mark for Deletion checked when Destruction Date is less than Today</description>
        <field>SD_Mark_for_Deletion__c</field>
        <literalValue>1</literalValue>
        <name>SD Mark for Deletion Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Mark_for_Deletion_Update_After</fullName>
        <description>Suspension and Debarment Mark for Deletion checked when Destruction Date is less than Today.  Action takes place the day after the Destruction Date passes.</description>
        <field>SD_Mark_for_Deletion__c</field>
        <literalValue>1</literalValue>
        <name>SD Mark for Deletion Update After</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SD_Recalled_Record</fullName>
        <description>Field update status to &quot;With Integrity Officer&quot; when a record is recalled</description>
        <field>Case_Status__c</field>
        <formula>&quot;With Integrity Officer&quot;</formula>
        <name>SD Recalled Record</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Toggle_off_the_Currently_In_Approval_box</fullName>
        <description>This field tells the trigger when to start creating and deleting the appropriate SD_Document_Upload__share records for the appropriate user.</description>
        <field>Is_Currently_In_Approval_Approcess__c</field>
        <literalValue>0</literalValue>
        <name>Toggle off the Currently In Approval box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Toggle_on_the_Currently_In_Approval_box</fullName>
        <description>This field tells the trigger when to start creating and deleting the appropriate SD_Document_Upload__share records for the appropriate user.</description>
        <field>Is_Currently_In_Approval_Approcess__c</field>
        <literalValue>1</literalValue>
        <name>Toggle on the Currently In Approval box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateRecordType</fullName>
        <description>No values needed for RecordType Respondent.</description>
        <field>RecordTypeId</field>
        <lookupValue>Suspension_and_Debarment_Respondent</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>UpdateRecordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>SD Approval Start Date</fullName>
        <actions>
            <name>Approval_Start_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Is_Currently_In_Approval_Approcess__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Workflow to populate Approval Start Date field.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SD Mark for Deletion Update</fullName>
        <actions>
            <name>SD_Mark_for_Deletion_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SD_Destruction_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SD_Destruction_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>S&amp;D Mark for Deletion Update based on Destruction Date passing.  This executes immediately upon edit and handles any file that already has a past Destruction Date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SD Mark for Deletion Update Aft</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SD_Destruction_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SD_Destruction_Date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>S&amp;D Mark for Deletion Update based on Destruction Date passing. This executes an hour after the Destruction Date.  It handles any file that will pass the Destruction Date in the future.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SD_Mark_for_Deletion_Update_After</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Suspension_and_Debarment_Case__c.SD_Destruction_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SDO_Approval</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Submit_for_Approval__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Approval_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Suspension and Debarment Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Approval_Reject_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Case_Status__c</field>
            <operation>notEqual</operation>
            <value>With Integrity Officer</value>
        </criteriaItems>
        <description>Workflow rules for email reminders of Suspension and Debarment Approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SDO_60_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SDO_30_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SDO_Legal_Approval</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Submit_for_Legal__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Legal_Approval_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Suspension and Debarment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Legal_Reject_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Case_Status__c</field>
            <operation>notEqual</operation>
            <value>With Integrity Officer</value>
        </criteriaItems>
        <description>Workflow rules for email reminders Suspension and Debarment Legal Approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SDO_Legal_30_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SDO_Legal_60_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SD_LeadAgencyDeterminationNecessaryRule</fullName>
        <actions>
            <name>DateofTransferBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>LeadAgencyBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Lead_Agency_Determination_Necessary__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>If Lead Agency Determination Necessary is No. Clear Date of Transfer field.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SD_Respondent_Approval</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Submit_for_Approval__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Approval_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Respondent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Approval_Reject_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Case_Status__c</field>
            <operation>notEqual</operation>
            <value>With Integrity Officer</value>
        </criteriaItems>
        <description>Workflow rules for email reminders of Suspension and Debarment Approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SD_Respondent_30_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SD_Respondent_60_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SD_Respondent_Legal_Approval</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Submit_for_Legal__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Legal_Approval_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Respondent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.SDO_Legal_Reject_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Suspension_and_Debarment_Case__c.Case_Status__c</field>
            <operation>notEqual</operation>
            <value>With Integrity Officer</value>
        </criteriaItems>
        <description>Workflow rules for email reminders Suspension and Debarment Respondent Legal Approval</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SD_Respondent_Legal_60_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>SD_Respondent_Legal_30_day_email_alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
