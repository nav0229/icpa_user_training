<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Agency_Protest_Legal_Reject_Email</fullName>
        <description>Agency Protest Legal Reject Email</description>
        <protected>false</protected>
        <recipients>
            <field>Integrity_Officer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Reject</template>
    </alerts>
    <alerts>
        <fullName>Agency_Protest_Senior_Reject_Email</fullName>
        <description>Agency Protest Senior Reject Email</description>
        <protected>false</protected>
        <recipients>
            <field>Integrity_Officer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Reject</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_180_days_email_alert</fullName>
        <description>SD_APO 180 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_APOReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_30_days_email_alert</fullName>
        <description>SD_APO 30 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_APOReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_60_days_email_alert</fullName>
        <description>SD_APO 60 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_APOReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Approval_Assigned</fullName>
        <description>SD APO Approval Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Approval</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Legal_180_days_email_alert</fullName>
        <description>SD_APO Legal 180 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Legal_30_days_email_alert</fullName>
        <description>SD_APO Legal 30 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Legal_60_days_email_alert</fullName>
        <description>SD_APO Legal 60 days email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_SD_Legal</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_LegalReminder</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Legal_Approval_Assigned</fullName>
        <description>SD APO Legal Approval Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>Suspension_Debarment_Users</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Approval</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Senior_Approved_Email</fullName>
        <description>SD APO Senior Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Approved</template>
    </alerts>
    <alerts>
        <fullName>SD_APO_Senior_Reject_Email</fullName>
        <description>SD APO Senior Rejected Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/SD_AgencyProtest_Reject</template>
    </alerts>
    <fieldUpdates>
        <fullName>APO_Approval_Date_Populate</fullName>
        <description>Populates the APO Approval Date field.</description>
        <field>APO_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>APO Approval Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Approval_Reject_Date_Clear</fullName>
        <description>Clears the date on the APO Approval Reject Date</description>
        <field>APO_Approval_Reject_Date__c</field>
        <name>APO Approval Reject Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Approval_Reject_Date_Populate</fullName>
        <description>Updates the APO Approval Reject Date upon rejection.</description>
        <field>APO_Approval_Reject_Date__c</field>
        <formula>Today()</formula>
        <name>APO Approval Reject Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Case_Status_Update_Pending_APO_Rev</fullName>
        <description>Updates the Case Status field to either the &quot;Pending APO Review&quot; value or the &quot;Pending Legal Review&quot; value.</description>
        <field>Case_Status__c</field>
        <formula>IF(  ISBLANK( APO_Legal_Reject_Date__c) , &quot;Pending APO Review&quot;, &quot;Pending Legal Review&quot;)</formula>
        <name>APO Case Status Update Pending APO Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Case_Status_Update_Pending_Legal_Rev</fullName>
        <description>Updates the Case Status field to a &quot;Pending Legal Review&quot; value.</description>
        <field>Case_Status__c</field>
        <formula>&quot;Pending Legal Review&quot;</formula>
        <name>APO Case Status Update Pending Legal Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Case_Status_Update_With_IO</fullName>
        <description>Updates the Case Status field to the &quot;With Integrity Officer&quot; value.</description>
        <field>Case_Status__c</field>
        <formula>&quot;With Integrity Officer&quot;</formula>
        <name>APO Case Status Update With IO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Legal_Approval_Populate</fullName>
        <description>Populates the Legal Approval Date</description>
        <field>Legal_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>Legal Approval Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Legal_Reject_Date_Clear</fullName>
        <description>Clears the date on the APO Legal Reject Date</description>
        <field>APO_Legal_Reject_Date__c</field>
        <name>APO Legal Reject Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Legal_Reject_Date_Populate</fullName>
        <description>Populates the APO Legal Reject Date upon legal rejection</description>
        <field>APO_Legal_Reject_Date__c</field>
        <formula>Today()</formula>
        <name>APO Legal Reject Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Submit_for_Approval_Date_Clear</fullName>
        <description>Clears the APO Submit for Approval Date field.</description>
        <field>APO_Submit_for_Approval__c</field>
        <name>APO Submit for Approval Date Clear</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APO_Submit_for_Approval_Date_Populate</fullName>
        <description>Populates the APO Submit for Approval Date field.</description>
        <field>APO_Submit_for_Approval__c</field>
        <formula>Today()</formula>
        <name>APO Submit for Approval Date Populate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AP_Mark_for_Deletion_Update</fullName>
        <description>Agency Protest Mark for Deletion checked when Destruction Date is less than today.</description>
        <field>AP_Mark_for_Deletion__c</field>
        <literalValue>1</literalValue>
        <name>AP Mark for Deletion Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AP_Mark_for_Deletion_Update_After</fullName>
        <description>Agency Protest Mark for Deletion checked when Destruction Date is passed.</description>
        <field>AP_Mark_for_Deletion__c</field>
        <literalValue>1</literalValue>
        <name>AP Mark for Deletion Update After</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Legal_Approval_rejection_update</fullName>
        <description>APO Approval Date field updated with null, when APO Legal Approval rejection happens in the Approval processes.</description>
        <field>APO_Approval_Date__c</field>
        <name>Legal Approval rejection update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
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
    <rules>
        <fullName>SD AP Mark for Deletion Update</fullName>
        <actions>
            <name>AP_Mark_for_Deletion_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Agency_Protest_Case__c.Destruction_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Agency_Protest_Case__c.Destruction_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Agency Protest Mark for Deletion update based on Destruction Date passing. This executes immediately upon edit and handles any file that already has a past Destruction Date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SD AP Mark for Deletion Update Aft</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Agency_Protest_Case__c.Destruction_Date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Agency_Protest_Case__c.Destruction_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Agency Protest Mark for Deletion update based on Destruction Date passing. This executes an hour after the Destruction Date.  It handles any file that will pass the Destruction Date in the future.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AP_Mark_for_Deletion_Update_After</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Agency_Protest_Case__c.Destruction_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
