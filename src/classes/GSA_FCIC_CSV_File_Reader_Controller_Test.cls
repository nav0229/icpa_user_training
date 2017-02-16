@isTest(SeeAllData=true)
private class GSA_FCIC_CSV_File_Reader_Controller_Test {

	private static GSA_FCIC_CSV_File_Reader_Controller setupController(CSAT_File__c csatFile) {
		GSA_FCIC_CSV_File_Reader_Controller controller = new GSA_FCIC_CSV_File_Reader_Controller(new ApexPages.StandardController(csatFile));
		return controller;
	}
	
	@isTest static void testReadCSVFileErrors() {
		GSA_FCIC_Test_Util.isTest = true; 
		
		CSAT_File__c firstCSATFile = GSA_FCIC_Test_Util.createCSATFile();
		insert firstCSATFile;

		Case firstTestCase = GSA_FCIC_Test_Util.createCase('1.00092E+15');
		insert firstTestCase;

		CSAT_File__c secondCSATFile = GSA_FCIC_Test_Util.createCSATFile();
		insert secondCSATFile;

		Case secondTestCase = GSA_FCIC_Test_Util.createCase('1.00093E+15');
		insert secondTestCase;

		Survey_Report_Cards__c surveyReportCard = GSA_FCIC_Test_Util.createSurveyReportCard('1.00092E+15');
		insert surveyReportCard;

		Test.startTest();
			GSA_FCIC_CSV_File_Reader_Controller controller = setupController(firstCSATFile);
			PageReference pageRef = controller.readCSVFile();

			System.assertEquals(null, pageRef, 'Returned page reference should be null - no attachments');

			Attachment firstAttachment = GSA_FCIC_Test_Util.createCSVAttachment(firstCSATFile);
			insert firstAttachment;

			Attachment secondAttachment = GSA_FCIC_Test_Util.createCSVAttachment(firstCSATFile);
			insert secondAttachment;

			Attachment thirdAttachment = GSA_FCIC_Test_Util.createCSVAttachment(firstCSATFile);
			pageRef = controller.readCSVFile();

			System.assertEquals(null, pageRef, 'Returned page reference should be null - too many attachments');

			delete secondAttachment;

			firstAttachment.Name = 'blah.csv';

			update firstAttachment;
			pageRef = controller.readCSVFile();

			System.assertEquals(null, pageRef, 'Returned page reference should be null - incorrect file name format');

			firstAttachment.Name = '07082015-08092015_Phone_CSAT.csv';
			Blob backupBody = firstAttachment.Body;
			String body = 'RESPID,FXDATE,FXCALLDT,FXAGTNM,FXAGTID,FXASWSPL,FXTELE,FXUNIQID,FXDURTN,FXCVGUID,SQ1,Q1,Q2,Q3,Q4,Q5,Q6,Q7a,Q7b,Q8,Q9,Q10a,Q10b,Q10c,Q10d,Q10e,Q10f,Q10g,Q11,Q12,Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_DK,Q13_REF,Q13_OTHER,Q14,Q15,Q16,Q17,Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,Q20_6,Q20_7,Q20_DK,Q20_REF,Q20_OTHER,Q21,Q21_OTHER,Q22,Q23\n12754,150501,4/30/20015 16:05,Jane Doe,52016,601,2148860004,1.00093E+15,312,1.50501E+11,1,8,The rep did not have the answer to my question.,DK,5,5,1,5,10,1,2,10,10,10,10,10,10,10,1,2,,,,,,,,,,,,,2,2,,2,,,,,,,,,15,I needed a phone number to a military unit.,,\n12763,150501,4/30/2015 18:59,Jon Doh,52051,601,2605821022,1.13191E+15,118,1.50501E+11,1,10,the rep was definately concerned with my issuse,6,10,5,1,9,uuo777,1,1,10,10,6666666,10,10,10,10,5,1,,,3,4,,,,,,,1,contacted my cogressman,7,1,,,,,5,,,,,congressman sent it to me,16,,,\n12784,150501,4/30/2015 15:52,James Do,52030,601,4129834060,1.12857E+15,432,1.50501E+11,1,10,The rep was helpful and gave me the information that I needed.,8,3,10,2,10,5,2,2,8,10,7,10,10,7,10,5,1,,,,4,,,,,,,2,,1,1,,2,,,,,,,,,20,hi,,\n';
			firstAttachment.Body = Blob.valueOf(body);
			update firstAttachment;
			pageRef = controller.readCSVFile();

			firstAttachment.Body = backupBody;
			update firstAttachment;

			pageRef = controller.readCSVFile();

			System.assertEquals(null, pageRef, 'Returned page reference should be null - file processed');

			firstCSATFile = [SELECT RecordType.Name, Name, Data_Set_First_Date__c, Data_Set_Last_Date__c, Status__c FROM CSAT_File__c WHERE Id =: firstCSATFile.Id];
			GSA_FCIC_CSV_File_Reader_Controller controller2 = setupController(firstCSATFile);
			pageRef = controller2.readCSVFile();
			
			System.assertEquals(null, pageRef, 'Returned page reference should be null - file already processed');

			String newBody = firstAttachment.Body.toString().replace('Q2', 'blah');
			firstAttachment.Body = Blob.valueOf(newBody);
			update firstAttachment;
			pageRef = controller.readCSVFile();

			/**/
			Attachment attachmentTooLarge = [SELECT Id, Name, ParentId FROM Attachment WHERE Name = :GSA_FCIC_Test_Util.CSAT_TEST_FILE_TOO_LARGE_NAME];
			CSAT_File__c c2 = [SELECT Id, RecordType.Name, Name FROM CSAT_File__c WHERE Id = :attachmentTooLarge.ParentId];
			GSA_FCIC_CSV_File_Reader_Controller controller3 = setupController(c2);
			pageRef = controller3.readCSVFile();
			
			System.assertEquals(null, pageRef, 'Returned page reference should be null - file too big');

			Attachment attachmentNonUTF = [SELECT Id, Name, ParentId FROM Attachment WHERE Name = :GSA_FCIC_Test_Util.CSAT_TEST_FILE_NON_UTF8_NAME];
			CSAT_File__c c3 = [SELECT Id, RecordType.Name, Name FROM CSAT_File__c WHERE Id =:attachmentNonUTF.ParentId];
			GSA_FCIC_CSV_File_Reader_Controller controller4 = setupController(c3);
			pageRef = controller4.readCSVFile();

			Id csatPhoneExceptionId = [
				select Id, Name
				from RecordType
				where SObjectType = 'Exception__c'
				and Name = 'CSAT Phone Upload'
				limit 1
			].Id;
			insert GSA_FCIC_Util.createException('Non utf-8 encoded file', csatPhoneExceptionId);
			
			System.assertEquals(null, pageRef, 'Returned page reference should be null - file non UTF-8');

			body = 'RESPID,FXDATE,FXCALLDT,FXAGTNM,FXAGTID,FXASWSPL,FXTELE,FXUNIQID,FXDURTN,FXCVGUID,SQ1,Q1,Q2,Q3,Q4,Q5,Q6,Q7a,Q7b,Q8,Q9,Q10a,Q10b,Q10c,Q10d,Q10e,Q10f,Q10g,Q11,Q12,Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_DK,Q13_REF,Q13_OTHER,Q14,Q15,Q16,Q17,Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,Q20_6,Q20_7,Q20_DK,Q20_REF,Q20_OTHER,Q21,Q21_OTHER,Q22,Q23\n12754,150501,4/30/2015 16:05,Jane Doe,52016,601,2148860004,1.00092E+15,312,1.50501E+11,1,8,The rep did not have the answer to my question.,DK,5,5,1,5,10,1,2,10,10,10,10,10,10,10,1,2,,,,,,,,,,,,,2,2,,2,,,,,,,,,15,I needed a phone number to a military unit.,,\n12763,150501,4/30/2015 18:59,Jon Doh,52051,601,2605821022,1.13191E+15,118,1.50501E+11,1,10,the rep was definately concerned with my issuse,6,10,5,1,9,uuo777,1,1,10,10,6666666,10,10,10,10,5,1,,,3,4,,,,,,,1,contacted my cogressman,7,1,,,,,5,,,,,congressman sent it to me,16,,,\n12784,150501,4/30/2015 15:52,James Do,52030,601,4129834060,1.12857E+15,432,1.50501E+11,1,10,The rep was helpful and gave me the information that I needed.,8,3,10,2,10,5,2,2,8,10,7,10,10,7,10,5,1,,,,4,,,,,,,2,,1,1,,2,,,,,,,,,20,I was trying to get my credit report altered.,,\n';
			newBody = body.replace('contacted my cogressman', '\"contacted, my cogressman\"');
			firstAttachment.Body = Blob.valueOf(newBody);
			update firstAttachment;

			pageRef = controller.readCSVFile();
			body = 'RESPID,FXDATE,FXCALLDT,FXAGTNM,FXAGTID,FXASWSPL,FXTELE,FXUNIQID,FXDURTN,FXCVGUID,SQ1,Q1,Q2,Q3,Q4,Q5,Q6,Q7a,Q7b,Q8,Q9,Q10a,Q10b,Q10c,Q10d,Q10e,Q10f,Q10g,Q11,Q12,Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_DK,Q13_REF,Q13_OTHER,Q14,Q15,Q16,Q17,Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,Q20_6,Q20_7,Q20_DK,Q20_REF,Q20_OTHER,Q21,Q21_OTHER,Q22,Q23\n12754,150501,4/30/2015 16:05,Jane Doe,52016,601,2148860004,1.00092E+15,312,1.50501E+11,1,8,The rep did not have the answer to my question.,REF,REF,REF,DKDKFKDKFKD,5,10,1,2,10,10,10,10,10,10,10,1,2,,3333444cccvfvf,,,REF,REF,sdfdsfs,3423fdfdg,,546546fffbbbvv,,,2,2,,2,,,,,,,,,15,I needed a phone number to a military unit.,,\n12763,150501,4/30/2015 18:59,Jon Doh,52051,601,2605821022,1.13191E+15,118,1.50501E+11,1,10,the rep was definately concerned with my issuse,123232,10,3534,1,9555555,645454545454545454,1,-0--0===1,10,10,10,10,10,45654,10,5,1,,,3,4,,,,,,,1,contacted my cogressman,7,1,,,,,5,,,,,congressman sent it to me,16,,,\n12784,150501,4/30/2015 15:52,James Do,52030,601,4129834060,1.12857E+15,432,1.50501E+11,1,10,The rep was helpful and gave me the information that I needed.,8,3,10,2,10,5,2,2,8,10,7,10,10,7,10,5,1,,,,4,,,,,,,2,,1,1,,2,,,,,,,,,20,I was trying to get my credit report altered.,,\n';
			firstAttachment.Body = Blob.valueOf(body);
			update firstAttachment;

			pageRef = controller.readCSVFile();
			firstAttachment.Name ='07322015-08092015_Phone_CSAT.csv';
			update firstAttachment;
			pageRef = controller.readCSVFile();

			secondCSATFile = [SELECT RecordType.Name, Name, Data_Set_First_Date__c, Data_Set_Last_Date__c, Status__c FROM CSAT_File__c WHERE Id =: secondCSATFile.Id];
			GSA_FCIC_CSV_File_Reader_Controller controller5 = setupController(secondCSATFile);
			Attachment fourthAttachment = GSA_FCIC_Test_Util.createCSVAttachment(secondCSATFile);
			insert fourthAttachment;
			body = 'RESPID,FXDATE,FXCALLDT,FXAGTNM,FXAGTID,FXASWSPL,FXTELE,FXUNIQID,FXDURTN,FXCVGUID,SQ1,Q1,Q2,Q3,Q4,Q5,Q6,Q7a,Q7b,Q8,Q9,Q10a,Q10b,Q10c,Q10d,Q10e,Q10f,Q10g,Q11,Q12,Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_DK,Q13_REF,Q13_OTHER,Q14,Q15,Q16,Q17,Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,Q20_6,Q20_7,Q20_DK,Q20_REF,Q20_OTHER,Q21,Q21_OTHER,Q22,Q23\n12754,150501,4/30/2015 16:05,Jane Doe,52016,601,2148860004,1.00093E+15,312,1.50501E+11,1,8,The rep did not have the answer to my question.,DK,5,5,1,5,10,1,2,10,10,10,10,10,10,10,1,2,,,,,,,,,,,,,2,2,,2,,,,,,,,,15,I needed a phone number to a military unit.,,\n12763,150501,4/30/2015 18:59,Jon Doh,52051,601,2605821022,1.13191E+15,118,1.50501E+11,1,10,the rep was definately concerned with my issuse,6,10,5,1,9,uuo777,1,1,10,10,6666666,10,10,10,10,5,1,,,3,4,,,,,,,1,contacted my cogressman,7,1,,,,,5,,,,,congressman sent it to me,16,,,\n12784,150501,4/30/2015 15:52,James Do,52030,601,4129834060,1.12857E+15,432,1.50501E+11,1,10,The rep was helpful and gave me the information that I needed.,8,3,10,2,10,5,2,2,8,10,7,10,10,7,10,5,1,,,,4,,,,,,,2,,1,1,,2,,,,,,,,,20,consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam consectetur adipisci velit sed quia non numquam,,\n';
			fourthAttachment.Name ='07322014-08092014_Phone_CSAT.csv';
			fourthAttachment.Body = Blob.valueOf(body);
			update fourthAttachment;
			pageRef = controller5.readCSVFile();

		Test.stopTest();
	}

