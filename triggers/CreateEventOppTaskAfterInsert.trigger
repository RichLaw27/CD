trigger CreateEventOppTaskAfterInsert on Opportunity_Task__c (after insert, after update) 
{
    if(Trigger.isInsert){
        for(Opportunity_Task__c opptyTask : Trigger.new){
            if(opptyTask.Assigned_User__c != null) {
            if(opptyTask.Create_Event__c== true ) {

            Task ts= new Task();
            ts.Subject= 'Opportunity Task';//opptyTask.RecordType;
            ts.Ownerid= opptyTask.Assigned_User__c;
            ts.ActivityDate=opptyTask.Date_Required__c;
            ts.Description= opptyTask.Details__c;
            ts.Type= 'Other';
            ts.Whatid=opptyTask.Id;
            insert ts;            
            }
        }
    
    }
}
}