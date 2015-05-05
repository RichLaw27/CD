// keep trip reports, contact roles and discussion points attached to Account, Contact and Opportunity after Lead conversion

trigger Leads_AU on Lead (after update) 
{
	List<ID> LeadIDs = new List <Id>();
	
	List<Trip_Report__c> Trip_Reports = new List<Trip_Report__c> ();
	List<Trip_Report__c> Trip_Reports_to_Update = new List<Trip_Report__c> ();
	
	List<Trip_Report_Contact_Role__c> Trip_Report_Contact_Roles = new List<Trip_Report_Contact_Role__c> ();
	List<Trip_Report_Contact_Role__c> Trip_Report_Contact_Roles_to_Update = new List<Trip_Report_Contact_Role__c> ();
	
	List<Discussion_Points__c> Discussion_Points = new List<Discussion_Points__c> ();
	List<Discussion_Points__c> Discussion_Points_to_Update = new List<Discussion_Points__c> ();
	
	for(Lead l: trigger.new)
	{
		LeadIDs.add(l.Id);
	}
	
	Trip_Reports = [SELECT id, RecordtypeId, Lead__c, Account__c, Opportunity__c FROM Trip_Report__c WHERE Lead__c IN :LeadIDs];
	Trip_Report_Contact_Roles = [SELECT id, Contact_Selection__c, Contact__c, Lead__c FROM Trip_Report_Contact_Role__c WHERE Lead__c IN :LeadIDs];
	Discussion_Points = [SELECT id, Responsible_selection__c, Responsible_contact__c, Lead__c FROM Discussion_Points__c WHERE Lead__c IN :LeadIDs];
	
	for(Lead l: Trigger.new)
	{
		if(l.IsConverted == true)
		{
			// Trip Reports assigned to this lead
			for(Trip_Report__c tr : Trip_Reports)
			{
				if(tr.Lead__c == l.Id)
				{
					tr.Lead__c = null;
					tr.Account__c = l.ConvertedAccountId;
					if(l.ConvertedOpportunityId != null)
					{
						tr.Opportunity__c = l.ConvertedOpportunityId;
					}													
					Trip_Reports_to_Update.add(tr);
				}
			} // end trip reports
			
			// Trip Report contact Roles assigned to this lead
			for(Trip_Report_Contact_Role__c tcr : Trip_Report_Contact_Roles)
			{
				if(tcr.Lead__c == l.id)
				{
					tcr.Lead__c = null;
					tcr.Contact__c = l.ConvertedContactId;
					tcr.Contact_Selection__c = 'Contact';
					Trip_Report_Contact_Roles_to_Update.add(tcr);
				}
			}// end contact roles
			
			// Discussion Points assigned to this lead
			for(Discussion_Points__c dp : Discussion_Points)
			{
				if(dp.Lead__c == l.id)
				{
					dp.Lead__c = null;
					dp.Responsible_contact__c = l.ConvertedContactId;
					dp.Responsible_selection__c = 'Contact';
					Discussion_Points_to_Update.add(dp);
				}
			}
		}
	}
	if(Trip_Reports_to_Update.size() > 0)
	{
		update Trip_Reports_to_Update;
	}
	if(Trip_Report_Contact_Roles_to_Update.size() > 0)
	{
		update Trip_Report_Contact_Roles_to_Update;
	}
	if (Discussion_Points_to_Update.size() >0)
	{
		update Discussion_Points_to_Update;
	}
	
}