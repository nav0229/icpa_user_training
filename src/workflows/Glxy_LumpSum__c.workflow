<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Galaxy_Send_Budget_Exclusion_notice_Lump_Sum</fullName>
        <description>Galaxy - Send Budget Exclusion notice-Lump Sum</description>
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
        <template>Galaxy_Email_Templates/Galaxy_Budget_Exclusion_Lump_Sum</template>
    </alerts>
    <fieldUpdates>
        <fullName>Glxy_BudgetReason_LumpSum_FU</fullName>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <field>Budget_Exclusion_Reason__c</field>
        <name>Glxy_BudgetReason_LumpSum_FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_SetAccrualFlagLS</fullName>
        <field>CalculateAccruals__c</field>
        <literalValue>1</literalValue>
        <name>Glxy_SetAccrualFlagLS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_Update_Processed_Date_LS</fullName>
        <field>ProcessedDate__c</field>
        <formula>Acceptance620Date__c</formula>
        <name>Glxy_Update Processed Date (LS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>set_Processed_Date_LumpSum</fullName>
        <description>Sets the processed Date with Effective date if null</description>
        <field>ProcessedDate__c</field>
        <formula>If ( 
YEAR(EffectiveDate__c + 92) &lt; YEAR(TODAY() + 92), 
Date(YEAR(TODAY() - 92), 10, 01), 
EffectiveDate__c 
)</formula>
        <name>GLXY_set Processed Date(LumpSum)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28Lump Sum%29</fullName>
        <actions>
            <name>set_Processed_Date_LumpSum</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Defaults the processed date with the effective date if processed date is null</description>
        <formula>(ISBLANK(Acceptance620Date__c) || ISNULL(Acceptance620Date__c)) &amp;&amp; (ISCHANGED(EffectiveDate__c) || ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_send budget exclude notify - Lump Sum</fullName>
        <actions>
            <name>Galaxy_Send_Budget_Exclusion_notice_Lump_Sum</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends email to Realty Specialist and Current User that Budget exclusion has been set on a Lump sum record.</description>
        <formula>AND(ISCHANGED(BDGFlag__c), BDGFlag__c=FALSE, RecordType.DeveloperName=&quot;Rexus&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_BudgetReason_LumpSum</fullName>
        <actions>
            <name>Glxy_BudgetReason_LumpSum_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LumpSum__c.BDGFlag__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_SetCalculateAccrualFlagLS</fullName>
        <actions>
            <name>Glxy_SetAccrualFlagLS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets the Calculate Accrual flag for the Lump Sum object. This will be used by the back-end job to reset Accrual amounts.</description>
        <formula>(ISCHANGED(StatusCd__c) &amp;&amp;  ISPICKVAL(StatusCd__c, &apos;Actual&apos;) &amp;&amp;  RecordType.DeveloperName = &apos;Rexus&apos; &amp;&amp;  PRIORVALUE(CalculateAccruals__c) = false)  ||  ( ISNEW() &amp;&amp; ISPICKVAL(StatusCd__c, &apos;Actual&apos;) &amp;&amp;  RecordType.DeveloperName = &apos;Rexus&apos;  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_Update Processed Date %28LS%29</fullName>
        <actions>
            <name>Glxy_Update_Processed_Date_LS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(    ISCHANGED(Acceptance620Date__c)     &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) ) || (    IsNew()    &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
