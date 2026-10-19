page 50052 "NAVFam  Role Center"
{
    Caption = 'Small Business Role Center';
    PageType = RoleCenter;
    //ApplicationArea = All;
    // UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            part(Activities; 1310)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 17 = R;
            }
            part(Chart; 1390)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 84 = R;
                Visible = false;
            }

            part(Reports; 681)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';
            action(Customers)
            {
                Caption = 'Customers';
                ApplicationArea = All;
                RunObject = Page 22;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                ApplicationArea = All;
                RunObject = Page 27;
            }
            action(Items)
            {
                Caption = 'Items';
                ApplicationArea = All;
                RunObject = Page "Item List";
            }
            action("Breed Master List")
            {
                Caption = 'Breed Master List';
                ApplicationArea = All;
                RunObject = Page 50000;
            }
            action("Template Master List")
            {
                Caption = 'Template Master List';
                ApplicationArea = All;
                RunObject = Page 50002;
            }
            action("<Page Hatchery Entry List>")
            {
                Caption = 'Hatchery Entry List';
                ApplicationArea = All;
                RunObject = Page 50003;
            }
            action("<Page Data Entry List>")
            {
                Caption = 'Data Entry List';
                ApplicationArea = All;
                RunObject = Page 50004;
            }
            action("<Page Posted Hatchery List>")
            {
                Caption = 'Posted Hatchery Entry List';
                ApplicationArea = All;
                RunObject = Page 50008;
            }
            action("<Page Breed Master Card>")
            {
                Caption = 'Breed Master List';
                ApplicationArea = All;
                RunObject = Page 50000;
            }
            action("Finished Production Orders")
            {
                Caption = 'Finished Production Orders';
                ApplicationArea = All;
                RunObject = Page 9327;
            }
            action("Purchase Orders")
            {
                RunObject = Page 9307;
                ApplicationArea = All;
            }
            action("Location List")
            {
                RunObject = Page 15;
                ApplicationArea = All;
            }
            action("Indent List")
            {
                RunObject = Page 50032;
                ApplicationArea = All;
            }
            action("User Location Resp. Center")
            {
                RunObject = Page 50035;
                ApplicationArea = All;
            }
            action("Posted Data Entry List")
            {
                RunObject = Page 50009;
                ApplicationArea = All;
            }
            action("Posted Transfer Shipment")
            {
                RunObject = Page 5752;
                ApplicationArea = All;
            }
            action("Posted Transfer Receipt")
            {
                RunObject = Page 5753;
                ApplicationArea = All;
            }
            action("Sales List")
            {
                RunObject = Page 9305;
                ApplicationArea = All;
            }
            action("Sales Invoice")
            {
                RunObject = Page 9301;
                ApplicationArea = All;
            }
            action("Assign Indent List")
            {
                RunObject = Page 50041;
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Finance)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action(GeneralJournals)
                {
                    Caption = 'General Journals';
                    ApplicationArea = All;
                    Image = Journal;
                    RunObject = Page 251;
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                }
                action("Chart of Accounts")
                {
                    Caption = 'Chart of Accounts';
                    ApplicationArea = All;
                    RunObject = Page 16;
                }
                action(CashReceiptJournals)
                {
                    Caption = 'Cash Receipt Journals';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                }
                action(PaymentJournals)
                {
                    Caption = 'Payment Journals';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page 251;
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    ApplicationArea = All;
                    Image = BankAccount;
                    RunObject = Page 371;
                }
                action("Bank Acc. Reconciliations")
                {
                    Caption = 'Bank Acc. Reconciliations';
                    ApplicationArea = All;
                    Image = BankAccountRec;
                    RunObject = Page 388;
                }
                action("Bank Acc. Statements")
                {
                    Caption = 'Bank Acc. Statements';
                    ApplicationArea = All;
                    Image = BankAccountStatement;
                    RunObject = Page 389;
                }
                action("Direct Debit Collections")
                {
                    Caption = 'Direct Debit Collections';
                    ApplicationArea = All;
                    RunObject = Page 1207;
                }
                action(Currencies)
                {
                    Caption = 'Currencies';
                    ApplicationArea = All;
                    Image = Currency;
                    RunObject = Page 5;
                }
                action(Employees)
                {
                    Caption = 'Employees';
                    ApplicationArea = All;
                    RunObject = Page 5201;
                }
                action("VAT Statements")
                {
                    Caption = 'VAT Statements';
                    ApplicationArea = All;
                    RunObject = Page 320;
                }
                action("Intrastat Journals")
                {
                    Caption = 'Intrastat Journals';
                    ApplicationArea = All;
                    RunObject = Page 327;
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos. See customers and transaction history.';
                action("Sales Quotes")
                {
                    Caption = 'Sales Quotes';
                    ApplicationArea = All;
                    RunObject = Page "Sales Quotes";
                }
                action("Sales Invoices")
                {
                    Caption = 'Sales Invoices';
                    ApplicationArea = All;
                    RunObject = Page 1306;
                }
                action("Sales Credit Memos")
                {
                    Caption = 'Sales Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Sales Credit Memos";
                }
                action(Reminders)
                {
                    Caption = 'Reminders';
                    ApplicationArea = All;
                    Image = Reminder;
                    RunObject = Page 436;
                }
                action("Finance Charge Memos")
                {
                    Caption = 'Finance Charge Memos';
                    ApplicationArea = All;
                    Image = FinChargeMemo;
                    RunObject = Page 448;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    ApplicationArea = All;
                    RunObject = Page 1309;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    ApplicationArea = All;
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Issued Finance Charge Memos")
                {
                    Caption = 'Issued Finance Charge Memos';
                    ApplicationArea = All;
                    Image = PostedMemo;
                    RunObject = Page 452;
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    Caption = 'Vendors';
                    ApplicationArea = All;
                    RunObject = Page "Vendor List";
                }
                action("Incoming Documents")
                {
                    Caption = 'Incoming Documents';
                    ApplicationArea = All;
                    RunObject = Page 190;
                }
                action("<Page Mini Purchase Invoices>")
                {
                    Caption = 'Purchase Invoices';
                    ApplicationArea = All;
                    RunObject = Page 1356;
                }
                action("<Page Mini Posted Purchase Invoices>")
                {
                    Caption = 'Posted Purchase Invoices';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("<Page Mini Purchase Credit Memos>")
                {
                    Caption = 'Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page 1367;
                }
                action("<Page Mini Posted Purchase Credit Memos>")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Credit Memos";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'Approve requests made by other users.';
                action("Requests to Approve")
                {
                    Caption = 'Requests to Approve';
                    ApplicationArea = All;
                    Image = Approvals;
                    RunObject = Page 654;
                }
            }
            group("Advanced Finance")
            {
                Caption = 'Advanced Finance';
                Image = AnalysisView;
                ToolTip = 'Manage budgets, cash flows, fixed assets, VAT, and analyze sales.';
                action("G/L Budgets")
                {
                    Caption = 'G/L Budgets';
                    ApplicationArea = All;
                    RunObject = Page 121;
                }
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    ApplicationArea = All;
                    RunObject = Page 5601;
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    ApplicationArea = All;
                    RunObject = Page 103;
                }
                action("Sales Analysis Reports")
                {
                    Caption = 'Sales Analysis Reports';
                    ApplicationArea = All;
                    RunObject = Page 9376;
                }
                action("Purchase Analysis Reports")
                {
                    Caption = 'Purchase Analysis Reports';
                    ApplicationArea = All;
                    RunObject = Page 9375;
                }
                action("Inventory Analysis Reports")
                {
                    Caption = 'Inventory Analysis Reports';
                    ApplicationArea = All;
                    RunObject = Page 9377;
                }
                action("VAT Reports")
                {
                    Caption = 'VAT Reports';
                    ApplicationArea = All;
                    RunObject = Page 744;
                }
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    ApplicationArea = All;
                    RunObject = Page 849;
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    ApplicationArea = All;
                    RunObject = Page 851;
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    ApplicationArea = All;
                    RunObject = Page 857;
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    ApplicationArea = All;
                    RunObject = Page 859;
                }
            }
        }
        area(processing)
        {
            action("<G/L Trial Balance>")
            {
                Caption = 'G/L Trial Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 4;
            }

            action("General Journal")
            {
                Image = Voucher;
                ApplicationArea = All;
                RunObject = Page 39;
            }
            action("Cash Receipt Voucher")
            {
                Image = Payment;
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page "Cash Receipt Voucher";
            }
            action("Cash Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
                ApplicationArea = All;
                Image = Costs;
                Promoted = true;
                RunObject = Page "Cash Payment Voucher";
            }
            action("Page Item Ledger Entries")
            {
                Caption = 'Items History-Item Ledger Entries';
                ApplicationArea = All;
                Image = Item;
                RunObject = Page 38;
            }
            action("Item Availability by Periods")
            {
                Caption = 'Item Availability by Periods';
                ApplicationArea = All;
                Image = ItemAvailabilitybyPeriod;
                Promoted = true;
                RunObject = Page 157;
            }
            action("Page Item Turnover")
            {
                Caption = 'Item Turnover';
                ApplicationArea = All;
                Image = ItemRegisters;
                RunObject = Page 158;
            }
            action("Page Items by Location")
            {
                Caption = 'Items by Location';
                ApplicationArea = All;
                Image = ItemAvailbyLoc;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 491;
            }

            action("Change Branch")
            {
                Image = ListPage;
                ApplicationArea = All;
                RunObject = Page 50036;
            }
            action("Liqudation Report ")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50071;
            }
            action("Brokerage Commission")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50010;
            }
        }
    }
}

