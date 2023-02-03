public with sharing class Module5 {
@auraEnabled(cacheable=true)

public static List<Account> fetchusers()
{

List<Account> oppList =[SELECT Id, Name,Phone, ShippingAddress, OwnerId, CreatedDate, CreatedById ,
                (select id,LastName,FirstName, MobilePhone from Contacts)FROM Account where  OwnerId =: UserInfo.getUserId()];
      return oppList;
}
}