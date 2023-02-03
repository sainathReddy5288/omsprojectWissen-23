public class task13 
{
@AuraEnabled
    public static  list<Address_Book__c> adddata(string uname)
    {
        list<User> uid=[select id from User where Name=:uname];
      list<Address_Book__c> addlist= [select Id,User__c,Name,City__c,Country__c,Land_Mark__c,Postal_Code__c,State__c,Street__c from Address_Book__c where User__c=:uid];
        return addlist;
    }
}