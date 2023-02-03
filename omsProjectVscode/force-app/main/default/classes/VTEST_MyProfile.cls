public class VTEST_MyProfile {
    public static List<Account> GetAccountdetails(){
        List<Account> acc=[Select id,Name,(Select Name,Phone,OwnerId From Contacts) From Account where OwnerId=:userinfo.getuserId()];
        return acc;
    }
    public static List<Order__c> GetOrderDetails(){
        List<Order__c> ordrs =[SELECT Id,Delivered_Date__c, Order_Date__c,Total__c,Owner.Name FROM Order__c where OwnerId =: UserInfo.getUserId()];
    return ordrs;
    }
   public static List<Cart__c> GetCartDetails(){
         List<Cart__c> cts =[SELECT  Name,Discounted_Amount__c,Total_Quantity__c  From Cart__c];
        return cts;
    }
/*
    public static List<User> GetCartDetails(){
         List<User> cu=[Select Id,Name,Email from User where Id=:userinfo.getuserId()];
        return cu;
    }
*/
}