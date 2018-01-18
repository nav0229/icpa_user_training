({
    detailsByDocType : {
        "Order/Award": {key: "oa", pdt:[], req:["regionCtrl", "pdnCtrl"]},
        "Amendment/Mod": {key: "am", pdt:[], req:["regionCtrl", "pdnCtrl", "amendmentCtrl"]},
        "Direct Pay (D7)": {key: "d7", pdt:["D7"], req:["regionCtrl", "pegasysCtrl", "invoiceCtrl"]},
        "Pegagsys Document Number (PDN) Request (Budget Only)": {key: "pdnr", pdt:["IX", "PS", "PX"], req:["regionCtrl", "pegasysCtrl"]},
        "Commitment": {key: "c", pdt:[], req:["regionCtrl"]},
        "Credit Card": {key: "cc", pdt:["CL", "CT"], req:["regionCtrl", "pegasysCtrl"], disabled:true},
        "Receiving Report – Construction, Recurring, or Goods and Services (attachments required)": {key: "rra", pdt:[], req:["regionCtrl", "pdnCtrl"]},
        "Receiving Report – Goods and Services (no attachments)": {key: "rrgs", pdt:[], req:["regionCtrl", "pdnCtrl", "vendorCtrl", "amountCtrl", "receivedOnCtrl", "acceptedOnCtrl"]},
	},
    detailsByControlName : {
        "regionCtrl" : {missing: "Region is missing"},
        "pegasysCtrl" : {missing: "Pegasys Document Type is missing"},
        "pdnCtrl" : {missing: "PDN is missing", regexPattern: "(^\\s*$)|(^(1B|AE|AR|CL|CT|D7|EJ|EK|EN|EP|EQ|GP|IX|PJ|PN|PR|PS|PX|RA|RB|RO|RQ|RR|RT|RW)\\w{0,14}$)", regexPatternFlags: "i", regexMessage: "Must begin with a specific prefix and contain at most 16 letters or numbers."},
        "amendmentCtrl" : {missing: "Amendment Number is missing", regexPattern: "(^\\s*$)|(^\\s*[A-Z0-9]+\\s*$)", regexPatternFlags: "i", regexMessage: "Must not contain any special characters"},
        "amountCtrl" : {missing: "Amount is missing"},
        "invoiceCtrl" : {missing: "Invoice Number is missing", regexPattern: "(^\\s*$)|(^\\s*[A-Z0-9]+\\s*$)", regexPatternFlags: "i", regexMessage: "Must not contain any special characters"},
        "vendorCtrl" : {missing: "Vendor is missing"},
        "receivedOnCtrl" : 
        {
            missing: "Received on Date is missing", 
            validators:
            [
                function(val,c,component,helper){ 
                    var d = helper.createDateFromDateWidgetVal(val);
                    helper.logMessage("receivedOnCtrl.validators[0]: "+val+" = "+d+" <= "+new Date()+" yields "+(d<=new Date()));
                    return {
                        result:d<=new Date(),  
                        errorMessage:"Received on Date must be today or in the past."
                    }; 
	            }
            ]
        },
        "acceptedOnCtrl" : 
        {
            missing: "Accepted on Date is missing",
            validators:
            [
                function(val,c,component,helper){ 
                    var d = helper.createDateFromDateWidgetVal(val);
                    helper.logMessage("acceptedOnCtrl.validators[0]: "+val+" = "+d+" <= "+new Date()+" yields "+(d<=new Date()));
                    return {
                        result:d<=new Date(), 
                        errorMessage:"Accepted on Date must be today or in the past."
                    }; 
                },
                function(val,c,component,helper){ 
                    var d = helper.createDateFromDateWidgetVal(val);
                    var receivedOnDate = helper.createDateFromDateWidgetVal(component.find("receivedOnCtrl").get("v.value"));
                    return {
                        result:d >= receivedOnDate, 
                        errorMessage:"Accepted on Date must be the same or after Received on Date."
                    }; 
                }
        	]
        }
    },
    createDateFromDateWidgetVal : function (val) {
        var parts = val.split("-");
        return new Date(parts[1]+"/"+parts[2]+"/"+parts[0]);
    },
    populateValueFromAjaxAction : function (component, backendApi, fieldName) {
        var action = component.get(backendApi);
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set(fieldName, response.getReturnValue());
            }
        });  
        return action;
    },    
    validateRegexOnFieldChange : function(component, controlName) {
        var ctrl = component.find(controlName);
        var val = ctrl.get("v.value");        
        var errorMessage = null;                
        var fieldDetails = this.detailsByControlName[controlName];  
        var flags = fieldDetails.regexPatternFlags;
        if (flags==null) flags = "";
        var r = new RegExp(fieldDetails.regexPattern, flags);
        if (!r.test(val)){
            errorMessage = fieldDetails.regexMessage;
            if (errorMessage==null){
                errorMessage = "Invalid";
            }
        }
        ctrl.set("v.errors", errorMessage==null?null:[{message:errorMessage}]);
    },
    traceProperties : function(o){
        var msg = "";
        for (var prop in o)
        {            
            msg += `o.${prop} = [${o[prop]}]\n`;
        }
    	this.logMessage(msg);
        //alert(msg);
    },
    logCallbackNonSuccess : function(status, errorMessage){
        if (status === "INCOMPLETE") {
            logMessage("No response from server or client is offline.")
        }
    	else if (status === "ERROR") {
            logMessage("Error: " + errorMessage);
        }
        else {
            logMessage("Unexpected Status: " + status);                
        }        
    },
	logMessage : function(msg){
    	console.log(msg);
        var el = document.getElementById("diagnosticLogMessageStream");
    	var h = el.innerHTML.trim();
    	if (h.length>0)
        {
            h = h + "<hr />";
        }
        var d = new Date();
        var dm = d + " " + d.getMilliseconds() + "ms";
        el.innerHTML = h + dm + "<br />" + msg;
	},
    finalizeCreatePDECaseEntryIntervalId: 0,
    finalizeCreatePDECaseEntry : function(component, pdeCaseEntryId){
        var f = this.finalizeCreatePDECaseEntryCheck;
        var lm = this.logMessage;
        var me = this;
        me.logMessage("finalizeCreatePDECaseEntry=> pdeCaseEntryId:"+pdeCaseEntryId);
        this.finalizeCreatePDECaseEntryIntervalId = setInterval(function(){f(me, component, pdeCaseEntryId);}, 1500);
    },    
    finalizeCreatePDECaseEntryCallbackQueued: 0,
    finalizeCreatePDECaseEntryCallbackReturned: 0,
	finalizeCreatePDECaseEntryCheck : function(me, component, pdeCaseEntryId){
        me.logMessage(
            "finalizeCreatePDECaseEntryCheck=> pdeCaseEntryId:"+pdeCaseEntryId+
            " this:"+me+
            " $A:"+$A+
            " queued:"+me.finalizeCreatePDECaseEntryCallbackQueued+
            " returned:"+me.finalizeCreatePDECaseEntryCallbackReturned);
    	var action = component.get("c.getFinalizationData");
        action.setParams({pdeCaseEntryId : pdeCaseEntryId});
        action.setCallback(me, function(response) {
            var cbr = (++me.finalizeCreatePDECaseEntryCallbackReturned);
            me.logMessage("finalizeCreatePDECaseEntryCheck.callback #"+cbr);
            me.finalizeCreatePDECaseEntryOutstanding--;
            var state = response.getState();
            var returnValue = response.getReturnValue();
            me.logMessage("cb.state=["+state+"] cb.returnValue=["+returnValue+"]");
            if (state == "SUCCESS") {
                var parts = returnValue.split(";");
                var outstandingDocCount = parts[2];
                var caseNumber = parts[3];
                if (me.showCaseNumberAndComplete(caseNumber)){
                    window.clearInterval(me.finalizeCreatePDECaseEntryIntervalId);
                    me.finalizeCreatePDECaseEntryIntervalId=0;
                }
            }            
            else me.traceResponseErrors(response, "cb.Error");
        }); 
        ++me.finalizeCreatePDECaseEntryCallbackQueued;
        $A.enqueueAction(action);            
    },
    showCaseNumberAndComplete : function(caseNumber){
        if (caseNumber==null||caseNumber=="null"||caseNumber=="") return false;
    	jQuery("#createdCaseNumber").text(caseNumber);
        jQuery("#pdeFormSaving").hide();
        jQuery("#pdeFormSaved").removeClass("hidden").show();              
        return true;
    },
    traceResponseErrors : function(response, caller){
        var msg = "";
        msg += "Caller: ["+caller+"]\n";
        msg += "State: ["+response.getState()+"]\n";
        msg += "Ret: ["+response.getReturnValue()+"]\n";
        var errors = response.getError();
        if (errors && errors[0] && errors[0].message) 
        {
            msg += "Error: ["+errors[0].message+"]";
        }
        else
        {
            msg += "Error: <Unknown>";
        }
        console.log(msg);
        alert(msg);           
    }
})