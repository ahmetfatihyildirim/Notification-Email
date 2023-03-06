public with sharing class EmailMessageController {

    @AuraEnabled
    public static string getRecords(){
        string finalId;

        List<EmailMessage> listofEmails = new List<EmailMessage>();
        listofEmails = [SELECT Id,Email_Read__c, ActivityId, Subject, MessageDate FROM EmailMessage where RelatedToId!=null and Email_Read__c!=true ORDER BY MessageDate DESC
        ];

        if(listofEmails.size()>0){
            finalId = listofEmails[0].Id;
        }

        return finalId;
    }

    @AuraEnabled
    public static string getRecordsTask(){
        string finalActivityId;

        List<EmailMessage> listofEmails = new List<EmailMessage>();
        listofEmails = [SELECT Id,Email_Read__c, ActivityId, Subject, MessageDate FROM EmailMessage where RelatedToId!=null and Email_Read__c!=true ORDER BY MessageDate DESC 
        ];

        if(listofEmails.size()>0){
            finalActivityId = listofEmails[0].ActivityId;
        }

        return finalActivityId;
    }

    @AuraEnabled
    public static void setRecords(string recordId){
        if(recordId!=null){
            EmailMessage listofEmails = new EmailMessage();
            listofEmails = [SELECT Id,Email_Read__c FROM EmailMessage where RelatedToId!=null and id =:recordId and Email_Read__c!=true LIMIT 1];
           listofEmails.Email_Read__c =true;
           update listofEmails; 
        }
    }
}