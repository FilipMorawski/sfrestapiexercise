import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import NAME_FIELD from '@salesforce/schema/TestCustomObject__c.Name';

import { subscribe, onError } from 'lightning/empApi';

export default class TestObject extends LightningElement {

 @api recordId;
 @track wiredRecords;
 @api subscription;


@wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD]})
getRecord(result) {

     if(!this.subscription) {
         var channelName = '/data/ChangeEvents';

                const messageCallback = function(response) {
                    if(response.data.payload.ChangeEventHeader.recordIds.length == 1
                        && response.data.payload.ChangeEventHeader.recordIds[0] == this.recordId) {

                        refreshApex(this.wiredRecords);
                    }
                }.bind(this)

                subscribe(channelName, -1, messageCallback).then(response => {
                    this.subscription = response;
                });
     }
     this.wiredRecords = result;
 }

}





