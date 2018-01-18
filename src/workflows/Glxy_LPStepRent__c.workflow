<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Galaxy_Send_Budget_Exclusion_notice_LP_Step_Rent</fullName>
        <description>Galaxy - Send Budget Exclusion notice-LP Step Rent</description>
        <protected>false</protected>
        <recipients>
            <field>RealtySpecialist__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Galaxy_Email_Templates/Galaxy_Budget_Exclusion_LP_Step_Rent</template>
    </alerts>
    <fieldUpdates>
        <fullName>GLXY_Set_Processed_Date_LPStepRent</fullName>
        <field>ProcessedDate__c</field>
        <formula>EffectiveDate__c</formula>
        <name>GLXY_Set Processed Date(LPStepRent)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_BudgetReason_ProjectStepRent_FU</fullName>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <field>Budget_Exclusion_Reason__c</field>
        <name>Glxy_BudgetReason_ProjectStepRent_FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28 LP StepRent %29</fullName>
        <actions>
            <name>GLXY_Set_Processed_Date_LPStepRent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Defaults Processed Date to Effective Date on NULL</description>
        <formula>ISBLANK( ProcessedDate__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_send budget exclude notify %28LP StepRent%29</fullName>
        <actions>
            <name>Galaxy_Send_Budget_Exclusion_notice_LP_Step_Rent</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends an email to the Realty specialist and current users that budget exclusion has been set for a record.</description>
        <formula>AND(  ISCHANGED( BDGFlag__c ) , BDGFlag__c = FALSE ,  RecordType.DeveloperName = &quot;Rexus&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_BudgetReason_ProjectStepRent</fullName>
        <actions>
            <name>Glxy_BudgetReason_ProjectStepRent_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LPStepRent__c.BDGFlag__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
