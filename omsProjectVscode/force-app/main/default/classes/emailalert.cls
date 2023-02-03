public class emailalert {
    public static void afterinsert(list<Order__c> newrec){  
        for (Order__c ord : newrec) {
            string o = ord.Customer__c;
            string emailAddr = [select Email from contact where Id = :o].Email;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {emailAddr};
                mail.setToAddresses(toAddresses);
            mail.setReplyTo('venkat.goshika@gmail.com');
            mail.setSenderDisplayName('Ezone');
            mail.setSubject('Your Order is placed successfully');
            mail.setBccSender(false);
            mail.setUseSignature(false);
            mail.setHtmlBody('Your Order number <b> ' + ord.Name + '</b>  <br/>' +
                             'order Amount <b>' +ord.Total__c+  '</b>  <br/>' +
                             'shipping Address <b>' +ord.Shipping_Address__c+ '</b>  <br/>' +
                             'Estimated Delivery Date <b>' +ord.Expected_Delivery_Date__c+  '</b>  <br/>' +                          
                             ' View case <a href=https://wissen-be-dev-ed.develop.my.site.com/EZone/survey/runtimeApp.app?invitationId=0Ki2w000000NXPB&surveyName=customer_product_feedback_survey_link&UUID=4c7db96d-8e0c-4dd1-9286-5adf9cfa1dd1>click here</a>');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
        if (newrec[0].Payment_Method__c != 'COD'){
            for (Order__c ord : newrec) {
                string o = ord.Customer__c;
                string emailAddr = [select Email from contact where Id = :o].Email;
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {emailAddr}; 
                    mail.setToAddresses(toAddresses);
                mail.setReplyTo('venkat.goshika@gmail.com');
                mail.setSenderDisplayName('Ezone');
                mail.setSubject('Your Order payment reminder');
                mail.setBccSender(false);
                mail.setUseSignature(false);
                mail.setHtmlBody('Order number <b> ' + ord.Name + '</b>  <br/>' +
                                 'order Amount <b>' +ord.Total__c+  '</b>  <br/>' +
                                 'Payment status is <b> ' + ord.Payment_Method__c + '</b>  <br/>' +
                                 'View case <a href=https://na1.salesforce.com/'+case.Id+'>click here</a>');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        }
    }
    public static void afterupdate(list<Order__c> oldlist ,list<Order__c> newlist ){
        if ((oldlist[0].Status__c != newlist[0].Status__c) && 
            ((newlist[0].Status__c =='In Process')||
             (newlist[0].Status__c =='Shipped')||
             (newlist[0].Status__c =='Cancelled')||
             (newlist[0].Status__c =='Out for Delivery'))){
                 for (Order__c ord : newlist) {
                     string o = ord.Customer__c;
                     string emailAddr = [select Email from contact where Id = :o].Email;
                     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     String[] toAddresses = new String[] {emailAddr}; 
                         mail.setToAddresses(toAddresses);
                     mail.setReplyTo('venkat.goshika@gmail.com');
                     mail.setSenderDisplayName('Ezone');
                     mail.setSubject('Your Order Information');
                     mail.setBccSender(false);
                     mail.setUseSignature(false);
                     mail.setHtmlBody('Order number <b> ' + ord.Name + '</b>  <br/>' +
                                      'Order Amount <b>' +ord.Total__c+  '</b>  <br/>' +
                                      'Payment status is <b> ' + ord.Payment_Status__c + '</b>  <br/>' +
                                      'Order has been <b> ' + ord.Status__c + '</b>  <br/>' +
                                      'Shipping Address <b>' +ord.Shipping_Address__c+ '</b>  <br/>' +
                                      'Estimated Delivery Date <b>' +ord.Expected_Delivery_Date__c+  '</b>  <br/>' +                          
                                      ' View case <a href=https://wissen-be-dev-ed.develop.my.site.com/EZone/survey/runtimeApp.app?invitationId=0Ki2w000000NXPB&surveyName=customer_product_feedback_survey_link&UUID=4c7db96d-8e0c-4dd1-9286-5adf9cfa1dd1>click here</a>');
                     
                     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }
             }
    }
}