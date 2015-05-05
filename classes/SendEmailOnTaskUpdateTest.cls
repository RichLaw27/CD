@istest (seealldata=true)
private class SendEmailOnTaskUpdateTest {
static testMethod void testSendEmailOnTaskUpdate() {
     
     Task taskObj = new task();
     taskObj.OwnerId = userinfo.getuserId();
     taskobj.Assigned_By__c = userinfo.getuserId();
     taskobj.Subject = 'Call';
     taskobj.Status = 'In Progress';
     taskobj.Description = 'Testing';
     taskobj.Priority = 'Normal';
     taskobj.Type = 'Call';
     insert taskObj;
       
  }
  }