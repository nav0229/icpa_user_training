({

    /*
     *  This method will get the Case Record ID and File Details and will pass the parameters to Helper method.
     */
    save : function(component, event, helper) {
       
        var recordId = event.getParam("recordId");
        var fileInput = event.getParam("fileInput");

	    helper.saveFile(component, recordId, fileInput);
    }
})