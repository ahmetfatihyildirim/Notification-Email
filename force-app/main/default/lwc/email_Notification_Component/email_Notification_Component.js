import { LightningElement,api } from 'lwc';
import getRecords from '@salesforce/apex/EmailMessageController.getRecords';
import getRecordsTask from '@salesforce/apex/EmailMessageController.getRecordsTask';
import setRecords from '@salesforce/apex/EmailMessageController.setRecords';
import { NavigationMixin } from "lightning/navigation";

export default class EmailNotification extends NavigationMixin(LightningElement) {

@api emailRead=false;
@api emailMessageId;
@api activityId;

connectedCallback(){
    this.GetRecordsFromEmailMessageObject();
    this.GetRecordsFromTaskObject();
}
renderedCallback(){
    this.GetRecordsFromEmailMessageObject();
    this.GetRecordsFromTaskObject();
}

GetRecordsFromEmailMessageObject(){
    getRecords()
    .then(result=>{
        if(result !=null){
            this.emailRead =false;
            this.emailMessageId = result;
        }
       else{
        this.emailRead =true;
        this.emailMessageId =null;
       }
    });
}
GetRecordsFromTaskObject(){
    getRecordsTask()
    .then(result=>{
        if(result !=null){
            
            this.activityId = result;
        }
       else{
        
        this.activityId =null;
       }
    });
}

updateEmailReadStatus(){
    setRecords({recordId:this.emailMessageId})
    .then(()=>{
        this.navigate();
    });
}

navigate(){
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.activityId,
            objectApiName: 'Task',
            actionName: 'view'
        }
    });
}

closeHandler(){
    setRecords({recordId:this.emailMessageId})
    .then(()=>{
        this.renderedCallback();
    });
    
}

navigate2(){
    this[NavigationMixin.Navigate]({
        type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
        }
    });
}
}
//https://sfdcsaga.blogspot.com/