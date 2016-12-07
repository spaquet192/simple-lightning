({
	showSpinner : function (component, event, helper) {
	    var m = component.find('spinner');
   		$A.util.removeClass(m, "slds-hide");
	},
    
	hideSpinner : function (component, event, helper) {
    	var m = component.find('spinner');
    	$A.util.addClass(m, "slds-hide");
	} 
})