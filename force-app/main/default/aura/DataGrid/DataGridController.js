({
	doInit : function(component, event, helper) {
        helper.onInit(component);	
	},
    
    showSpinner: function(component, event, helper) {
        helper.onSpinner(component,event,helper);
    },
    
    hideSpinner: function(component, event, helper) {
        helper.offSpinner(component,event,helper);        
    }
})