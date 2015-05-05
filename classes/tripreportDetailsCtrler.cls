public class tripreportDetailsCtrler 
{
    public Id tripReportId {get;set;}
    private List<Trip_Report__c> TripRep;
    private List<Trip_Report_Contact_Role__c> TripRepConRoles ;
    private List<Discussion_Points__c> TripRepPoints;
    private List<Call_Report_Opportunity__c> TripRepOppys;
    
    public tripreportDetailsCtrler ()
    {
        TripRep = new List<Trip_Report__c> ();
        TripRepConRoles = new List<Trip_Report_Contact_Role__c>();
        TripRepPoints = new List<Discussion_Points__c>();
        TripRepOppys = new List<Call_Report_Opportunity__c>();
        system.debug('\n'+tripReportId+'\n');
    }
    
    public Trip_Report__c getTripRep()
    {
        TripRep = [SELECT Name , Customer_name__c, leadname__c, Contact_Type__c, Location__c, Location_Details__c, Account__r.name, Opportunity__r.name, Visit_Date__c, Next_Meeting__c, Executive_Summary__c, Introduction__c FROM Trip_Report__c WHERE Id = :tripReportId LIMIT 1];
        if(TripRep.size() > 0)
            return TripRep[0];
        else
            return null;            
    }
    
    public List<Call_Report_Opportunity__c> getTripRepOppys()
    {
        TripRepOppys = [SELECT Id, Opportunity__c, Opportunity__r.name, Call_Report__c FROM Call_Report_Opportunity__c WHERE Call_Report__c = :tripReportId];
        return TripRepOppys;
    }
    
    public List<Trip_Report_Contact_Role__c> getTripRepConRoles()
    {
        TripRepConRoles = [SELECT Name, Title__c, Contact__c, Contact__r.Name, Contact_Selection__c, Lead__c, User__c, Contact_Name__c, Contact_Role__c, Primary_Contact__c, No__c FROM Trip_Report_Contact_Role__c WHERE Trip_Report__c = :tripReportId ORDER BY No__c];
        return TripRepConRoles;
    }
    public List<Discussion_Points__c> getTripRepPoints()
    {
        TripRepPoints = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId ORDER BY No__c];
        return TripRepPoints;
    }
    public List <Discussion_Points__c> getCurrentBusinessReview()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = 'Current Business Review' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;
    }

    public List <Discussion_Points__c> getNewBusinessOpportunity()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = 'New Business Opportunity' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;

    }

    public List <Discussion_Points__c> getCompetitiveIntelligence()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = 'Competitive Intelligence' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;
    }

    public List <Discussion_Points__c> getMiscellaneous()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = 'Miscellaneous' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;
    }

    public List <Discussion_Points__c> getActionItem()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = 'Action Item' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    public List <Discussion_Points__c> getNoCategory()
    {
        List<Discussion_Points__c> result = [SELECT Due_Date__c, Opportunity__c, Opportunity__r.name, Lead__c, Internal_use_only__c, No__c, Category__c, Responsible_contact__r.Name, Responsible_contact__c, Responsible_company__c, Responsible_selection__c, Responsible_user__r.Name, Responsible_user__c, Subject__c, internal_use__c, Summary__c, Trip_Report__c, Name FROM Discussion_Points__c WHERE Trip_Report__c = :tripReportId AND Category__c = '' AND internal_use_only__c = 'No' ORDER BY No__c];       
        if(result.size() > 0)
            return result;
        else
            return null;
    }
    
}