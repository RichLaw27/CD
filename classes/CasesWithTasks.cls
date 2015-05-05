public class CasesWithTasks {
    
    //Case Id To Acess
    Id  CaseID;  
    Case CurrentCaseDetails;
    public List<Case_Task__c> CaseTasks {get; private set; }
    public Product2 Productname {get;private set;}
    public Date ReportRunDate { get { return Date.today(); }}
    public Case_Task__c InvestigationCaseTask {get; private set; }
    public User InvestigatedBy  {get; private set; }
    public User CaseOwner{get; private set; }
    public String AccountDetails{get;private set;}
    //To Get Access to StandardConroller
    private ApexPages.StandardController controller;
    public CasesWithTasks () {
        CaseID= ApexPages.CurrentPage().getParameters().get('id');
        Init();
    }
    
    
    
    public CasesWithTasks (ApexPages.StandardController c) {
        controller = c;
        CaseID= c.getRecord().id;
        CaseTasks = new List<Case_Task__c>();
        InvestigationCaseTask = new Case_Task__c();
        Init();
    } 
    
    
    private void Init()
    {
        GetCaseDetails(CaseID);
        GetCaseTaskDetails(CaseID);
        SetInvestigatedBy();    
        SetCaseOwner();
    }
    //Get CaseTasks For the Present Case
    
    void SetInvestigatedBy()
    {
        try{
            List<User> InvestUser  =  [Select Name from user where id in( Select Investigated_By__c 
                                                                         from Case_task__c where CaseId__c= :ApexPages.CurrentPage().getParameters().get('id')  and Investigated_By__c <> null) Limit 1 ];
            
            if(InvestUser<>null)
            {
                InvestigatedBy  =InvestUser[0]; 
            }
        }
        catch(Exception e) {
        }     
    }      
    
    void SetCaseOwner()
    {
        try{
            List<User> CaseOwners  =  [Select Name from user where id in( Select OwnerId 
                                                                         from Case where id= :ApexPages.CurrentPage().getParameters().get('id')  ) Limit 1 ];
            
            if(CaseOwners  <>null)
            {
                CaseOwner  =CaseOwners[0]; 
            }
        }
        catch(Exception e) {}
        
    }      
    
    void GetCaseDetails(id id) { 
        try{
            CurrentCaseDetails= [SELECT AccountId, Acknowledge_Complaint__c,Batch_Number__c,Business_Area__c,CaseNumber,CaseOwner__c,CaseReasons_C__c,ClosedDate,ContactId,Cost_Detail__c,CreatedById,CreatedDate,CurrencyIsoCode,Customer_PO_Number__c,Customer_Ref__c,Customer_Type__c,Description,Id,Investigation_status__c,IsClosed,IsDeleted,IsEscalated,
                                 LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Order_Number__c,Origin,Our_Item__c,OwnerId,ParentId,Priority,Product_Group_C__c,Product_Type__c,QueriedQty__c,Reason,RecordTypeId,Respond_to_Customer__c,Status,Subject,SuppliedCompany,SuppliedEmail,SuppliedName,SuppliedPhone,SystemModstamp,Type,UM__c FROM Case
                                 where id = :CaseID limit 1]; 
            if(CurrentCaseDetails.Product_Type__c<>null)
            {
                Productname =  [Select CreatedById,CreatedDate,CurrencyIsoCode,Description,Family,Id,IsActive,IsDeleted,LastModifiedById,LastModifiedDate,Name,Parent_Category__c,ProductCode,Reporting_Attribute__c,Requires_Know_Your_Customer__c,Sub_Category__c,SystemModstamp from Product2 where id = :CurrentCaseDetails.Product_Type__c limit 1];
             }
            Account acc=[Select Name from Account where id=:CurrentCaseDetails.AccountId limit 1]  ;
            AccountDetails= acc.name;
            System.debug(AccountDetails);
            AccountDetails=AccountDetails.Split('-',0)[0];
            System.debug(AccountDetails);
        }
        catch(Exception e) {
        }
        
    }
    
    void  GetCaseTaskDetails(id id)
    {
        try
        {
            CaseTasks= [Select  Actual_Faulty_Qty__c,AssignedTo__c,CaseID__c,Containment_Action__c,Corrective_Action__c,Cost_to_Replace_Material__c,Cost_to_return_Samples__c,CreatedById,CreatedDate,Credit_Note_Reference__c,CurrencyIsoCode,Date_Completed__c,Date_Required__c,Date_Started__c,Details__c,Id,Investigated_By__c,Investigation_Details__c,Invoice_Number__c,IsDeleted,LastActivityDate,LastModifiedById,LastModifiedDate,Name,Preventative_Action__c,Price_Cost__c,Product_Group__c,RecordTypeId,Responsible_Department__c,Responsible_Site__c,Responsible_Sites__c,Root_Couse__c,Samples_Returned__c,Status__c,SystemModstamp,Total_Cost__c,UM__c,Value_of_Credit__c
                        from Case_Task__c where CaseID__c = :CaseID and Investigated_By__c <>null ];
            if(CaseTasks<>null && CaseTasks.size()>0 )
            {
                InvestigationCaseTask =CaseTasks[0];
            }
        }
        catch(Exception e) {}
    }
    
    
    
    
}