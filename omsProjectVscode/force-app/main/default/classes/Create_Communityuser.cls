public class Create_Communityuser {
    public static void createuser(list<Contact> cn){
        Profile Pf = [SELECT Id FROM Profile WHERE Name='E-Zone Profile' Limit 1];
        List<User> us = new list<User>();
        for(contact c : cn){
            User u = new user();
            u.contactId = c.Id;
            u.LastName = c.LastName;
            u.Email = c.Email;
            u.Alias = c.LastName;
            u.Username = c.Email+System.now().millisecond();
            u.CommunityNickname = c.Title;
            u.LocaleSidKey = 'en_US';
            u.TimeZoneSidKey = 'Asia/Kolkata';
            u.ProfileID = Pf.Id;
            u.LanguageLocaleKey = 'en_US';
            u.EmailEncodingKey = 'UTF-8';
            us.add(u);
        }
        Database.insert(us);
    }
}