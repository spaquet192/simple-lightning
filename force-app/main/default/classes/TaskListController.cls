public with sharing class TaskListController {

  @AuraEnabled
  public static List<Task> getMyTasks(String taskName,String taskId,String taskStatus,String startDate,String endDate) {
      
     String query = 'SELECT ';
     query = query + 'ActivityDate, ' ;
     query = query + 'Subject, ';
     query = query + 'Id, ';
     query = query + 'Status ';
     query = query + 'from Task ';
     query = query + 'WHERE TaskSubType = \'Task\' AND Subject <> \'\'';
     
     if (taskName != '') {
       query = query + ' and Subject like ' +  '\'%'+ String.escapeSingleQuotes(taskName) + '%\'';
     }
      
     if (taskId != '') {
       query = query + ' and id = \'' + String.escapeSingleQuotes(taskId) + '\'';   
     } 
     
     if (startDate != '') {
       query = query + ' and ActivityDate >= '  + String.escapeSingleQuotes(startDate);
     }
      
     if (endDate != '') {
       query = query + ' and ActivityDate < '  + String.escapeSingleQuotes(endDate);
     } 
      
     query = query + ' order by ActivityDate ASC';
      
     List<sObject> sobjList = Database.query(query);
      
     return sobjList;
  }  
}