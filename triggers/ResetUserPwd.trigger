trigger ResetUserPwd on User (after Update) {
    for (User U:Trigger.new)
    {

        if (U.ResetUser__c == 901 && U.Email==U.UserName)
        {
            System.ResetPassword(u.ID,true);
            User  Usr = new User(ID=U.Id);
            Usr.ResetUser__C=902 ;
            Update Usr;
        }
    }
}