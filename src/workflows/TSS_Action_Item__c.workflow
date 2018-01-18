<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>X14_day_After_Action_Item_Due</fullName>
        <description>14 day after Action Item Due</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Item_Over_Due</template>
    </alerts>
    <alerts>
        <fullName>X1_Day_after_Action_Item_due</fullName>
        <description>1 Day after Action Item due</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Item_Over_Due</template>
    </alerts>
    <alerts>
        <fullName>X7_Day_reminder_for_Action_Item</fullName>
        <description>7 Day reminder for Action Item</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TSS_Results_and_Action_Plans/TSS_Action_Item_Due_Soon</template>
    </alerts>
    <rules>
        <fullName>TSS Action Item Due Dates</fullName>
        <active>true</active>
        <criteriaItems>
            <field>TSS_Action_Item__c.Estimated_Completion_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>TSS_Action_Item__c.Status__c</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <description>Email notifications one week before and one day after Estimated Completion Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X7_Day_reminder_for_Action_Item</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>TSS_Action_Item__c.Estimated_Completion_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>X1_Day_after_Action_Item_due</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>TSS_Action_Item__c.Estimated_Completion_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>X14_day_After_Action_Item_Due</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>TSS_Action_Item__c.Estimated_Completion_Date__c</offsetFromField>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
