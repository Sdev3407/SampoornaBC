pageextension 50099 "PurchasingAgentRoleCenter" extends "Purchasing Agent Role Center"
{
    actions
    {

        addlast(reporting)
        {
            action("Brokerage Commision")
            {
                Caption = 'Brokerage Commision';
                Image = "Report";
                // RunObject = Report 50005;
                applicationarea = all;
            }
            action("<Report Balance to Date>")
            {
                Caption = 'Vendor-Balance to Date';
                Image = "Report";
                RunObject = Report 321;
                applicationarea = all;
            }
        }
        addafter(PurchaseOrdersPartDeliv)
        {
            action(PurchaseOrderApproved)
            {
                Caption = 'PurchaseOrderApproved';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER('Released'));
                applicationarea = all;
            }
        }
        addfirst(processing)
        {
            action("General Journal")
            {
                Caption = 'General Journal';
                RunObject = Page "General Journal";
                applicationarea = all;
            }
        }
    }
}