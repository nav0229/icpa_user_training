global class ApexSOQL_LoanConditions implements Loop.IApexDataSource {
    
    // Loop.IApexDataSource interface requires four public methods with the following signatures:
    // Set<string> getGlobalDescribe()
    // Set<string> getChildRelationships(string objectName)
    // List<ExternalData.DataObject> describeObjects(List<string> objectNames)
    // Loop.ExternalData.QueryResultSet query(Loop.ExternalData.QueryRequestInfo requestInfo)
    
    // optional, but good practice: use variables to store object names to avoid mistakes from typos
    private string sampleSoqlObjectName = 'ApexSoql_LoanConditions';
    
    // query used for the 'ApexSoql' object
    //private string sampleSoqlQuery = 'SELECT Checklist_Item__c.Name FROM Checklist_Item__c WHERE Id = :Checklist_Item_Id';
    private string sampleSoqlQuery = 'SELECT Name,Loan_Condition_Code__c,Property__r.Property_Address__c,Property__r.City__c,Property__r.State__c,Property__r.Zip_Code__c,(SELECT Loan_Condition_Element__c.Element_Value__c, Loan_Condition_Element__c.Custom_Element_Value__c from Loan_Condition_Elements__r ) FROM Loan_Condition_Checklist__c WHERE Loan__c = :loanId';
    public Set<string> getGlobalDescribe() {
        // Return a set of object names that this Apex class will provide data for.
        // In this example, we will provide data from a single SOQL query.
        return new Set<string>{
            sampleSoqlObjectName
        };
    }
    
    public Set<string> getChildRelationships(string objectName) {
        // Return a set of object names corresponding to the children for the objectName specified
        // In this example, there are no child objects.
        return new Set<string>{};
    }
    
    public List<Loop.ExternalData.DataObject> describeObjects(List<string> objectNames) {
        // Describe each object in objectNames.
        // In this example, we will use a hard coded set of fields. This is recommended **only** for small sets of fields. For larger sets,
        // use Field Sets or a full object describe.
        
        // Declare the variable to be returned.
        List<Loop.ExternalData.DataObject> describeObjectResults = new List<Loop.ExternalData.DataObject>();
        
        // Loop through each object in objectNames and add to the result
        for (string objectName : objectNames) {
            // Declare variable to store field data for the object
            List<Loop.ExternalData.FieldInfo> fields = new List<Loop.ExternalData.FieldInfo>();
            
            if (objectName == sampleSoqlObjectName) {
                // Describe the fields for this object.
                fields.add(new Loop.ExternalData.FieldInfo('Name', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Loan_Condition_Code__c', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Property__r.Property_Address__c', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Property__r.City__c', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Property__r.State__c', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Property__r.Zip_Code__c', Schema.DisplayType.STRING));
                //fields.add(new Loop.ExternalData.FieldInfo('Loan_Condition_Elements__r', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_1', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_2', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_3', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_4', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_5', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_6', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_7', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_8', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_9', Schema.DisplayType.STRING));
                fields.add(new Loop.ExternalData.FieldInfo('Element_Value_10', Schema.DisplayType.STRING));
            }
            
            // Declare variable to add to results list using fields described above
            Loop.ExternalData.DataObject describeObjectResult = new Loop.ExternalData.DataObject(objectName, fields);
            
            // Add to results list
            describeObjectResults.add(describeObjectResult);
        }
        
        return describeObjectResults;
    }
    
    public Loop.ExternalData.QueryResultSet query(Loop.ExternalData.QueryRequestInfo requestInfo) {
        // Provide data for each object in requestInfo.GetObjectNames()
        system.debug(requestInfo);
        system.debug(requestInfo.RecordId);
            
        // Assume that the Document Package is run from the ChecklistItem
        Id Checklist_Item_Id = requestInfo.RecordId;
        
        Id loanId = [SELECT Loan__c FROM Checklist_Item__c where Id=:Checklist_Item_Id].Loan__c;
 
        // Declare the variable to be returned.
        Loop.ExternalData.QueryResultSet queryResultSet = new Loop.ExternalData.QueryResultSet();
        
        // Loop through all objects requested. The QueryResultSet instance returned needs to contain a QueryResult instance for each object requested.
        for (string objectName : requestInfo.GetObjectNames()) {
            // Declare fields list for QueryResult instance
            List<string> fields = new List<string>();
            
            // Declare query result to add to QueryResultSet instance
            Loop.ExternalData.QueryResult queryResult = new Loop.ExternalData.QueryResult(objectName, fields);
            
            // set up fields list to get data for QueryResult instance
            if (objectName == sampleSoqlObjectName) {
                //fields = new List<string>{ 'Name', 'Title' };
                fields = new List<string>{ 'Name','Loan_Condition_Code__c','Property__r.Property_Address__c','Property__r.City__c','Property__r.State__c','Property__r.Zip_Code__c','Element_Value_1','Element_Value_2','Element_Value_3','Element_Value_4','Element_Value_5','Element_Value_6','Element_Value_7','Element_Value_8','Element_Value_9','Element_Value_10'};
                // Since we added fields to the list, update the QueryResult instance
                queryResult = new Loop.ExternalData.QueryResult(objectName, fields);
                
                //Loan_Condition_Checklist__c LoanConditions = new Loan_Condition_Checklist__c();                
                Loan_Condition_Element__c LoanConditionElement = new Loan_Condition_Element__c();
               
               List<Loan_Condition_Checklist__c> LoanConditions = [SELECT Name,Loan_Condition_Code__c,Property__r.Property_Address__c,Property__r.City__c,Property__r.State__c,Property__r.Zip_Code__c,(SELECT Loan_Condition_Element__c.Element_Value__c,Loan_Condition_Element__c.Custom_Element_Value__c from Loan_Condition_Elements__r Order by Loan_Condition_Element__c.ID) FROM Loan_Condition_Checklist__c WHERE Loan__c = :loanId];
               
               
                // for each row of data returned by the query
                for (Loan_Condition_Checklist__c LoanCondition : LoanConditions){
                    string Element1='',Element2='',Element3='',Element4='',Element5='',Element6='',Element7='',Element8='',Element9='',Element10='';
                    
                    // Store the values (as strings) from the record in the same order of the fields defined in the QueryResult instance
                    List<string> recordValues = new List<string>();
                    
					recordValues.add(LoanCondition.Name);
                    recordValues.add(LoanCondition.Loan_Condition_Code__c);
                    recordValues.add(LoanCondition.Property__r.Property_Address__c);   
                    recordValues.add(LoanCondition.Property__r.City__c); 
                    recordValues.add(LoanCondition.Property__r.State__c);
                    recordValues.add(LoanCondition.Property__r.Zip_Code__c);
					
                    integer eCount=0;
                    if (!LoanCondition.Loan_Condition_Elements__r.isEmpty()) {
                        List<string> Elements = new List<string>();
                        
                        for (Loan_Condition_Element__c childRecord : LoanCondition.Loan_Condition_Elements__r) {
                            eCount++;
                            
                            string lc_element=null;
                            
                            if(childRecord.Element_Value__c!=null){                            	
                                
                                lc_element=childRecord.Element_Value__c;
                                //Elements.add(childRecord.Element_Value__c);
                            }
                            else
                            {
                                if(childRecord.Custom_Element_Value__c!=null)
                                {
                                   lc_element=childRecord.Custom_Element_Value__c;
                                   //Elements.add(childRecord.Element_Value__c);
                                }
                            }                            
                            
                            	if (eCount == 1) {

                                    Element1 = lc_element;
                                    
                                } else if (eCount == 2) {
                                    
                                    Element2 = lc_element;
                                    
                                } else if (eCount == 3) {
                                    
                                    Element3 = lc_element;
                                    
                                } else if (eCount == 4) {
                                    
                                    Element4 = lc_element;
                                } else if (eCount == 5) {
                                    
                                    Element5 = lc_element;
                                } else if (eCount == 6) {
                                    
                                    Element6 = lc_element;
                                    
                                } else if (eCount == 7) {
                                    
                                    Element7 = lc_element;
                                
                                } else if (eCount == 8) {
                                    
                                    Element8 = lc_element;
                                    
                                } else if (eCount == 9) {
                                    
                                    Element9 = lc_element;
                                    
                                } else if (eCount == 10) {
                                    
                                    Element10 = lc_element;                                    
                                }
                            
                            system.debug(childRecord);                           
                        }
                        
                       //if(!Elements.isEmpty()){
                          //recordValues.add(string.join(Elements,','));
                       //}
                        
                    }
                    //else{
                        //recordValues.add('');
                    //}
                    
                    recordValues.add(Element1);
                    recordValues.add(Element2);
                    recordValues.add(Element3);
                    recordValues.add(Element4);
                    recordValues.add(Element5);
                    recordValues.add(Element6);
                    recordValues.add(Element7);
                    recordValues.add(Element8);
                    recordValues.add(Element9);
                    recordValues.add(Element10);
                    
					// Add the values to the QueryResult instance rows
                    queryResult.rows.add(recordValues);
                    System.debug(queryResult.rows);
                }
               
                //// for each row of data returned by the query
                //for (SObject record : Database.query(sampleSoqlQuery)) {
                    //// Store the values (as strings) from the record in the same order of the fields defined in the QueryResult instance
                    //List<string> recordValues = new List<string>();
                    //for (string field : fields) {
                        
                        	//recordValues.add(getFieldValue(record, field));
                       
                    //}
					
                    //if (!record.Loan_Condition_Elements__r.isEmpty()) {
                        //for (Loan_Condition_Element__c childRecord : record.Loan_Condition_Elements__r) {
                            
                            
                            //system.debug(childRecord);
                        //}
                    //}
                    
					//System.debug('Record' + record);     
                    
                    // Add the values to the QueryResult instance rows
                    //queryResult.rows.add(recordValues);
                //}
            }
            
            // Add the QueryResult instance to the QueryResultSet instance
            // This needs to be done for every object specified in requestInfo.GetObjectNames(), regardless of whether data is required for the request.
            queryResultSet.add(queryResult);
        }
        
        System.debug('Borrowers' + queryResultSet);
        
        return queryResultSet;
    }
    
    // Helper method
    
    // This method properly retrieves a field value from an SObject for fields used through lookup relationships, 
    // e.g. PricebookEntry.Product2.ProductCode on the OpportunityLineItem object.
    private string getFieldValue(sObject obj, string field) {
        if (obj == null) return '';
        string[] fieldParts = field.split('\\.');
        if (fieldParts.size() == 3) {
            sObject sobj = obj.getSObject(fieldParts[0]);
            if (sobj == null) return '';
            sobj = sobj.getSObject(fieldParts[1]);
            if (sobj == null) return '';
            return string.valueOf(sobj.get(fieldParts[2]));
        }
        else if (fieldParts.size() == 2) {
            sObject sobj = obj.getSObject(fieldParts[0]);
            if (sobj == null) return '';
            return string.valueOf(sobj.get(fieldParts[1]));
        }
        return string.valueOf(obj.get(field));
    }
}