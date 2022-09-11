@IsTest
private class FND_AddresValidatorCtrlTest {
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

        Test.startTest();

        Boolean addressValidated = FND_AddresValidatorCtrl.validateAddressWithAPI(c.Id, request);

        Test.stopTest();
    }
}
