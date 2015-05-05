trigger OpportunityTaskAfterInsertUpdate on Opportunity_Task__c (after insert, after update) {

	//This section gives R/O access to person assigned the task
		
	private Map<Id,Id>	teamMap = new	Map<Id,Id>();
	private List<Opportunity_Task__c> 	taskList	=	new List<Opportunity_Task__c>();
	
	if(Trigger.isInsert){
		for(Opportunity_Task__c opptyTask : Trigger.new){
			if(opptyTask.Assigned_User__c != null) {
				taskList.add(opptyTask);
				teamMap.put(opptyTask.Opportunity__c,
							opptyTask.Assigned_User__c);
			}
		}
	}
	else if(Trigger.isUpdate){
				
		for(Opportunity_Task__c opptyTask : Trigger.new){
			
			if(opptyTask.Assigned_User__c != Trigger.oldMap.get(opptyTask.Id).Assigned_User__c) {
				taskList.add(opptyTask);
				teamMap.put(opptyTask.Opportunity__c,
							opptyTask.Assigned_User__c);				
			}
		}						
	}
	
	/*	Uncomment if you want to auto member task assignee
	
	if (teamMap.size() > 0) {
		OpportunityTriggersHandler.addToOpportunityTeam(teamMap);
	}
	
	*/

	/* Uncomment this if you want automatic task creation
		
	if (taskList.size() > 0) {
		OpportunityTriggersHandler.addTaskToOpportunityTask(taskList);
	}
	
	*/
}