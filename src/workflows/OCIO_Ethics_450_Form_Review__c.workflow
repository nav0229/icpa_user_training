<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Ethics450Form_Law_Manager_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics450Form Law Manager AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics450_Region_CBCA_Form_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region CBCA (G) Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_CBCA_G_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics450 Region CBCA Form Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics450_Region_CBCA_G_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics450 Region CBCA (G) AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics450_StaffOffice_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics450 StaffOffice AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics450_StaffOffice_Form_Owner_Update</fullName>
        <description>This rule will update the form owner to the Central Office- Staff Office Leaders forms for review queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_CO_Staff_Offices_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics450 StaffOffice  Form Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450Form_Law_Managers_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Law Managers queue so they can review all GSA attorneys 450 forms.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_Attorney_Mgrs</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450Form Law Managers Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450Form_No_Region_Owner_Update</fullName>
        <description>This workflow will route all forms that do not have an identified region to a queue for unknown regions.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_Unknown</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450Form No Region Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_CO_FAS_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Central Office- FAS Leaders forms for review queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_CO_FAS_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 CO-FAS  Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_CO_PBS_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Central Office- PBS Leaders forms for review queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_CO_PBS_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 CO-PBS  Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_C_O_FAS_Form_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 C.O. FAS  Form AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_C_O_PBS_Form_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 C.O. PBS Form AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Reg_NCR_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Reg. NCR AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_10_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 10 AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_1_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 1 AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_2_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 2 AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_3_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 3 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_4_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 4 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_5_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 5 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_6_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 6 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_7_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 7 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_8_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 8 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_9_Awaiting_Review</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region 9 Awaiting Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_IG_Awaiting_Revie</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region IG Awaiting Revie</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_LG_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region LG AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_LP_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region LP AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Region_LR_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Form Region LR AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Form_Routing_Region_5</fullName>
        <description>This rule will update the form owner to the Ethics Region 5  Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg5_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Form Routing Region 5</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Law_Staff_Form_AwaitingReview</fullName>
        <description>The &quot;review status&quot; field will update to &quot;Awaiting review&quot; once the form is placed in the queue.</description>
        <field>Ethics450_Review_Status__c</field>
        <literalValue>Awaiting Review</literalValue>
        <name>Ethics 450 Law Staff Form AwaitingReview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Law_Staff_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Law Staff queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Ethics_Law_Staff_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Law Staff  Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_10_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 10 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg10_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  10 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_1_Forms_Own_Update</fullName>
        <description>The Form owner will update to &quot;Region 1 Manager&apos;s Queue&quot; when the region identified is &quot;1&quot;</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg1_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region 1 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_1_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 1 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg1_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  1 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_1_Forms_Ownwe_Update</fullName>
        <description>The Form owner will update to &quot;Region 1 Manager&apos;s Queue&quot; when the region identified is &quot;1&quot;</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg1_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region 1 Forms Ownwe Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_2_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 2 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg2_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  2 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_3_Updated</fullName>
        <description>This rule will update the form owner to the Ethics Region 2 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg3_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region 3 Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_4_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 4 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg4_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  4 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_6_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 6 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg6_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  6 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_7_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 7 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg7_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  7 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_8_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 8 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg8_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  8 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_9_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region 9 Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg9_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  9 Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_IG_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region IG  Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_IG_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  IG Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_LG_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region LG  Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_LG_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  LG Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_LP_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region LP Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_LP_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  LP Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_LR_Forms_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region LR Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_LR_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  LR Forms Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ethics_450_Region_NCR_Form_Owner_Update</fullName>
        <description>This rule will update the form owner to the Ethics Region NCR Leaders queue so they can assign a reviewing attorney.</description>
        <field>OwnerId</field>
        <lookupValue>OGC_Ethics_450_Reg_NCR_Reviewer</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Ethics 450 Region  NCR Form Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Ethics 450 Form Routing Central Office-FAS</fullName>
        <actions>
            <name>Ethics_450_CO_FAS_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_C_O_FAS_Form_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Central Office -FAS</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms from Central Office-FAS to the Central Office- FAS leaders.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Central Office-PBS</fullName>
        <actions>
            <name>Ethics_450_CO_PBS_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_C_O_PBS_Form_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Central Office -PBS</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms from Central Office-PBS to the Central Office- PBS leaders.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Central Office-Staff Offices</fullName>
        <actions>
            <name>Ethics450_StaffOffice_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics450_StaffOffice_Form_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Central Office -Staff Offices</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms from Central Office- Staff Offices to the Central Office- Staff Offices leaders.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Law Managers</fullName>
        <actions>
            <name>Ethics450Form_Law_Manager_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450Form_Law_Managers_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Regional Attorney (L)</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms from all GSA Ethics attorneys to the Law Managers</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region  CBCA %28G%29</fullName>
        <actions>
            <name>Ethics450_Region_CBCA_Form_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics450_Region_CBCA_G_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Civilian Board of Contract Appeals (G)</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region CBCA (G).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 1</fullName>
        <actions>
            <name>Ethics_450_Form_Region_1_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_1_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 1.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 10</fullName>
        <actions>
            <name>Ethics_450_Form_Region_10_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_10_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 10.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 2</fullName>
        <actions>
            <name>Ethics_450_Form_Region_2_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_2_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>2</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 2.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 3</fullName>
        <actions>
            <name>Ethics_450_Form_Region_3_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_3_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>3</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 3.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 4</fullName>
        <actions>
            <name>Ethics_450_Form_Region_4_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_4_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 4.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 5</fullName>
        <actions>
            <name>Ethics_450_Form_Region_5_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Form_Routing_Region_5</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>5</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 5.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 6</fullName>
        <actions>
            <name>Ethics_450_Form_Region_6_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_6_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>6</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 6.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 7</fullName>
        <actions>
            <name>Ethics_450_Form_Region_7_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_7_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>7</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 7.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 8</fullName>
        <actions>
            <name>Ethics_450_Form_Region_8_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_8_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>8</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 8.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region 9</fullName>
        <actions>
            <name>Ethics_450_Form_Region_9_Awaiting_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_9_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>9</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region 9.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region IG</fullName>
        <actions>
            <name>Ethics_450_Form_Region_IG_Awaiting_Revie</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_IG_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>Office of Inspector General (IG)</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region IG.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region LG</fullName>
        <actions>
            <name>Ethics_450_Form_Region_LG_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_LG_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>LG</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region LG.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region LP</fullName>
        <actions>
            <name>Ethics_450_Form_Region_LP_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_LP_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>LP</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region LP.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region LR</fullName>
        <actions>
            <name>Ethics_450_Form_Region_LR_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_LR_Forms_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>LR</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region LR.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing Region NCR</fullName>
        <actions>
            <name>Ethics_450_Form_Reg_NCR_AwaitingReview</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ethics_450_Region_NCR_Form_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>equals</operation>
            <value>NCR</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will automatically route all Ethics 450 forms to the managers for region NCR.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ethics 450 Form Routing- No Region</fullName>
        <actions>
            <name>Ethics_450Form_No_Region_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Region__c</field>
            <operation>notContain</operation>
            <value>Central Office -PBS,NCR,LR,Regional Attorney,LP,Central Office -FAS,3,2,1,10,7,6,5,4,Civilian Board of Contract Appeals (G),9,Central Office -Staff Offices,8,IG,LG</value>
        </criteriaItems>
        <criteriaItems>
            <field>OCIO_Ethics_450_Form_Review__c.Ethics450_Run_Workflow__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This rule will route all forms without an identified region.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
