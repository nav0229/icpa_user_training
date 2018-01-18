/************************************************************************************************************************
 * Original source code from: http://christopheralunlewis.blogspot.com/2012/04/clone-plus-clone-salesforce-objects.html
 * Expanded by GSA IT
 ***********************************************************************************************************************/ 
public with sharing class ClonePlusController {

    //public Boolean isAtuo { get; set; }
    //public String fieldLabel {get; set;}
    //public String fieldApi{get; set;}
    public String fieldValue {get; set;}
    public String fieldName {get; set;}
    public String relatedLists { get; set; }
    public String autoNumber {get; set;}
    private Map <String, String> childRelatedFields = new Map <String, String> ();
    private Map <String, String> ApiLabelsMap = new Map <String, String> ();
    public List<relatedObjects> objectChildren  { get; set; }
    public String               objectTypeName  { get; set; }
    public String               objectName      { get; set; }
    private SObject headSObject, headClone;
   public String objectLabelName {get; set;} 
    
  public Map<String, String> getRelatedFields () {
            String fields = ApexPages.currentPage().getParameters().get('childRelatedFields');
            String objects = ApexPages.currentPage().getParameters().get('childobjecttypes');
            if(fields != null && childRelatedFields.isEmpty())  {
            String[] objTokens = objects.split(',');
            String[] fldTokens = fields.split(',');
            for(Integer i = 0; i < objTokens.size(); i++) {
                  childRelatedFields.put(objTokens.get(i), fldTokens.get(i));
                        
            } 
       }
      return childRelatedFields;
  }
  
  private String getObjectId() {
      return String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'));
  }
  
  // Initialisation method called when the clone plus page is loaded.
  // Use the id page parameter to find out what kind of 
  // object we are trying to clone.
  // Then load the object from the database.
  // Finally call the populateObjectChildren method to      
  public void initialiseObjectsForCloning()
  {

    // Here we generate a keyprefixmap using the global describe 
    // Then compare that to our object to determine type.  
    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
       
    Map<String,String> keyPrefixMap = new Map<String,String>{};
      
    for(String sObj : gd.keySet()){
      Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
      keyPrefixMap.put(r.getKeyPrefix(), r.getName());
    }
      
    String objectID = getObjectId();
    
    String objectTypeKey = objectId.subString(0,3);
      
    objectTypeName = keyPrefixMap.get(objectTypeKey);
     
    headSObject = Database.query('SELECT Id,Name FROM ' + String.escapeSingleQuotes(objectTypeName) + ' WHERE Id = :objectId'); 
        //objectName          = '' +'cloned_'+ headSObject.get('Name');
        
        objectName          = ''+ headSObject.get('Name');
        Schema.SObjectType t = Schema.getGlobalDescribe().get(objectTypeName);
        Schema.DescribeSObjectResult r = t.getDescribe();
        Schema.DescribeFieldResult f = r.fields.getMap().get('Name').getDescribe();
        system.debug('This is the data type for Name ' + f.isAutoNumber());
        if(f.isAutoNumber()) {
        autoNumber = 'true'; 
        system.debug('This is autonumber true ' + autoNumber);       
        } else {
        autoNumber = 'false';
                system.debug('This is autonumber false ' + autoNumber);       
        }
        populateObjectChildren();
       
        getApiLabels();
   }
   
  public Boolean isValid() {  
        Schema.SObjectType t = Schema.getGlobalDescribe().get(objectTypeName);
        Schema.DescribeSObjectResult r = t.getDescribe();
        Schema.DescribeFieldResult f = r.fields.getMap().get('Name').getDescribe();
        system.debug('This is the data type for Name ' + f.isAutoNumber());      
//     List<objectName> projectName = [Select Id, Name From objectName WHERE Name = :objectName LIMIT 1];
       system.debug('This is object name ' +objectName);
     
      if (objectName == '') {           
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please enter ' + f.getLabel());
           ApexPages.addMessage(myMsg);
          return false;
      }
      
     else {
      if(!f.isAutoNumber()) { 
          objectName = String.escapeSingleQuotes(objectName.trim());
           system.debug('This is object label ' + f.getLabel());           
          List<sObject> lstObj = Database.query('SELECT Id,Name FROM ' + String.escapeSingleQuotes(objectTypeName) + ' WHERE Name = :objectName LIMIT 1');      
      if (lstObj.size() > 0) {
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: ' + f.getLabel() + ' already exists in the system. Please enter a new ' + f.getLabel());
           ApexPages.addMessage(myMsg);
           return false;
      } 
      }
      }
      return true;
  }

     public void getApiLabels()
        {
            Schema.SObjectType t = Schema.getGlobalDescribe().get(objectTypeName);
        Schema.DescribeSObjectResult r = t.getDescribe();
        Schema.DescribeFieldResult f = r.fields.getMap().get('Name').getDescribe();
        objectLabelName = f.getLabel();
            String fields = ApexPages.currentPage().getParameters().get('childRelatedFields');
            String objects = ApexPages.currentPage().getParameters().get('childobjecttypes');
               if(fields != null)  {
            String[] objTokens = objects.split(',');
            String[] fldTokens = fields.split(',');
            for(Integer i = 0; i < objTokens.size(); i++) {
                    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
       
                     Map<String, Schema.SObjectField> fMap = gd.get(objTokens[i].toLowerCase()).getDescribe().Fields.getMap();
                        if (fMap != null){
           for (Schema.SObjectField ft : fMap.values()){ 
               Schema.DescribeFieldResult fd = ft.getDescribe();
               if(fields.contains(fd.getName())){
               ApiLabelsMap.put(fd.getName(),fd.getLabel());
               system.debug('Label Map: '+ApiLabelsMap);
               }
               }
            } 
       }  }
       }

  // Get all of the children of the current object that have a 
  // object type contained in the child object types page parameter.
  // Not restricting the child objects to particular types 
  // results in unclonable system objects being added to the options, 
  // which we need to avoid (You will not want to clone these!)
  // Making these object type choices also allows us 
  // focus our efforts on the specific kinds of objects 
  // we want to allow users to clone.  
  public void populateObjectChildren()
  {
       getApiLabels();
    objectChildren = new List<relatedObjects>{};   
    Set<String> childObjectTypes = new Set<String>{};
    
    // read the object types from the page parameter.    
    childObjectTypes.addAll( ApexPages.currentPage().getParameters().get('childobjecttypes').split(','));
   
    // Use the sobjecttype describe method to retrieve all 
    // child relationships for the object to be cloned.    
    Schema.DescribeSObjectResult headDescribe = headsObject.getSObjectType().getDescribe();
    
    List<Schema.ChildRelationship> childRelationships = headDescribe.getChildRelationships(); 
    
    getRelatedFields();
    String fieldApi = '';

    // Iterate through each relationship, 
    // and retrieve the related objects.       
    for (Schema.ChildRelationship childRelationship :childRelationships){
      Schema.SObjectType childObjectType = childRelationship.getChildSObject();
      
      // Only retrieve the objects if their type is 
      // included in the page argument.          
      if (childObjectTypes.contains( childObjectType.getDescribe().getName()))
      {
        List<relatedObjectRow> relatedObjects = new List<relatedObjectRow>{};
        
        Schema.SObjectField childObjectField = childRelationship.getField();

        String relatedChildSObjectsquery = 'SELECT ID, Name, ' +  String.escapeSingleQuotes(fieldApi) + ', CreatedDate FROM '+ String.escapeSingleQuotes(childObjectType.getDescribe().getName()) + ' WHERE '+ String.escapeSingleQuotes(childObjectField.getDescribe().getName()) + ' = \'' + String.escapeSingleQuotes(headsObject.Id) + '\''; 

        if(childRelatedFields.containsKey(childObjectType.getDescribe().getName()) ) {
            fieldApi = childRelatedFields.get(childObjectType.getDescribe().getName());

            if(fieldApi.trim().length() > 0) {
               relatedChildSObjectsquery = 'SELECT ID, Name, ' + String.escapeSingleQuotes(fieldApi) + ', CreatedDate FROM '+ String.escapeSingleQuotes(childObjectType.getDescribe().getName()) + ' WHERE '+ String.escapeSingleQuotes(childObjectField.getDescribe().getName()) + ' = \'' + String.escapeSingleQuotes(headsObject.Id) + '\''; 
            }
            
        } 
              
// String relatedChildSObjectsquery = 'SELECT ID, Name FROM ' + childObjectType.getDescribe().getName() + ' WHERE ' + childObjectField.getDescribe().getName() + ' = :headsObject.Id';                                                
        for (SObject childObject : 
             Database.query(relatedChildSObjectsquery))
        {
          String fieldLabel = GSAUtility.getFieldValueFromObject(childObject, fieldApi);  
          relatedObjects.add(new relatedObjectRow(childObject, fieldApi, fieldLabel));
        
        }
        if (!relatedObjects.isEmpty())
        {
         //objectChildren.add(new relatedObjects(relatedObjects,childObjectType.getDescribe().getLabelPlural(),childObjectField.getDescribe().getName(), fieldApi));
         system.debug(' fieldApi: ' + fieldApi);
         
             objectChildren.add(new relatedObjects(relatedObjects,childObjectType.getDescribe().getLabelPlural(),childObjectField.getDescribe().getName(), ApiLabelsMap.get(fieldApi)));
             system.debug('get fieldApi:'+ApiLabelsMap.get(fieldApi));
          //objectChildren.add(new relatedObjects(relatedObjects,childObjectType.getDescribe().getLabelPlural(),childObjectField.getDescribe().getLabel(), fieldApi));
        } 
      }
    }
   }  
 
   // Perform the cloning process.
  // First clone the parent, then all of the child objects. 
  // Then redirect the user to the new object page.
  public PageReference doClone()
  {
        if(isValid()) {
        headClone = cloneObjects(new List<sObject>{headSObject}).get(0);
       // headClone.put('Name',objectName);
        Schema.SObjectType t = Schema.getGlobalDescribe().get(objectTypeName);
        Schema.DescribeSObjectResult r = t.getDescribe();
        Schema.DescribeFieldResult f = r.fields.getMap().get('Name').getDescribe();
        objectLabelName = f.getLabel();
        system.debug('This is the data type for Name ' + f.isAutoNumber());
        if(f.isAutoNumber()) {
        autoNumber = 'true'; 
        system.debug('This is autonumber true ' + autoNumber);       
        } else {
        autoNumber = 'false';
        headClone.put('Name',objectName);
                    
        }
        headClone.put('OwnerId', userinfo.getuserid());    
        insert headClone;
    
        cloneSelectedObjects();
    
        return new PageReference('/' + headClone.Id);
    }
    return null;
  }
  
    //cancel
  public PageReference goBack()
  {
    headClone = cloneObjects(new List<sObject>{headSObject}).get(0);
    return new PageReference('/' + headSobject.Id);
  }
  
  // Clone the selected child objects.
  // Associate the cloned objects with the new cloned parent object.
  public void cloneSelectedObjects()
  {
        
    List<sObject> clonedObjects = new List<sObject>{};
    List<sObject> selectedRelatedObjects;
     
    for (relatedObjects relatedObject : objectChildren)
    {
      selectedRelatedObjects = new List<sObject>{};  
      clonedObjects = new List<sObject>{};  
      
      for (relatedObjectRow row : relatedObject.objectRows) 
      {
        if (row.selected)
        {
          selectedRelatedObjects.add(row.obj);
        }
      }
      
      if (!selectedRelatedObjects.isEmpty())
      {
        clonedObjects = cloneObjects(selectedRelatedObjects);
        
        for (sObject clone : clonedObjects)
        {
          clone.put(relatedObject.relatedFieldName, headClone.Id);  
        }
        
          try {
            insert clonedObjects;
          }
          catch(Exception e) {
            System.debug('ERROR:' + e);
          }

      }
    }
  }

  // Clone a list of objects to a particular object type
  // Parameters 
  // - List<sObject> sObjects - the list of objects to be cloned 
  // The sObjects you pass in must include the ID field, 
  // and the object must exist already in the database, 
  // otherwise the method will not work.
  public static List<sObject> cloneObjects(List<sObject> sObjects){
                                                
    Schema.SObjectType objectType = sObjects.get(0).getSObjectType();
    
    // A list of IDs representing the objects to clone
    List<Id> sObjectIds = new List<Id>{};
    // A list of fields for the sObject being cloned
    List<String> sObjectFields = new List<String>{};
    // A list of new cloned sObjects
    List<sObject> clonedSObjects = new List<sObject>{};
    
    // Get all the fields from the selected object type using 
    // the get describe method on the object type.
    if(objectType != null){
      sObjectFields.addAll(
        objectType.getDescribe().fields.getMap().keySet());
    }
    
    // If there are no objects sent into the method, 
    // then return an empty list
    if (sObjects != null || 
        sObjects.isEmpty() || 
        sObjectFields.isEmpty()){
    
      // Strip down the objects to just a list of Ids.
      for (sObject objectInstance: sObjects){
        sObjectIds.add(objectInstance.Id);
      }

      /* Using the list of sObject IDs and the object type, 
         we can construct a string based SOQL query 
         to retrieve the field values of all the objects.*/
    
      String allSObjectFieldsQuery = 'SELECT ' + sObjectFields.get(0); 
    
      for (Integer i=1 ; i < sObjectFields.size() ; i++){
        allSObjectFieldsQuery += ', ' + sObjectFields.get(i);
      }
    
      allSObjectFieldsQuery += ' FROM ' + objectType.getDescribe().getName() +' WHERE ID IN (\'' + sObjectIds.get(0) + '\'';

      for (Integer i=1 ; i < sObjectIds.size() ; i++){
        allSObjectFieldsQuery += ', \'' + sObjectIds.get(i) + '\'';
      }
    
      allSObjectFieldsQuery += ')';
    
      system.debug('allSObjectFieldsQuery: ' + allSObjectFieldsQuery);
    
      try{
      
        // Execute the query. For every result returned, 
        // use the clone method on the generic sObject 
        // and add to the collection of cloned objects
        for (SObject sObjectFromDatabase:
             Database.query(allSObjectFieldsQuery)){
             clonedSObjects.add(sObjectFromDatabase.clone(false,true));  
        }
    
      } catch (exception e){}
      
    }
   
    return clonedSObjects;
    
  }
  
  
  // Related objects data construct - 
  // used to store a collection of child objects connected to 
  // the head object through the same relationship field.
  public class relatedObjects
  {
    public List<relatedObjectRow> objectRows { get; set; }
    public String                 pluralLabel      { get; set; }
    public String                 relatedFieldName { get; set; }
    public String                 customFieldName { get; set; }
    
    public relatedObjects(List<relatedObjectRow> objectRows,String pluralLabel,String relatedFieldName, String customFieldName ) 
    {
      this.objectRows       = objectRows;
      this.pluralLabel      = pluralLabel;
      this.relatedFieldName = relatedFieldName;
      this.customFieldName = customFieldName;
      
    }   
  }     

  // An indidual child object row. 
  // Each instance simply contains the object definition, 
  // and a checkbox to select the row for cloning 
  // on the clone plus page.
  public class relatedObjectRow
  {
   
    public sObject obj      { get; set; }
    public Boolean selected { get; set; }
    public String fieldLabel {get; set;}
   
    public String fieldName{get; set;} 
    public relatedObjectRow(Sobject obj,String fieldApi, String fieldLabel)
              
    {
      this.obj      = obj;
      // All object rows are selected by default.
      this.selected     = true;
      
      this.fieldLabel = fieldLabel;     
     
    }
    
    public String getName(){
      try{
        return '' + obj.get('Name');
      } catch (Exception e){ return '';}    
    }
    public String getCreatedDate(){
      try{
        return '' + obj.get('createddate');
      } catch (Exception e){ return ''; }    
    }
    
    public String getfieldLabel(){
        return fieldLabel;
    }  
 
  }
}