public class testapexclass
{

@AuraEnabled
    public static Address_Book__c adddata(string uname)
    {
        list<User> uid=[select id from User where Name=:uname];
      return [select Id,User__c,Name,City__c,Country__c,Land_Mark__c,Postal_Code__c,State__c,Street__c from Address_Book__c where User__c=:uid];
         
    }
}