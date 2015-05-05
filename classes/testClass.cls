/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class testClass 
{
    static testmethod void test_Leads_AU()
    {
        // Create Lead
        Lead testLead = new Lead();
        testLead.LastName = 'test';
        testLead.Company = 'test';
        testLead.Phone = '123456';
        testLead.disable_validation__c = true;
        insert testLead;
        
        // Create Trip Report
        Trip_Report__c testTR = new Trip_Report__c ();
        /* testTR.Visit_Date__c = date.today(); */
        testTR.Lead__c = testLead.Id;
        insert testTR;
         
        // Create Trip Report Contact Role
        Trip_Report_Contact_Role__c testCR = new Trip_Report_Contact_Role__c();
        testCR.Lead__c = testLead.Id;
        testCR.Trip_Report__c = testTR.Id;
        testCR.Contact_Selection__c = 'Lead';
        insert testCR;
        
        // Create Discussion Points
        Discussion_Points__c testDP = new Discussion_Points__c();
        testDP.Name = 'test';
        testDP.Lead__c = testLead.id;
        testDP.Responsible_selection__c = 'Lead';
        testDP.Trip_Report__c = testTR.Id;
        insert testDP;
        
        // Convert Lead
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(testLead.id);
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
    }
    
    static testMethod void ContactRoles_DiscussionPoints_Ctrler_Test() 
    {
        PageReference pageRef = Page.tripReportDisplay;
        Test.setCurrentPageReference(pageRef);
        
        Account testaccount = new Account(name = 'test');
        insert testaccount;
        Contact testcontact = new Contact(Lastname = 'test', Account = testaccount);
        insert testcontact;
        
        Trip_Report__c tripRep = new Trip_Report__c (/*,  Account__c = testaccount.id, Visit_Date__c = date.today()*/);
        insert tripRep;
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(tripRep);
        
        ContactRoles_DiscussionPoints_Ctrler Ctrler = new ContactRoles_DiscussionPoints_Ctrler(sc);
        
        // first try delete with empty list
        Ctrler.ConRoleDelete();
        // fill list
        Ctrler.ConRoleAddRow();
        Ctrler.ConRoleAddRow();
        // set selection for deletion to 1
        Ctrler.selectConRole = 1;
        // delete first Contact Role
        Ctrler.ConRoleDelete();
        Ctrler.ConRoleAddRow();
        Ctrler.ConRolesave();
        Ctrler.ConRoleAddRow();
        Ctrler.TripRepConRoles[0].Primary_Contact__c = true;
        for(Trip_Report_Contact_Role__c con : Ctrler.TripRepConRoles)
        {
            con.Contact__c = testcontact.id;
        }
        Ctrler.ConRolesave();
        Ctrler.selectConRole = 1;
        Ctrler.ConRoleDelete();
        
        
        // first try delete with empty list
        Ctrler.PointDelete();
        // fill list
        Ctrler.PointAddRow();
        Ctrler.PointAddRow();
        // set selection for deletion to 1
        Ctrler.selectPoint = 1;
        // delete first point
        Ctrler.PointDelete();
        Ctrler.PointAddRow();        
        Ctrler.PointAddRow();
        // to create an exception
        Ctrler.TripRepPoints[2].Create_Error__c = true;
        Ctrler.Pointsave();
        Ctrler.TripRepPoints[2].Create_Error__c = false;
        Ctrler.Pointsave();
        Ctrler.PointAddRow();
        Ctrler.selectPoint = 1;
        Ctrler.PointDelete();
        Ctrler.Pointsave();
        List <Trip_Report_Contact_Role__c> ConRoles = Ctrler.TripRepConRoles;
        List <Discussion_Points__c> Points = Ctrler.TripRepPoints;
        Points =  Ctrler.getNon_Internal_Discussion_Points();
    }
    static testmethod void test_tripreportDetailsCtrler()
    {
        Account testaccount = new Account(name = 'test');
        insert testaccount;
        
        Trip_Report__c tripRep = new Trip_Report__c (/* Account__c = testaccount.id, Visit_Date__c = date.today()*/);
        insert tripRep;
        
        tripreportDetailsCtrler Ctrler = new tripreportDetailsCtrler();
        
        // try without ID
        Ctrler.getTripRep();
        
        // add ID
        Ctrler.tripReportId = tripRep.Id;
        
        // call get Methods
        Ctrler.getTripRep();
        Ctrler.getTripRepConRoles();
        Ctrler.getTripRepPoints(); 
    }

    public static testMethod void CreateAndClone()
    {
            // Create Trip Report
        Trip_Report__c testTR = new Trip_Report__c ();
        insert testTR;
     
        // Create Trip Report Contact Role
        Trip_Report_Contact_Role__c testCR = new Trip_Report_Contact_Role__c();
        testCR.Trip_Report__c = testTR.Id;
        insert testCR;
        
        // Create Discussion Points
        Discussion_Points__c testDP = new Discussion_Points__c();
        testDP.Name = 'test';
        testDP.Trip_Report__c = testTR.Id;
        insert testDP;
        
        PageReference pageRef = Page.DeepCloneCallReport;
        Test.setCurrentPage(pageRef);
         ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(testTR);
        cloneCallReport Ctrler = new cloneCallReport(sc);
        Ctrler.cloneRecord();
    }
    public static testmethod void test_Points_BI_BU_trigger()
    {
    	// Create Trip Report
        Trip_Report__c testTR = new Trip_Report__c ();
        insert testTR;
        
        // Create Account and Opportunity 
        Account testaccount = new Account(name = 'test');
        insert testaccount;
        Opportunity testoppy = new Opportunity(Name = 'test', Accountid = testaccount.id, StageName = 'Qualified Lead', CloseDate = date.today());
        insert testoppy;
     
        // Create Discussion Points
        Discussion_Points__c testDP = new Discussion_Points__c();
        testDP.Name = 'test';
        testDP.Opportunity__c = testoppy.id;
        testDP.Trip_Report__c = testTR.Id;
        insert testDP;

        Discussion_Points__c testDP2 = new Discussion_Points__c();
        testDP2.Name = 'test';
        testDP2.Opportunity__c = testoppy.id;
        testDP2.Trip_Report__c = testTR.Id;
        insert testDP2;
    	
    }
}