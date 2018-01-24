/****************************************************************
 Name: MasterChecklistDataAccessor
============================================================
Author: 
Purpose: Data Accessor for Master_Checklist__c
============================================================

****************************************************************/

public with sharing class MasterChecklistDataAccessor implements MasterChecklistDAO {
    public static final String ASSIGN_INSURANCE_PROCEEDS_CODE = 'RE-AIP';
    public static final String FLOOD_INSURANCE_BY_LAW_CODE = 'MI-FLD';
    public static final String CBR_CODE = 'CBR';
    public static final String LOAN_HISTORY_CODE = 'LOAN-HIST';
    public static final String IRS_TRANSCRIPT_CODE = 'IRS-TRANS';
    public static final String FEMA_DOB_CODE = 'FEMA-DOB';
    public static final String FEMA_NFIRA_CODE = 'FEMA-NFIRA';
    public static final String LOSS_VERIFICATION_CODE = 'LV';
    public static final String FLOOD_MAPPING_CODE = 'FLD-MAP';
    public static final String INSURANCE_INFO_CODE = 'INSC-REQ';
    public static final String REPRESENTATIVE_NAME_CODE = 'REP-REQ';
    public static final String RESIDENT_CARD_REQUEST_CODE = 'RES-REQ';
    public static final String PAYSTUB_CODE = 'PAYSTUB';
    
    public static final String STANDARD_REAL_ESTATE_CODE = 'RE-STD';
    public static final String LC_CONDOMINIUM_REPAIRS = 'OC-CRP';

    public static final String TILA_CODE = 'TILA';
    public static final String HAPPY_LETTER_CODE = 'HAP-LET';
    public static final String PROMISSORY_NOTE_CODE = 'PROM-NOTE';
    public static final String APPROVAL_LETTER = 'APR-LET';

    public static final String POLICY_TYPE_CODE = 'PLCYTYPE';
    public static final String POLICY_NUMBER_CODE = 'PLCYNUM';
    public static final String POLICY_HOLDER_CODE = 'HLDRNAME';
    public static final String CONDOMINIUM_REPAIRS_CI_CODE = 'OC-CRP-CI';
    public static final String OC_SHD_LOAN_CONDITION_CODE = 'OC-SHD';
    public static final String OC_SHD_CHECKLIST_ITEM_CODE = 'OC-SHD-CI';
    public static final String SHARED_REPAIR_RESPONSIBILITY = 'SRR';
    public static final String SRR_CHECKLIST_ELEMENT_CODE = 'SRR-CIE';
    public static final String RA_ACM_CODE = 'RA-ACM';
    public static final String RA_ACM_CHECKLIST_ITEM_CODE = 'RA-ACM-CI';
    public static final String RA_LAW_CODE = 'RA-LAW';
    public static final String RA_LAW_CHECKLIST_ITEM_CODE = 'RA-LAW-CI';
    public static final String LP_EXT_CODE = 'LP-EXT';
    public static final String LP_EXT_CHECKLIST_ITEM_CODE = 'LP-EXT-CI';
    public static final String LP_FLA_CODE = 'LP-FLA';
    public static final String LP_FLA_CHECKLIST_ITEM_CODE = 'LP-FLA-CI';

    public static final String DEFENDANT_TITLE_CODE = 'DEFTTL';
    public static final String DEFENDANT_TITLE_CIE_CODE = 'DEFTTL-CIE';
    public static final String ASSIGNMENT_DATE_CODE = 'ASSNDAT';
    public static final String ATTORNEY_TO_SIGN_CODE = 'SBA-ATS';
    public static final String CASE_NUMBER_CODE = 'CASENUM';
    public static final String CASE_NUMBER_CIE_CODE = 'CASENUM-CIE';
    public static final String DEFENDANT_NAME_CODE = 'DEFNAME';
    public static final String DEFENDANT_NAME_CIE_CODE = 'DEFNAME-CIE';
    public static final String COURT_NAME_CODE = 'CRTNAME';
    public static final String COURT_NAME_CIE_CODE = 'CRTNAME-CIE';
    public static final String NAME_FL_CODE = 'NAME';
    public static final String TITLE_POSITION_CODE = 'TTL-POS';
    public static final String DOLLAR_AMOUNT_CODE = 'DOLAMT';
    public static final String PERCENT_COLA_CODE = 'PERCOLA';
    public static final String LEASE_LENGTH_CODE = 'LSLEN';
    public static final String MONTHLY_AMOUNT_CODE = 'LSAMT';
    public static final String STREET_ADDRESS = 'ADRONE';
    public static final String CITY_CODE = 'CITY';
    public static final String STATE_CODE = 'STATE';
    public static final String ZIP_CODE_CODE = 'ZIP';
    public static final String ADDRESS_TWO_CODE = 'ADRTWO';
    public static final String PROPERTY_NUMBER_CODE = 'PROPNUM';
    public static final String PROPERTY_NUMBER_CIE_CODE = 'PROPNUM-CIE';
    public static final String MAX_MONTHLY_PMT_CODE = 'MAXPMT';
    public static final String NUM_YEARS_CODE = 'NUMYR';

    public static final String REAL_ESTATE_CODE = 'REALESTATE-LCE';
    public static final String CONTENTS_CODE = 'CONTENTS-LCE';
    public static final String LOSS_PAYEE_CODE = 'LOSS-PAYEE-LCE';
    public static final String WINDSTORM_CODE = 'WINDSTORM-LCE';

    public static final String HAZARD_INSURANCE = 'MI-HAZ';
    public static final String PROOF_OF_HAZARD_INS = 'MI-HAZ-CI';
    public static final String RE_COVERAGE_CIE_CODE = 'RE-COVR-CIE';
    public static final String CONT_COVERAGE_CIE_CODE = 'CONT-COVR-CIE';
    public static final String LOSS_PAYEE_CIE_CODE = 'LOSS-PAYEE-CIE';
    public static final String WINDSTORM_CIE_CODE = 'WINDSTORM-CIE';
    public static final String SEWER_BACKUP_CIE_CODE = 'SEW-BACK-CIE';

    public static final String MI_CST_CODE = 'MI-CST';
    public static final String MI_TXT_CODE = 'MI-TXT';
    public static final String DC_CST_CODE = 'DC-CST';
    public static final String DC_TXT_CODE = 'DC-TXT';
    public static final String LP_CST_CODE = 'LP-CST';
    public static final String LP_TXT_CODE = 'LP-TXT';
    public static final String OC_TAG_CODE = 'OC-TAG';
    public static final String TRUST_NAME_CODE = 'TRST-NM';
    public static final String TAG_CI_CODE = 'TAG-CI';
    public static final String TRUST_NM_CIE_CODE ='TRST-NM-CIE';
    public static final String TRUST_DT_CIE_CODE ='TRST-DT-CIE';
    public static final String OWNR_DOC_DEED ='OC-ORE';
    public static final String OWNR_DOC_CI = 'OWNR-DOC';
    public static final String OWNR_DOC_VSL = 'OC-OVS';
    public static final String VESSLE_NAME ='VSL-NAME';
    public static final String OWNR_DOC_MANU_HOME ='OC-OMH';
    public static final String OWNR_DOC_CUSTOM = 'OC-OCT';
    public static final String CST_OTHER_COND = 'OC-CST';
    public static final String CST_OTHER_COND_TXT = 'OC-CST-TXT';
    public static final String CST_REMIT_ASIGN = 'RA-CST';
    public static final String CST_REMIT_ASIGN_TXT ='RA-CST-TXT';
    public static final String ASSN_LIFE_INSC = 'ASSN-L-INS';
    public static final String ASSN_DAMAGE_INSC = 'AP-DMGS';
    public static final String CARRIER_NAME = 'CRY-NM';
    public static final String INSURANCE_AMOUNT = 'INS-AMT';
    public static final String CST_RE_CONST_REP = 'RE-CST';
    public static final String CST_RE_CONST_REP_TXT ='RE-CST-TXT';
    public static final String POLICY_NUMBER_CIE = 'PLCYNUM-CIE';
    public static final String NAME_OF_INSURED = 'NAME-INSD';


    public static final Set<String> CHECKLIST_CODES = new Set<String>{
        STANDARD_REAL_ESTATE_CODE,
        ASSIGN_INSURANCE_PROCEEDS_CODE,
        FLOOD_INSURANCE_BY_LAW_CODE,
        CBR_CODE,
        LOAN_HISTORY_CODE,
        IRS_TRANSCRIPT_CODE,
        FEMA_DOB_CODE,
        FEMA_NFIRA_CODE,
        LOSS_VERIFICATION_CODE,
        FLOOD_MAPPING_CODE,
        INSURANCE_INFO_CODE,
        REPRESENTATIVE_NAME_CODE,
        RESIDENT_CARD_REQUEST_CODE,
        PAYSTUB_CODE,
        TILA_CODE,
        HAPPY_LETTER_CODE,
        PROMISSORY_NOTE_CODE,
        OC_SHD_LOAN_CONDITION_CODE,
        OC_SHD_CHECKLIST_ITEM_CODE,
        SRR_CHECKLIST_ELEMENT_CODE,
        LC_CONDOMINIUM_REPAIRS,
        CONDOMINIUM_REPAIRS_CI_CODE
    };

    public static final Set<String> DEFAULT_DOC_REQ_CODES = new Set<String>{
        IRS_TRANSCRIPT_CODE,
        LOAN_HISTORY_CODE,
        FLOOD_MAPPING_CODE,
        LOSS_VERIFICATION_CODE
    };

    public static final Set<String> DEFAULT_CLOSING_DOC_CODES = new Set<String>{
        TILA_CODE,
        HAPPY_LETTER_CODE,
        PROMISSORY_NOTE_CODE
    };
    
    public static final Set<String> DEFAULT_SYSTEM_GENERATED_CODES = new Set<String>{
    	APPROVAL_LETTER
    };

    private final String MASTER_CHECKLIST = 'Master_Checklist__c';

    private Set<String> masterChecklistFields;

    public MasterChecklistDataAccessor(){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        this.masterChecklistFields = schemaMap.get(MASTER_CHECKLIST).getDescribe().fields.getMap().keySet();
    }

    public List<Master_Checklist__c> getMasterChecklists() {
        QueryBuilder masterChecklistQueryBuilder = new QueryBuilder(MASTER_CHECKLIST);
        masterChecklistQueryBuilder.addSelectField(this.masterChecklistFields);
        return (List<Master_Checklist__c>)Database.query(masterChecklistQueryBuilder.generateQuery());
    }    

    public Map<Id, Master_Checklist__c> getMasterChecklistsMapById(List<Id> masterChecklistIds) {
        QueryBuilder masterChecklistQueryBuilder = new QueryBuilder(MASTER_CHECKLIST);
        masterChecklistQueryBuilder.addSelectField(this.masterChecklistFields);
        masterChecklistQueryBuilder.addWhereCondition('Id', masterChecklistIds, QueryBuilder.ComparisonOperator.IN_LIST);
        return new Map<Id,Master_Checklist__c>((List<Master_Checklist__c>)Database.query(masterChecklistQueryBuilder.generateQuery()));
    }

    public Master_Checklist__c getMasterChecklistByChecklistCode(String checklistCode) {
        QueryBuilder masterChecklistQueryBuilder = new QueryBuilder(MASTER_CHECKLIST);
        masterChecklistQueryBuilder.addSelectField(this.masterChecklistFields);
        masterChecklistQueryBuilder.addWhereCondition('Checklist_Code__c', checklistCode, QueryBuilder.ComparisonOperator.EQUALS);
        masterChecklistQueryBuilder.setLimit(1);
        return (Master_Checklist__c)Database.query(masterChecklistQueryBuilder.generateQuery());
    }

    public List<Master_Checklist__c> getMasterChecklistsByChecklistCodes(List<String> checklistCodes) {
        QueryBuilder masterChecklistQueryBuilder = new QueryBuilder(MASTER_CHECKLIST);
        masterChecklistQueryBuilder.addSelectField(this.masterChecklistFields);
        masterChecklistQueryBuilder.addWhereCondition('Checklist_Code__c', checklistCodes, QueryBuilder.ComparisonOperator.IN_LIST);
        return Database.query(masterChecklistQueryBuilder.generateQuery());
    }
}