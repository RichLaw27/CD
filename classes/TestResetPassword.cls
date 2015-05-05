@isTest 
private class TestResetPassword  {
    static testMethod void TestResetPassword() 
{
 User  Usr = new User(LastName ='abc',ProfileId='00e20000001G1ChAAK', Email='sampath@kumar.com',MDM_External_Id__c='sampath@kumar.com', UserName ='sampath@kumar.com',Alias ='SampK11',TimeZoneSidKey ='Europe/London', LocaleSidKey ='en_GB'   ,EmailEncodingKey ='ISO-8859-1',   LanguageLocaleKey='en_US');
    insert Usr ;
    Usr.ResetUser__c=901;
Update Usr;
    }
    
}