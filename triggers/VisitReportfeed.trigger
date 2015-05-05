trigger VisitReportfeed on Event(after insert) {

    for (Event E:Trigger.new)
    {
    
if ((E.Type == 'Meeting at Customer Site')|| (E.Type == 'Meeting at Essentra Site') || (E.Type == 'Meeting Elsewhere'))
{
    FeedItem fItem = new FeedItem();
    fItem.Type = 'LinkPost';
    fItem.ParentId = UserInfo.getUserId();
    fItem.Title='Customer Visit Report';
    
    if (E.WhatId ==null)
    fItem.Body= 'Visit Report created (Please update Account/Opportunities/Contact Details)';

    else
        fItem.Body= 'Visit Report Related To :'+ system.URL.getSalesforceBaseUrl().toExternalForm()+'/'+E.WhatId ;
    
    fItem.LinkUrl= system.URL.getSalesforceBaseUrl().toExternalForm()+'/'+E.id;
    insert fItem;
    
 User Mgr=[select ManagerId from User where Id=:UserInfo.getUserId()];
       
        if (Mgr.ManagerId !=null)
        {
        FeedItem mItem = new FeedItem();
        mItem.Type = 'LinkPost';
        mItem.ParentId = Mgr.ManagerId ;
        mItem.Title='Customer Visit Report';
        mItem.Body= UserInfo.getUserName() +'  Created Vist Report Related To :'+ system.URL.getSalesforceBaseUrl().toExternalForm()+'/'+E.WhatId ;
        
if (E.WhatId ==null)
    mItem.Body= UserInfo.getUserName() + ' Created Vist Report Related To (Please update Account/Opportunities/Contact Details)';

    else
        mItem.Body= UserInfo.getUserName() + ' Created Vist Report Related To :'+ system.URL.getSalesforceBaseUrl().toExternalForm()+'/'+E.WhatId ;
  
  
        mItem.LinkUrl= system.URL.getSalesforceBaseUrl().toExternalForm()+'/'+E.id;
        insert mItem;
         }
    }
    
}
}