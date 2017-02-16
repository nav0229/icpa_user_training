<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <knowledgePublishes>
        <fullName>Publish_Draft_Procedural_Articles</fullName>
        <action>Publish</action>
        <description>This action will publish draft Procedural Asset articles automatically when they hit the system (via Wizard article import)</description>
        <label>Publish Draft Procedural Articles</label>
        <language>en_US</language>
        <protected>false</protected>
    </knowledgePublishes>
    <rules>
        <fullName>Publish Procedures</fullName>
        <actions>
            <name>Publish_Draft_Procedural_Articles</name>
            <type>KnowledgePublish</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Procedural_Asset__kav.PublishStatus</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>GSA Federal Citizen Information Center Service Cloud Topic Desk Staff</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
