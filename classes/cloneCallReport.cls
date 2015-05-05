public with sharing class cloneCallReport
{
    // variable to hold current record
    Trip_report__c currentRecord;
    
    // standard contructor
    public cloneCallReport(ApexPages.StandardController controller)
    {
        currentRecord = (Trip_report__c)controller.getRecord();
    }
    
    public PageReference cloneRecord()
    {
        //Variable to hold the new record
        Trip_report__c newRecord;
        Savepoint sp = Database.setSavepoint();
        try
        {
            currentRecord = [Select id, name, Visit_Date__c, Next_Meeting__c, Location_Details__c, Account__c, Base_Call_Report__c, Primary_Contact__c, Lead__c, Opportunity__c, Contact_Type__c, Location__c, Executive_Summary__c, Introduction__c, RecordTypeId from Trip_report__c where id =:currentRecord.id];
            newRecord = currentRecord.clone(false);
            newRecord.Base_Call_Report__c = currentRecord.id;
            insert newRecord;
            
            //copy related list discussion points
            List<Discussion_Points__c> newPoints =  new List<Discussion_Points__c>();
            for(Discussion_Points__c dp : [SELECT Id, Name, Create_Error__c, Due_Date__c, Responsible_contact__c, Lead__c, Opportunity__c, Responsible_user__c, Trip_Report__c, No__c, Category__c, Internal_use_only__c, Responsible_selection__c, Summary__c, Subject__c FROM Discussion_Points__c WHERE Trip_Report__c = :currentRecord.id])
            {
                Discussion_Points__c newDP = dp.clone(false);
                newDP.Trip_Report__c = newRecord.id;
                newPoints.add(newDP);
            }
            if(newPoints.size() > 0)
            {
                insert newPoints;
            }
            
            // copy related list Participants (Trip_Report_Contact_Role__c)
            List <Trip_Report_Contact_Role__c> newRoles = new List<Trip_Report_Contact_Role__c>();
            for(Trip_Report_Contact_Role__c cr : [SELECT id, Name, Primary_Contact__c, Contact__c, Lead__c, User__c, Trip_Report__c, No__c, Contact_Selection__c, Contact_Role__c FROM Trip_Report_Contact_Role__c WHERE Trip_Report__c = :currentRecord.id])
            {
                Trip_Report_Contact_Role__c newCR = cr.clone(false);
                newCR.Trip_Report__c = newRecord.id;
                newRoles.add(newCR);
            }
            if(newRoles.size()>0)
            {
                insert newRoles;
            }
        }
        catch (Exception e)
        {
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
        }
        return new PageReference('/'+newRecord.id);
    }
}