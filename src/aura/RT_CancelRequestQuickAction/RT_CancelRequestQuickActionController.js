({
	myAction : function(component, event, helper) {
		var action= component.get("c.UpdateRequestTrackerStatusField");
        var recId= component.get("v.recordId");
        console.log('The record id is-'+recId);
        
        action.setParams({
            Id: recId
            
        });
        action.setCallback(this, function(response){
             console.log(response.getState());
             if(component.isValid() && response.getState() === "SUCCESS"){
                component.set("v.EnableDisableButton", response.getReturnValue()); 
                 var booleanValue= component.get("v.EnableDisableButton");
                 var el = document.getElementById('main');
                    el.style.display = 'none'; 
                 console.log('The boolean value is-'+booleanValue);
                 if(!booleanValue){
                     $A.get("e.force:closeQuickAction").fire(); 
                     $A.get('e.force:refreshView').fire();
                     console.log('The reload part of the page=====');
                     //location.reload();
                 } 
             }         
         });
        
       $A.enqueueAction(action);
	},
    
    ownerName: function(component, event, helper) {
        
        var ownerSerget=component.get("c.ReturnOwnerName");
        var recId= component.get("v.recordId");
        
        console.log('The record id is-'+recId);
        
        ownerSerget.setParams({
            Id: recId
        });
        ownerSerget.setCallback(this, function(response){
             console.log(response.getState());
             if(component.isValid() && response.getState() === "SUCCESS"){
                component.set("v.OwnerName", response.getReturnValue()); 
                 var Ownernameconsole= component.get("v.OwnerName");
                 console.log('The boolean value is-'+Ownernameconsole); 
             }         
         });
        $A.enqueueAction(ownerSerget);
    }
})