@isTest(SeeAllData=true)
public class PDE_TestFormController {

    static testMethod void validateHasSourceDocumentTypes(){
        System.assert(PDE_FormController.getsourcedocumentpickval().size()>0);
    }

    static testMethod void validateHasRegions(){
        System.assert(PDE_FormController.getregionpickval().size()>10);
    }

    static testMethod void validateHasUserData(){
        String d = PDE_FormController.getUserName();
        System.assert(d.length()>0);
        String e= PDE_FormController.getEmail();
        System.debug(e);
        String f=PDE_FormController.getDivision();
        System.debug(f);
        String g=PDE_FormController.getOrg();
        System.debug(g);
        String h = PDE_FormController.getTitle();
        System.debug(h);
        User u= [Select Id From User where (not email like '%=%') and isActive = true limit 1];
        String i = PDE_FormController.getUserNameId(u.id);
        System.debug(i);
    }
    
    static testMethod void testSaveCaseNoRegion(){
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Commitment';
        String ret = PDE_FormController.savePDECaseEntry(c);
        System.assert(ret.contains('region'));        
    }
    
    static testMethod void testSaveCaseBadPdn(){
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Commitment';
        c.PDE_PDN__c='#@';
        String ret = PDE_FormController.savePDECaseEntry(c);
        System.assert(ret.contains(';PDN must'));       
    }
    
    static testMethod void testSaveCaseGoodPdn(){
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Commitment';
        c.PDE_PDN__c='RWa';
        String ret = PDE_FormController.savePDECaseEntry(c);
        System.assert(!ret.contains(';PDN must'));        
    }
    
    static testMethod void testSaveCaseNoAttachmentsWhenRequired(){
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Order/Award';
        c.PDE_Attachments_To_Load_Counter__c = 0;
        String ret = PDE_FormController.savePDECaseEntry(c);
        System.assert(ret.contains(';You only'), ret);        
    }
    
    static testMethod void testSaveCaseThenGetFinalizationData(){
        system.debug('testSaveCaseThenGetFinalizationData vvvvvvvvvvvvvvvvvvvvvvvvvvvvv');    
        String ret;
        
        User u = [Select Id, Name From User where (not email like '%=%') and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true limit 1];    
        ret = string.valueOf(u.Id);
        system.debug('testSaveCaseThenGetFinalizationData adding user Id='+ret+' name='+u.Name);
        //ret = ret.substring(0, ret.length()-3);
        PDE_Case_Entry__c c = new PDE_Case_Entry__c();
        c.PDE_Source_Document__c='Commitment';
        c.PDE_PDN__c='RWa';
        c.PDE_Team_Members__c = ret;
        c.PDE_Region__c = '5';
        c.PDE_Attachments_To_Load_Counter__c = 1;
        ret = PDE_FormController.savePDECaseEntry(c);
        System.assert(ret.contains('success;'));        
        ret = string.valueOf(c.Id);
        ret = ret.substring(0, ret.length()-3);
        PDE_AttachmentsController.saveTheChunk(ret, 'Attach5.txt', 'VEVTVCB0ZXN0IFRFU1QgdGVzdCBiYXNlNjQgZGF0YS4=', 'text/plain', '', 'Y') ;       
        ret = PDE_FormController.getFinalizationData(c.Id);
        System.assert(ret.contains('finalizationData;'));       
        system.debug('testSaveCaseThenGetFinalizationData ^^^^^^^^^^^^^^^^^^^^^^^^^^^');    
    }
    
    static testMethod void ParseMoney(){
        System.AssertEquals(1.03, PDEHelper.ParseMoney(' $1.03'));
        System.AssertEquals(1000.03, PDEHelper.ParseMoney(' $1000.03'));
        System.AssertEquals(10000.03, PDEHelper.ParseMoney(' $10,000.03'));
        System.AssertEquals(-1.03, PDEHelper.ParseMoney(' -$1.03'));
    }
        
