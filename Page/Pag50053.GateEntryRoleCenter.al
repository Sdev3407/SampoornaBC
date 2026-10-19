page 50053 "Gate Entry Role Center"
{
    Caption = 'Gate Entry Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Lists;



    layout
    {
        area(rolecenter)
        {
            group(grp)
            {

                systempart("Outlook"; Outlook)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }

        }
    }

    actions
    {
        area(embedding)
        {
            action("Page General Journal Batches")
            {
                Caption = 'General Journal';
                ApplicationArea = All;
                Image = GetStandardJournal;
                RunObject = Page "General Journal Batches";
                //  RunPageView = WHERE("Sub Type" = FILTER(' '));
            }
        }
        area(processing)
        {
            action("Page Inward Gate Entry List")
            {
                Image = Card;
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page "Inward Gate Entry List";
            }
            action("Sales Planing")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50067;
            }
            action("Dispatch Report Item Wise")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50083;
            }
            action("Stock Report")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50034;
            }
            action("Closing Stock")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50047;
            }
            action("Transfer Report")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50070;
            }
            action("Page Outward Gate Entry List")
            {
                Image = Card;
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page "Outward Gate Entry List";
            }
            action("Posted transfer receipt")
            {
                RunObject = Page 5745;
                ApplicationArea = All;
            }
            action("Posted transfer shipment")
            {
                RunObject = Page 5743;
                ApplicationArea = All;
            }
            action("Page Purchase Order")
            {
                Image = Purchase;
                Promoted = true;
                ApplicationArea = All;
                RunObject = Page "Purchase Orders";
                RunPageView = WHERE(Status = FILTER('Released'));
            }
            action("Page Item Journal")
            {
                Caption = 'Item Journal';
                ApplicationArea = All;
                RunObject = Page 40;
            }
            action("Page Output Journal")
            {
                Caption = 'Page Output Journal';
                ApplicationArea = All;
                RunObject = Page 99000823;
            }
            action("<Page General Journal>")
            {
                Caption = 'General Journal';
                ApplicationArea = All;
                Image = GeneralLedger;
                Promoted = true;
                RunObject = Page "General Journal";
            }
            action("Cash Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
                ApplicationArea = All;
                Image = CashReceiptJournal;
                Promoted = true;
                RunObject = Page "Cash Receipt Voucher";
            }
            action("Change Login")
            {
                RunObject = Page 50114;
                ApplicationArea = All;
            }
            action("Journal Voucher")
            {
                Caption = 'Journal Voucher';
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                RunObject = Page "Journal Voucher";
            }
            action("Assign Indent List")
            {
                Caption = 'Assign Indent List';
                ApplicationArea = All;
                RunObject = Page 50041;
            }
            group(grp1)
            {
                action("Posted Inward Gate Entry list")
                {
                    RunObject = Page "Posted Inward Gate Entry List";
                    ApplicationArea = All;
                }
                action("Posted Outward Gate Entry list")
                {
                    RunObject = Page "Outward Gate Entry Line List";
                    ApplicationArea = All;
                }
            }
        }
    }
}

