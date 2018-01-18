<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>FedRAMP_Email_on_Package_creation</fullName>
        <description>FedRAMP Email on Package creation</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>info@fedramp.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>FedRAMP_Email_Templates/FedRAMP_Send_Email_on_Package_Creation</template>
    </alerts>
    <rules>
        <fullName>FedRAMP Submission Confirmation Email Primary and Secondary</fullName>
        <actions>
            <name>FedRAMP_Email_on_Package_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FedRAMP_Contact__c.Contact_Type__c</field>
            <operation>equals</operation>
            <value>Primary,Secondary</value>
        </criteriaItems>
        <criteriaItems>
            <field>FedRAMP_Contact__c.Contact_Organization_Type__c</field>
            <operation>equals</operation>
            <value>Cloud Service Provider</value>
        </criteriaItems>
        <criteriaItems>
            <field>FedRAMP_Contact__c.Contact_Email__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
