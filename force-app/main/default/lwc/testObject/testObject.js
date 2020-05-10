import { LightningElement, api, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { subscribe, onError } from 'lightning/empApi';

import getTestObject from '@salesforce/apex/TestObjectController.getTestObject';

export default class TestObject extends LightningElement {

 @api recordId;
 @api subscription;

 @track object;
 @track wiredRecords;

 @wire(getTestObject, {id : '$recordId'})
 getTestObject(result) {

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
    if (result.data) {
        this.object = result.data;
    } else if (result.error) {
         console.error('ERROR => ', JSON.stringify(error));
     }
 }

}





