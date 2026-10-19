page 50047 "PI & TDS Role Cnt"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
        }
    }

    actions
    {
        area(processing)
        {
            group("Purchase and TDS")
            {
                Caption = 'Purchase and TDS';
                action("Page Purchase Invoice")
                {
                    ApplicationArea = All;
                    RunObject = Page 51;
                }
                action("Page Purchase Credit Memo")
                {
                    ApplicationArea = All;
                    RunObject = Page "Purchase Credit Memo";
                }

            }
        }
        area(embedding)
        {

            action("Page TDS Groups")
            {
                ApplicationArea = All;
                Caption = 'TDS Groups';
                RunObject = Page "TDS Sections";
            }

            action("Page TDS Setup")
            {
                ApplicationArea = All;
                Caption = 'TDS Setup';
                RunObject = Page "TDS Setup";
            }

        }
        area(creation)
        {
            group("History & Report")
            {
                Caption = 'History & Report';
                action("Page TDS Entries")
                {
                    ApplicationArea = All;
                    //   RunObject = Page 13737;
                }

                action("Page Pay TDS")
                {
                    ApplicationArea = All;
                    //    RunObject = Page 13788;
                }
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                action("Page Posted Purchase Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoice";
                }
                action("Page Posted Purchase Cr Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Cr Memos';
                    RunObject = Page "Posted Purchase Credit Memo";
                }
            }
        }
    }
}

