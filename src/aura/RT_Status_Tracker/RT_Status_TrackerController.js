({
    doInit : function(component, event, helper) {
        //Geting the present URL
        var recid= component.get("v.recordId");
        console.log('The record is ----->--------->'+recid);
        var action= component.get("c.TrackerUpdate");
        
        action.setParams({id: recid});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var resp= response.getReturnValue();  
                 console.log('The status is ----->--------->'+resp);
                 component.set("v.StatusColor","#d8dde6");
                if(resp== "Alternative product found" || resp == "Open") {
                    component.set("v.PerValue",0);
                    component.set("v.lival1",resp);
                    component.set("v.CurrentStatus1","Curent Status");
                    component.set("v.CurrentStatus2","");
                    component.set("v.CurrentStatus3","");
                    component.set("v.lival2","");
                    component.set("v.lival3","");
                    component.set("v.CurrentNode1","slds-wizard__item slds-is-active");
                    component.set("v.CurrentNode2","slds-wizard__item");
                    component.set("v.CurrentNode3","slds-wizard__item");
                    
                }
                else if(resp == "In Progress") {
                    component.set("v.PerValue",50);
                    component.set("v.lival2",resp);
                    component.set("v.lival3","");
                     component.set("v.lival1","");
                    component.set("v.lisubvalClasstwo","approved"); 
                    component.set("v.CurrentStatus1","");
                    component.set("v.CurrentStatus2","Curent Status");
                  	 component.set("v.CurrentStatus3","");
                    component.set("v.phaseclasstwo","approvedphase");
                    component.set("v.CurrentNode2","slds-wizard__item slds-is-active");
                    component.set("v.CurrentNode1","slds-wizard__item slds-is-active");
                    component.set("v.CurrentNode3","slds-wizard__item");
                    
                }
              	else if(resp == "Approved" || resp == "Cancelled" || resp == "Rejected") {
                    	component.set("v.PerValue",100);
                    	component.set("v.lival3",resp);
                   		 component.set("v.lival2","");
                    	component.set("v.lival1","");
                    	component.set("v.lisubvalClasstwo","approved"); 
                    	component.set("v.phaseclasstwo","approvedphase");
                     	component.set("v.CurrentStatus1","");
                    	component.set("v.CurrentStatus2","");
                    	component.set("v.CurrentStatus3","Final Status");
                    	component.set("v.CurrentNode3","slds-wizard__item slds-is-active");
                    	component.set("v.CurrentNode2","slds-wizard__item slds-is-active");
                    	component.set("v.CurrentNode1","slds-wizard__item slds-is-active");
                    	
                    	if(resp == "Rejected" || resp == "Cancelled") {
                           component.set("v.lisubvalClassthree","denied");
                     	   component.set("v.phaseclassthree","deniedphase");
                            component.set("v.StatusColor","#FC0202");
                         } else {
                           	component.set("v.lisubvalClassthree","approved");
                            component.set("v.phaseclassthree","approvedphase");
                            component.set("v.StatusColor","#92D051");
                           }
                }
             
			}
             
        });
       
     $A.enqueueAction(action);
      
    }
})