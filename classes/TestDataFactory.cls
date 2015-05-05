public with sharing class TestDataFactory {

	public	static	Account				varAccount;
	public	static	Opportunity			varOpportunity;
	public	static	Opportunity_Task__c varOpportunityTask;
	public	static	Product2 			varProduct2;
	public	static	Pricebook2 			standardPB;
	public	static	PricebookEntry 		varPricebookEntry; 
	public	static	OpportunityLineItem varOpportunityLineItem;
	public	static	Business_Area__c	varBusiness_Area;
	public	static	User				varRandomUser;
	
	public static    Account createAccount()
	{
		return new Account(
			// CurrentBalance__c			= '',
			// ERP_Customer_ID_of_Parent__c	= '',
			// Phone						= '',
			// Report_Territory__c			= '',
			// Jigsaw						= '',
			// Aged2__c						= '',
			// ParentId						= '',
			// Type							= '',
			// Customer_Type__c				= '',
			// BalDue__c					= '',
			// BillingCity					= '',
			// Description					= '',
			// RecordTypeId					= '',
			// Industry						= '',
			// Business_Segment__c			= '',
			// CreditLimit__c				= '',
			// Approved_by_GMC__c			= '',
			// Fax							= '',
			// ShippingCity					= '',
			// Location_Type__c				= '',
			// AnnualRevenue				= '',
			// ShippingState				= '',
			// BillingPostalCode			= '',
			// OwnerId						= '',
			// Approved_by_Customer__c		= '',
			// Aged3__c						= '',
			// NumberOfEmployees			= '',
			// HoldAmount__c				= '',
			// ShippingPostalCode			= '',
			// FS_CUST_ID__c				= '',
			// Account_Type__c				= '',
			// SicDesc						= '',
			// CurrencyIsoCode				= '',
			// FS_Ship_To_ID__c				= '',
			// AccountSource				= '',
			// BillingState					= '',
			// BillingCountry				= '',
			// Aged1__c						= '',
			// Customer_Group__c			= '',
			Name							= 'Test Account',
			// ShippingStreet				= '',
			// CSR__c						= '',
			//	MDM_External_ID__c				= 'EXTERNAL',
			Last_MDM_Update__c				=	System.today()	
			// Website						= '',
			// FS_Site_ID__c				= '',
			// ShippingCountry				= '',
			// Active__c					= '',
			// BillingStreet				= '',
			// Plan_Created__c				= '',
			// Approved_by_Director__c		= '',
			// Key_Account__c				= '',
			// PayTerms__c					= ''
		);
	}
		
	// Use: Opportunity varOpportunity = UnitTestDataFactory.createOpportunity();
	public static    Opportunity createOpportunity(	Id AccountId, 
													Id RecordTypeID,
													Id Business_Area)
	{
		return new Opportunity(
			// Requires_Know_Your_Customer__c= '',
			// Approval_Requirement_definition__c= '',
			// LeadSource					= '',
			// Revenue_month_1__c			= '',
			// Approval_Sample_by_Customer__c= '',
			// Revenue_Year_2__c			= '',
			Amount_this_year__c			= 1000,
			// Revenue_Year_1__c			= '',
			Type							= 'Existing Business',
			// Amount_year_three__c			= '',
			// Amount						= '',
			Description						= 'Test Opportunity',
			RecordTypeId					= RecordTypeID,
			// Approval_Trial_Product_Production__c= '',
			CloseDate					= System.today().addDays(+10),
			// Revenue_month_11__c			= '',
			// OwnerId						= '',
			// Cost_margin_percentage__c	= '',
			// Approval_Compliance_certification__c= '',
			Business_Area__c				= Business_Area,
			// Revenue_month_12__c			= '',
			// Fixed_Development_Cost__c	= '',
			// Contribution_margin__c		= '',
			// CampaignId					= '',
			// Approval_Solution_cost_estimate__c= '',
			// CurrencyIsoCode				= '',
			// Approval_Supply_chain_validation__c= '',
			// NextStep						= '',
			// Approval_Full_Production_Plan__c= '',
			Gross_Margin_Percentage__c	= 1,
			// Approval_Innovation_council__c= '',
			// Revenue_month_9__c			= '',
			// Approval_Solution_specification__c= '',
			// Revenue_month_2__c			= '',
			// Pricebook2Id					= '',
			// CSR__c						= '',
			Name							= 'Test Opportunity',
			// Probability					= '',
			// Revenue_month_7__c			= '',
			AccountId					= AccountId,
			// Approval_Value_proposition__c= '',
			// Amount_year_two__c			= '',
			// Approval_Know_your_customer__c= '',
			// Revenue_month_4__c			= '',
			// Approval_Graphical_design__c	= '',
			// Revenue_month_10__c			= '',
			// Revenue_month_8__c			= '',
			// ForecastCategoryName			= '',
			// Approval_Legal_and_NDA__c	= '',
			// Revenue_month_3__c			= '',
			// Approval_Technical_Solution_Timeframes__c= '',
			// Revenue_month_6__c			= '',
			StageName					= 'Unqualified',
			// Revenue_month_5__c			= '',
			// Internal_Record_Type_Name__c	= '',
			Confirmed_Con_counterfeiter__c= true
		);
	}
	
	// Use: Opportunity_Task__c varOpportunityTask = UnitTestDataFactory.createOpportunity_Task();
	public static    Opportunity_Task__c createOpportunity_Task(Id OpportunityID,
																Id RecordTypeID)
	{
		return new Opportunity_Task__c(
			// Assigned_User__c				= '',
			Details__c						= 'The task detail',
			Date_Final_Approval__c			= System.today().addDays(-1),
			Date_Started__c					= System.today().addDays(-1),
			// Internal_Approval__c			= '',
			// Date_Completed__c			= '',
			Date_Required__c				= System.today().addDays(-1),
			RecordTypeId					= RecordTypeID,
			// Assigned_to__c				= '',
			Opportunity__c					= OpportunityID
			// CurrencyIsoCode				= ''
		);
	}
	
	// Use: Business_Area__c varBusiness_Area = UnitTestDataFactory.createBusiness_Area();
	public static    Business_Area__c createBusiness_Area()
	{
		return new Business_Area__c(
			Name							=	'Filters-TestData',
			MDM_External_Id__c				=	'Filters-TestData'
		);
	}
	
	// Use: Product2 varProduct2 = UnitTestDataFactory.createProduct2();
	public static    Product2 createProduct2()
	{
		return new Product2(
			Requires_Know_Your_Customer__c	= true,
			// Sub_Category__c				= '',
			// ProductCode					= '',
			// Division__c					= '',
			// IsActive						= '',
			Description						= 'My Test Product',
			// Family						= '',
			Name							= 'My Test Product',
			CurrencyIsoCode					= 'GBP'
		);
	}
	
	// Use: PricebookEntry varPricebookEntry = UnitTestDataFactory.createPricebookEntry();
	public static    PricebookEntry createPricebookEntry(Id priceBookID,
														 Id productID)
	{
		return new PricebookEntry(
			UseStandardPrice				= false,
			UnitPrice						= 0,
			IsActive						= true,
			Pricebook2Id					= priceBookID,
			Product2Id						= productID,
			CurrencyIsoCode					= 'GBP'
		);
	}
		
	// Use: OpportunityLineItem varOpportunityLineItem = UnitTestDataFactory.createOpportunityLineItem();
	public static    OpportunityLineItem createOpportunityLineItem(Id priceBookEntryID,
																   Id opportunityId)
	{
		return new OpportunityLineItem(
			PricebookEntryId				= priceBookEntryID,
			// Shipment_Location__c			= '',
			// TotalPrice					= '',
			// ServiceDate					= '',
			UnitPrice						= 1000,
			Description						= 'Test Product',
			Quantity						= 6,
			OpportunityId					= opportunityId
		);
	}
	
	public	static void	CreateTestData()
	{
		
		//	Find some random  users which we can use to populate stuff
		
		List<User>				ul	=	[Select ID from user where IsActive = true and ID != : Userinfo.getUserId()];
		if (ul.size() > 0) {
			varRandomUser		=	ul[0];
		}
		
		varBusiness_Area	=	TestdataFactory.createBusiness_Area();
		insert varBusiness_Area;
		
		varAccount = TestDataFactory.createAccount();
		insert	varAccount;
		System.assertNotEquals(varAccount.Id,null,'Failed to create Account');
		
		List<RecordType>		orl	=	[SELECT Id FROM RecordType WHERE SobjectType = 'Opportunity' AND DeveloperName = 'Innovation_Opportunities' and IsActive = true];
		varOpportunity = TestDataFactory.createOpportunity(	varAccount.Id,
															orl[0].Id,
															varBusiness_Area.Id);
		insert	varOpportunity;
		System.assertNotEquals(varOpportunity.Id,null,'Failed to create Opportunity');
		
		System.debug('Opportunity after insert' + varOpportunity);
		
		//	Create a task for every record type we have
		
		List<RecordType>		rl	=	[SELECT Id FROM RecordType WHERE SobjectType = 'Opportunity_Task__c' AND IsActive = true];
		system.assertNotEquals(rl.size(),0,'No Opportunity task record types found');
		for (RecordType RecType: rl) {		
			varOpportunityTask = TestDataFactory.createOpportunity_Task(varOpportunity.Id,RecType.Id);
			insert	varOpportunityTask;
			if (varRandomUser != null) {
				varOpportunityTask.Assigned_User__c = varRandomUser.Id;
				update	varOpportunityTask;
			}
			System.assertNotEquals(varOpportunityTask.Id,null,'Failed to create varOpportunityTask');
		}
		
		//	Create and add a product to this Oppty
		
		varProduct2 = TestDataFactory.createProduct2();
		insert varProduct2;
		System.assertNotEquals(varProduct2.Id,null,'Failed to create varProduct2');
		
		//	Get the standard price book reference out

		standardPB 			= 	[select id from Pricebook2 where isStandard=true];
    	System.assertNotEquals(standardPB.id,null,'Failure reading standardPB');
		
		//	Create a standard price book entry for this product
		varPricebookEntry = TestDataFactory.createPricebookEntry(standardPB.Id,varProduct2.Id);
		insert	varPricebookEntry;
		System.assertNotEquals(varPricebookEntry.Id,null,'Failed to create varPricebookEntry');
		
		//	Add a OpportunityLineItem to this Opportunity
		varOpportunityLineItem = TestDataFactory.createOpportunityLineItem(varPriceBookEntry.Id,varOpportunity.Id);
		insert	varOpportunityLineItem;
		System.assertNotEquals(varOpportunityLineItem.Id,null,'Failed to create varOpportunityLineItem');
		
	}

}