public class currentUserInfoCtrl {
    @AuraEnabled 
    public static user fetchUser(){
       User u = [select id,Name,MobilePhone,Email,Address from User where id =: userInfo.getUserId()];
        return u;
    }

}