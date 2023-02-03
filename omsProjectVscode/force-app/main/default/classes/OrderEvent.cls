public with sharing class OrderEvent {
    
   //private static final String In_Process = 'In Process';
  private List<OrderEvent__e> orderEventList; 
    //Order Event List
    //onAfterUpdate
    
    public void onAfterInsert(List<Order__c> pNewOrders){
       // system.debug('seshi');
       List<OrderEvent__e> orderEventList = new List<OrderEvent__e>();
        for (Order__c newOrder :pNewOrders){
            //Raise events for Ready to Ship orders only 
          //  if(newOrder.Status__c.equalsIgnoreCase(In_Process)){
            
            orderEventList.add(
                new OrderEvent__e( 
                    Order_no__c = newOrder.Name,
                    Account_id__c = newOrder.Account_Name__c,
                    Contact_id__c = newOrder.Customer__c,
                    Total_amount__c = newOrder.Total__c,
                    Total_quantity__c = newOrder.Total_Items__c,
                    Billing_address__c = newOrder.Billing_Address__c,
                    Shipping_address__c = newOrder.Shipping_address__c,
                    Order_status__c=newOrder.Status__c
                )
            );
        }
       // }
        if(!orderEventList.isEmpty()){
            //Publish Event
            List<Database.SaveResult> eventPubResultList = EventBus.publish(orderEventList);
            //Check published event status 
            for(Database.SaveResult eventPubResult :eventPubResultList){
                if(eventPubResult.isSuccess()){                   
                    
                    System.debug('***Events published successfully >'+ eventPubResult);
                }
                else{
                    for (Database.Error pubError: eventPubResult.getErrors()){
                        System.debug('***Event publishing failed- '
                                     + pubError.getStatusCode()
                                     +'-' + pubError.getMessage()
                                    );
                    }
                }
            }
        }
    }
    
     public void onAfterUpdate(list<Order__c> pNewOrders ,list<Order__c> newlist ){
          List<Order_update__e> orderEventList = new List<Order_update__e>();
         if ((pNewOrders[0].Status__c != newlist[0].Status__c)){
        for (Order__c newOrder :pNewOrders){
            
            orderEventList.add(
                new Order_update__e( 
                    Order__c = newOrder.Name,
                    Order_Amount__c = newOrder.Total__c,
                    Order_status__c=newOrder.Status__c
                )
            );
        }
        }
        if(!orderEventList.isEmpty()){
            //Publish Event
            List<Database.SaveResult> eventPubResultList = EventBus.publish(orderEventList);
            //Check published event status 
            for(Database.SaveResult eventPubResult :eventPubResultList){
                if(eventPubResult.isSuccess()){                   
                    
                    System.debug('***Events Updated successfully >'+ eventPubResult);
                }
                else{
                    for (Database.Error pubError: eventPubResult.getErrors()){
                        System.debug('***Event publishing failed- '
                                     + pubError.getStatusCode()
                                     +'-' + pubError.getMessage()
                                    );
                    }
                }
            }
        }
    }
}