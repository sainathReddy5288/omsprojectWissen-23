public  class addressBook {
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
    
    
}