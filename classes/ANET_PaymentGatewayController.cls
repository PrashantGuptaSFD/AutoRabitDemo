public class ANET_PaymentGatewayController {
	
    private static string APIkey = '47vB3pRQ';
    private static string transKey = '3yX899Wc57yPCEuN';
    private string Amt = '5';
    @auraEnabled
    public static List<ProductWrapper> getproducts(){
        List<ProductWrapper> proWrapList = new List<ProductWrapper>();
        for(product2 product :[SELECT ID,(SELECT id, UnitPrice FROM PricebookEntries), Name,Family, Description FROM Product2 LIMIT 50] ){
            if(product.PricebookEntries!=null && !product.PricebookEntries.isEmpty())
            	proWrapList.add(new ProductWrapper(product,product.PricebookEntries[0].UnitPrice));
        }
        system.debug('>>' +proWrapList );
        return proWrapList;
    }
    @auraEnabled
    public static boolean authorizeCard(String cardHolderName, String cardNumber, String expiry, String cvv, String totalPrice, List<ProductWrapper> listItem){
    	ANET_TransactionRequest.MerchantAuthentication authentication = new ANET_TransactionRequest.MerchantAuthentication();
        authentication.name = APIkey;
        authentication.transactionKey = transKey;
        ANET_TransactionRequest.Payment pay = new ANET_TransactionRequest.Payment();
        pay.creditCard.cardNumber = cardNumber;
        pay.creditCard.expirationDate = cardNumber;
        pay.creditCard.cardCode = cvv;
        
        ANET_TransactionRequest requestBody = new ANET_TransactionRequest();    
        requestBody.CreateTransactionRequest.transactionRequest.payment= pay;   
        requestBody.CreateTransactionRequest.transactionRequest.transactionType= 'authCaptureTransaction'; 
        requestBody.CreateTransactionRequest.transactionRequest.amount = '12345';
        requestBody.CreateTransactionRequest.merchantAuthentication = authentication;        
        requestBody.CreateTransactionRequest.refId = '12345';  
        system.debug('requestBody' +requestBody);
        makeAuthorizeCardRequest(requestBody);
        return true;
    }
    
    //Method to authorize the card to make the payment later
    public Static void makeAuthorizeCardRequest(ANET_TransactionRequest request){
        HttpRequest authorizeRequest = new HttpRequest();
        authorizeRequest.setMethod('POST');
        authorizeRequest.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        authorizeRequest.setHeader('content-type', 'application/json');
        system.debug('request' +request);
        string requestBody =JSON.Serialize(request,true) ;
        
        	system.debug('requestBody'+requestBody);
        authorizeRequest.setHeader('Content-length', String.valueOf(requestBody.length()));
        authorizeRequest.setBody(requestBody);
        
        authorizeRequest.setTimeout(60*1000);
        Http protocol = new Http();
        String resp1;
        HttpResponse apiResponse = protocol.send(authorizeRequest);
        resp1 = apiResponse.getBody();
        Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(apiResponse.getBody().substring(1,apiResponse.getBody().length())) ;
        for(string keyStr : responseMap.keyset())
        	system.debug('Response'+responseMap.get(keyStr));      
    }
    
    public class ProductWrapper{
        @AuraEnabled public Boolean isSelected = False;
        @AuraEnabled public String Name = '';
        @AuraEnabled public String Family = '';
        @AuraEnabled public String Description = '';
        @AuraEnabled public Product2 product = null;
        @AuraEnabled public Decimal Price = 0;
        public ProductWrapper(Product2 pro, Decimal pri){
            this.price = pri;
            this.product = pro;
            Name = pro.Name;
            Family = pro.Family;
            Description = pro.Description;
        }
    }
}