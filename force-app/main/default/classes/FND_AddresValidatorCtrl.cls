// Controller class for the fndAddressValidator LWC
public with sharing class FND_AddresValidatorCtrl {
    private static FND_Address_Validation_Settings__c addressValidationSettings = FND_Address_Validation_Settings__c.getInstance('Default');

    // Validate the address by using the service class
    @AuraEnabled
    public static Boolean validateAddressWithAPI(Id contactId, FND_AddressRequestDTO addressRequest) {
        // Perform the callout using the service class and save the response in the address response DTO
        FND_AddressResponseDTO addressResponse = FND_AddressAPIService.validateAddress(addressRequest);

        // Log the confidence variable, we use this to validate the address
        Decimal confidence = Decimal.valueOf(addressResponse.features[0].properties.rank.confidence);

        // We can set our threshold to identify what is a validated address or not.
        Boolean addressValidated = confidence >= addressValidationSettings.Confidence_Threshold__c ? true : false;

        // Update the contact using the contactId
        Contact c = new Contact(
            Id = contactId,
            Address_Validated__c = addressValidated
        );

        update c;

        // Return the result of the validation to the LWC
        return addressValidated;
    }
}
