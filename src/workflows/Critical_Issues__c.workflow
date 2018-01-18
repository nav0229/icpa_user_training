<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Critical_Item_Email_alert</fullName>
        <description>Critical Item Email alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>komal.rasheed@ent.gsa.gov</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Critical_Item_Email_alert</template>
    </alerts>
    <alerts>
        <fullName>Critical_Item_Status_Change_Email_Alert_Audit_Group</fullName>
        <description>Critical Item Status Change Email Alert Audit Group</description>
        <protected>false</protected>
        <recipients>
            <recipient>Critical_Items_AuditGroup_Users</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Critical_Item_Status_Change</template>
    </alerts>
    <alerts>
        <fullName>Critical_Item_Status_Change_Email_Alert_Exec_Sec</fullName>
        <description>Critical Item Status Change Email Alert Exec Sec</description>
        <protected>false</protected>
        <recipients>
            <recipient>Critical_Items_ExecSec_Users</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Critical_Item_Status_Change</template>
    </alerts>
    <fieldUpdates>
        <fullName>Critical_Issue_Email_field_update</fullName>
        <field>Email_address_of_Staff_POC__c</field>
        <formula>User__r.Email</formula>
        <name>Critical Issue Email field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Critical_Issue_Phone_field_update</fullName>
        <field>Phone_Number_of_Staff_POC__c</field>
        <formula>User__r.Phone</formula>
        <name>Critical Issue Phone field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Critical_Item_Approval_Date_field_update</fullName>
        <field>Approval_Date__c</field>
        <formula>TODAY()</formula>
        <name>Critical Item Approval Date field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Impacted_org_text_update</fullName>
        <field>Business_Line__c</field>
        <formula>IF( INCLUDES( Related_Organization__c, &apos;Exec Sec&apos;), &apos;Exec Sec;&apos;,&apos;&apos;) &amp;
IF( INCLUDES( Related_Organization__c, &apos;Audit Group&apos;), &apos;Audit Group;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OCR&apos;), &apos;OCR;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;CFO&apos;), &apos;CFO;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OHRM&apos;), &apos;OHRM;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OMA&apos;), &apos;OMA;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OSBU&apos;), &apos;OSBU;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OAS&apos;), &apos;OAS;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;CIO&apos;), &apos;CIO;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OGC&apos;), &apos;OGC;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OGP&apos;), &apos;OGP;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;PBS&apos;), &apos;PBS;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;FAS&apos;), &apos;FAS;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OCIA&apos;), &apos;OCIA;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OCSIT&apos;), &apos;OCSIT;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;OCM&apos;), &apos;OCM;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 1&apos;), &apos;Region 1;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 2&apos;), &apos;Region 2;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 3&apos;), &apos;Region 3;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 4&apos;), &apos;Region 4;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 5&apos;), &apos;Region 5;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 6&apos;), &apos;Region 6;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 7&apos;), &apos;Region 7;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 8&apos;), &apos;Region 8;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 9&apos;), &apos;Region 9;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Region 10&apos;), &apos;Region 10;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;NCR&apos;), &apos;NCR;&apos;,&apos;&apos;) &amp; IF( INCLUDES( Related_Organization__c, &apos;Administrative Office&apos;), &apos;Administrative Office;&apos;,&apos;&apos;)</formula>
        <name>Critical item Affected org text update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Critical Issue Email and Phone Update</fullName>
        <actions>
            <name>Critical_Issue_Email_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Critical_Issue_Phone_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule to update the email and phone fields of a POC based on Critical Item POC field</description>
        <formula>OR(ISNEW(), ISCHANGED(User__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Critical Item Action Deadline Email alert</fullName>
        <active>false</active>
        <description>Send an email to owner and POC to remind them 2 days before the action deadline.</description>
        <formula>AND(NOT(ISBLANK(Deadline__c)), NOT(ISPICKVAL( Critical_Item_Status__c, &apos;Completed&apos;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Critical_Item_Email_alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Critical_Issues__c.Deadline__c</offsetFromField>
            <timeLength>-2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Critical Item Affected org text box</fullName>
        <actions>
            <name>Impacted_org_text_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule to update the Affected org text field based on the Affected Org Multi-select picklist values</description>
        <formula>OR(IF(ISNEW(), NOT(ISNULL(Related_Organization__c)), false), IF(ISCHANGED(Related_Organization__c), true, false) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Critical Item Approval Date</fullName>
        <actions>
            <name>Critical_Item_Approval_Date_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule to auto populate the approval date field on critical item records</description>
        <formula>AND(ISCHANGED( Critical_Item_Status__c ), OR(AND( ISPICKVAL(Critical_Item_Status__c, &quot;Administrator Approved&quot;),ISPICKVAL(Highest_Intended_Audience__c,&quot;Administrator&apos;s Office&quot;)), AND( ISPICKVAL(Critical_Item_Status__c, &quot;Commissioner Approved&quot;), ISPICKVAL(Highest_Intended_Audience__c,&quot;Regional Commissioner&quot;))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Critical Item Status Change Rule Audit Group</fullName>
        <actions>
            <name>Critical_Item_Status_Change_Email_Alert_Audit_Group</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Rule to send an email alert when a critical item  (Submitting Org: Audit Group) status is changed.</description>
        <formula>AND(ISPICKVAL( Organization__c ,&apos;Audit Group&apos;), ISCHANGED(Critical_Item_Status__c ),  OR(ISPICKVAL(Critical_Item_Status__c, &apos;Administrator Approved&apos;),ISPICKVAL(Critical_Item_Status__c, &apos;Administrator Reviewed&apos;),ISPICKVAL(Critical_Item_Status__c, &apos;Follow-up&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Critical Item Status Change Rule Exec Sec</fullName>
        <actions>
            <name>Critical_Item_Status_Change_Email_Alert_Exec_Sec</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Rule to send an email alert when a critical item  (Submitting Org: Exec Sec) status is changed.</description>
        <formula>AND(ISPICKVAL( Organization__c ,&apos;Exec Sec&apos;), ISCHANGED(Critical_Item_Status__c ),  OR(ISPICKVAL(Critical_Item_Status__c, &apos;Administrator Approved&apos;),ISPICKVAL(Critical_Item_Status__c, &apos;Administrator Reviewed&apos;),ISPICKVAL(Critical_Item_Status__c, &apos;Follow-up&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
