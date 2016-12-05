({
	alert : function(component, title, message) {
		$A.createComponent(
            "c:ModalDialog",
            {
                "title": title,
                "body": message,
                "onclose":component.getReference("c.onDestroyModalDialog")
            },
            function(msgBox) {
                if (component.isValid()) {
                    var targetCmp = component.find('optionalModalDialog');
                    var body = targetCmp.get('v.body');
                    body.push(msgBox);
                    targetCmp.set('v.body',body);
                }
            }
        );
    },
    
    callServer : function(component,method,callback,params) {
        var action = component.get(method);
        if (params) {
        action.setParams(params);
        }
         
         action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") { 
                // pass returned value to callback function
                callback.call(this,response.getReturnValue());   
            } else if (state === "ERROR") {
                // generic error handler
                var errors = response.getError();
                if (errors) {
                    console.log("Errors", errors);
                    if (errors[0] && errors[0].message) {
                        throw new Error("Error" + errors[0].message);
                    }
                } else {
                    throw new Error("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    }   
})