    static testMethod void testEasiEmailData(){    
        String body = 
'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Jonathan Chen - PCBL-C</b> <span dir="ltr">&lt;<a href="mailto:jonathan.chen@gsa.gov">jonathan.chen@gsa.gov</a>&gt;</span><br>Date: Wed, Aug 30, 2017 at 9:13 PM<br>Subject: Fwd: GSA EASi: Mod Finalized - GS-P-02-15-DT-7023 Mod PC06<br>To: Jason Thomas - BR1-C &lt;<a href="mailto:jason.thomas@gsa.gov">jason.thomas@gsa.gov</a>&gt;<br><br><br><div><br><div class="gmail_quote"><div>---------- Forwarded message ---------<br>From: Lynnie Wu - BR1F &lt;<a href="mailto:lynn.wu@gsa.gov" target="_blank">lynn.wu@gsa.gov</a>&gt;<br>Date: Thu, Jul 27, 2017 at 10:41 AM<br>Subject: Fwd: GSA EASi: Mod Finalized - GS-P-02-15-DT-7023 Mod PC06<br>To: Jonathan Chen (PCBL-C) &lt;<a href="mailto:jonathan.chen@gsa.gov" target="_blank">jonathan.chen@gsa.gov</a>&gt;<br></div><br><br><div><div style="font-family:verdana,sans-serif"><br clear="all"></div><div><div class="m_3526508001029765117m_-2442312672567214212gmail_signature" data-smartmail="gmail_signature"><div><div><div><div><div><div><div><font color="#000000">Lynnie Wu</font></div><div><font color="#000000">Branch Chief,&nbsp;</font><span style="font-size:12.8px">Financial Management Division, Zone 1</span><div><div style="font-size:12.8px">Region 2 OCFO/PBS Regional Liaison</div><div style="font-size:small"><span style="font-family:arial">Office of the Chief Financial Officer</span><span style="font-family:arial"><br></span></div><div style="font-size:small">US General Services Administration</div><div><div><div><a style="color:rgb(17,85,204)" value="&#43;12122644287">(212) 264-4287</a><br></div></div></div></div></div></div></div></div></div></div></div></div></div>'+
'<br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername"></b> <span>&lt;<a href="mailto:easi.admin@gsa.gov" target="_blank">easi.admin@gsa.gov</a>&gt;</span><br>Date: Wed, Jul 26, 2017 at 7:36 AM<br>Subject: GSA EASi: Mod Finalized - GS-P-02-15-DT-7023 Mod PC06<br>To: Lynn Wu &lt;<a href="mailto:lynn.wu@gsa.gov" target="_blank">lynn.wu@gsa.gov</a>&gt;<br><br><br><div><div style="padding:15px">Mod GS-P-02-15-DT-7023 Mod PC06 has been awarded and finalized.<br><br><table><tbody><tr><td><b>Mod Number:</b></td><td>GS-P-02-15-DT-7023 Mod PC06</td></tr><tr><td><b>Title:</b></td><td>GS-P-02-13-DT-0024</td></tr><tr><td><b>Owner:</b></td><td>Shari Gouveia</td></tr><tr><td><b>Total Amount:</b></td><td>$0.00</td></tr><tr><td><b>Obligated Values:</b></td><td>$0.00</td></tr><tr><td><b>Option(s) Value:</b></td><td>$0.00</td></tr><tr><td><b>Vendor Name:</b></td><td>CBRE, INC</td></tr><tr><td><b>Award Form:</b></td><td>SF1449</td></tr><tr><td><b>Award Number:</b></td><td>GS-05-P-17-SL-D-0006</td></tr><tr><td><b>PR Number(s):</b></td><td>EQ5P2SS2F1-16-5239</td></tr><tr><td><b>Mod Form:</b></td><td>SF30</td></tr><tr><td><b>Period of Performance Start Date:</b></td><td>04/22/2013</td></tr><tr><td><b>Period of Performance End Date:</b></td><td>11/03/2017</td></tr></tbody></table>'+
'  <br>'+
'  To view the Mod use the link provided below:'+
'  <br><a href="https://easi.pbs.gsa.gov/suite/tempo/records/type/award/item/iwBinLDeHJegYbgj9gQhFKBU2JwSZTc3yq8xAGfS6zQcZVbsTBy7-Zy1TQddg/view/summary" target="_blank">Link to Mod Details</a></div><span class="HOEnZb"><font color="#888888">'+
'  </font></span><span class="HOEnZb"><font color="#888888">'+
'</font></span><table style="padding-top:10px;font-family:Arial,sans-serif;font-size:11px;color:#3c3c3c">'+
'  <tbody><tr>'+
'    <td>This message has been sent by GSA PBS Electronic Acquisition System Integration (EASi)</td>'+
'  </tr> '+
'  <tr>'+
'   <td>If you need assistance, please email the GSA IT Service Desk at <a href="mailto:ITServiceDesk@gsa.gov" target="_blank">ITServiceDesk@gsa.gov</a> or call them at <a href="tel:(866)%20450-5250" target="_blank" value="&#43;18664505250">(866) 450-5250</a></td></tr></tbody></table></div></div><span class="HOEnZb"><font color="#888888"><br></font></span></div><span class="HOEnZb"><font color="#888888">'+
'</font></span></div></div><span class="HOEnZb"><font color="#888888"><div dir="ltr">-- <br></div><div class="m_3526508001029765117gmail_signature" data-smartmail="gmail_signature"><div dir="ltr">Jonathan Chen<div><br></div></div></div>'+
'</font></span></div><br></div>';


        PDEHelper.EasiEmailData e = new PDEHelper.EasiEmailData(body);
        System.AssertEquals('GS-P-02-15-DT-7023 Mod PC06', e.ModString);
        System.AssertEquals('PC06', e.ModNumber);
        System.AssertEquals('GS-P-02-13-DT-0024', e.Title);
        System.AssertEquals('Shari Gouveia', e.Owner);
        System.AssertEquals(0, e.TotalAmount);
        System.AssertEquals(0, e.ObligatedValues);
        System.AssertEquals(0, e.OptionValues);
        System.AssertEquals('CBRE, INC', e.VendorName);
        System.AssertEquals('SF30', e.ModForm);
        System.AssertEquals(date.parse('04/22/2013'), e.PopStartDate);
        System.AssertEquals(date.parse('11/03/2017'), e.PopEndDate);                                 
    
    Messaging.InboundEmail email;
    email = new Messaging.InboundEmail();
    
    Messaging.InboundEmail.BinaryAttachment a = new Messaging.InboundEmail.BinaryAttachment ();

    a.filename = 'test';
    a.body = Blob.valueof('test');
    a.mimeTypeSubType  = 'test/test';
    
    email.binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[1];
    email.binaryAttachments[0] = a;
    email.htmlBody = body;
    email.fromAddress = [SELECT email FROM User WHERE (not email like '%=%') and Profile.UserLicense.LicenseDefinitionKey in ('AUL', 'SFDC') and isActive = true LIMIT 1].email;
    
    Messaging.InboundEmailResult TestResult;
    testResult = PDEHelper.handleInboundEmail(email, NULL);
    //System.AssertNotNull(TestResult);
        PDE_EmailHandler handler = new PDE_EmailHandler();
        Messaging.InboundEmailResult emailresult = handler.handleInboundEmail(email, null);
        
        System.assert(emailresult != null);
    }
    
    static testMethod void testRegionParser(){
        System.assertEquals('5', PDEHelper.RegionParser('GS-05-P-16-SL-D-7000'));
        System.assertEquals('3', PDEHelper.RegionParser('GS-P-03-15-CY-7009'));
        System.assertEquals('4', PDEHelper.RegionParser('GS-P-04-15-CY-7009 Mod PO10'));
        System.assertEquals('3', PDEHelper.RegionParser('47PD0818C0001'));


    }

    
}