trigger SendEmailOnTaskUpdate on Task (after insert, after update) {
    //Set<Id> ownerIds = new Set<Id>();
    set<Id> taskIdSet = new set<Id>();
    for(Task tsk: Trigger.New){
        //ownerIds.add(tsk.ownerId);
       if(trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(tsk.id).Status != tsk.Status) || (trigger.isUpdate && trigger.oldMap.get(tsk.id).Description != tsk.Description))
                taskIdSet.add(tsk.id);
    }
    if(taskIdSet.size() > 0){
        map<id,Task> taskMap = new map<id, Task>([select id, owner.Name,owner.Email, Assigned_By__r.Email, What.Email from task where id =: taskIdSet]);
        id templateId = [select id, name from EmailTemplate where developername = : 'Task_Update_Notification_VF'].id;
            
        //Map<Id, User> userMap = new Map<Id,User>([select Name, Email from User where Id in :ownerIds]);
        for(Task tsk : Trigger.New){
            //User theUser = userMap.get(tsk.ownerId);
            if(taskMap.get(tsk.id) != null){
                Task taskObj = taskMap.get(tsk.id);
               // if(taskObj.owner.Email!=null || taskObj.owner.Email.trim()!=''  )
              //  { 
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                //String[] toAddresses = new String[] {taskObj.owner.Email};
                List<String> toAdd = new List<String>();
                toAdd.add(taskObj.owner.Email);
                system.debug(taskObj.owner.Email+'....taskObj.owner.Email.....'+toAdd);
                mail.setToAddresses(toAdd);
               // if(taskObj.Assigned_By__r.Email!=null || taskObj.Assigned_By__r.Email.trim()!='')
               //{
                String[] ccAddresses = new String[] {taskObj.Assigned_By__r.Email};
                mail.setCcAddresses(ccAddresses);
              // }
                /*
                mail.setSubject('A task owned by you has been updated');
                
                String template = 'Hello {0}, \nYour task has been modified. Here are the details - \n\n';
                template+= 'Subject - {1}\n';
                template+= 'Due Date - {2}\n';
                template+= 'My Test Field - {3}\n';
                String duedate = '';
                if (tsk.ActivityDate==null)
                    duedate = '';
                else
                    duedate = tsk.ActivityDate.format();
                List<String> args = new List<String>();
                args.add(taskObj.owner.Name);
                args.add(tsk.Subject);
                args.add(duedate);
                //args.add(tsk.MyTestField__c);
               
                // Here's the String.format() call.
                String formattedHtml = String.format(template, args);
                */
                mail.setTargetObjectId(tsk.OwnerId);
                mail.setSaveAsActivity(false);
                //mail.setWhatId(tsk.whatId);
                mail.setTemplateId(templateId);
                mail.setwhatId(Tsk.Id);
                
                //mail.setPlainTextBody(formattedHtml);
                if(!test.isRunningTest())
                Messaging.SendEmail(new Messaging.SingleEmailMessage[] {mail});
                }
            }
        }
    }