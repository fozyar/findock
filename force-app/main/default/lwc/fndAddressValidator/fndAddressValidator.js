import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import validateAddressWithAPI from '@salesforce/apex/FND_AddresValidatorCtrl.validateAddressWithAPI';

// Contact fields to be used for display on the UI
const FIELDS = [  
    'Contact.MailingCity',
    'Contact.MailingStreet',
    'Contact.MailingCountry',
    'Contact.MailingPostalCode',
    'Contact.MailingState'
];

export default class FndAddressValidator extends LightningElement {
    // Record ID needed for later DML update
    @api recordId;

    // Retrieve the current Contact record using the recordId
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;

    loading = false;

    // Using the get's for retrieving the values defined in FIELDS
    get city() {
        return this.contact.data.fields.MailingCity.value;
    }

    get street() {
        return this.contact.data.fields.MailingStreet.value;
    }

    get country() {
        return this.contact.data.fields.MailingCountry.value;
    }

    get postalCode() {
        return this.contact.data.fields.MailingPostalCode.value;
    }

    get state() {
        return this.contact.data.fields.MailingState.value;
    }

    // Validate the address by setting up the address request DTO and passing this along to the Apex class with the contact recordId
    validateAddress(event) {
        this.loading = true;

        // In Salesforce there is no field for housenumber (required for the API), this is saved in the MailingStreet field. So we seperate these values from the field and save them in different variables, to be used for the callout
        const street = this.street.replace(/[0-9]/g, '');
        const housenumber = this.street.replace(/\D/g, '');

        // Setup the address request DTO
        const addressRequestDTO = {
            city : this.city,
            street : street,
            housenumber : housenumber,
            country : this.country,
            state : this.state,
            postcode : this.postalCode
        }

        // After validating the address with the API, display a toast message based on the result
        validateAddressWithAPI({ contactId: this.recordId, addressRequest: addressRequestDTO})
            .then((result) => {
                this.loading = false;

                if(result) {
                    this.showToast('Validated', 'Address is validated', 'success');
                } else {
                    this.showToast('Not Validated', 'Address was not validated', 'error');
                }
            })
            .catch((error) => {
                this.loading = false;
                
                this.error = error;
                console.log('An error occured validating the address: ' + error);

                this.showToast('Error', 'An error occured validating the address, check the console log', 'error');
            });
    }

    // Display a toast message
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(event);
    }
}