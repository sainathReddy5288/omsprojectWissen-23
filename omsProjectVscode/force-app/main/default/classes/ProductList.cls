public class ProductList {
@AuraEnabled(Cacheable=true)
public Static List<Category__c> getCategories()
{
    return [SELECT Id,Name, Sequence__c, Static_URL__c,Category__c FROM Category__c  where Sequence__c !=null  Order By Sequence__c ASC];
}
@AuraEnabled(Cacheable=true)
public Static List<Product2> getProducts(string catId)
{
    set<Id> proIds=new Set<Id>();
 List<Product_Category__c> procategories=[SELECT Id, Name, Category__c, Category__r.Category__c,Product__c
                                          FROM Product_Category__c where  Category__r.Category__c=:catId];
    for(Product_Category__c pc:procategories) 
 {
     proIds.add(pc.Product__c);
     system.debug('proIds'+proIds);
 }
   
   return [SELECT Id, Name, Discount__c, Inventory__c, Price__c,Highlights__c, Remaining_Quantity__c,
           (SELECT Id, Product__c, ResourceURL__c, URL__c, HeroImage__c, Type__c, Resource__c FROM Product_Images1__r  Where ResourceURL__c !=null limit 1) FROM Product2 where Id IN:proIds];
    
}
 
}