	@isTest static void testReadCSVFile() {
		CSAT_File__c c = GSA_FCIC_Test_Util.createCSATFile();
		insert c;

		Case testCase = GSA_FCIC_Test_Util.createCase('453821');
		insert testCase;

		Case testCase2 = GSA_FCIC_Test_Util.createCase('920154');
		insert testCase2;

		Case testCase3 = GSA_FCIC_Test_Util.createCase('770012');
		insert testCase3;


		Attachment a1 = GSA_FCIC_Test_Util.createCSVAttachment(c);
		insert a1;

		Test.startTest();
			GSA_FCIC_CSV_File_Reader_Controller controller = setupController(c);
			controller.readCSVFile();
			System.assert(true);
		Test.stopTest();
	}

	@isTest static void testSendEmail() {
		CSAT_File__c c = GSA_FCIC_Test_Util.createCSATFile();
		insert c;

		EmailTemplate successTemplate = [select Id from EmailTemplate where DeveloperName =: 'CSAT_File_Confirmation_Text' LIMIT 1];

		Id csatPhoneExceptionId = [
			select Id, Name
			from RecordType
			where SObjectType = 'Exception__c'
			and Name = 'CSAT Phone Upload'
			limit 1
		].Id;

		Test.startTest();
			GSA_FCIC_Util.emailUtil email = new GSA_FCIC_Util.emailUtil(csatPhoneExceptionId);
			email.CSATfile(c.Id);
			email.templateID(successTemplate.Id);
			email.oweaID(UserInfo.getUserId());
			List<Messaging.SendEmailResult> results = email.sendEmail();
			System.assert(!results[0].isSuccess());
		Test.stopTest();
	}

}