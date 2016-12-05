({
    onListItemClick: function(component,event,helper) {
        var params = event.getParams();
        component.set("v.selectedRecordId",params.pk);
        var selectedRowEl = component.get("v.selectedRowEl");
        if (selectedRowEl) {
            $A.util.removeClass(selectedRowEl,"slds-is-selected");
        }
        component.set("v.selectedRowEl", params.domEl);
        $A.util.addClass(params.domEl,"slds-is-selected");      
    },
    
    doInit: function(component, event, helper) {          
        helper.callServer(component,"c.getMyTasks",function(response){
            var rec;
            var recs = [];
            
            for (var i=0; i< response.length; i++) {
                rec = response[i];
                recs.push({
                    pk: rec.Id,
                    data: ''.concat(
                        rec.Subject,
                        "|",
                        response[i].ActivityDate,
                        '|',
                        response[i].Status
                    ),
                    delimiter: "|"
                });
            }
            
            component.set("v.rows", recs);  
            component.find('grid').refresh();
        }, {
            taskName: component.get('v.taskName'),
            taskId: component.get('v.taskId'),
            taskStatus: component.get('v.taskStatus'),
            startDate: component.get('v.startDate'),
            endDate: component.get('v.endDate')
        });
    }
    
    
    
})