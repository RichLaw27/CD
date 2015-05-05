trigger Points_BI_BU on Discussion_Points__c (before insert, before update) 
{
    List<ID> CallRepIDs = new List<ID>();
    List <Call_Report_Opportunity__c> CallReportsOpportunity = new List <Call_Report_Opportunity__c> ();
    List <Call_Report_Opportunity__c> newCROs = new List <Call_Report_Opportunity__c> ();
    
    for(Discussion_Points__c dp : trigger.new)
    {
    	CallRepIDs.add(dp.Trip_Report__c);
    }
    
    CallReportsOpportunity = [SELECT Call_Report__c, Opportunity__c FROM Call_Report_Opportunity__c WHERE Call_Report__c IN :CallRepIDs];
    
    for(Discussion_Points__c dp : trigger.new)
    {
    	if(dp.Opportunity__c != null)
    	{
	    	boolean entryExists = false;
	    	for(Call_Report_Opportunity__c cro : CallReportsOpportunity)
	    	{
	    		if(cro.Opportunity__c == dp.Opportunity__c && cro.Call_Report__c == dp.Trip_Report__c)
	    		{
	    			/* system.debug('Opportunity: '+cro.Opportunity__c +'=='+ dp.Opportunity__c);
	    			system.debug('Call Report: '+cro.Call_Report__c +'=='+ dp.Trip_Report__c);
	    			system.debug('Entry exists'); */
	    			entryExists = true;
	    			break;
	    		}
	    	}
	    	if(entryExists == false)
		    {
		    	// system.debug('New Call Report <-> Opportunity');
		    	Call_Report_Opportunity__c newCRO = new Call_Report_Opportunity__c();
		    	newCRO.Call_Report__c = dp.Trip_Report__c;
		    	newCRO.Opportunity__c = dp.Opportunity__c;
		    	CallReportsOpportunity.add(newCRO);
	    	}	    	
    	}
    }
    if(CallReportsOpportunity.size() > 0)
    {
    	upsert CallReportsOpportunity;
    } 
}