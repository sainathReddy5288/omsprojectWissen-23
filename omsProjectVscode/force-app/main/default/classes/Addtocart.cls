public class Addtocart {
   //Add to cart button 
   @AuraEnabled(cacheable=true)
    public static void addtocartmeth1(id productid, integer items){
        system.debug(productid);
        string presentusermail = UserInfo.getUserEmail() ;
        string pc = [select id,email from Contact where email =: presentusermail].id;
        system.debug(pc);
        list<Cart__c> cartdetail = [select id,Customer__c,Status__c from Cart__c where Customer__c =: pc and Status__c = 'Open'];
        
        list<Cart_Item__c> proid = [select id,Product__c from Cart_Item__c where Product__c =: productid ];
        
        system.debug(cartdetail);
        if(cartdetail.size()>0) {
            
            if(proid.size()>0){
                list<Cart_Item__c> cartup = [select id,Product__c,Quantity__c from Cart_Item__c where id =: proid[0].id];
                cartup[0].Quantity__c = cartup[0].Quantity__c+items;
                update cartup;
            }
            else{
                // system.debug(cartdetail[0].id);
                Cart_Item__c cartitem= new Cart_Item__c();
                cartitem.Cart_Id__c= cartdetail[0].id;
                cartitem.Product__c= productid;
                decimal proprice = [select id,Price__c from Product2 where id =: productid].Price__c;
                cartitem.Quantity__c= items;
                cartitem.Amount__c= proprice;
                cartitem.Unit_Price__c= proprice;
                insert cartitem;
            } 
        }
        else{
            Cart__c cart= new Cart__c();
            cart.Customer__c =pc;
            cart.Status__c = 'Open';
            insert cart;
            
            Cart_Item__c cartitem= new Cart_Item__c();
            cartitem.Cart_Id__c= cart.id;
            cartitem.Product__c= productid;
            decimal proprice = [select id,Price__c from Product2 where id =: productid].Price__c;
            cartitem.Quantity__c= items;
            cartitem.Amount__c= proprice;
            cartitem.Unit_Price__c= proprice;
            insert cartitem;   
        }  
    }
}