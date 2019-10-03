public class ANET_TransactionResponse {

	public class Messages {
		public String code;
		public String description;
	}

	public class UserFields {
		public String name;
		public String value;
	}

	public class TransactionResponse {
		public String responseCode;
		public String authCode;
		public String avsResultCode;
		public String cvvResultCode;
		public String cavvResultCode;
		public String transId;
		public String refTransID;
		public String transHash;
		public String accountNumber;
		public String accountType;
		public List<Messages> messages;
		public List<UserFields> userFields;
	}

	public TransactionResponse transactionResponse;
	public String refId;
	public Messages_Z messages;

	public class Message {
		public String code;
		public String text;
	}

	public class Messages_Z {
		public String resultCode;
		public List<Message> message;
	}

	
	public static ANET_TransactionResponse parse(String json) {
		return (ANET_TransactionResponse) System.JSON.deserialize(json, ANET_TransactionResponse.class);
	}
}