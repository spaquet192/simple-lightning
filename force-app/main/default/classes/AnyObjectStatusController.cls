public with sharing class AnyObjectStatusController {
    
    public class Status {
        String name {get;set;}
        String helpText {get;set;}
        boolean selected {get;set;}
        
        public Status (string name, string helpText, boolean selected) {
            this.name = name;
            this.helpText = helpText;
            this.selected = selected;
        }
    }
    
    @AuraEnabled
    public static String getStatus(string objectName, string picklistFieldName, String recordId) {
        List<Status> results = new List<Status>();
        
        // Get list of values for target picklist field
    	SObjectType thisObject = Schema.getGlobalDescribe().get(objectName);
    	DescribeSObjectResult thisObjDef = thisObject.getDescribe();
    	Map<String, SObjectField> describeFields = thisObjDef.fields.getMap();
        Schema.DescribeFieldResult describeResult = describeFields.get(picklistFieldName).getDescribe();
        List<Schema.PicklistEntry> ple = describeResult.getPicklistValues();
		Map<String,String> statusData = new Map<String,String>();
        for (Schema.PicklistEntry f : ple) {
            statusData.put(f.getLabel(),'');
        }
        
        String statusVal = recordId != '' ? getFieldValue(objectName, picklistFieldName, recordId) : '';
        
        // Prep result
        for (String key : statusData.keySet()) {
            Status newStatus = new Status(
                key,
                statusData.get(key),
                key == statusVal ? true : false);
            results.add(newStatus);
        }
        
        return JSON.serialize(results);
    }
    
    @AuraEnabled
    public static String getFieldValue(string objectName, string fieldName, string recordId) {
        String query = 'SELECT '+String.escapeSingleQuotes(fieldName)+' FROM '+objectName+' WHERE Id = \''+String.escapeSingleQuotes(recordId)+'\' LIMIT 1';
        sObject thisObject = Database.Query(query);
        return (String)thisObject.get(fieldName);
    }

}