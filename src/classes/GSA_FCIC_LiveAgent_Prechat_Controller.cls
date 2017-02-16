public class GSA_FCIC_LiveAgent_Prechat_Controller {

    public static String businessGovRecordTypeId {get; set;}
    public static String gobiernoGovRecordTypeId {get; set;}
    public static String usaGovRecordTypeId {get; set;}
    public static String exImGovRecordTypeId {get; set;}

    RecordTypeRefs__c busaRecType = RecordTypeRefs__c.getValues('BusinessUSA.gov');
    String busaRecId = busaRecType.Id__c;

    RecordTypeRefs__c gobiernoRecType = RecordTypeRefs__c.getValues('GobiernoUSA.gov');
    String gobiernoRecId = gobiernoRecType.Id__c;

    RecordTypeRefs__c usaRecType = RecordTypeRefs__c.getValues('USA.gov');
    String usaRecId = usaRecType.Id__c;

    RecordTypeRefs__c exImRecType = RecordTypeRefs__c.getValues('ExIm.gov');
    String exImRecId = exImRecType.Id__c;

    // I was getting an authorization error when trying to query these record ids on page load - will come back
    public GSA_FCIC_LiveAgent_Prechat_Controller(){
        businessGovRecordTypeId = busaRecId;
        gobiernoGovRecordTypeId = gobiernoRecId;
        usaGovRecordTypeId = usaRecId;
        exImGovRecordTypeId = exImRecId;
    }

}