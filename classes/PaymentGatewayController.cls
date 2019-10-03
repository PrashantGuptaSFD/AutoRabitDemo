global with sharing class PaymentGatewayController{
    /* 
    public boolean isAuthorizedCard = false;
    global static Map<String,Object> processPayment(Map<String,Object> inputData){
        final string APIkey = customSetting.API_Login__c;
        final string transKey = customSetting.Transaction_Key__c;
        final string Amt = '5';
        final string cardNum = '370000000000002';
        final string expdate = '1220';
        final string cvvCode = '999';
            Map<String,object> responseMap = makePayment(APIkey,transKey,Amt,cardNum,expdate,cvvCode);
            return responseMap;
    }
   
    //Method to make payment and charge the card
    public Map<String,object> makePayment(String APIkey,string transKey,string Amt,string cardNum,string expdate,string cvvCode){
        Map<String,object> responseMap = new Map<String,object>();
        ManageAuthorizePayment manageAuthPayment = new ManageAuthorizePayment();
        //Getting access token from Paypal
        HttpRequest req1 = new HttpRequest();
        req1.setMethod('POST');
        req1.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        req1.setHeader('content-type', 'application/json');
       
        string messageBody1 ='{"createTransactionRequest":{"merchantAuthentication":{"name":"'+APIkey+'","transactionKey":"'+transKey+'"},'
            +'"refId":"123456","transactionRequest":{"transactionType":"authCaptureTransaction","amount":"'+Amt+'","payment":{"creditCard":'
            +'{"cardNumber":"'+cardNum+'","expirationDate":"'+expdate+'","cardCode":"'+cvvCode+'"}},"lineItems":{"lineItem":{"itemId":"1","name":"vase",'
            +'"description":"Cannes logo","quantity":"18","unitPrice":"45.00"}},"tax":{"amount":"4.26","name":"level2 tax name","description":"level2 tax"},'
            +'"duty":{"amount":"8.55","name":"duty name","description":"duty description"},"shipping":{"amount":"4.26","name":"level2 tax name",'+
            '"description":"level2 tax"},"poNumber":"456654","customer":{"id":"99999456654"},"billTo":{"firstName":"Ellen","lastName":"Johnson",'+
            '"company":"Souveniropolis","address":"14 Main Street","city":"Pecan Springs","state":"TX","zip":"44628","country":"USA"},"shipTo":'+
            '{"firstName":"China","lastName":"Bayles","company":"Thyme for Tea","address":"12 Main Street","city":"Pecan Springs","state":"TX","zip":"44628",'+
            '"country":"USA"},"customerIP":"192.168.1.1","transactionSettings":{"setting":{"settingName":"testRequest","settingValue":"false"}},'+
            '"userFields":{"userField":[{"name":"MerchantDefinedFieldName1","value":"MerchantDefinedFieldValue1"},{"name":"favorite_color","value":"blue"}]}}}}';
       
        req1.setHeader('Content-length', String.valueOf(messageBody1.length()));
        req1.setBody(messageBody1);
       
        req1.setTimeout(60*1000);
        Http h1 = new Http();
        String resp1;
        if(!Test.isRunningTest()){
            try{
                HttpResponse res1 = h1.send(req1);    
                resp1 = res1.getBody();
                System.debug('Resposne Error : ' + resp1);
               
                string resp2 = resp1.trim().replace('\uFEFF', '');
                system.debug('resp2'+ resp2);
                manageAuthPayment = (ManageAuthorizePayment)JSON.deserialize(resp2, ManageAuthorizePayment.class);  
            }catch(Exception e){
                System.debug('Exception :- '+e);
            }
        }        
        if(manageAuthPayment != null){
            ccrz__E_StoredPayment__c storedPayment = new ccrz__E_StoredPayment__c();
            storedPayment.ccrz__AccountNumber__c = manageAuthPayment.TransactionResponse.accountNumber;
            storedPayment.ccrz__AccountType__c = manageAuthPayment.TransactionResponse.accountType;
            storedPayment.ccrz__Account__c = manageAuthPayment.TransactionResponse.accountNumber;
        }
        return responseMap;
    } */   
}