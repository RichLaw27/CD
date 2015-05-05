@isTest 
private class TesteventClass {
    static testMethod void TestEventTrig() {

    Event b = new Event (CurrencyIsoCode='GBP',Description='Test Event ',EndDateTime=system.now(), StartDateTime=system.now()-1, Type='Meeting at Essentra Site' );
    
    System.debug('Price before inserting new book: ' + b.AccountID );

// Insert book
    insert b;

}
}