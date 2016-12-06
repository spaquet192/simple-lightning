({
	doInit : function(component, event, helper) {
        var picklistField = component.get('v.picklistSource');
        var currentId = component.get('v.recordId');
        // Get initial stages from target picklist
        helper.callServer(component,"c.getStages",function(response){
            var rec;
            var recs = [];
            var data = JSON.parse(response);
            for (var i in data) {
                rec = data[i];
                recs.push({
                    name: rec.name,
                    helpText: rec.helpText,
                    className: rec.className
                });
            }
            component.set("v.stages", recs);  
        }, {
            objectName: 'Task',
            picklistFieldName: picklistField,
            recordId: currentId
        });
        
        // Get current status for picklist
        helper.callServer(component,"c.getFieldValue",function(response){
            component.set('v.currentStage',response);
        }, {
            fieldName: picklistField,
            recordId: currentId
        });
        
        debugger;
		
	}
})