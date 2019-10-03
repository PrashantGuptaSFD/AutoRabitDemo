public class sendEmailTestController {

    @auraEnabled
    public static void sendmail() {
        // Create a master list to store the emails that we will send
        List < List < Messaging.SingleEmailMessage >> masterListMails =
            new List < List < Messaging.SingleEmailMessage >> ();
        for (integer j = 0; j < 10; j++) {
            List < Messaging.SingleEmailMessage > messageList = new List < Messaging.SingleEmailMessage > ();
            for (integer i = 0; i <= 14; i++) {
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = new String[] {
                    'prashantguptasfd+notreal@gmail.com'
                };
                message.subject = 'Opt Out Test Message Message 2';
                message.plainTextBody = 'This is the message body.';

                messageList.add(Message);
            }
            masterListMails.add(messageList);
        }
        for (List < Messaging.SingleEmailMessage > messageList: masterListMails) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messageList);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        }


    }
}