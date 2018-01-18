<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>TSS_Action_Plan_Approval_Email_to_Property_Manager</fullName>
        <description>TSS Action Plan Approval Email to Property Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Property_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Plan_Automatic_Approval</template>
    </alerts>
    <alerts>
        <fullName>TSS_Action_Plan_Completed_Email_to_Property_Manager</fullName>
        <description>TSS Action Plan Completed Email to Property Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Property_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Plan_Completed_for_Property_Manager</template>
    </alerts>
    <alerts>
        <fullName>TSS_Action_Plan_Completed_Email_to_Supervisor</fullName>
        <description>TSS Action Plan Completed Email to Supervisor</description>
        <protected>false</protected>
        <recipients>
            <field>Supervisor__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Plan_Completed_for_Supervisor</template>
    </alerts>
    <alerts>
        <fullName>TSS_Action_Plan_Formal_Approval_Email_Alert</fullName>
        <description>TSS Action Plan Formal Approval Email Alert to Property Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Property_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Plan_Supervisor_Approved</template>
    </alerts>
    <alerts>
        <fullName>TSS_Email_to_Property_Manager_after_Rejection</fullName>
        <description>TSS Email to Property Manager after Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Property_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Plan_Email_Supervisor_Reject</template>
    </alerts>
    <fieldUpdates>
        <fullName>TSS_Action_Plan_Status_Approved</fullName>
        <field>Action_Plan_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>TSS Action Plan Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Action_Plan_Status_to_Cancelled</fullName>
        <field>Action_Plan_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>TSS Action Plan Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Action_Plan_Status_to_In_Development</fullName>
        <field>Action_Plan_Status__c</field>
        <literalValue>In Development</literalValue>
        <name>TSS Action Plan Status to In Development</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Action_plan_completion_field_update</fullName>
        <field>Action_Plan_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>TSS Action plan completion field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Result_Action_Plan_Status_Submitted</fullName>
        <field>Action_Plan_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>TSS Result Action Plan Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_Result_action_plan_name_field_update</fullName>
        <field>Name</field>
        <formula>TEXT( Fiscal_Year__c ) &amp; &quot; &quot; &amp;  Location_Code_Plus__c</formula>
        <name>TSS Result action plan name field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_approval_date_field_update</fullName>
        <field>Action_Plan_Approved_Date__c</field>
        <formula>TODAY()</formula>
        <name>TSS approval date field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TSS_completed_date_field_update</fullName>
        <field>Action_Plan_Completed_Date__c</field>
        <formula>TODAY()</formula>
        <name>TSS completed date field update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>TSS Action Plan Status to Cancelled</fullName>
        <actions>
            <name>TSS_Action_Plan_Status_to_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TSS_Result_Action_Plan__c.Mark_for_Cancellation__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates Status to Cancelled when Action Plan is Marked for Cancellation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TSS Action Plan Status to Completed</fullName>
        <actions>
            <name>TSS_Action_Plan_Completed_Email_to_Property_Manager</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>TSS_Action_Plan_Completed_Email_to_Supervisor</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>TSS_Action_plan_completion_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>TSS_completed_date_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Status to Completed when all Action Items are completed and sends email; prior Status must be Approved</description>
        <formula>IF(AND(Total_Action_Items__c &gt; 0, ISPICKVAL( Action_Plan_Status__c , &apos;Approved&apos;)), IF(Total_Action_Items__c = Completed_Action_Items__c, true, false), false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TSS Action Plan Status to In Development</fullName>
        <actions>
            <name>TSS_Action_Plan_Status_to_In_Development</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>TSS_Result_Action_Plan__c.Total_Action_Items__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Updates Status to In Development when first Action Item is created</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TSS Automatic Approval to Property Manager</fullName>
        <actions>
            <name>TSS_Action_Plan_Approval_Email_to_Property_Manager</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>When no Supervisor Approval is required, sends email when Action Plan is auto approved.</description>
        <formula>AND( NOT(ISPICKVAL(PRIORVALUE(Action_Plan_Status__c), &quot;Approved&quot;)), ISPICKVAL(Action_Plan_Status__c, &quot;Approved&quot;),  NOT(Requires_Supervisor_Approval__c),  NOT(  AND(Occupancy__c &gt;= 25,  Overall_Satisfaction_Avg_Score__c &lt;= 3, NOT(ISPICKVAL(Fiscal_Year__c,&quot;FY17&quot;))  ) )   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TSS Result and Action Plan name rule</fullName>
        <actions>
            <name>TSS_Result_action_plan_name_field_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the TSS Result and Action Plan name to FY + Location Code Plus</description>
        <formula>AND(NOT(ISBLANK( Location_Code_Plus__c )),  NOT(ISBLANK(TEXT(Fiscal_Year__c) )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
