@IsTest
global class FND_AddressAPIHttpCalloutMock implements HttpCalloutMock {
    private static final String addressValidationMockFileName = 'FND_AddressAPIMockResponse';

    global HttpResponse respond(HttpRequest request) {
        List<StaticResource> mockResources = [SELECT Body FROM StaticResource WHERE Name = :addressValidationMockFileName];
        
        String responseBody;

        if(!mockResources.isEmpty()) {
            responseBody = mockResources.get(0).Body.toString();
        } 

        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(responseBody);
        response.setStatusCode(200);
        
        return response;
    }
}
