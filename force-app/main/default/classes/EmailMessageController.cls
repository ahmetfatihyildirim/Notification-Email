//Create a  custom field on Activity Object named Email Read

public with sharing class EmailMessageController {

    @AuraEnabled
    public static string getTaskRecords(){
        string finalId;

        List<Task> listofEmails = new List<Task>();
        listofEmails = [SELECT Id, WhatId, Email_Read__c, TaskSubtype, CreatedDate FROM Task WHERE WhatId!=null AND Email_Read__c!=true AND TaskSubtype='Email' ORDER BY CreatedDate DESC];

        if(listofEmails.size()>0){
            finalId = listofEmails[0].Id;
        }

        return finalId;
    }

    @AuraEnabled
    public static void setRecords(string recordId){
        if(recordId!=null){
            Task listofEmails = new Task();
            listofEmails = [SELECT Id, WhatId, Email_Read__c, TaskSubtype, CreatedDate FROM Task WHERE WhatId!=null AND Id =:recordId AND Email_Read__c!=true LIMIT 1];
            listofEmails.Email_Read__c =true;
           update listofEmails; 
        }
    }
}