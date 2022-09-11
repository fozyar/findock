# Findock Assessment

Creating a LWC (fndAddressValidator) to validate the address on a contact. This LWC will be displayed as a seperate component on the Contact page (FND_Contact_Lightning_Page) and will retrieve the mailing address and display it alongside a button.

The button serves to start a validation process by performing a callout with values provided by the contact record, in this case we provide the LWC with the MailingAddress.

Used the https://api.geoapify.com API as a validator. A remote site setting (GeoApify) is setup to allow callouts to this endpoint. 
The API will return a confidence ratio of the address retrieved in the request. I've set a threshold on this confidence ratio and if it exceeds it we count it as valid.

The API key and confidence threshold are saved in a custom setting (FND_Address_Validation_Settings__c) for dynamic changing.

For the request I've setup a request and response DTO (FND_AddressRequestDTO / FND_AddressResponseDTO) which can be used to process the data in Salesforce. These DTO's are used by the service class (FND_AddressAPIService) which performs the callout.
The service class is called by the controller class (FND_AddressValidatorCtrl) of the LWC for reusability.

In case of address validation success: update the Contact.Address_Validation__c field to true, to identify if the address is validated. The opposite will happen if address is not validated (Contact.Address_Validation__c field is set to false)