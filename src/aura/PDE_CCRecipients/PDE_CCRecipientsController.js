/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
({
    

    handleInputLookupEvt: function(component, event, helper){
		helper.searchAction(component, event.getParam('searchString')); 
    },
    
    /*
    	Loads the typeahead component after JS libraries are loaded
    */
    initTypeahead : function(component, event, helper){
        //first load the current value of the lookup field and then
        //creates the typeahead component
        helper.loadFirstValue(component);
    }
    ,
    /*
        Removes the CcRecipient textbox and 'Remove' button
    */
    removeAssoc : function(component, event, helper) {
        var whichOne = event.getSource(); // Find which button clicked
        
        
        var assocarray = component.getSuper().get("v.body");
      
        var indexnumber = assocarray.indexOf(whichOne);  // Get the Index Number of the button
        
        assocarray.splice(indexnumber, 1);  // Remove "Remove Button"

        component.set("v.body", assocarray); 
    }
    

})