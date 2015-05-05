public with sharing class ContactRoles_DiscussionPoints_Ctrler 
{
    private final Trip_Report__c TripRep;
    public List<Trip_Report_Contact_Role__c> TripRepConRoles {get; set;}
    public List<Discussion_Points__c> TripRepPoints{get;set;}
    public List<Call_Report_Opportunity__c> Oppys{get;set;}
    public integer selectConRole {get; set;}
    public integer selectPoint{get; set;}
    
    public ContactRoles_DiscussionPoints_Ctrler (ApexPages.StandardController TripRepCtrler)
    {
        TripRep = (Trip_Report__c)TripRepCtrler.getRecord();
        TripRepConRoles = [SELECT Name, Title__c, Contact__c, Contact__r.Name, Contact_Selection__c, Lead__c, User__c, Contact_Name__c, Contact_Role__c, Primary_Contact__c, No__c FROM Trip_Report_Contact_Role__c WHERE Trip_Report__c = :TripRep.id ORDER BY No__c];
        TripRepPoints = [SELECT Id, Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :TripRep.id ORDER BY No__c];
        Oppys = [SELECT Id, Opportunity__c, Opportunity__r.name, Call_Report__c FROM Call_Report_Opportunity__c WHERE Call_Report__c = :TripRep.id];
    }
    public void ConRoleAddRow()
    {
        decimal no = 0;
        if(TripRepConRoles.size() >= 1)
            no = TripRepConRoles[TripRepConRoles.size()-1].No__c+1;
        Trip_Report_Contact_Role__c newConRole = new Trip_Report_Contact_Role__c(Trip_Report__c = TripRep.id, No__c = no, Contact_Selection__c = 'Contact');
        TripRepConRoles.add(newConRole); 
    }
    public void ConRolesave()
    {
        try
        {
            for(Trip_Report_Contact_Role__c conRole : TripRepConRoles)
            {
                if(conRole.Primary_Contact__c == true && null != conRole.Contact__c)
                {
                    TripRep.Primary_Contact__c = conRole.Contact__c;
                    update TripRep;
                    break;
                }
            }
            upsert TripRepConRoles;
        }
        catch (Exception e)
        {
            system.debug('exception: '+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Following exception occurred: ' + e.getMessage()));
        } 
    }   
    
    public void ConRoleDelete()
    {
        system.debug(TripRepConRoles);
        if(TripRepConRoles.size() == 0)
            return;
        else
        {
            Trip_Report_Contact_Role__c toBeDeleted = null;
            integer i = 0;
            for(Trip_Report_Contact_Role__c tpc : TripRepConRoles)
            {
                if(tpc.No__c == selectConRole)
                {
                    if(tpc.id != null)
                        toBeDeleted = tpc;
                    TripRepConRoles.remove(i); 
                    system.debug(toBeDeleted);                  
                    break;
                }
                i++;
            }
            if(toBeDeleted != null)
            {
                Delete toBeDeleted;
            }
        }
    }
    
    public List <Discussion_Points__c> getNon_Internal_Discussion_Points()
    {
        List <Discussion_Points__c> non_internal = new List <Discussion_Points__c> (); 
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.internal_use_only__c == 'No')
            {
                non_internal.add(dp);
            }
        }
        return non_internal;
    }   
    public List<Discussion_Points__c> getNoCategory()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if((dp.Category__c == '' || dp.Category__c == null) && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getCurrentBusinessReview()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.Category__c == 'Current Business Review' && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getNewBusinessOpportunity()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.Category__c == 'New Business Opportunity' && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getCompetitiveIntelligence()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.Category__c == 'Competitive Intelligence' && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getMiscellaneous()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.Category__c == 'Miscellaneous' && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getActionItem()
    {
        List<Discussion_Points__c> result = new List<Discussion_Points__c>();
        for(Discussion_Points__c dp : TripRepPoints)
        {
            if(dp.Category__c == 'Action Item' && dp.internal_use_only__c == 'No')
            {
                result.add(dp);
            }
        }
        if(result.size() > 0)
            return result;
        else
            return null;
    }
        
    public void PointAddRow()
    {
        decimal no = 0;
        if(TripRepPoints.size() >= 1)
            no = TripRepPoints[TripRepPoints.size()-1].No__c+1;
        Discussion_Points__c newPoint = new Discussion_Points__c(Trip_Report__c = TripRep.id, No__c = no, Responsible_Selection__c = 'User', internal_use_only__c = 'Yes', Name = 'Point ' + (no + 1));
        TripRepPoints.add(newPoint);
        /* return null; */
        this.Pointsave(); 
    }
    public PageReference Pointsave()
    {
        try
        {
            upsert TripRepPoints;
            // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Successfully upserted '+TripRepPoints.size()+' lines.'));
        }
        catch (Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Following exception occurred: ' + e.getMessage()));
        } 
        return null; 
    }   
    
    public PageReference PointDelete()
    {
        system.debug('selectPoint: '+selectPoint+'\n TripReports'+TripRepPoints);
        if(TripRepPoints.size() == 0)
            return null;
        else
        {
            Discussion_Points__c toBeDeleted = null;
            integer i = 0;
            for(Discussion_Points__c tpc : TripRepPoints)
            {
                if(tpc.No__c == selectPoint)
                {
                    if(tpc.id != null)
                        toBeDeleted = tpc;
                    TripRepPoints.remove(i); 
                    system.debug(toBeDeleted);                  
                    break;
                }
                i++;
            }
            if(toBeDeleted != null)
            {
                Delete toBeDeleted;
            }
        }
        return null; 
    }
}