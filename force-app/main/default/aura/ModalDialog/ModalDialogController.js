({
    defaultCloseAction : function(component, event, helper) {
        $A.util.addClass(component, "hideModal");
	},
    handleClick : function(component, event, helper) {
        $A.util.addClass(component, "hideModal");
    }
    
})