<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Spend_Tracker_Item_Approval_Request_Approved</fullName>
        <description>Spend Tracker-Item-Approval Request Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Spend_Request_Email_Templates/Spend_Tracker_Item_Approval_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Spend_Tracker_Item_Approval_Request_Denied</fullName>
        <description>Spend Tracker-Item-Approval Request Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Spend_Request_Email_Templates/Spend_Tracker_Item_Approval_Request_Denied</template>
    </alerts>
    <alerts>
        <fullName>Spend_Tracker_Item_Approval_Request_Submitted</fullName>
        <description>Spend Tracker-Item-Approval Request Submitted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Spend_Request_Email_Templates/Spend_Tracker_Item_Approval_Request_Submitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>Product_equals_standard</fullName>
        <field>Product_Standard_or_Not_Listed__c</field>
        <formula>IF(Product_Or_Service__r.Product_Name__c = &quot;Not Listed&quot;, &quot;Not Listed&quot;, &quot;Standard&quot;)</formula>
        <name>Product equals standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clear_Denied_Hidden</fullName>
        <field>Denied_Hidden__c</field>
        <literalValue>0</literalValue>
        <name>Spend Tracker-Item-Clear Denied Hidden</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clear_DenyAppItemComm</fullName>
        <field>Deny_Approved_Item_Comments__c</field>
        <name>Spend Tracker-Item-Clear DenyAppItemComm</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clear_Deny_Appr_Item</fullName>
        <field>Deny_Approved_Item__c</field>
        <literalValue>0</literalValue>
        <name>Spend Tracker-Item-Clear Deny Appr Item</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clear_Re_Submit_Appr</fullName>
        <field>Re_Submit_Denied_Items_for_Approval__c</field>
        <literalValue>0</literalValue>
        <name>Spend Tracker-Item-Clear Re-Submit Appr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clone_Clear_AStatus</fullName>
        <description>When an item is Cloned, &quot;Approval Status&quot; field is reset to &quot;Not Submitted&quot;.</description>
        <field>Approval_Status__c</field>
        <literalValue>Not Submitted</literalValue>
        <name>Spend Tracker-Item-Clone Clear AStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Clone_Clear_FollowUp</fullName>
        <field>Follow_Up__c</field>
        <literalValue>0</literalValue>
        <name>Spend Tracker-Item-Clone Clear FollowUp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Denied_Hidden</fullName>
        <field>Denied_Hidden__c</field>
        <literalValue>1</literalValue>
        <name>Spend Tracker-Item-Denied Hidden</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Spend Tracker-Item-Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Denied</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Denied</literalValue>
        <name>Spend Tracker-Item-Status Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Not_Submitted</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Not Submitted</literalValue>
        <name>Spend Tracker-Item-Status Not-Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Under_FAS_Rev</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Under FAS Review</literalValue>
        <name>Spend Tracker-Item-Status Under FAS Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Under_OCFORev</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Under OCFO Review</literalValue>
        <name>Spend Tracker-Item-Status Under OCFORev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Under_PBS_Rev</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Under PBS Review</literalValue>
        <name>Spend Tracker-Item-Status Under PBS Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Item_Status_Under_SRB_Rev</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Under SRB Review</literalValue>
        <name>Spend Tracker-Item-Status Under SRB Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Total_Cost</fullName>
        <description>Calculates the Total of the O&amp;M and DM&amp;E fields if the request is IT Spend and Calculates the Unit Cost X Quantity if the Request is a Professional Services Request.</description>
        <field>Total_Cost__c</field>
        <formula>CASE(RecordType.Name,&quot;IT Spend Item&quot;,O_M_Cost__c + DM_E_Cost__c ,&quot;Professional Services Item&quot;,Quantity__c * Unit_Cost__c,&quot;Legacy IT Spend Item Record Type&quot;,O_M_Cost__c + DM_E_Cost__c ,&quot;Legacy Professional Services Item&quot;,Quantity__c * Unit_Cost__c,0)</formula>
        <name>Spend Tracker Total Cost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Spend_Tracker_Vendor_Populated_Check</fullName>
        <field>Vendor_Populated_Check__c</field>
        <literalValue>1</literalValue>
        <name>Spend Tracker Vendor Populated Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Spend Tracker Product Not Listed or Standard</fullName>
        <actions>
            <name>Product_equals_standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Used to populate a field on the item object that consolidates the Product to a Not Listed or Listed value.</description>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker Vendor Populated Check</fullName>
        <actions>
            <name>Spend_Tracker_Vendor_Populated_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Items__c.Vendor_If_Known__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Used for reports and dashboards</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker-Item-Clone Clear Item Fields</fullName>
        <actions>
            <name>Spend_Tracker_Item_Clear_Denied_Hidden</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clear_DenyAppItemComm</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clear_Deny_Appr_Item</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clear_Re_Submit_Appr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clone_Clear_AStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clone_Clear_FollowUp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Items__c.Name</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <description>When an item is Cloned, &quot;Approval Status&quot; field is reset to &quot;Not Submitted&quot;, &quot;Re-Submit Denied Items for Approval&quot; checkbox to false and &quot;Follow Up&quot; checkbox to false.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Spend Tracker-Item-Deny Approved Item</fullName>
        <actions>
            <name>Spend_Tracker_Item_Approval_Request_Denied</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clear_Deny_Appr_Item</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Clear_Re_Submit_Appr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Denied_Hidden</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Spend_Tracker_Item_Status_Denied</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Items__c.Deny_Approved_Item__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Items__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>&quot;Deny Approved Item&quot; check box will change &quot;Approval Status&quot; from Approved to Initial Stage.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Total Cost</fullName>
        <actions>
            <name>Spend_Tracker_Total_Cost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Used to update the &quot;Total Cost&quot; field so that it can be used in a roll-up summary.</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
