public class ApplyCoupon {
    @AuraEnabled
    public static Decimal applied(string coupcode){
        Decimal discamount ;
   //     Decimal discountingammount ;
        system.debug(coupcode);
        
        string presentusermail = UserInfo.getUserEmail() ;
        string pc = [select id,email from Contact where email =: presentusermail].id;
        list<Cart__c> cartdetail = [select id,Customer__c,Status__c,Total_Amount__c from Cart__c where Customer__c =: pc and Status__c = 'Open'];
        Decimal cartamount = cartdetail[0].Total_Amount__c;
        
        list<Coupon__c> coupname =[select id,Name,Type__c,Flat_Discount__c,Discount__c from Coupon__c where Name=:coupcode];
        if(coupname.size()>0)
        {
            
            string typ = coupname[0].Type__c ;
            if(typ == 'Flat')
            {
                decimal flatdisc = coupname[0].Flat_Discount__c;
             //   discountingammount = flatdisc;
                discamount=cartamount - flatdisc;
                system.debug(discamount);
                cartdetail[0].Discounted_Amount__c = flatdisc;
            update cartdetail;
              //  return new map<string, Decimal>{'Flat'=> discamount};
            }
          //  system.debug(discamount);
            else if(typ == 'Percentage')
            {
                system.debug(coupname[0].Discount__c);
                 decimal flatdisc = coupname[0].Discount__c;
              //  discountingammount = (cartamount * flatdisc)/100 ;
                 discamount=cartamount - (cartamount * flatdisc)/100 ;
                system.debug(discamount);
                cartdetail[0].Discounted_Amount__c = discamount;
            update cartdetail;
            //    return new map<string, Decimal>{'Flat'=> discamount};
            }
            
          //  Cart__c cart = new Cart__c();
            
            
           return(discamount);
        }
        else{
            system.debug('invalid');
             return null;
        }
    }
}