public with sharing class test {
    @AuraEnabled(cacheable=true)
    public static User getUserDetails(String recId) {
        return  [Select Id , Name ,Email,Phone,Address from User where Id =:recId];

    }
}