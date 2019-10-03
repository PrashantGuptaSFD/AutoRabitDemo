public class ANET_TransactionRequest {

	//Variable
	public CreateTransactionRequest createTransactionRequest;
    
    //Constructor    
    public ANET_TransactionRequest(){
        createTransactionRequest = new CreateTransactionRequest();
    }
    
    public class LineItem {
		public String itemId;
		public String name;
		public String description;
		public String quantity;
		public String unitPrice;
	}
    
	public class LineItems {
		public LineItem lineItem;
        public LineItems(){
            LineItem lineItem = new LineItem();
        }
	}

	public class UserFields {
		public List<UserField> userField;
        public UserFields(){
            userField = new List<UserField>();
        }
	}

	public class Customer {
		public String id;
	}

	public class UserField {
		public String name;
		public String value;
	}

	public class Tax {
		public String amount;
		public String name;
		public String description;
	}

	public class CreditCard {
		public String cardNumber;
		public String expirationDate;
		public String cardCode;
	}

	public class TransactionRequest {
		public String transactionType;
		public String amount;
		public Payment payment;
		public List<LineItems> lineItems;
		public Tax tax;
		public Tax duty;
		public Tax shipping;
		public String poNumber;
		public Customer customer;
		public BillTo billTo;
		public BillTo shipTo;
		public String customerIP;
		public UserFields userFields;
        public TransactionRequest(){
            lineItems = new List<LineItems>();
            customer = new Customer();
            userFields = new UserFields();
            tax = new Tax();
            duty = new Tax();
            shipping = new Tax();
            BillTo = new BillTo();
            shipTo = new BillTo();
        }
	}
	public class MerchantAuthentication {
		public String name;
		public String transactionKey;
	}
	public class CreateTransactionRequest {
		public TransactionRequest transactionRequest;
		public MerchantAuthentication merchantAuthentication;
		public String refId;
        public CreateTransactionRequest(){
            merchantAuthentication = new MerchantAuthentication();
            transactionRequest = new TransactionRequest();
        }
	}

	public class Payment {
		public CreditCard creditCard;
        public Payment(){
            creditCard = new CreditCard();
        }
	}

	public class BillTo {
		public String firstName;
		public String lastName;
		public String company;
		public String address;
		public String city;
		public String state;
		public String zip;
		public String country;
	}

	
	public static ANET_TransactionRequest parse(String json) {
		return (ANET_TransactionRequest) System.JSON.deserialize(json, ANET_TransactionRequest.class);
	}
}