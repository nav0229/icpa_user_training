({  
    doScriptsLoaded : function(){
//        alert("doScriptsLoaded; "+jQuery);
		jQuery(".hidden").hide().removeClass("hidden");        
        jQuery(".toastCloser").each(function(){
            jQuery(this).click(function(e){
              e.preventDefault();
              var sel = jQuery(this).attr("data-container-sel");
              jQuery(sel).hide();
              return false;
            });
        });
    },
    
    doInit: function(component, event, helper) {
        //https://salesforce.stackexchange.com/questions/72885/lightning-how-to-change-page-title-for-lightning-app/72894
        document.title = "Pegasys Data Entry Request Form";
        // To Populate Source Document Picklist Values

        var pickValPopulateCallback = function(a) {
            try
            {
                var j = jQuery;
                helper.logMessage("pickValPopulateCallback ready");
            }
            catch (ex)
            {
                helper.logMessage("pickValPopulateCallback NOT ready");
                setTimeout(function(){pickValPopulateCallback(a);}, 250);
                return;
            }
            var rv = a.getReturnValue();
	        var ctrl = component.find("docTypeCtrl");
	        var opts=[];
            for(var i=0;i< rv.length;i++)
            {
                var val = rv[i];
                var details = helper.detailsByDocType[val];
                if (details==null || !(details.disabled===true))
                {
                    var ro = val == '--Select Document Type--';
                    var o = {class: "optionClass", label: val, value: val, disabled: ro};
                    opts.push(o);                    
                }
            }
            ctrl.set("v.options", opts);
            
        };
        var action = component.get("c.getsourcedocumentpickval");
        action.setCallback(this, pickValPopulateCallback);
        $A.enqueueAction(action); 

        // To Populate Region Picklist Values
        var regionPopulateCallback = function(a) {
            try
            {
                var j = jQuery;
                helper.logMessage("regionPopulateCallback ready");
            }
            catch (ex)
            {
                helper.logMessage("regionPopulateCallback NOT ready");
                setTimeout(function(){regionPopulateCallback(a);}, 250);
                return;
            }
            var rv = a.getReturnValue();
            var ctrl = component.find("regionCtrl");
            var opts=[{class: "optionClass", label: "--Select a Region--", value: "", disabled: true}];
            for(var i=0;i< rv.length;i++){
                var o = {class: "optionClass", label: rv[i], value: rv[i]};
				opts.push(o);
            }
            ctrl.set("v.options", opts);            
            jQuery("#regionCtrl").val("_");
        };
        action = component.get("c.getregionpickval");
        action.setCallback(this, regionPopulateCallback);
        $A.enqueueAction(action);                 
        
        //To Populate User name from $USER Object
        $A.enqueueAction(helper.populateValueFromAjaxAction(component, "c.getUserName", "v.newGsaCustom.PDE_ContactName__c"));               
        
        //To Populate Email from $USER Object
        $A.enqueueAction(helper.populateValueFromAjaxAction(component, "c.getEmail", "v.newGsaCustom.PDE_ContactEmail__c"));               

        //To Populate Title from $USER Object
        $A.enqueueAction(helper.populateValueFromAjaxAction(component, "c.getTitle", "v.newGsaCustom.PDE_Title__c"));               

        //To Populate Divison from $USER Object
        $A.enqueueAction(helper.populateValueFromAjaxAction(component, "c.getDivision", "v.newGsaCustom.PDE_Division__c"));               
    },
    /*
     * This method will be called upon selecting an option in "Source Document Type" picklist
     * and show the required fields and hides the fiesl that are not required.
     */
    onDocTypeCtrlChange : function(component, event, helper) {
        var ctrl = component.find("docTypeCtrl");
        var selected = ctrl.get("v.value");        
        var details = helper.detailsByDocType[selected];
        jQuery("div[data-docTypeKeys],span[data-docTypeKeys]").each(function(z){
            var jel = jQuery(this);
            var keys = jel.attr("data-docTypeKeys").split(",");
            for (var x=0;x<keys.length;++x)
            {
                if (keys[x]==details.key || keys[x]=="*")
                {
		            jel.show();
                    //alert("showing "+jel.attr("data-aura-rendered-by"));
                    return;
                }
            }
            jel.hide();
        });
        var opts = [];
        for (var x=0;x<details.pdt.length;++x)
        {
            opts.push({"class": "optionClass", label: details.pdt[x], value: details.pdt[x]})            
        }
        component.find("pegasysCtrl").set("v.options", opts);        
    },
    /*
     * This method will be called on Region Picklist Change and it will populate the corresponding Zones Picklist.
     */
    onRegionCtrlChange : function(component, event, helper) {
        var ctrl = component.find("regionCtrl");
        var selected = ctrl.get("v.value");        
        var zoneValue = "";
        if( selected == 1 || selected == 2 || selected == 3 || selected == 5)
        { 
            zoneValue = "Zone 1";
        }
        else if( selected == 4 || selected == 6 || selected == 7)
        { 
            zoneValue = "Zone 2";
        }
        else if( selected == 8 || selected == 9 || selected == 10)
        { 
            zoneValue = "Zone 3";
        }
        else if( selected == 11)
        { 
            zoneValue = "Zone 4";
        }
        else if( selected == 'CO')
        { 
            zoneValue = "Central Office";
        } 
		component.set("v.newGsaCustom.PDE_Zone__c", zoneValue);
    },
    /*
     * This function is to display CcRecipient textbox dynamically 
     */
    showAssoc : function(component, event, helper) 
    {
		$A.createComponent(
            "aura:html",
            {  
                "tag": "div",
            },            
            function(newAttach, status, errorMessage){
                if (status === "SUCCESS") {
                    var body = component.get("v.displayassoc");                   
                    body.push(newAttach);
                    component.set("v.displayassoc", body);
                }
                else helper.logCallbackNonSuccess(status, errorMessage);
            }
        ); 
        $A.createComponent(
            "c:PDE_CCRecipients",
            {  
                "type": component.getReference("v.objNew.sobjectType") ,
                "className": "form-control",
                "aura:id": "assocuserid"
            },
            function(newLookup, status, errorMessage){
                if (status === "SUCCESS") {
                    var assocarray = component.get("v.displayassoc");
                    assocarray.push(newLookup);                    
                    component.set("v.displayassoc", assocarray);
                }
                else helper.logCallbackNonSuccess(status, errorMessage);
            }
        );         
    },
    /* 
     * This method will be called on PDN Value change and perform corresponding Validations
     */
    onPDNChange : function(component, event, helper) {
        helper.validateRegexOnFieldChange(component, "pdnCtrl");
    },
     /* 
     * This method will be called on Amendment Value change and perform corresponding Validations
     */
    onAmendmentChange : function(component, event, helper) {
        helper.validateRegexOnFieldChange(component, "amendmentCtrl");
    },
     /* 
     * This method will be called on Invoice Number Value change and perform corresponding Validations
     */
    onInvoiceChange : function(component, event, helper) {
        helper.validateRegexOnFieldChange(component, "invoiceCtrl");
    },
    /*
     * This method is to show the Attachment input control dynamically
     */
    showAttach : function(component, event, helper) {        
        $A.createComponent(
            "aura:html",
            {  
                "tag": "div",
            },            
            function(newAttach, status, errorMessage){
                //Add the new attachment to body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");                   
                    body.push(newAttach);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                        // Show error message
                    }
            }
        ); 
        $A.createComponent(
            "input",
            {  
                "type": "file",
                "class": "file",
                "aura:id": "file",
                "class": "dynamic1",                
            },
            function(newAttach, status, errorMessage){
                //Add the new attachment to body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");                  
                    body.push(newAttach);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                        // Show error message
                    }
            }
        ); 
        $A.createComponent(
            "ui:button",
            {  
                "label":"Remove Attachment",
                "press": component.getReference("c.handlePress"),
                "class": "dynamic1",
            },
            function(newAttach, status, errorMessage){
                //Add the new attachment to body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");                    
                    body.push(newAttach);
                    component.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                    else if (status === "ERROR") {
                        console.log("Error: " + errorMessage);
                        // Show error message
                    }
            }
        );    
    },
    /*
     * This method is to hide the Attachment and "Remove Attachment" button
     */    
    handlePress : function(component, event, helper) {
        var whichOne = event.getSource(); // Find which button clicked
        var body = component.get("v.body");
        var indexnumber = body.indexOf(whichOne);  // Get the Index Number of the button
        
        body.splice(indexnumber, 1);  // Remove "Remove Button"
        body.splice(indexnumber-1,1); // Remove Attachment
        body.splice(indexnumber-2,1); // Remove New Line
        component.set("v.body", body); 
    },
    /*
     * This method will call "savePDNCaseEntry" apex method to create a PDNCaseEntry 
     * and also saves the corresponding Attachment and CaseTeam related lists
     */    
    createPDECaseEntry : function(component, event, helper) { 
        helper.logMessage("createPDECaseEntry ======================");
		jQuery("#pdeValidationErrorContainer").hide();

        var details = helper.detailsByDocType[component.find("docTypeCtrl").get("v.value")];
        var clientSideErrorsExist = false;
        jQuery("#pdeValidationErrorList").html("");
        for (var x=0;x<details.req.length;++x)
        {            
            var r = details.req[x];            
            var fieldDetails = helper.detailsByControlName[r];            
            var c = component.find(r);
            if (c!=null){
                var val = c.get("v.value");
                if (val!=null){
                    val = (""+val).trim();
                }
                helper.logMessage("checking required ["+r+"]=["+val+"]");
                if (val==null||val==""){
                    helper.logMessage("value not present");
                    var errorMessage = "";
                    if (fieldDetails==null || fieldDetails.missing==null){
                        errorMessage = "Field "+r+" is missing";
                    }
                    else{
                        errorMessage = fieldDetails.missing;
                    }
					jQuery("#pdeValidationErrorList").append(jQuery("<li></li>").text(errorMessage));                                                                
                    clientSideErrorsExist=true;
                }
                else if (fieldDetails!=null && fieldDetails.validators!=null){
                    helper.logMessage(fieldDetails.validators.length+" validator exists; val="+val);
                    for (vi=0;vi<fieldDetails.validators.length;++vi){
                        var validator = fieldDetails.validators[vi];
                        var res = validator(val, c, component, helper);
                        if (!res.result){
                            jQuery("#pdeValidationErrorList").append(jQuery("<li></li>").text(res.errorMessage));                                                                
                            clientSideErrorsExist=true;                        
                        }
                    }
                }
            }
            else{
                helper.logMessage("cannot find required control: ["+r+"]");
                return;
            }
        }
        if (clientSideErrorsExist){
            jQuery("#pdeValidationErrorContainer").show();
            return;
        }
        jQuery("#pdeForm").hide();
        jQuery("#pdeFormSaving").removeClass("hidden").show();
        
        //Calculate Number of Attachments
        var files = jQuery("#attachmentsContainer input[type='file']");        
        var attachCounter = 0;
        for(var i=0; i<files.length; i++) 
        {
            attachCounter += files[i].files[0]==null ? 0 : 1;
        }                    
        helper.logMessage("attachCounter="+attachCounter+"; files.length="+files.length);
        component.set("v.newGsaCustom.PDE_Attachments_To_Load_Counter__c", attachCounter);
        
        // Added to Save Case Team Members
//        var userBoxes = jQuery(".teamMemberContainer .recipientValue input[type='text']");
        var userBoxes = jQuery(".recipientValue");
        var teamMembers = "";
        for(var j=0; j< userBoxes.length; j++) {
            var caseMemberName = userBoxes[j].value;
            if(caseMemberName != null)
            {              
		        helper.logMessage("TeamMember="+caseMemberName);
                teamMembers = teamMembers + caseMemberName + "|";
            } 
        } 
		component.set("v.newGsaCustom.PDE_Team_Members__c", teamMembers);      
        
        var newGsaCustom = component.get("v.newGsaCustom");
        //helper.traceProperties(newGsaCustom);
        
    	//Call savePDECaseEntry Apex Method        
        var action = component.get("c.savePDECaseEntry");
        action.setParams({ 
            newpdecaseentry : newGsaCustom
        }); 
        
        action.setCallback(this, function(response) {
            //alert("state: "+response.getState()+" ret: "+response.getReturnValue());
            var state = response.getState();
            if (state=="SUCCESS")
            {
	            var retParts = response.getReturnValue().split(";");                
                if (retParts[0]!="success"){
			        jQuery("#pdeForm").show();
			        jQuery("#pdeFormSaving").hide();
                    jQuery("#pdeValidationErrorList").html("");
                    for (var x=1;x<retParts.length;++x)
                    {
	                    jQuery("#pdeValidationErrorList").append(jQuery("<li></li>").text(retParts[x]));                                            
                    }                    
			        jQuery("#pdeValidationErrorContainer").show();
                    return;
                }
                else
                {
                    helper.logMessage("createPDECaseEntry.callback retParts=["+response.getReturnValue()+"]");
                    var pdeCaseEntryId = retParts[1];
                    var recordId = retParts[2];
                    var caseNumber = retParts[3];
    
                    // Added to Save the Attachments
                    for(var i=0; i<files.length; i++) 
                    {
                        var file = files[i]
                        if (file.files[0]!=null)
                        {
                            //alert("Inside Attachment: "+file.files[0]);
                            var compEvent = $A.get("e.c:PDE_FormEvent");                        
                            compEvent.setParams({"recordId":recordId,"fileInput":file} );                        
                            //Fire Application Event to call PDE_Attachments_Custom component's save method
                            compEvent.fire();
                        }                      
                    }            
                    if (!helper.showCaseNumberAndComplete(caseNumber)){
	                    helper.finalizeCreatePDECaseEntry(component, recordId);                        
                    }
					return;                    
                }                                
            }
            jQuery("#pdeFormSaving").hide();
            jQuery("#pdeFormFailed").removeClass("hidden").show();       
            helper.traceResponseErrors(response, "createPDECaseEntry");
        });        
        $A.enqueueAction(action);         
    }
})