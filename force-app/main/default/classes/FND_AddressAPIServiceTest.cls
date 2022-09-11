@IsTest
private class FND_AddressAPIServiceTest {
    @TestSetup
    static void setup() {
        Contact c = new Contact(
            FirstName = 'Captain Jack',
            LastName = 'Sparrow',
            MailingCity = 'The Black Pearl',
            MailingCountry = 'Caribbean',
            MailingPostalCode = '1234AB',
            MailingStreet = 'Amazing Sea Street 25'
        );

        insert c;

        FND_Address_Validation_Settings__c testSettings = new FND_Address_Validation_Settings__c(
            Name = 'Default',
            ApiKey__c = 'TESTAPIKEY123456789'
        );

        insert testSettings;
    }

    @IsTest
    static void testAddressValidation() {
        Test.setMock(HttpCalloutMock.class, new FND_AddressAPIHttpCalloutMock());

        Contact c = [SELECT Id, MailingCity, MailingCountry, MailingPostalCode, MailingStreet FROM Contact LIMIT 1];
        
        FND_AddressRequestDTO request = new FND_AddressRequestDTO();
        request.housenumber = '25';
        request.street = c.MailingStreet;
        request.postcode = c.MailingPostalCode;
        request.city = c.MailingCity;
        request.country = c.MailingCountry;
        request.text = '';

        Test.startTest();
            
        FND_AddressResponseDTO testResponse = FND_AddressAPIService.validateAddress(request);
        System.assertNotEquals(null, testResponse);
        System.assertNotEquals(null, testResponse.type);
        System.assertNotEquals(null, testResponse.features);

        for(FND_AddressResponseDTO.FeaturesDTO f : testResponse.features) {
            System.assertNotEquals(null, f.type);
            System.assertNotEquals(null, f.properties);
            System.assertNotEquals(null, f.properties.datasource);
            System.assertNotEquals(null, f.properties.datasource.sourceName);
            System.assertNotEquals(null, f.properties.datasource.attribution);
            System.assertNotEquals(null, f.properties.datasource.license);
            System.assertNotEquals(null, f.properties.datasource.url);
            System.assertNotEquals(null, f.properties.housenumber);
            System.assertNotEquals(null, f.properties.street);
            System.assertNotEquals(null, f.properties.suburb);
            System.assertNotEquals(null, f.properties.city);
            System.assertNotEquals(null, f.properties.state);
            System.assertNotEquals(null, f.properties.country);
            System.assertNotEquals(null, f.properties.postcode);
            System.assertNotEquals(null, f.properties.country_code);
            System.assertNotEquals(null, f.properties.lon);
            System.assertNotEquals(null, f.properties.lat);
            System.assertNotEquals(null, f.properties.state_code);
            System.assertNotEquals(null, f.properties.formatted);
            System.assertNotEquals(null, f.properties.address_line1);
            System.assertNotEquals(null, f.properties.address_line2);
            System.assertNotEquals(null, f.properties.result_type);
            System.assertNotEquals(null, f.properties.rank);
            System.assertNotEquals(null, f.properties.rank.importance);
            System.assertNotEquals(null, f.properties.rank.popularity);
            System.assertNotEquals(null, f.properties.rank.confidence);
            System.assertNotEquals(null, f.properties.rank.confidence_city_level);
            System.assertNotEquals(null, f.properties.rank.confidence_street_level);
            System.assertNotEquals(null, f.properties.rank.match_type);
            System.assertNotEquals(null, f.properties.place_id);
            System.assertNotEquals(null, f.geometry);
            System.assertNotEquals(null, f.geometry.type);
            System.assertNotEquals(null, f.geometry.coordinates);
            System.assertNotEquals(null, f.bbox);
        }

        System.assertNotEquals(null, testResponse.query);
        System.assertEquals('', testResponse.query.text);
        System.assertNotEquals(null, testResponse.query.parsed.housenumber);
        System.assertNotEquals(null, testResponse.query.parsed.street);
        System.assertNotEquals(null, testResponse.query.parsed.postcode);
        System.assertNotEquals(null, testResponse.query.parsed.city);
        System.assertNotEquals(null, testResponse.query.parsed.country);
        System.assertNotEquals(null, testResponse.query.parsed.expected_type);
        
        Test.stopTest();
    }
}
