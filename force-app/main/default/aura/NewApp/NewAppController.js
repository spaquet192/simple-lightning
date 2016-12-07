({
	doInit : function(component, event, helper) {
		var name = component.get('v.Name');
        component.set('v.Name',name || 'Andre');
	}
})