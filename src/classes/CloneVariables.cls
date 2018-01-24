global without sharing class CloneVariables {
    
/* 
 *  global static Map<String, String> mapApexMessages() {
        List<ApexMessage__c> msgs = ApexMessage__c.getAll().values();
        Map<String, String> options = new Map<String, String>();
        for (ApexMessage__c msg : msgs) {
            options.put(msg.Name, msg.ApexMessage__c);
        }
        return options;
    } */
    
    global static Map<String, Set<String>> mapChildRelationships() {
       List<Loan_Mod_Clone_Object__mdt>  childParentList = [SELECT Child_relationship__c ,Parent__c FROM Loan_Mod_Clone_Object__mdt];
        Map<String, Set<String>> mapOf = new Map<String, Set<String>>();
       for (Loan_Mod_Clone_Object__mdt relation : childParentList) {
            if (!mapOf.containsKey(relation.Parent__c)) {
                mapOf.put(relation.Parent__c, new Set<String>());
            }
            mapOf.get(relation.Parent__c).add(relation.Child_Relationship__c);
        }
        return mapOf;
    }
    
    global static Map<String, Set<String>> mapFieldExclusions() {
        //List<FieldExclusion__c> excls = FieldExclusion__c.getAll().values();
        Map<String, Set<String>> mapOf = new Map<String, Set<String>>();
       /* for (FieldExclusion__c excl : excls) {
            if (!mapOf.containsKey(excl.sObjectType__c)) {
                mapOf.put(excl.sObjectType__c, new Set<String>());
            }
            mapOf.get(excl.sObjectType__c).add(excl.FieldExclusion__c.toLowerCase());
        }*/
        return mapOf;
    }
    
    global static Map<String, Map<String, String>> mapFieldDefaults() {
       // List<FieldDefault__c> defs = FieldDefault__c.getAll().values();
        Map<String, Map<String, String>> mapOf = new Map<String, Map<String, String>>();
        
        //mapof.put('Application__c', new Map<String,String>{'external_id__c'=>'10000'});
        //mapof.put('Property__c',new Map<String,String>{'external_id__c'=>'10000'});
       /* for (FieldDefault__c def : defs) {
            if (!mapOf.containsKey(def.sObjectType__c)) {
                mapOf.put(def.sObjectType__c, new Map<String, String>());
            }
            mapOf.get(def.sObjectType__c).put(def.FieldDefault__c.toLowerCase(), def.FieldValue__c);
        }*/
        return mapOf;
    }
    
    //** Maps, held privately so as to only pull once per call
   // private static final Map<String, String> mapApexMessages = UtilsCustomSetting.mapApexMessages();
    private static final Map<String, Set<String>> mapChildRelationships = mapChildRelationships();
    private static final Map<String, Set<String>> mapFieldExclusions = mapFieldExclusions();
    private static final Map<String, Map<String, String>> mapFieldDefaults = mapFieldDefaults();
    
    //** Returns a message for use in APEX error handling, chatter posting, etc
 //   global static String getApexMessage(String msgName) {
 //       return mapApexMessages.get(msgName);
 //   }
    
    //** Returns a set of child relationships to include in the cloning query
    global static Set<String> getChildRelationships(String relName) {
        Set<String> setOf = new Set<String>();
        if (mapChildRelationships.containsKey(relName)) {
            setOf.addAll(mapChildRelationships.get(relName));
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static Set<String> getFieldExclusions(String esclName) {
        Set<String> setOf = new Set<String>();
        if (mapFieldExclusions.containsKey(esclName)) {
            setOf.addAll(mapFieldExclusions.get(esclName));
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static Set<String> getFieldDefaults(String defName) {
        Set<String> setOf = new Set<String>();
        if (mapFieldDefaults.containsKey(defName)) {
            setOf.addAll(mapFieldDefaults.get(defName).keySet());
        }
        return setOf;
    }
    
    //** Returns a set of fields to exclude from the cloning query
    global static String getFieldDefault(String defName, String defValue) {
        if (mapFieldDefaults.containsKey(defName)) {
            if (mapFieldDefaults.get(defName).containsKey(defValue)) {
                return mapFieldDefaults.get(defName).get(defValue);
            }
        }
        return null;
    }
    
}