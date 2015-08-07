public with sharing class TestSendMailController {
    private Visit_Report__c currentVisitReport;
    public string emailPlainText{get;set;}
    public TestSendMailController(ApexPages.StandardController controller) {
        currentVisitReport = (Visit_Report__c)controller.getRecord();
    }
    
    public pageReference sendMail(){
        PageReference ref = Page.TestEmailPDF;
        ref.getParameters().put('Id', currentVisitReport.Id);
        Blob b = ref.getContentAsPDF();

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject( 'Test Subject');
        List<String> emailIds = new List<String>();
        emailIds.add('Venkata.reddy@cloudsherpas.com');
        emailIds.add('Venkat2205@gmail.com');
        email.setToAddresses(emailIds);
        email.setTargetObjectId(userInfo.getUserId());
        email.setPlainTextBody(emailPlainText);
        email.saveAsActivity = false;
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName(Visit_Report__c.Id + '.pdf');
        efa1.setBody(b);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        return null;
    }

}