//Test Class : ApiCallLightningComponentTest
public with sharing class ApiCallLightningComponent {

    public static String fetchUserSessionId(){
        String sessionId = '';
        // Refer to the Page
        PageReference reportPage = Page.GetSessionIdVF;
        // Get the content of the VF page
        String vfContent = (!Test.isRunningTest()) ? reportPage.getContent().toString() : 'Start_Of_Session_Id'+Userinfo.getSessionId()+'End_Of_Session_Id';
        // Find the position of Start_Of_Session_Id and End_Of_Session_Id
        Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
        endP = vfContent.indexOf('End_Of_Session_Id');
        // Get the Session Id
        sessionId = vfContent.substring(startP, endP);
        // Return Session Id
        return sessionId;
    }

    @AuraEnabled
    public static String makeAPICall(String apiVer, String restMethod, String accessToken){

        String sessionId = !String.isEmpty(accessToken) ? accessToken : fetchUserSessionId();
        String endpoint = URL.getSalesforceBaseUrl().toExternalForm();
        endpoint += '/services/data/'+apiVer;
        endpoint += restMethod;
        EncodingUtil.urlEncode(endpoint,'UTF-8');
        
        //HTTP Request send
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        return '{\"SessionId\":\"'+ sessionId + '\", \"ResponseBody\":' + res.getBody() +'}';
    
    }

}