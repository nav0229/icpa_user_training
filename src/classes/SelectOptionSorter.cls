/*
Copyright (c) 2011 tgerm.com
All rights reserved.
*/
/**
    Utility class to provide efficient sorting of Apex SelectOption instances. 
    Efficient as all the heavy lifting of sorting is internally handled by native List.sort(),
    so this leads to fast sorting and lesser consumption of script statements and one is more safe from Governor. 

    @author Abhinav Gupta (abhinav@tgerm.com)
*/
global class SelectOptionSorter {
    
    /**
        Sort field to use in SelectOption i.e. Label or Value
    */
    global enum FieldToSort {
        Label, Value
    }
    
    global static void doSort(List<Selectoption> opts, FieldToSort sortField) {
        
        Map<String, Selectoption> mapping = new Map<String, Selectoption>();
        // Suffix to avoid duplicate values like same labels or values are in inbound list 
        Integer suffix = 1;
        for (Selectoption opt : opts) {
            if (sortField == FieldToSort.Label) {
                mapping.put(    // Done this cryptic to save scriptlines, if this loop executes 10000 times
                                // it would every script statement would add 1, so 3 would lead to 30000.
                             (opt.getLabel() + suffix++), // Key using Label + Suffix Counter  
                             opt);   
            } else {
                mapping.put(    
                             (opt.getValue() + suffix++), // Key using Label + Suffix Counter  
                             opt);   
            }
        }
        
        List<String> sortKeys = new List<String>();
        sortKeys.addAll(mapping.keySet());
        sortKeys.sort();
        // clear the original collection to rebuilt it
        opts.clear();
        
        for (String key : sortKeys) {
            opts.add(mapping.get(key));
        }
    }
    
    
  
    // Test Cases //
  
    
    static testMethod void testdoSortByValue() {
        Selectoption[] opts = new Selectoption[] {
                                   new Selectoption('v1', 'l1'),
                                   new Selectoption('v5', 'l1'),
                                   new Selectoption('v2', 'l1'),
                                   new Selectoption('v6', 'l1'),
                                   new Selectoption('v8', 'l1')
                               };
       
       doSort(opts, FieldToSort.Value);
       
       System.assertEquals(opts.size(), 5);
       System.assertEquals('v1', opts[0].getValue());
       System.assertEquals('v2', opts[1].getValue());
       System.assertEquals('v5', opts[2].getValue());
       System.assertEquals('v6', opts[3].getValue());
       System.assertEquals('v8', opts[4].getValue());
    }
    
    static testMethod void testdoSortByLabel() {
        Selectoption[] opts = new Selectoption[] {
                                   new Selectoption('v1', 'l1'),
                                   new Selectoption('v5', 'l5'),
                                   new Selectoption('v2', 'l2'),
                                   new Selectoption('v2.2', 'l2'), // Same label case
                                   new Selectoption('v6', 'l6'),
                                   new Selectoption('v8', 'l8')
                               };
       
       doSort(opts, FieldToSort.Label);
       
       System.assertEquals(opts.size(), 6);
       System.assertEquals('l1', opts[0].getLabel());
       System.assertEquals('l2', opts[1].getLabel());
       System.assertEquals('l2', opts[2].getLabel());
       System.assertEquals('l5', opts[3].getLabel());
       System.assertEquals('l6', opts[4].getLabel());
       System.assertEquals('l8', opts[5].getLabel());
    }

       
}