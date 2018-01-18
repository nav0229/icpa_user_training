<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Galaxy_Send_Budget_Exclusion_notice_Lease_Project</fullName>
        <description>Galaxy - Send Budget Exclusion notice-Lease Project</description>
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
        <template>Galaxy_Email_Templates/Galaxy_Budget_Exclusion_Lease_Project</template>
    </alerts>
    <alerts>
        <fullName>Glxy_NotifyBA53BudgetIncludes</fullName>
        <description>Glxy_NotifyBA53BudgetIncludes</description>
        <protected>false</protected>
        <recipients>
            <field>BA53RealtyAnalyst__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>donotreply@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Galaxy_Email_Templates/Glxy_NotifyBA53ProjectIncludes</template>
    </alerts>
    <fieldUpdates>
        <fullName>GLXY_LeaseProjectIAConversionDate</fullName>
        <field>IAConversionDate__c</field>
        <formula>Date(if( month(EffectiveDate__c)&lt;=10,year(EffectiveDate__c)+1,year(EffectiveDate__c)+2), 10, 1)</formula>
        <name>GLXY_LeaseProjectIAConversionDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Galaxy_Budget_Exclusion_Reason</fullName>
        <field>Budget_Exclusion_Reason__c</field>
        <formula>&quot;Reduction Project created by the System based on New/Replacing Project&quot;</formula>
        <name>Galaxy Budget Exclusion Reason</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Galaxy_Clear_Out_Verified_Past_Due</fullName>
        <field>Verified_Past_Due__c</field>
        <literalValue>0</literalValue>
        <name>Galaxy - Clear Out Verified Past Due</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Galaxy_Clear_Out_Verified_Rate_Diff_C</fullName>
        <field>Verified_Rate_Diff__c</field>
        <literalValue>0</literalValue>
        <name>Galaxy - Clear Out Verified Rate Diff. C</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Galaxy_Exclude_Budget_Flag</fullName>
        <description>Exclude Budget Flag</description>
        <field>BDGFlag__c</field>
        <literalValue>0</literalValue>
        <name>Galaxy_Exclude Budget Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_BudgetReason_Project_FU</fullName>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <field>Budget_Exclusion_Reason__c</field>
        <name>Glxy_BudgetReason_Project_FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_LeaseProjectVal</fullName>
        <description>Unique Project Number</description>
        <field>ProjectID__c</field>
        <formula>Name</formula>
        <name>Glxy_LeaseProjectVal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_SetAccrualFlagProj</fullName>
        <field>CalculateAccruals__c</field>
        <literalValue>1</literalValue>
        <name>Glxy_SetAccrualFlagProj</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_UpdateOldIABasedOnCheckbox</fullName>
        <field>OldIASqFt__c</field>
        <formula>CalculatedOldIASqFt__c</formula>
        <name>Glxy_UpdateOldIABasedOnCheckbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_UpdateOldNOABasedOnCheckbox</fullName>
        <field>OldNOASqFt__c</field>
        <formula>CalculatedOldNOASqFt__c</formula>
        <name>Glxy_UpdateOldNOABasedOnCheckbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_UpdateOldSqFtBasedOnCheckbox</fullName>
        <field>Old_Square_Feet__c</field>
        <formula>CalculatedOldIASqFt__c + CalculatedOldNOASqFt__c</formula>
        <name>Glxy_UpdateOldSqFtBasedOnCheckbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Glxy_Update_Processed_Date_PROJ</fullName>
        <field>ProcessedDate__c</field>
        <formula>Acceptance620Date__c</formula>
        <name>Glxy_Update Processed Date (PROJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Processed_Date_LeaseProject</fullName>
        <field>ProcessedDate__c</field>
        <formula>If ( 
YEAR(EffectiveDate__c + 92) &lt; YEAR(TODAY() + 92), 
Date(YEAR(TODAY() - 92), 10, 01), 
EffectiveDate__c 
)</formula>
        <name>GLXY_Set Processed Date (LeaseProject)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>GLXY_Default Processed Date %28 Lease Projects %29</fullName>
        <actions>
            <name>Set_Processed_Date_LeaseProject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Defaults the processed date to effective date when processed date null</description>
        <formula>(ISBLANK(Acceptance620Date__c) || ISNULL(Acceptance620Date__c)) &amp;&amp; (ISCHANGED(EffectiveDate__c) || ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_LeaseProjectIAConversionDate</fullName>
        <actions>
            <name>GLXY_LeaseProjectIAConversionDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes values of IA Converstion Date based on change on IA SqFt.</description>
        <formula>AND(ISBLANK( IAConversionDate__c ), (IASquareFeet__c &lt;&gt; 0))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GLXY_send budget exclude notify</fullName>
        <actions>
            <name>Galaxy_Send_Budget_Exclusion_notice_Lease_Project</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(ISCHANGED(BDGFlag__c), BDGFlag__c=FALSE, RecordType.DeveloperName=&quot;Rexus&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Galaxy - Clear Out Verified Past Due Checkbox</fullName>
        <actions>
            <name>Galaxy_Clear_Out_Verified_Past_Due</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Clear out Past Due checkbox when Past Due Bucket changes ...</description>
        <formula>((TEXT( Past_Due_Bucket__c ) &lt;&gt; TEXT(PRIORVALUE(Past_Due_Bucket__c)) &amp;&amp; NOT(ISBLANK(TEXT(PRIORVALUE(Past_Due_Bucket__c)))) ) || (PastDueIndicator__c == false &amp;&amp; PRIORVALUE(PastDueIndicator__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Galaxy - Clear Out Verified Rate Diff%2E Checkbox</fullName>
        <actions>
            <name>Galaxy_Clear_Out_Verified_Rate_Diff_C</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Clear out Rate Diff checkbox when rate diff % changes ...</description>
        <formula>Round((Rate_Diff_Percent__c)* 100,2) &lt;&gt; Round(PRIORVALUE(Rate_Diff_Percent__c) * 100,2)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Galaxy_ReductionProjects_ExcludeBudget</fullName>
        <actions>
            <name>Galaxy_Budget_Exclusion_Reason</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Galaxy_Exclude_Budget_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>For Reduction type of Projects, Exclude budget for that Project</description>
        <formula>(TEXT(Project_Type__c) = &apos;Reduction&apos;) &amp;&amp; CONTAINS( Remarks__c , &quot;created by the system&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_BudgetReason_Project</fullName>
        <actions>
            <name>Glxy_BudgetReason_Project_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Glxy_LeaseProjects__c.BDGFlag__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Glxy_LeaseProjects__c.Project_Type__c</field>
            <operation>notEqual</operation>
            <value>Reduction</value>
        </criteriaItems>
        <criteriaItems>
            <field>Glxy_LeaseProjects__c.Remarks__c</field>
            <operation>notContain</operation>
            <value>created by the system</value>
        </criteriaItems>
        <description>Set Budget Reason blank when the Budget Flag is set to true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_LeaseProjectKeyVal</fullName>
        <actions>
            <name>Glxy_LeaseProjectVal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.CreatedById</field>
            <operation>greaterThan</operation>
            <value>1/1/1900</value>
        </criteriaItems>
        <description>LeaseProject can have only one unique project</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_NotifyAnalystOnBudgetIncludes</fullName>
        <actions>
            <name>Glxy_NotifyBA53BudgetIncludes</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify the BA53 if Cast Iron user includes this project in budget</description>
        <formula>(   !ISNEW() &amp;&amp;    BDGFlag__c == true &amp;&amp;   PRIORVALUE(BDGFlag__c) == false &amp;&amp;   RecordType.DeveloperName = &apos;Rexus&apos;  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_SetCalculateAccrualFlagProj</fullName>
        <actions>
            <name>Glxy_SetAccrualFlagProj</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets the Calculate Accrual flag for the Lease Project object. This will be used by the back-end job to reset Accrual amounts.</description>
        <formula>ISCHANGED(eEorA__c)  &amp;&amp;   ISPICKVAL(eEorA__c, &apos;Actual&apos;)  &amp;&amp;   Value(ProcessedDateFY__c) &gt; Value(EffectiveDateFY__c) &amp;&amp; RecordType.DeveloperName = &apos;Rexus&apos;  &amp;&amp;   PRIORVALUE( CalculateAccruals__c) = false</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Glxy_Update Processed Date %28PROJ%29</fullName>
        <actions>
            <name>Glxy_Update_Processed_Date_PROJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(    ISCHANGED(Acceptance620Date__c)     &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) ) || (    IsNew()    &amp;&amp;    NOT(ISBLANK(Acceptance620Date__c))    &amp;&amp;     NOT(ISNULL(Acceptance620Date__c)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
