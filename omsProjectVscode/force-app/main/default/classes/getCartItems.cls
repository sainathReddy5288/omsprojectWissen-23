public class getCartItems {
	@AuraEnabled(Cacheable=true)
    
    public static list<Cart_Item__c> getCartitemswithDetails(){
        
        return [SELECT Name, Quantity__c,Product__r.Name, Product__r.Price__c, Product__r.Description FROM Cart_Item__c];
    }
}