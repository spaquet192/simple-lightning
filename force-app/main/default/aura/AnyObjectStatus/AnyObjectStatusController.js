({
	doInit : function(component, event, helper) {
        var picklistField = component.get('v.picklistSource');
        var objectName = component.get('v.objectName');
        var currentId = component.get('v.recordId') || '';
        var currentStage = component.get('v.currentStage') || '';
        // Get initial stages from target picklist
        helper.callServer(component,"c.getStatus",function(response){
            var rec;
            var recs = [];
            var data = JSON.parse(response);
            for (var i in data) {
                rec = data[i];
                recs.push({
                    name: rec.name,
                    helpText: rec.helpText,
                    className: rec.selected ? 'slds-is-current' : ''
                });
                if (rec.selected) { currentStage = rec.name; }
            }
            debugger;
            component.set("v.stages", recs);  
            component.set('v.currentStage',currentStage);
        }, {
            objectName: objectName,
            picklistFieldName: picklistField,
            recordId: currentId
        });	
	}
})