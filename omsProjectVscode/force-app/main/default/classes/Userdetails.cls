public with sharing class Userdetails {
    @AuraEnabled(cacheable=true)
    public static List<account> fetchusers(){

        List<account>  acc =[SELECT Id, Name,
                    BillingStreet, OwnerId, CreatedDate, 
                    CreatedById ,OWner.name,
                    (select id,LastName, MobilePhone from Contacts)
                    FROM Account 
                   where OwnerId =: UserInfo.getUserId()];
        

      return acc;

 }
}