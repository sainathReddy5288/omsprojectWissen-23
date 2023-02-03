public class task15 {
    @AuraEnabled
    public static List<Order__c> fetchorder(){
       string name=userinfo.getUserEmail();
        list<Order__c> odlist = [SELECT Id,Name,Customer__c,Total_Items__c,Expected_Delivery_Date__c,Total__c,Shipping_Address__c,Billing_Address__c FROM Order__c  where Customer__r.email=:name];
        return odlist; 
    } 
    @AuraEnabled
    public static List<Order_Line_Item__c> statuscheck()
    {
        string name=userinfo.getUserEmail();
      // list<Order__c> odlist = [SELECT Id,Name,Expected_Delivery_Date__c,Total__c,Shipping_Address__c,Status__c,Billing_Address__c FROM Order__c where Customer__r.email=:name];
        list<Order_Line_Item__c> lineitem=new list<Order_Line_Item__c>();
        list<Order_Line_Item__c> lineitems=[select id,name,Order__r.status__c,Order__r.Name,Product__r.Name,Total__c from Order_Line_Item__c where (Order__r.status__c='open' or Order__r.status__c='in process')];
        if(lineitems!=null)
        {
           for(Order_Line_Item__c c:lineitems)
           {
                lineitem.add(c);
               
           }
                    
            }           
        return lineitem; 
        
    }
    @AuraEnabled
    public static list<Order_Line_Item__c>  deleterecord(Id recorddeleteId)
    {
        list<Order_Line_Item__c> od=[select id,Name from Order_Line_Item__c where id=:recorddeleteId];
        for(Order_Line_Item__c o:od){
            delete o;
        }
        return od;        
    }
    @AuraEnabled
    public static list<Order__c>  updaterecord(Id reorderid)
    {
        list<Order__c> odd=[select id,Name,Customer__c,Status__c from Order__c where id=:reorderid];
        for(Order__c order:odd){
            order.Status__c='Open';
            update order;
        }
        return odd;        
    }
}