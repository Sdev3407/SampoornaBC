page 50057 "NAVFam  Role Center-acc"
{
    Caption = 'Small Business Role Center';
    PageType = RoleCenter;
    // ApplicationArea = All;
    //UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            part(Activities; 1310)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 17 = R;
            }
            part(Genericchart; 1390)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 84 = R;
            }

            part(trialbalance; 1393)
            {
                ApplicationArea = All;
                AccessByPermission = TableData 17 = R;
                Visible = false;
            }
            part(ReportInbox; 681)
            {
                ApplicationArea = All;
                Visible = false;
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
                RunObject = Page "Customer List";
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                ApplicationArea = All;
                RunObject = Page "Vendor List";
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
            action("Location List")
            {
                RunObject = Page "Location List";
                ApplicationArea = All;
            }
            action("Indent List")
            {
                RunObject = Page 50032;
                ApplicationArea = All;
            }
            action("User Location Resp. Center")
            {
                ApplicationArea = All;
                RunObject = Page 50035;
            }
            action("Posted Data Entry List")
            {
                ApplicationArea = All;
                RunObject = Page 50009;
            }
            action("Posted Transfer Shipment")
            {
                ApplicationArea = All;
                RunObject = Page 5752;
            }
            action("Posted Transfer Receipt")
            {
                ApplicationArea = All;
                RunObject = Page 5753;
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
                    RunObject = Page "General Journal Batches";
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
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                }
                action(PaymentJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                }
                action("Bank Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action("Bank Acc. Reconciliations")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Acc. Reconciliations';
                    Image = BankAccountRec;
                    RunObject = Page 388;
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    RunObject = Page 389;
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = All;
                    Caption = 'Direct Debit Collections';
                    RunObject = Page 1207;
                }
                action(Currencies)
                {
                    ApplicationArea = All;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action(Employees)
                {
                    ApplicationArea = All;
                    Caption = 'Employees';
                    RunObject = Page 5201;
                }
                action("VAT Statements")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Statements';
                    RunObject = Page 320;
                }
                action("Intrastat Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Intrastat Journals';
                    RunObject = Page "Intrastat Journal";
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos. See customers and transaction history.';
                action(Sales_CustomerList)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action("Sales Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Quotes';
                    RunObject = Page "Sales Quotes";
                }
                action("Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    RunObject = Page 1306;
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                }
                action(Reminders)
                {
                    ApplicationArea = All;
                    Caption = 'Reminders';
                    Image = Reminder;
                    RunObject = Page "Reminder List";
                }
                action("Finance Charge Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Finance Charge Memos';
                    Image = FinChargeMemo;
                    RunObject = Page "Finance Charge Memo List";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page 1309;
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Issued Reminders")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Finance Charge Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Finance Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Incoming Documents';
                    RunObject = Page "Incoming Documents";
                }
                action("<Page Mini Purchase Invoices>")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = Page 1356;
                }
                action("<Page Mini Posted Purchase Invoices>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("<Page Mini Purchase Credit Memos>")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page 1367;
                }
                action("<Page Mini Posted Purchase Credit Memos>")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
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
                    RunObject = Page "G/L Budget Names";
                }
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    ApplicationArea = All;
                    RunObject = Page "Fixed Asset List";
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    ApplicationArea = All;
                    RunObject = Page "Account Schedule Names";
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
                    RunObject = Page "Cash Flow Forecast List";
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    ApplicationArea = All;
                    RunObject = Page "Chart of Cash Flow Accounts";
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    ApplicationArea = All;
                    RunObject = Page "Cash Flow Manual Revenues";
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    ApplicationArea = All;
                    RunObject = Page "Cash Flow Manual Expenses";
                }
            }
        }
        area(processing)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Transfer Material CBF")
                {
                    ApplicationArea = All;
                    RunObject = Page 393;

                }
            }
        }
    }
}

