public class offeralert {
    public static void offermail(list<Product_Offer__c> newrec){
        
      //   list<Profile> ezoneid = [Select Id from Profile where name = 'E-Zone Profile'];
            // 00e2w000000jEQeAAM is E-Zone Profile ID  
        
        list<user> pr =[Select id,email from user where Profile.name = 'E-Zone Profile' ];
        list<string> emails = new list<string>();
        for(user u : pr)
        {
            emails.add(u.email);
        }
        
        for (Product_Offer__c pro : newrec) {
            string productid =   pro.Product__c;
            string productname = [select id,Name from Product2 where id =: productid].Name;
            
            string po = [select id,URL__c,Resource__c,ResourceURL__c from Product_Image__c where Product__c =: productid][0].URL__c;
            
            // list<Profile> ezoneid = [Select Id from Profile where name = 'E-Zone Profile'];
            // 00e2w000000jEQeAAM is E-Zone Profile ID  
            
            
            for(Integer i=0; i<emails.size();i++ )
            {
                If(emails[i]!=null)
                {
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    
                    //    String[] toAddresses = new String[] {emailAddr};
                    mail.setToAddresses(new list<string>{emails[i]});
                    mail.setReplyTo('support@acme.com');
                    mail.setSenderDisplayName('Salesforce Support');
                    mail.setSubject('Your Order is successfully placed' );
                    mail.setBccSender(false);
                    mail.setUseSignature(false);
                    
                    mail.setHtmlBody('Hello sir/Mam  <br/>' +
                                     'we are excited to inform you that there is a sale live going on ' +
                                     '<img style="max-width: 500px; height: 100px" src=' + po + ' alt="Not Available"/><br></br>'+
                                     'Product Name <b> ' + productname + '</b>  <br/>' +  
                                     ' View Product <a href=https://na1.salesforce.com/'+case.Id+'><button type="button"; style = "background-color:blue; color:white">Hit here</button></a>');
                    
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    
                }            
            }
            
        }
    }
}