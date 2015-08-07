public with sharing class TestEmailPDFController {
    public Visit_Report__c currentVisitReport;
    public TestEmailPDFController(ApexPages.StandardController controller) {
         currentVisitReport = (Visit_Report__c)controller.getRecord();
         if(currentVisitReport!=null){
              currentVisitReport = [Select Id, Email_account_name__c from Visit_Report__c where Id=:currentVisitReport.Id];       
         }
    }

}