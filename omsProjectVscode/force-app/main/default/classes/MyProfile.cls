public with sharing class MyProfile {
     @auraEnabled(cacheable=true)
     public static List<User> fetchusers(){
        List<User> userLst =[SELECT Id,Name,Phone from User where id =: userInfo.getUserId()]; 
        return userLst;
      }
      @auraEnabled(cacheable=true)
      public static List<Order__c> GetOrderDetails(){
        List<Order__c> ord =[SELECT Name,	Customer__c,Total__c,Delivered_Date__c From Order__c where OwnerId =: UserInfo.getUserId()];
        return ord;
     }
     @AuraEnabled
     public static List<Address_Book__c> getAddressDetails()   
     {
         return [SELECT Id,Name,City__c, Country__c, Postal_Code__c, State__c, Street__c, User__c FROM Address_Book__c	where User__c=:userInfo.getUserId()];   
     }
     @AuraEnabled
     public static string createAddress(Address_Book__c objAdd)   
     {
          objAdd.User__c=userInfo.getUserId();
          string msg;
           try{
             insert objAdd;
             msg=objAdd.Id;
           }
           catch(Exception e)
           {
             msg=e.getMessage();
           }
           return msg;
     }
     
         
              @auraEnabled(cacheable=true)
              public static List<Cart__c> GetCartDetails(){
                List<Cart__c> cts =[SELECT Name,Discounted_Amount__c,Total_Quantity__c From Cart__c where OwnerId =: UserInfo.getUserId()];
                return cts;
             }

             
             }