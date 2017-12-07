@isTest
global class ExchangeRateMockTest  implements HttpCalloutMock{

    private String mockBody;
    private Integer mockStatus;
  
    global ExchangeRateMockTest(String body, Integer code) {
        this.mockBody = body;
        this.mockStatus = code;
    }
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(mockStatus);
        res.setBody(mockBody);
        return res;
    }
}