public class SendMailController {
    
    private Case record;
    public String recordName { get; set; }
    public Id recordId { get; set; }
    public Boolean showContent { get; set; }
    
    public String fromEmail { get; set; }
    public String toEmail { get; set; }
    public String ccEmail { get; set; }
    
    public String subject { get; set; }
    public String body { get; set; }
    
    public void init() {
        recordId = ApexPages.currentPage().getParameters().get('id');
        record = [Select id, CaseNumber, Owner.Email, ContactId, Contact.Email from Case where id =:recordId];
                
        recordName = (String)record.get('CaseNumber');
        fromEmail = [Select email from User where id =: UserInfo.getUserId()].email;
        toEmail = record.Contact.Email;
        ccEmail = record.Owner.Email;
        subject = '';
        body = '';
        showContent = true;
      
            
    }
    
    public void send() {
        if (String.isBlank(subject)) {
            ApexPages.addMessage(new ApexPages.Message(
                    ApexPages.Severity.ERROR, 'Please Fill Email Subject'));
        }

        if (String.isBlank(body)) {
            ApexPages.addMessage(new ApexPages.Message(
                    ApexPages.Severity.ERROR, 'Please Fill Email Body'));
        }       
        if (ApexPages.hasMessages(ApexPages.Severity.ERROR)) {
            return;
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setReplyTo(UserInfo.getUserEmail());
        mail.setSenderDisplayName(UserInfo.getName());
        mail.setSubject(subject);
        mail.setPlainTextBody(body); 
        if (!String.isBlank(toEmail)) {
            mail.setToAddresses(toEmail.split(';'));
        }
        
        if (!String.isBlank(ccEmail)) {
            mail.setCcAddresses(ccEmail.split(';'));
        }
        
        attachPdf(mail);
        
        Task taskObj = new Task();
        taskObj.Subject = subject;
        taskObj.Description = 'TO: '+toEmail+' \r\n'+'CC:'+ccEmail+' \r\n'+ 'Subject: '+subject+' \r\n'+' Body: '+' \r\n \r\n'+body;
        
        taskObj.Status = 'Completed';
        taskObj.Type = 'Send Email';
        taskObj.WhatId = recordId;
        taskObj.WhoId = record.ContactId;
        taskObj.ActivityDate = date.today();
        
        
        if(!test.isRunningTest()){
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { mail });
            
            insert taskObj;
        
        }
        ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.INFO, 'Case PDF has been sent successfully!!..'));
                
        showContent = false;
    }
    
    private void attachPdf(Messaging.SingleEmailMessage mail) {
        Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
        emailAttachment.setBody(generatePdf());
        
        emailAttachment.setFileName(recordName + '.pdf');
        
        mail.setFileAttachments(new List<Messaging.EmailFileAttachment> { emailAttachment });
    }
    
    private Blob generatePdf() {
        PageReference pdfPage = new PageReference('/apex/CaseReportsNew?id='+recordId);
        
        return getContentAsPDF(pdfPage);
    }
    
    public Blob getContentAsPDF(PageReference page) {
        return mock.getContentAsPdfMock(page);
    }
    
    private GetContentMock mock = new DefaultBehaviour();
    
    public void setMock(GetContentMock testMock) {
        mock = testMock;
    }
    public interface GetContentMock {
        Blob getContentAsPdfMock(PageReference page);
    }
    
    private class DefaultBehaviour implements GetContentMock {
        public Blob getContentAsPdfMock(PageReference page) {
            return page.getContentAsPDF();
        }
    }
    
    public class MockBehaviour implements GetContentMock {
        public Blob getContentAsPdfMock(PageReference page) {
            return Blob.valueOf('Mock');
        }
    }

}