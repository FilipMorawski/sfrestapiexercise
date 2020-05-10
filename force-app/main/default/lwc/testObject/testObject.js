import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import NUMBER_FIELD from '@salesforce/schema/TestCustomObject__c.NumberValue__c';
import NAME_FIELD from '@salesforce/schema/TestCustomObject__c.Name';
import PICKLIST_FIELD from '@salesforce/schema/TestCustomObject__c.TestPicklistValue__c';
import CHECKBOX_FIELD from '@salesforce/schema/TestCustomObject__c.TestCheckboxValue__c';

import { subscribe, onError } from 'lightning/empApi';

export default class TestObject extends LightningElement {

 @api recordId;
 @api subscription;

 @track object;
 @track wiredRecords;

@wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, NUMBER_FIELD, CHECKBOX_FIELD, PICKLIST_FIELD]})
getRecord(result) {

     if(!this.subscription) {
         var channelName = '/data/ChangeEvents';

                const messageCallback = function(response) {
                    if(response.data.payload.ChangeEventHeader.recordIds.length == 1
                        && response.data.payload.ChangeEventHeader.recordIds[0] == this.recordId) {

                        console.log('REFRESH DATA');
                        refreshApex(this.wiredRecords);
                    }
                }.bind(this)

                subscribe(channelName, -1, messageCallback).then(response => {
                    console.log('ChannelName : ' + channelName);
                    this.subscription = response;
                });
     }

     this.wiredRecords = result;
     if (result.data) {
        var obj = {};
        obj[NUMBER_FIELD.fieldApiName] = result.data.fields[NUMBER_FIELD.fieldApiName].value;
        obj[NAME_FIELD.fieldApiName] = result.data.fields[NAME_FIELD.fieldApiName].value;
        obj[PICKLIST_FIELD.fieldApiName] = result.data.fields[PICKLIST_FIELD.fieldApiName].value;
        obj[CHECKBOX_FIELD.fieldApiName] = result.data.fields[CHECKBOX_FIELD.fieldApiName].value;
        this.object = obj;
    } else if (result.error) {
         console.error('ERROR => ', JSON.stringify(error)); // handle error properly
     }
 }

handleClick() {
    registerChannel();
}

}





