public with sharing class AnyObjectStatusController {
    
    public class Status {
        String name {get;set;}
        String helpText {get;set;}
        String className {get;set;}
        
        public Status (string name, string helpText, String className) {
            this.name = name;
            this.helpText = helpText;
            this.className = className;
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
        
        // Get description for target picklist field and use this as helpText contextual (Special formatting parsing)
		String helpText = describeResult.getInlineHelpText(); 
        for (String entry : helpText.split('\n')) {
            if (entry.indexOf(':') == -1) { continue; }
            string key = entry.split(':')[0].trim();
            if (statusData.containsKey(key)) {
                statusData.put(key,entry.split(':')[1].trim());
            }
        }
        
        String statusVal = getFieldValue(objectName, picklistFieldName, recordId);
        
        // Return properly staged object
        for (String key : statusData.keySet()) {
            String cn = 'slds-tabs--path__item slds-is-incomplete';
            if ('Pending'.equals(statusVal)) {
                if ('Pending'.equals(key)) {
                    cn = 'slds-tabs--path__item slds-is-current';
                }
                if ('False'.equals(key)) {
                    continue;
                }
            }
            if ('Processing'.equals(statusVal)) {
                if ('Pending'.equals(key)) {
                    cn = 'slds-tabs--path__item slds-is-complete';
                }
                if('Processing'.equals(key)) {
                    cn = 'slds-tabs--path__item slds-is-current';
                }
                if ('False'.equals(key)) {
                    continue;
                }
            }
            if ('Synced'.equals(statusVal)) {
                if ('Pending'.equals(key) || 'Processing'.equals(key)) {
                    cn = 'slds-tabs--path__item slds-is-complete';
                }
                if ('Synced'.equals(key)) {
	                cn = 'slds-tabs--path__item slds-is-complete slds-is-won';
                }
                if ('Failed'.equals(key)) {
                    continue;
                }
            }
            if ('Failed'.equals(statusVal)) {
				if ('Synced'.equals(key)){
                    continue;
                }
                if ('Failed'.equals(key)) {
                    cn = 'slds-tabs--path__item slds-is-lost';
                }
            }
            Status newStatus = new Status(key,statusData.get(key), cn);
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