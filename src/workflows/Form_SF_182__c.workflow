<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Sf_182_Updated_IDP_in_SF_182</fullName>
        <description>Sf 182 Updated IDP in SF 182</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SF_182_Updated_IDP_info</template>
    </alerts>
    <fieldUpdates>
        <fullName>Form_SF_182_Field_update_on_Division</fullName>
        <field>Division__c</field>
        <formula>Division_Formula__c</formula>
        <name>Form SF 182  Field update on Division</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_182_Field_update_on_Division</fullName>
        <field>Division__c</field>
        <formula>Division_Formula__c</formula>
        <name>SF 182  Field update on Division</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SF 182 - Workflow to update Division from User</fullName>
        <actions>
            <name>SF_182_Field_update_on_Division</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Division</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SF 182 Updated IDP in SF 182</fullName>
        <actions>
            <name>Sf_182_Updated_IDP_in_SF_182</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( IDP__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
