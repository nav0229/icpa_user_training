<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PropTrack_PIF_Agreed_Budget_Scope</fullName>
        <description>PropTrack-PIF-Agreed Budget &amp; Scope</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Agreed_on_Budget_and_Scope</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Early_Stage_7_Day_Reminder</fullName>
        <description>PropTrack-PIF-Early Stage 7 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Team Member</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_Early_Stage_7_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_First_Meeting_Scheduled_14_Day_Reminder</fullName>
        <description>PropTrack-PIF-First Meeting Scheduled 14 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_First_Meeting_Scheduled_Stage_14_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</fullName>
        <description>PropTrack-PIF-IAA Request Form Completed Stage 3 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_IAA_Request_Form_Completed_Stage_3_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_IAA_Signed_Notification</fullName>
        <description>PropTrack-PIF-IAA Signed Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Team Member</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_IAA_Signed_Notification</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Needs_Scoping_Stage_14_Day_Reminder</fullName>
        <description>PropTrack-PIF-Needs Scoping Stage 14 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_Needs_Scoping_Stage_14_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Oppty_Project_Proposal_Submitted</fullName>
        <description>PropTrack-PIF-Oppty Project Proposal Submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>PropTrack_PIF_Team_Members</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_Project_Proposal_Submitted</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Oppty_Proposal_Stage_5_Day_Reminder</fullName>
        <description>PropTrack-PIF-Oppty Proposal Stage 5 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>PropTrack_PIF_Managers</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_Proposal_Stage_5_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Project_End_Date_Notification</fullName>
        <description>PropTrack-PIF-Project End Date Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Team Member</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Project_End_Date_Notifications</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_SOW_Sent_to_Client_Stage_7_Day_Reminder</fullName>
        <description>PropTrack-PIF-SOW Sent to Client Stage 7 Day Reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>Lead</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Opportunity_SOW_Sent_to_Client_Stage_7_Day_Reminder</template>
    </alerts>
    <alerts>
        <fullName>PropTrack_PIF_Tock_Notification</fullName>
        <description>PropTrack-PIF-Tock Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Team Member</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <senderAddress>pif-intake@gsa.gov</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Proposal_Tracker/PropTrack_Tock_Name_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>PropTrack_Oppty_PIF_CloseDate_FY_EndDate</fullName>
        <description>Close Date on Opportunity should be defaulted to end of Government FY.</description>
        <field>CloseDate</field>
        <formula>IF (DATEVALUE(CreatedDate) &lt;= Date(2016, 09, 30), Date(2016, 09, 30), 
		(IF (DATEVALUE(CreatedDate) &gt; Date(2016, 09, 30) &amp;&amp; DATEVALUE(CreatedDate) &lt;= Date(2017, 09, 30) , Date(2017, 09, 30), 
				(IF (DATEVALUE(CreatedDate) &gt; Date(2017, 09, 30) &amp;&amp; DATEVALUE(CreatedDate) &lt;= Date(2018, 09, 30), Date(2018, 09, 30), 
						(IF(DATEVALUE(CreatedDate) &gt; Date(2018, 09, 30) &amp;&amp; DATEVALUE(CreatedDate) &lt;= Date(2019, 09, 30), Date(2019, 09, 30), 
								(IF (DATEVALUE(CreatedDate) &gt; Date(2019, 09, 30) &amp;&amp; DATEVALUE(CreatedDate) &lt;= Date(2020, 09, 30), Date(2020, 09, 30), DATEVALUE(CreatedDate) + 180))
							)
						)
					)
				)
			)
		)
	)</formula>
        <name>PropTrack-Oppty-PIF-CloseDate-FY EndDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PropTrack_Oppty_PIF_Stage_Early</fullName>
        <description>Update the Opportunity Stage to Early</description>
        <field>StageName</field>
        <literalValue>Early</literalValue>
        <name>PropTrack-Oppty-PIF-Stage-Early</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PropTrack_Oppty_PIF_Stage_EngagmntActive</fullName>
        <description>Update the Opportunity Stage to Engagement Active</description>
        <field>StageName</field>
        <literalValue>Engagement Active</literalValue>
        <name>PropTrack-Oppty-PIF-Stage-EngagmntActive</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PropTrack_Oppty_PIF_Stage_EngagmntClosed</fullName>
        <description>Update the Opportunity Stage to Engagement Closed</description>
        <field>StageName</field>
        <literalValue>Engagement Closed</literalValue>
        <name>PropTrack-Oppty-PIF-Stage-EngagmntClosed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-CreatedFromLead</fullName>
        <actions>
            <name>PropTrack_PIF_Oppty_Project_Proposal_Submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>PropTrack_Oppty_PIF_CloseDate_FY_EndDate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PropTrack_Oppty_PIF_Stage_Early</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Created_from_Lead__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>PropTrack - PIF - When Opportunity is created from Lead, send an email to PropTrack Team Members (non-Managers), update the close date to the end of the FY, update the opportunity stage to Early.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-End Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>PropTrack - PIF - When Opportunity is coming to an end, PropTrack members (associated to that opportunity) need to be notified 4 weeks, 2 weeks, 3 days prior to the end date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Project_End_Date_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.End_Date__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Project_End_Date_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.End_Date__c</offsetFromField>
            <timeLength>-28</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Project_End_Date_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.End_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in Agreed on Budget and Scope</fullName>
        <actions>
            <name>PropTrack_PIF_Agreed_Budget_Scope</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Agreed on Budget and Scope</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage has just entered &quot;Agreed on Budget and Scope&quot; from &quot;Scoping&quot;, send the PIF Lead an email notification. Also, send an email notification every day if the stage hasn’t progressed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Agreed_Budget_Scope</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Agreed_Budget_Scope</name>
                <type>Alert</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Agreed_Budget_Scope</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Agreed_Budget_Scope</name>
                <type>Alert</type>
            </actions>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Agreed_Budget_Scope</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in Early for days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Early</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage hasn&apos;t moved beyond Early for several days, send an email after every 7 days to the opportunity owner and the opportunity team members</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Early_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>28</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Early_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Early_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Early_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in Engagement Active</fullName>
        <actions>
            <name>PropTrack_Oppty_PIF_Stage_EngagmntActive</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>PropTrack - PIF - Stage automatically updates to &quot;Engagement Active&quot; when Start_Date is TODAY</description>
        <formula>RecordType.Name = &quot;PIF Project Opportunity&quot; &amp;&amp; Start_Date__c == TODAY() &amp;&amp;  ISPICKVAL( StageName , &apos;IAA Signed&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in Engagement Closed</fullName>
        <actions>
            <name>PropTrack_Oppty_PIF_Stage_EngagmntClosed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>PropTrack - PIF - Stage automatically updates  to &quot;Engagement Closed&quot; when End_Date is TODAY</description>
        <formula>RecordType.Name = &quot;PIF Project Opportunity&quot; &amp;&amp; End_Date__c == TODAY() &amp;&amp;  ISPICKVAL( StageName , &apos;Engagement Active&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in First Meeting Scheduled for days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>First Meeting Scheduled</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage hasn&apos;t moved beyond First Meeting Scheduled for several days, send an email notification to the Opportunity Owner and the PIF Manager 2 weeks later and then after 1 week three times</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_First_Meeting_Scheduled_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_First_Meeting_Scheduled_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>28</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_First_Meeting_Scheduled_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>35</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_First_Meeting_Scheduled_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in IAA Request Form Completed in 3 days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>IAA Request Form Completed</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage hasn&apos;t moved beyond &quot;IAA Request Form Completed&quot; for 3 days, send an email notification to the PIF Lead every 3 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>6</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>9</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_IAA_Request_Form_Completed_Stage_3_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>12</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in IAA Signed</fullName>
        <actions>
            <name>PropTrack_PIF_IAA_Signed_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>IAA Signed</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage has moved to IAA Signed stage, send email notification to PIF Team Members, including PIF Lead</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in SOW Sent to Client for 7 days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>SOW Sent to Client</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage hasn&apos;t moved beyond &quot;SOW Sent to Client&quot; in 7 days and every 7 days thereafter, send an email notification to the PIF Lead</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_SOW_Sent_to_Client_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>28</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_SOW_Sent_to_Client_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_SOW_Sent_to_Client_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_SOW_Sent_to_Client_Stage_7_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Stage in Scoping for 14 days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Scoping</value>
        </criteriaItems>
        <description>PropTrack - PIF - When stage hasn&apos;t moved beyond Scoping in at least 14 days, send an email notification to the Opportunity Owner and the PIF Manager and then 1 week later 3 more times</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Needs_Scoping_Stage_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>28</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Needs_Scoping_Stage_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>35</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Needs_Scoping_Stage_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Needs_Scoping_Stage_14_Day_Reminder</name>
                <type>Alert</type>
            </actions>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>PropTrack-Opportunity-PIF-Tock Name</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>PIF Project Opportunity</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Tock_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>PropTrack - PIF - When the PIF Team completes the Tock Name and Start Date, send an email notification to the PIF Team Member(s) 3 days before the Start Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>PropTrack_PIF_Tock_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Start_Date__c</offsetFromField>
            <timeLength>-3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
