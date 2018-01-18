<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EA_Approval_Request_has_been_moved_to_the_next_level</fullName>
        <description>EA - Approval Request has been moved to the next level</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Your_approval_has_moved_to_the_next_step</template>
    </alerts>
    <alerts>
        <fullName>EA_Event_Approval_Record_has_been_rejected</fullName>
        <description>Event Approval Record has been rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Approval_Rejection</template>
    </alerts>
    <alerts>
        <fullName>EA_Event_Approval_Request_has_been_approved</fullName>
        <description>EA - Event Approval Request has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Event_Approved</template>
    </alerts>
    <alerts>
        <fullName>Event_Approval_Submission_Confirmation</fullName>
        <description>Event Approval Submission Confirmation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_Submission_Conf</template>
    </alerts>
    <alerts>
        <fullName>Event_approval_Event_End_Date_30_Days_alert_to_update_the_actuals</fullName>
        <description>Event approval: Event End Date +30 Days - alert to update the actuals</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_30_Days_Need_Actuals</template>
    </alerts>
    <alerts>
        <fullName>Event_approval_Event_End_Date_60_Days_alert_to_update_the_actuals</fullName>
        <description>Event approval: Event End Date +60 Days - alert to update the actuals</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_60_Days_need_actuals</template>
    </alerts>
    <alerts>
        <fullName>Event_approval_Event_End_Date_7_Days_alert_to_update_the_actuals</fullName>
        <description>Event approval: Event End Date +7 Days - alert to update the actuals</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Event_Approval_Email_Templates/EA_7_Days_need_actuals</template>
    </alerts>
    <fieldUpdates>
        <fullName>EA_Move_Request_to_Waiting_for_Approval</fullName>
        <description>Will move the Event Approval Request to a Status of Waiting for Approval once the user hits submit.</description>
        <field>EA_Stage__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Move Request to Waiting for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_Canceled</fullName>
        <field>EA_Stage__c</field>
        <literalValue>Canceled</literalValue>
        <name>Event Canceled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_Status_Cleared</fullName>
        <description>Updates Event Status Hidden to NULL</description>
        <field>Event_Type_Hidden__c</field>
        <name>Event Status - Cleared</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_Status_to_Over</fullName>
        <description>Updates Event Status Hidden to Over</description>
        <field>Event_Type_Hidden__c</field>
        <formula>&quot;Over&quot;</formula>
        <name>Event Status to Over</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_Type_Hidden</fullName>
        <field>Event_Type_Hidden__c</field>
        <formula>RecordType.Name</formula>
        <name>Event Type Hidden</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Event_approval_field_update_stage_new</fullName>
        <field>EA_Stage__c</field>
        <literalValue>New</literalValue>
        <name>Event approval field update stage new</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Final_Rejection</fullName>
        <description>Used for the final rejection stage of the Event Approval request submitted by SSOs</description>
        <field>EA_Stage__c</field>
        <literalValue>Rejected</literalValue>
        <name>Final Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_Approval_Step_To_OAS</fullName>
        <field>Approval_Step__c</field>
        <literalValue>OAS</literalValue>
        <name>Move Approval Step To OAS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_Approval_Step_to_HSSO</fullName>
        <field>Approval_Step__c</field>
        <literalValue>HSSO</literalValue>
        <name>Move Approval Step to HSSO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_Approval_Step_to_None</fullName>
        <field>Approval_Step__c</field>
        <literalValue>None</literalValue>
        <name>Move Approval Step to None</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_Approval_Step_to_Supervisor</fullName>
        <field>Approval_Step__c</field>
        <literalValue>Supervisor</literalValue>
        <name>Move Approval Step to Supervisor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_Approved</fullName>
        <description>Moves Record in Event Approval to the &quot;Approved&quot; Stages and unlocks the record for editing.</description>
        <field>EA_Stage__c</field>
        <literalValue>Approved</literalValue>
        <name>Move to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_In_Progress</fullName>
        <description>Will Move Stage field in the Event Approval object back to &quot;In Progress&quot; upon Rejection of this step.</description>
        <field>EA_Stage__c</field>
        <literalValue>In Progress</literalValue>
        <name>Move to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_to_Pending_Approval</fullName>
        <description>Moves the &quot;Stage&quot; field in the Event Approval Application to &quot;Pending Approval&quot;  Once the submit button is selected</description>
        <field>EA_Stage__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Move to Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Event Approval - Event Canceled</fullName>
        <actions>
            <name>Event_Canceled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Approval__c.Event_Canceled__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Used to move the stage (read only) field to a &quot;Canceled&quot; value once the checkbox is checked.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval - Event Status</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Event_Approval__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>GSA Sponsored Conference,Non GSA Sponsored Conference</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Event_Status_to_Over</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Event_Approval__c.EA_End_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Event Approval - Event Status Clear</fullName>
        <actions>
            <name>Event_Status_Cleared</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Approval__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>GSA Sponsored Conference,Non GSA Sponsored Conference</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Approval__c.Event_Type_Hidden__c</field>
            <operation>equals</operation>
            <value>over</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Approval__c.EA_End_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Event Approval</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Event Approval 7 30 60 days -update actuals</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Event_Approval__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Awards Ceremony (With Cost),GSA Sponsored Conference</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Approval__c.EA_Total_Actual_Expenses__c</field>
            <operation>equals</operation>
            <value>0.00</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event_Approval__c.EA_Stage__c</field>
            <operation>equals</operation>
            <value>Approved,Completed</value>
        </criteriaItems>
        <description>Rule to send the reminder emails to complete the actuals for &quot;GSA Sponsored Conference&quot; and &quot;Award with Ceremonies&quot; events</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Event_approval_Event_End_Date_30_Days_alert_to_update_the_actuals</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Event_Approval__c.EA_End_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Event_approval_Event_End_Date_7_Days_alert_to_update_the_actuals</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Event_Approval__c.EA_End_Date__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Event_approval_Event_End_Date_60_Days_alert_to_update_the_actuals</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Event_Approval__c.EA_End_Date__c</offsetFromField>
            <timeLength>60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Event approval rule default stage to new</fullName>
        <actions>
            <name>Event_approval_field_update_stage_new</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To default the Event Approval status to New when the record is cloned from the other record.</description>
        <formula>NOT(ISPICKVAL(EA_Stage__c, &quot;New&quot;))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
