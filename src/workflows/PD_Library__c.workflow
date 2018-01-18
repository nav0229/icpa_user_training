<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PD_Library_Obsolete_Record_Hide</fullName>
        <description>When users select &quot;PD Status&quot; value as &quot;Obsolete&quot; or &quot;Historical Obsolete&quot;, then &quot;Obsolete Record Hide&quot; field will become True.</description>
        <field>Hide_Obsolete_Record__c</field>
        <literalValue>1</literalValue>
        <name>PD Library Obsolete Record Hide</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PD_Library_Obsolete_Record_Un_Hide</fullName>
        <description>When users select &quot;PD Status&quot; value anything other than &quot;Obsolete&quot; or &quot;Historical Obsolete&quot;, then &quot;Hide Obsolete Record&quot; field will become false.</description>
        <field>Hide_Obsolete_Record__c</field>
        <literalValue>0</literalValue>
        <name>PD Library Obsolete Record Un-Hide</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Region</fullName>
        <field>PD_Template__c</field>
        <literalValue>Regional</literalValue>
        <name>Update Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Master</fullName>
        <field>PD_Template__c</field>
        <literalValue>Master</literalValue>
        <name>Update to Master</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uncheck_Master</fullName>
        <field>Master__c</field>
        <literalValue>0</literalValue>
        <name>uncheck Master</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uncheck_the_master</fullName>
        <field>Master__c</field>
        <literalValue>0</literalValue>
        <name>uncheck the master</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_Standard</fullName>
        <field>PD_Template__c</field>
        <literalValue>Regional</literalValue>
        <name>update Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_cloned_checkbox</fullName>
        <field>Cloned_from_Master__c</field>
        <literalValue>1</literalValue>
        <name>update cloned checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_standard_to_region</fullName>
        <field>PD_Template__c</field>
        <literalValue>Regional</literalValue>
        <name>update standard to region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PD  Library Update Region</fullName>
        <actions>
            <name>Update_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PD_Library__c.Master__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Regions__c</field>
            <operation>notEqual</operation>
            <value>-None-</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Service__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>When a new Regional PDs are created, updating Standard field to Regional	 	.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PD Library Master to Region</fullName>
        <actions>
            <name>uncheck_the_master</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_cloned_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PD_Library__c.Cloned_from_Master__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.PD_Template__c</field>
            <operation>equals</operation>
            <value>Master</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Regions__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>When a Regional PDs is cloned from Master, updating Standard field to Regional and uncheck the Master Checkbox.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PD Library Obsolete Record Hide</fullName>
        <actions>
            <name>PD_Library_Obsolete_Record_Hide</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PD_Library__c.PD_Status__c</field>
            <operation>equals</operation>
            <value>Obsolete,Historical Obsolete</value>
        </criteriaItems>
        <description>When users select &quot;PD Status&quot; value as &quot;Obsolete&quot; or &quot;Historical Obsolete&quot;, then &quot;Obsolete Record Hide&quot; field will become True.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PD Library Obsolete Record Un-Hide</fullName>
        <actions>
            <name>PD_Library_Obsolete_Record_Un_Hide</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PD_Library__c.PD_Status__c</field>
            <operation>notEqual</operation>
            <value>Obsolete,Historical Obsolete</value>
        </criteriaItems>
        <description>When users select &quot;PD Status&quot; value anything other than &quot;Obsolete&quot; or &quot;Historical Obsolete&quot;, then &quot;Hide Obsolete Record&quot; field will become false.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PD Library Update Master</fullName>
        <actions>
            <name>Update_to_Master</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PD_Library__c.Master__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When a new Master PD is created, updating Standard field to Master to make PD as Master PD Template.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PD Library Update Regional</fullName>
        <actions>
            <name>uncheck_Master</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_standard_to_region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 4)  OR (2 AND 3) OR (1 AND 3)</booleanFilter>
        <criteriaItems>
            <field>PD_Library__c.Master__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Master__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Cloned_from_Master__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>PD_Library__c.Cloned_from_Master__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>When New Regional PD is created</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
