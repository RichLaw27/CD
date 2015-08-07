public with sharing class accountsAndOpportunitiesController {
    
    public list<userAccount> userAccounts {get;set;}
    public list<Account> accounts {get;set;}
    public Boolean showAccounts {get;set;}
    public Boolean showOpportunities {get;set;}

    public accountsAndOpportunitiesController() {
        showAccounts = false;
        showOpportunities = false;
        map <String, list<Opportunity>> accountswithOppMap = new map <String, list<Opportunity>>();
        map<String, Id> accountIdsMap = new map<String, Id>();
        Id userId = ApexPages.currentPage().getParameters().get('sfdc.userId');
        list<Opportunity> opportunities = [SELECT AccountId, Account.Name, Name, Amount_year_two__c, StageName, Probability, CloseDate FROM Opportunity WHERE OwnerId = :UserId AND IsClosed = false order by Account.Name, Name];
        accounts = [Select Name FROM Account WHERE OwnerId = :UserId order by Name];
        
        if (opportunities.size() > 0) {
            showOpportunities = true;
        }
        
        if (accounts.size() > 0) {
            showAccounts = true;
        }

        for(Opportunity opp :opportunities) {
            list<Opportunity> opps = new list<Opportunity>();
            if(accountswithOppMap.containsKey(opp.Account.Name) == true) opps = accountswithOppMap.get(opp.Account.Name);
            opps.add(opp);
            accountswithOppMap.put(opp.Account.Name, opps);
            accountIdsMap.put(opp.Account.Name, opp.AccountId);
        }
        
        userAccounts = new list<userAccount>();
        
        for(String myAccount :accountswithOppMap.keyset()) {
            userAccount myUserAccount = new userAccount();
            myUserAccount.AccountName = myAccount;
            if(accountIdsMap.containsKey(myAccount) == true)myUserAccount.AccountId = accountIdsMap.get(myAccount);
            myUserAccount.opportunities = new list<Opportunity>();
            if(accountswithOppMap.containsKey(myAccount) == true) myUserAccount.opportunities = accountswithOppMap.get(myAccount);
            userACcounts.add(myUserAccount);
        }
    }
    
    public class userAccount {
        public String AccountName {get;set;}
        public Id AccountId {get;set;}
        public list<Opportunity> opportunities {get;set;}
    }
    
    static testMethod void myTest() {
        
        Profile p = [select id from profile where name='System Administrator'];
        User user = new User(alias = 'standt', email='testuser@clondalkintest.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p.Id,
                timezonesidkey='America/Los_Angeles', username='testuser@clondalkintest.com');
        insert user;
        
        PageReference pageRef = Page.AccountsAndOpportunities;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('sfdc.userId', user.Id);
                
        System.runAs(user) {
            Account account = new Account(Name = 'testAccount');
            insert account;
            
            Opportunity opportunity = new Opportunity(Name = 'test opportunity', StageName = '3 - Commercial Quotation', CloseDate = system.today().addDays(1));
            insert opportunity;
            
            accountsAndOpportunitiesController ctrl = new accountsAndOpportunitiesController();
            system.assertEquals(1, ctrl.userAccounts.size(), 'One record should be returned');
        }
    }
}