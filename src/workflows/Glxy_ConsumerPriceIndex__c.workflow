<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Galaxy_Send_Budget_Exclusion_notice_CPI</fullName>
        <description>Galaxy - Send Budget Exclusion notice-CPI</description>
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
        <template>Galaxy_Email_Templates/Galaxy_Budget_Exclusion_CPI</template>
    </alerts>
    <fieldUpdates>
        <fullName>CPISQFttoLeaseSQFt</fullName>
        <field>Square_Feet__c</field>
        <formula>LeaseNumber__r.BaseSquareFeet__c</formula>
        <name>GLXY_CPISQFttoLeaseSQFt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_BudgetReason_CPI_FU</fullName>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <field>Budget_Exclusion_Reason__c</field>
        <name>Glxy_BudgetReason_CPI_FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_SetAccrualFlagCPI</fullName>
        <field>CalculateAccruals__c</field>
        <literalValue>1</literalValue>
        <name>Glxy_SetAccrualFlagCPI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_Update_Processed_Date_CPI</fullName>
        <field>ProcessedDate__c</field>
        <formula>Acceptance620Date__c</formula>
        <name>Glxy_Update Processed Date (CPI)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Processed_Date_CPI</fullName>
        <description>Sets the proccessed data = effective date when processed null</description>
        <field>ProcessedDate__c</field>
        <formula>If (
YEAR(EffectiveDate__c + 92) &lt; YEAR(TODAY() + 92),
Date(YEAR(TODAY() - 92), 10, 01),
EffectiveDate__c
)</formula>
        <name>Set Processed Date (CPI)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28 CPI %29</fullName>
        <actions>
            <name>Set_Processed_Date_CPI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Defaults the processed date</description>
        <formula>(ISBLANK(Acceptance620Date__c) || ISNULL(Acceptance620Date__c)) &amp;&amp; (ISCHANGED(EffectiveDate__c) || ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_Default the SQ Ft to Lease SQ Ft %28CPI%29</fullName>
        <actions>
            <name>CPISQFttoLeaseSQFt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If SQ Ft in CPI is NULL, Default to Lease SQ Ft</description>
        <formula>ISBLANK(Square_Feet__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_Update Processed Date %28CPI%29</fullName>
        <actions>
            <name>Glxy_Update_Processed_Date_CPI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(    ISCHANGED(Acceptance620Date__c)     &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) ) || (    IsNew()    &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_send budget exclude notify</fullName>
        <actions>
            <name>Galaxy_Send_Budget_Exclusion_notice_CPI</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(ISCHANGED(BDGFlag__c), BDGFlag__c=FALSE, RecordType.DeveloperName=&quot;Rexus&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_BudgetReason_CPI</fullName>
        <actions>
            <name>Glxy_BudgetReason_CPI_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_ConsumerPriceIndex__c.BDGFlag__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_SetCalculateAccrualFlagCPI</fullName>
        <actions>
            <name>Glxy_SetAccrualFlagCPI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets the Calculate Accrual flag for the CPI object. This will be used by the back-end job to reset Accrual amounts.</description>
        <formula>( ISCHANGED(StatusCD__c) &amp;&amp;   ISPICKVAL(StatusCD__c, &apos;Actual&apos;) &amp;&amp;   RecordType.DeveloperName = &apos;Rexus&apos; &amp;&amp;  PRIORVALUE(CalculateAccruals__c) = false &amp;&amp; Value(ProcessedDateFY__c) &gt; Value(EffectiveDateFY__c) )    ||    ( ISNEW() &amp;&amp;  ISPICKVAL(StatusCD__c, &apos;Actual&apos;) &amp;&amp;   RecordType.DeveloperName = &apos;Rexus&apos;   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
