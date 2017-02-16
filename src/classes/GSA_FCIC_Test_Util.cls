public with sharing class GSA_FCIC_Test_Util {
	public static final String CSAT_TEST_FILE_TOO_LARGE_NAME = 'TEST_TOO_LARGE.csv';
	public static final String CSAT_TEST_FILE_NON_UTF8_NAME = 'TEST_NON_UTF.csv';

	public static boolean isTest = false;

	public static CSAT_File__c  createCSATFile() {
		CSAT_File__c csatFile = new CSAT_File__c();
		csatFile.Status__c = 'New';
		return csatFile;
	}

	public static Attachment createCSVAttachment(CSAT_File__c c) {
		Attachment a = new Attachment();

		String body = 'RESPID,FXDATE,FXCALLDT,FXAGTNM,FXAGTID,FXASWSPL,FXTELE,FXUNIQID,FXDURTN,FXCVGUID,SQ1,Q1,Q2,Q3,Q4,Q5,Q6,Q7a,Q7b,Q8,Q9,Q10a,Q10b,Q10c,Q10d,Q10e,Q10f,Q10g,Q11,Q12,Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_DK,Q13_REF,Q13_OTHER,Q14,Q15,Q16,Q17,Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,Q20_6,Q20_7,Q20_DK,Q20_REF,Q20_OTHER,Q21,Q21_OTHER,Q22,Q23\n12754,150501,4/30/2015 16:05,Jane Doe,52016,601,2148860004,453821,312,1.50501E+11,1,8,The rep did not have the answer to my question.,DK,5,5,1,5,10,1,2,10,10,10,10,10,10,10,1,2,,,,,,,,,,,,,2,2,,2,,,,,,,,,15,I needed a phone number to a military unit.,,\n12763,150501,4/30/2015 18:59,Jon Doh,52051,601,2605821022,920154,118,1.50501E+11,1,10,"the rep was definately, concerned with my issuse",6,10,5,1,9,6,1,1,10,10,10,10,10,10,10,5,1,,,3,4,,,,,,,1,contacted my cogressman,7,1,,,,,5,,,,,congressman sent it to me,16,,,\n12784,150501,4/30/2015 15:52,James Do,52030,601,4129834060,920154,432,1.50501E+11,1,10,The rep was helpful and gave me the information that I needed.,8,3,10,2,10,5,2,2,8,10,7,10,10,7,10,5,1,,,,4,,,,,,,2,,1,1,,2,,,,,,,,,20,I was trying to get my credit report altered.,,\n';
		a.Body = Blob.valueOf(body);
		a.Name = '07082015-08092015_Phone_CSAT.csv';
		a.ParentId = c.Id;
		return a;
	}

	public static Case createCase(String ucid) {
		Case c = new Case();
		c.Avaya_UCID__c = ucid;
		return c; 
	}

	public static Survey_Report_Cards__c createSurveyReportCard(String ucid) {
		Survey_Report_Cards__c src = new Survey_Report_Cards__c();
		src.Avaya_UCID__c = ucid;
		return src;
	}
}