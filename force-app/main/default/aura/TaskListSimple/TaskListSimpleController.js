({
    doInit: function(component, event, helper) {          
        helper.callServer(component,"c.getMyTasks",function(response){
            var rec;
            var recs = [];
            
            for (var i=0; i< response.length; i++) {
                rec = response[i];
                recs.push({
                    Id : rec.Id,
                    Subject: rec.Subject,
                    DueDate: rec.ActivityDate,
                    Status: rec.Status
                });
            }
            
            component.set("v.tasks", recs);  
        }, {
            taskName: "",
            taskId: "",
            taskStatus: "",
            startDate: "",
            endDate: ""
        });
    },
    
    onRowClick: function(component, event, helper) {
        var compEvent = component.getEvent('rowClick');
        //var appEvent = $A.get('e.c:TaskListRowClickApp');
        var rowEl = event.currentTarget;
        var rowId = rowEl.getAttribute('data-row');
        var rowName = rowEl.innerText;
        compEvent.setParams({
            recordId: rowId,
            recordName: rowName
        });
        compEvent.fire();
        /*appEvent.setParams({
            recordId: rowId,
            recordName: rowName            
        });
        appEvent.fire();
        */
    },
    
    showSelectedRecord: function(component, event, helper) {
        var recordToShow = event.getParams().recordId;
        var recordName = event.getParams().recordName;
        debugger;
        $A.createComponent(
            "c:ModalRecordViewer",
            {
                recordId: recordToShow,
                recordName: recordName
            },
            function(newComponent, status, errorMessage){
                if (status == "SUCCESS") {
                    var body = component.get('v.body');
                    body.push(newComponent);
                    component.set('v.body',body);
                } else if (status == "INCOMPLETE") {
                    console.log("No response from server, client if offline, retry later")
                } else if (status == "ERROR") {
                    console.log("Error: " + errorMessage);
                }
            }
        );
    }
})