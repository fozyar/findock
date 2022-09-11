// The service class uses the request and response DTO's to process the address validation
public with sharing class FND_AddressAPIService {
    private static final String API_KEY = '2972430aa21746f7bb615f6d7bcc7111';
    private static FND_Address_Validation_Settings__c addressValidationSettings = FND_Address_Validation_Settings__c.getInstance('Default');

    // Method accepts a parameter of the address request DTO to process the request
    public static FND_AddressResponseDTO validateAddress(FND_AddressRequestDTO addressRequestDTO) {

        // Structure the URL using the request DTO
        String url = 'https://api.geoapify.com/v1/geocode/search?';
        url = url + 'housenumber=' + addressRequestDTO.housenumber + '&street=' + addressRequestDTO.street + '&postcode=' + addressRequestDTO.postcode + '&city=' + addressRequestDTO.city + '&country=' + addressRequestDTO.country + '&apiKey=' + addressValidationSettings.ApiKey__c;

        // Setup the request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        // Send the request using HTTP GET
        Http http = new Http();
        HttpResponse response = http.send(request);

        // Instantiate the response DTO
        FND_AddressResponseDTO addressResponse = new FND_AddressResponseDTO();

        // If success we save the response body to the address response DTO
        if(response.getStatusCode() == 200) {
            addressResponse = (FND_AddressResponseDTO)JSON.deserialize(response.getBody(), FND_AddressResponseDTO.class);
        }

        // Return the address response DTO
        return addressResponse;
    } 
}
