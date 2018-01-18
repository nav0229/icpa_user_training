({
    doScriptsLoaded : function(){
        $(".slds-tabs_scoped__link").click(function(e){            
            //alert("tab clicked: "+e.target);
            e.preventDefault();
            var activeTab = $(this);
            activeTab.parent().parent().children("li").removeClass("slds-is-active");
            activeTab.parent().addClass("slds-is-active");
            var tabContainer = activeTab.parent().parent().parent();
            tabContainer.children("div").removeClass("slds-show").addClass("slds-hide");
            tabContainer.children("div[aria-labelledby='"+this.id+"']").addClass("slds-show").removeClass("slds-hide");
            return false;
        });
        $(".diagnosticLogToggler").click(function( event ) {
            $("#diagnosticLog").toggle();
        });        
    }
})