// Used for the request and validation of addresses
public with sharing class FND_AddressRequestDTO {
    // Can either send with a structured request or just with a text string.
    @AuraEnabled public String housenumber {get; set;}
    @AuraEnabled public String street {get; set;}
    @AuraEnabled public String postcode {get; set;}
    @AuraEnabled public String city {get; set;}
    @AuraEnabled public String country {get; set;}
    @AuraEnabled public String text {get; set;}
}
