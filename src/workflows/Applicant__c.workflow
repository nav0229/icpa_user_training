<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>Get_SBA_Loan_History</fullName>
        <apiVersion>40.0</apiVersion>
        <description>Get the applicant&apos;s loan history information from ETRAN.</description>
        <endpointUrl>https://biztalk.tspi.net/LoanHistoryInformation/ApplicationId.svc</endpointUrl>
        <fields>Id</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>dcms2.systemuser@sba.gov</integrationUser>
        <name>Get SBA Loan History</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
</Workflow>
