public class ReturnOrder {
	@AuraEnabled
    public static List<Order__c> ordStatus()
    {
        string name=userinfo.getUserEmail();
        list<Order__c> odlist = [SELECT Id,Name,Expected_Delivery_Date__c,Total__c,Shipping_Address__c,Status__c,Billing_Address__c FROM Order__c where Customer__r.email=:name];
        list<Order__c> checklist=new list<Order__c>();
        if(odlist!=null)
        {
            for(Order__c c:odlist)
            {
                if(c.Status__c=='Delivered')
                {
                    checklist.add(c);
                }    
            }  
        }
        
        return checklist;    
    }
    @AuraEnabled
    public static list<Order__c>  cancelrecord(Id recorddeleteId)
    {
        list<Order__c> od=[select id,Name,Customer__c,Status__c from Order__c where id=:recorddeleteId];
        for(Order__c o:od){
            o.Status__c='Return requested';
            update o;
        }
        return od;        
    }
    
     @AuraEnabled
    public static void returnOrder(list<Order__c> oldlist ,list<Order__c> newlist ){
        if ((oldlist[0].Status__c != newlist[0].Status__c) && 
            (newlist[0].Status__c =='Return requested')){
            for (Order__c ord : newlist ) {
                string o = ord.Customer__c;
                string emailAddr = [select Email from contact where Id = :o].Email;
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {emailAddr}; 
                    mail.setToAddresses(toAddresses);
                mail.setReplyTo('venkat.goshika@gmail.com');
                mail.setSenderDisplayName('Ezone');
                mail.setSubject('Request to Return the Order is Confirmed');
                mail.setBccSender(false);
                mail.setUseSignature(false);
                mail.setHtmlBody('Here are the details of your Return order' +'</b>  <br/>'+ 
                    			 'Order number <b> ' + ord.Name + '</b>  <br/>' +
                                 'order Amount <b>' +ord.Total__c+  '</b>  <br/>' +
                                 'Expected Pickup Date <b>' +ord.Expected_Pickup_date__c+ '</b>  <br/>' );
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        }
    }
}