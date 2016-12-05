public with sharing class TaskListController {

  @AuraEnabled
  public static List<Task> getMyTasks() {
      
     String query = 'SELECT ';
     query = query + 'ActivityDate, ' ;
     query = query + 'Subject, ';
     query = query + 'Id, ';
     query = query + 'Status, ';
     query = query + 'Description ';
     query = query + 'from Task ';
     query = query + 'WHERE TaskSubType = \'Task\' AND Subject <> \'\'';
     query = query + ' order by ActivityDate ASC';
      
     List<sObject> sobjList = Database.query(query);
      
     return sobjList;
  }  
}