Public class profile_userdetails {
    @auraEnabled(cacheable=true)
    public static String fetchusers(){
        
    return UserInfo.getName();
  }
 }