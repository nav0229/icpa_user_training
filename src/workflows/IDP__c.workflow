<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>IDP_Notify_Employee_upon_IDP_Approval</fullName>
        <description>IDP Notify Employee upon IDP Approval</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <alerts>
        <fullName>IDP_Notify_Employee_upon_IDP_Rejection</fullName>
        <description>IDP Notify Employee upon IDP Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>IDP_Notify_HR_that_IDP_Approved</fullName>
        <description>IDP Notify HR that IDP Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_HR_Upon_IDP_Completion</template>
    </alerts>
    <alerts>
        <fullName>IDP_Recall_Notice_Sent_to_Supervisor</fullName>
        <description>IDP Recalled by Employee Notification to Supervisor</description>
        <protected>false</protected>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_Supervisor_of_Recall</template>
    </alerts>
    <alerts>
        <fullName>IDP_Record_Rejected_by_Supervisor</fullName>
        <description>IDP Rejected by Supervisor Notification to Employee</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_Employee_Upon_IDP_Rejection</template>
    </alerts>
    <alerts>
        <fullName>IDP_Supervisor_Approved_the_User_IDP_record</fullName>
        <description>IDP Approved by Supervisor Notification to Employee</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>IDP_Email_Templates/IDP_Notify_Employee_Upon_IDP_Approval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Record_Type_Change</fullName>
        <description>When the Supervisor approve, the IDP record type will be changed to Approved.</description>
        <field>RecordTypeId</field>
        <lookupValue>IDP_Approved</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Approved Record Type Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Record_type_to_IDP_Approved</fullName>
        <description>changes record type of IDP to IDP Approved</description>
        <field>RecordTypeId</field>
        <lookupValue>IDP_Approved</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>IDP Change Record type to IDP Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Record_type_to_IDP_Standard</fullName>
        <description>Changed IDP Record</description>
        <field>RecordTypeId</field>
        <lookupValue>IDP_Standard</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>IDP Change Record type to IDP Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Status_to_Approved</fullName>
        <description>Change IDP status to Approved</description>
        <field>IDP_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>IDP Change Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Status_to_New</fullName>
        <description>Changes the IDP status to New from Supervisor Review when Recalled from editing.</description>
        <field>IDP_Status__c</field>
        <literalValue>New</literalValue>
        <name>IDP Change Status to New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Status_to_Resubmit</fullName>
        <description>Change IDP Status field to Resubmit</description>
        <field>IDP_Status__c</field>
        <literalValue>Resubmit</literalValue>
        <name>IDP Change Status to Resubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_Status_to_Supervisor_Review</fullName>
        <description>Change status to Supervisor Review</description>
        <field>IDP_Status__c</field>
        <literalValue>Supervisor Review</literalValue>
        <name>IDP Change Status to Supervisor Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Change_status_to_Needs_Revision</fullName>
        <description>Changes IDP status to needs revision</description>
        <field>IDP_Status__c</field>
        <literalValue>Needs Revision</literalValue>
        <name>IDP Change status to Needs Revision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Field_update_on_Division</fullName>
        <field>Division__c</field>
        <formula>Division_Formula__c</formula>
        <name>IDP Field update on Division</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Record_Approved_By_Supervisor</fullName>
        <field>IDP_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>IDP Record Approved By Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Record_Rejected_by_Supervisor</fullName>
        <field>IDP_Status__c</field>
        <literalValue>Needs Revision</literalValue>
        <name>IDP Record Rejected by Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Status_Change</fullName>
        <field>IDP_Status__c</field>
        <literalValue>Supervisor Review</literalValue>
        <name>IDP Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDP_Update_Fiscal_Year_in_Val_Field</fullName>
        <description>Updates the fiscal year validation field.</description>
        <field>IDP_Fiscal_Year_Validation__c</field>
        <formula>value(right( text( Fiscal_Year_pick__c ),4))</formula>
        <name>IDP Update Fiscal Year in Val Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IDT_Inserts_Validation_Field</fullName>
        <field>Validation_one_idp_per_year__c</field>
        <formula>CreatedBy.Id &amp; text(Fiscal_Year_pick__c )</formula>
        <name>IDT Inserts Validation Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_office_symbol</fullName>
        <field>Formula_helper_text__c</field>
        <formula>IF(ISNUMBER(LEFT(Owner:User.Division,1)),if(ISNUMBER(LEFT(Owner:User.Division,2)),RIGHT(LEFT(Owner:User.Division,LEN(Owner:User.Division)-(LEN(Owner:User.Division)-3)),1),RIGHT(LEFT(Owner:User.Division,LEN(office_Symbol__c)-(LEN(Owner:User.Division)-2)),1)),LEFT(Owner:User.Division,LEN(Owner:User.Division)-(LEN(Owner:User.Division)-1)))</formula>
        <name>update office symbol</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GSA Org formula helper</fullName>
        <actions>
            <name>update_office_symbol</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>IDP__c.office_Symbol__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the formula helper text field for the GSA Organization formula field to pull in</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IDP - Workflow to update Division from User</fullName>
        <actions>
            <name>IDP_Field_update_on_Division</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Division</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IDP Formula Helper for GSA Org</fullName>
        <actions>
            <name>update_office_symbol</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>IDP__c.office_Symbol__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the formula helper text field for the GSA Organization formula field to pull in on the Shared IDPs object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IDP Insert Fiscal Year into Validation Field</fullName>
        <actions>
            <name>IDP_Update_Fiscal_Year_in_Val_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>IDP__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Inserts fiscal year into number field used for validation rule to prevent edits to prior years IDPs</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
