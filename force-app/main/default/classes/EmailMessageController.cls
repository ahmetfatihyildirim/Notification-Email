public with sharing class EmailMessageController {

    @AuraEnabled
    public static string getRecords(string recordId){
        string finalResult;

        List<EmailMessage> listofEmails = new List<EmailMessage>();
        listofEmails = [SELECT Id,Email_Read__c FROM EmailMessage where RelatedToId!=null and RelatedToId =:recordId and Email_Read__c!=true 
        ];

        if(listofEmails.size()>0){
            finalResult = listofEmails[0].Id;
        }

        return finalResult;
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