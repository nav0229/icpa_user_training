<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assign_loan_to_Case_Manager_q</fullName>
        <field>OwnerId</field>
        <lookupValue>Senior_Case_Manager_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign loan to Case Manager q</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_update_deadline_date</fullName>
        <field>Deadline_Date__c</field>
        <formula>Date_Time_Commitment_Letter_Generated__c +  Application__r.App_Processing_Variables__r.Commitment_Calendar_day_value__c</formula>
        <name>Auto update deadline date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_the_Assigned_To_field</fullName>
        <field>Assigned_To__c</field>
        <name>Blank the&quot; Assigned To&quot; field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_DT_reassigned_to_queue</fullName>
        <field>Date_Assigned_to_Queue__c</field>
        <formula>Now()</formula>
        <name>Capture DT reassigned to queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Capture_Date_Time_Assigned</fullName>
        <field>Date_Assigned_to_Commitment_Team_Member__c</field>
        <formula>Now()</formula>
        <name>Capture Date/Time Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_ownership_back_to_Commitment_que</fullName>
        <field>OwnerId</field>
        <lookupValue>Commitment_Team_Manager</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Set the ownership back to Commitment que</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_the_ownership_to_Assigned_To</fullName>
        <field>OwnerId</field>
        <lookupValue>Commitment_Team_Manager</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Set the ownership to &quot;Assigned To&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_date_assigned_to_Case_Manager_Q</fullName>
        <field>Date_assigned_to_Case_Manager_Queue__c</field>
        <formula>Now()</formula>
        <name>Update date assigned to Case Manager Q</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>blank_the_time_assigned_to_member</fullName>
        <field>Date_Assigned_to_Commitment_Team_Member__c</field>
        <name>blank the time assigned to member</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>set_the_status_to_Assigned</fullName>
        <field>Status__c</field>
        <literalValue>Assigned</literalValue>
        <name>set the status to Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Loan to Case Manager q after Obligation</fullName>
        <actions>
            <name>Assign_loan_to_Case_Manager_q</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_date_assigned_to_Case_Manager_Q</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Loan__c.Status__c</field>
            <operation>equals</operation>
            <value>Obligation-Successful,Commitment-Complete</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Deadline date</fullName>
        <actions>
            <name>Auto_update_deadline_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Loan__c.Deadline_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Date/Time (Commitment Letter Generated ) + Calendar day value set on App processing variable object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reassignment for Loan</fullName>
        <actions>
            <name>Blank_the_Assigned_To_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Capture_DT_reassigned_to_queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_the_ownership_back_to_Commitment_que</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>blank_the_time_assigned_to_member</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Loan__c.Status__c</field>
            <operation>equals</operation>
            <value>Reassign</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task assigned to Owner</fullName>
        <actions>
            <name>Pending_Loan_for_Assignment</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>Owner:Queue.Id =&apos;00Gr0000000wS1f&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task to Loan Owner to rerun interface</fullName>
        <actions>
            <name>Please_ReRun_the_Interface</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Loan__c.Status__c</field>
            <operation>equals</operation>
            <value>Error on Rerun of interface</value>
        </criteriaItems>
        <description>Notify the Owner to re-run interface because of the error</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update status to Assigned and time stamp</fullName>
        <actions>
            <name>Capture_Date_Time_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>set_the_status_to_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Pending_Loan_for_your_review</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Loan__c.Assigned_To__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>task for case manager</fullName>
        <actions>
            <name>Loan_for_your_review</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(OwnerId)&amp;&amp; (ispickval( Status__c,&quot;Obligation-Successful&quot;)||(ispickval( Status__c,&quot;Commitment-Complete&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Loan_for_your_review</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Loan is pending for your review</subject>
    </tasks>
    <tasks>
        <fullName>New_Loan_waiting_for_assignment</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Loan__c.Date_Assigned_to_Queue__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>New Loan waiting for assignment</subject>
    </tasks>
    <tasks>
        <fullName>Pending_Loan_for_Assignment</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Loan__c.Date_Assigned_to_Queue__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Pending Loan for Assignment</subject>
    </tasks>
    <tasks>
        <fullName>Pending_Loan_for_your_review</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Loan__c.Date_Assigned_to_Commitment_Team_Member__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Pending Loan for your review</subject>
    </tasks>
    <tasks>
        <fullName>Please_ReRun_the_Interface</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please Re Run the Interface because there is an error occured</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Open</status>
        <subject>Please ReRun the Interface</subject>
    </tasks>
</Workflow>
