public with sharing class PrdClass {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsDetails(String searchKey ){         
         if(searchKey !=''){
          String key='%'+searchKey+'%';
          List<Product2> pdList =[select id, name ,Price__c, Inventory__c , Remaining_Quantity__c ,
           (select id , ResourceURL__c FROM Product_Images1__r)  FROM Product2];
          system.debug('data'+pdList.size());
          return pdList;
         }
        else {
            return null;
        } 
     }
     @AuraEnabled(cacheable=true)
   public static list<sObject> searchproduct(string searchparam)
   {
    String likeParam = '%' +searchparam+'%';
    String Query = '';
    if(searchparam!=null)
    {
        Query = 'select id , Name , price Remaining_Quantity__c from Product2 where Name Like : Likeparam limit 5';
    }
    else 
    {
        Query = 'select id , Name , price Remaining_Quantity__c from Product2 limit 5';  
    }
    List<sObject> sObjectList = Database.Query(Query);
    return sObjectList;
   }
}