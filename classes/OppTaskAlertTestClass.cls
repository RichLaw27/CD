@isTest (SeeAlldata=true)
private class OppTaskAlertTestClass {

    static testMethod void TestOpptaskAlertTrig() {

Opportunity_Task__c b = new Opportunity_Task__c (Opportunity__c='0062000000Tty8xAAB',
RecordTypeId='01220000000UajYAAS',
Assigned_User__c='00520000003ApDiAAK' ,Date_Required__c=System.Today(),   Create_Event__c=TRUE);
    System.debug('Price before inserting new book: ' );
// Insert book
    insert b;

}
}