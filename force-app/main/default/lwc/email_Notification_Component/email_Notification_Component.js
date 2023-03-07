import { LightningElement,api } from 'lwc';
import getTaskRecords from '@salesforce/apex/EmailMessageController.getTaskRecords';
import setRecords from '@salesforce/apex/EmailMessageController.setRecords';
import { NavigationMixin } from "lightning/navigation";

export default class EmailNotification extends NavigationMixin(LightningElement) {

@api emailRead=false;
@api emailTaskId;
// @api activityId;

connectedCallback(){
    this.GetRecordsFromEmailMessageObject();
}

renderedCallback(){
    this.GetRecordsFromEmailMessageObject();
}

GetRecordsFromEmailMessageObject(){
    getTaskRecords()
    .then(result=>{
        if(result !=null){
            this.emailRead =false;
            this.emailTaskId = result;
        }
       else{
        this.emailRead =true;
        this.emailTaskId =null;
       }
    });
}

updateEmailReadStatus(){
    setRecords({recordId:this.emailTaskId})
    .then(()=>{
        this.navigate();
    });
}

navigate(){
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.emailTaskId,
            objectApiName: 'Task',
            actionName: 'view'
        }
    });
}

closeHandler(){
    setRecords({recordId:this.emailTaskId})
    .then(()=>{
        this.renderedCallback();
    });
    
}

}