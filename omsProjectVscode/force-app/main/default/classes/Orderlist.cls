public class Orderlist 
{
/*@AuraEnabled
    public static list<Order__c> fetchorderrecords() {
    string name=UserInfo.getUserEmail();
    system.debug(name);
        list<Order__c> odlist=[select id,Name from Order__c where Customer__r.email=:name];
        system.debug(odlist);
    return(odlist);
  }
}*/
@AuraEnabled

public static List<Order__c> getOrders()

{

return [SELECT Id,Name,Delivered_Date__c,Total__c FROM Order__c];

}

// This method used for reterived  the list of orders records based on the search string

@AuraEnabled

public static List<Order__c> getByName(Date searchKey) {

String name = '%' + searchKey + '%';
//date dt=Order_Date__c.date();
system.debug('jn');
    system.debug([SELECT Id,Name,Delivered_Date__c,Total__c FROM Order__c WHERE Order_Date__c=:searchKey]);
return [SELECT Id,Name,Delivered_Date__c,Total__c FROM Order__c WHERE Order_Date__c =:searchKey];

}
}