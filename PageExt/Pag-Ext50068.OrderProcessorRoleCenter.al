pageextension 50068 "OrderProcessorRoleCenter" extends "Order Processor Role Center"
{
    actions
    {
        addafter("Purchase Invoices")
        {
            action("Assign Indent List")
            {
                RunObject = Page 50041;
                Applicationarea = All;
            }
        }
        addfirst(processing)
        {
            action("Change Login")
            {
                Image = ListPage;
                RunObject = Page 50114;
                Applicationarea = All;
            }
            action("Item by Location")
            {
                Caption = 'Item by Location';
                Image = ListPage;
                RunObject = Page 491;
                Applicationarea = All;
            }
        }
        addafter(Action62)
        {
            group(RGP)
            {
                Caption = 'RGP/NRGP/RRGP';
                Visible = true;
                Image = Departments;

                action("RGP Gate Pass List")
                {
                    ApplicationArea = all;
                    Caption = 'RGP Gate Pass List';
                    RunObject = Page "RGP Gate Pass List";
                }
                action("Posted RGP Gate Pass List")
                {
                    ApplicationArea = all;
                    Caption = 'Posted RGP Gate Pass List';
                    RunObject = Page "Posted RGP Gate Pass list";
                }
                action("RRGP Gate Pass List")
                {
                    ApplicationArea = all;
                    Caption = 'RRGP Gate Pass List';
                    RunObject = Page "RRGP Gate Pass List";
                }
                action("Posted RRGP Gate Pass List")
                {
                    ApplicationArea = all;
                    Caption = 'Posted RRGP Gate Pass List';
                    RunObject = Page "Posted RRGP Gate Pass list";
                }
                action("Report")
                {
                    ApplicationArea = all;
                    Caption = 'Report';
                    RunObject = Report "RGP/NRGP/RRGP Report";
                }

            }
        }
    }
}