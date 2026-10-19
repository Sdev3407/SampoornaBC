page 50058 "Accounting Mngr Role Center 2"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(rolecenter)
        {
            group(grp)
            {
                part(Finance; 762)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(ACCManager; 9030)
                {
                    ApplicationArea = All;
                }
                part(Customers; 9150)
                {
                    ApplicationArea = All;
                }
            }
            group(grp1)
            {
                part("Sales Order"; 760)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part("Job Queue"; 675)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Vendors; 9151)
                {
                    ApplicationArea = All;
                }
                part(Report; 681)
                {
                    ApplicationArea = All;
                }
                part(CopyProfile; 9175)
                {
                    ApplicationArea = All;
                }
                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("&G/L Trial Balance")
            {
                Caption = '&G/L Trial Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 6;
            }
            action("&Bank Detail Trial Balance")
            {
                Caption = '&Bank Detail Trial Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 1404;
            }
            action("&Account Schedule")
            {
                Caption = '&Account Schedule';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 25;
            }
            action("<Journal Voucher>")
            {
                Caption = 'Journal Voucher';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page "Journal Voucher";
            }
            action("<Report Vendor Wise MRN Report>")
            {
                Caption = 'Vendor Wise MRN Report';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 50054;
            }
            action("Transfer Report")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report "Transfer Report";
            }
            action("Sales Vs Collection")
            {
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report 50039;
            }
            action("<Detail Trial Balance- Excluded>")
            {
                Caption = 'Detail Trial Balance- Excluded';
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 50046;
            }
            action("Trial Balance by &Period")
            {
                Caption = 'Trial Balance by &Period';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 38;
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 36;
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                Caption = 'Balance Comp. - Prev. Y&ear';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 37;
            }
            action("&Closing Trial Balance")
            {
                Caption = '&Closing Trial Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 10;
            }

            action("TCS Entry")
            {
                Caption = 'TCS Entry';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 50057;
            }




            action("Aged Accounts &Receivable")
            {
                Caption = 'Aged Accounts &Receivable';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 120;
            }
            action("Aged Accounts Pa&yable")
            {
                Caption = 'Aged Accounts Pa&yable';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 322;
            }
            action("<TDS Entry>")
            {
                Caption = 'TDS Entry';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 50014;
            }

            action("Vendor detail trial Balance")
            {
                Caption = 'Vendor detail trial Balance';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 304;
            }
            action("Reconcile Cus&t. and Vend. Accs")
            {
                Caption = 'Reconcile Cus&t. and Vend. Accs';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 33;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                ApplicationArea = All;
                RunObject = Page 16;
            }
            action(Vendor)
            {
                Caption = 'Vendors';
                ApplicationArea = All;
                Image = Vendor;
                RunObject = Page 27;
            }
            action(VendorsBalance)
            {
                Caption = 'Balance';
                ApplicationArea = All;
                Image = Balance;
                RunObject = Page 27;
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                ApplicationArea = All;
                RunObject = Page "Purchase Order List";
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                ApplicationArea = All;
                RunObject = Page Budget;
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                ApplicationArea = All;
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action(Items)
            {
                Caption = 'Items';
                ApplicationArea = All;
                Image = Item;
                RunObject = Page "Item List";
            }
            action("Purchase credit memo line")
            {
                RunObject = Page 50075;
                ApplicationArea = All;
            }
            action("Purchase invoice line")
            {
                RunObject = Page 50072;
                ApplicationArea = All;
            }
            action("Sales Lines")
            {
                Caption = 'Sales Lines';
                ApplicationArea = All;
                RunObject = Page 50090;
            }
            action("Sales Invoice Line")
            {
                Caption = 'Sales Invoice Line';
                ApplicationArea = All;
                RunObject = Page 50073;
            }
            action("Sales Credit memo Line")
            {
                Caption = 'Sales Credit memo Line';
                ApplicationArea = All;
                RunObject = Page 50074;
            }
            action("Sales List-Short Closed")
            {
                Caption = 'Sales List-Short Closed';
                ApplicationArea = All;
                RunObject = Page 50087;
            }
            action("General ledger entries ")
            {
                RunObject = Page 20;
                ApplicationArea = All;
            }
            action(Customer)
            {
                Caption = 'Customers';
                ApplicationArea = All;
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(CustomersBalance)
            {
                Caption = 'Balance';
                ApplicationArea = All;
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Get Sales Price")
            {
                Image = SalesPrices;
                ApplicationArea = All;
                Promoted = true;
                RunObject = Page 7007;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                ApplicationArea = All;
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Reminders)
            {
                Caption = 'Reminders';
                ApplicationArea = All;
                Image = Reminder;
                RunObject = Page "Reminder List";
            }
            action("Finance Charge Memos")
            {
                Caption = 'Finance Charge Memos';
                ApplicationArea = All;
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
            }
            action("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                ApplicationArea = All;
                Image = Documents;
                RunObject = Page "Incoming Documents";
            }
            action("NOD/NOC")
            {
                Caption = 'NOD/NOC';
                ApplicationArea = All;
                //     RunObject = Page 13708;
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action(PurchaseJournals)
                {
                    Caption = 'Purchase Journals';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                }
                action(SalesJournals)
                {
                    Caption = 'Sales Journals';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                }
                action("Cash Receipt Voucher")
                {
                    Caption = 'Cash Receipt Voucher';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //   "Sub Type" = CONST("Cash Receipt Voucher"),
                                        Recurring = CONST(false));
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
                action("Bank Receipt Voucher")
                {
                    Caption = 'Bank Receipt Voucher';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //    "Sub Type" = CONST("Bank Receipt Voucher"),
                                        Recurring = CONST(false));
                }
                action(PaymentJournals)
                {
                    Caption = 'Payment Journals';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                }
                action("Cash Payment Voucher")
                {
                    Caption = 'Cash Payment Voucher';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //    "Sub Type" = CONST("Cash Payment Voucher"),
                                        Recurring = CONST(false));
                }
                action("Bank Payment Voucher")
                {
                    Caption = 'Bank Payment Voucher';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //      "Sub Type" = CONST("Bank Payment Voucher"),
                                        Recurring = CONST(false));
                }
                action(ICGeneralJournals)
                {
                    Caption = 'IC General Journals';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Intercompany),
                                        Recurring = CONST(false));
                }
                action(GeneralJournals)
                {
                    Caption = 'General Journals';
                    ApplicationArea = All;
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                }
                action("General Voucher")
                {
                    Caption = 'General Voucher';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        // "Sub Type" = CONST("Journal Voucher"),
                                        Recurring = CONST(false));
                }
                action("Contra Voucher")
                {
                    Caption = 'Contra Voucher';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //  "Sub Type" = CONST("Cash Payment Voucher"),
                                        Recurring = CONST(false));
                }
                action("Intrastat Journals")
                {
                    Caption = 'Intrastat Journals';
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Page "Intrastat Journal";
                }
            }
            group("FixedAssets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    ApplicationArea = All;
                    RunObject = Page "Fixed Asset List";
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    ApplicationArea = All;
                    RunObject = Page "Insurance List";
                }
                action("Fixed Assets G/L Journals")
                {
                    Caption = 'Fixed Assets G/L Journals';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    ApplicationArea = All;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    ApplicationArea = All;
                    RunObject = Page "FA Reclass. Journal Batches";
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    ApplicationArea = All;
                    RunObject = Page "Insurance Journal Batches";
                }
                action("<Action3>")
                {
                    Caption = 'Recurring General Journals';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                }
                action("Recurring Fixed Asset Journals")
                {
                    Caption = 'Recurring Fixed Asset Journals';
                    ApplicationArea = All;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
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
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Types")
                {
                    Caption = 'Cost Types';
                    ApplicationArea = All;
                    RunObject = Page "Chart of Cost Types";
                }
                action("Cost Centers")
                {
                    Caption = 'Cost Centers';
                    ApplicationArea = All;
                    RunObject = Page "Chart of Cost Centers";
                }
                action("Cost Objects")
                {
                    Caption = 'Cost Objects';
                    ApplicationArea = All;
                    RunObject = Page "Chart of Cost Objects";
                }
                action("Cost Allocations")
                {
                    Caption = 'Cost Allocations';
                    ApplicationArea = All;
                    RunObject = Page "Cost Allocation Sources";
                }
                action("Cost Budgets")
                {
                    Caption = 'Cost Budgets';
                    ApplicationArea = All;
                    RunObject = Page "Cost Budget Names";
                }
            }
            group(grp2)
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    ApplicationArea = All;
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Fin. Charge Memos")
                {
                    Caption = 'Issued Fin. Charge Memos';
                    ApplicationArea = All;
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    ApplicationArea = All;
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Cost Accounting Registers")
                {
                    Caption = 'Cost Accounting Registers';
                    ApplicationArea = All;
                    RunObject = Page "Cost Registers";
                }
                action("Cost Accounting Budget Registers")
                {
                    Caption = 'Cost Accounting Budget Registers';
                    ApplicationArea = All;
                    RunObject = Page "Cost Budget Registers";
                }
            }
            group("<Action40>")
            {
                Caption = 'Bank';
                action("<Page Bank Account List>")
                {
                    Caption = 'Bank Account List';
                    ApplicationArea = All;
                    RunObject = Page "Bank Account List";
                }
            }
            group(TDS)
            {
                Caption = 'TDS';
                action("<T.A.N No.>")
                {
                    Caption = 'T.A.N No.';
                    ApplicationArea = All;
                    RunObject = Page "T.A.N. Nos.";
                }

                action("<Assessee Codes>")
                {
                    Caption = 'Assessee Codes';
                    ApplicationArea = All;
                    RunObject = Page "Assessee Codes";
                }

                action("<Concessional Codes>")
                {
                    Caption = 'Concessional Codes';
                    ApplicationArea = All;
                    RunObject = Page "Concessional Codes";
                }

                action("<Parties>")
                {
                    Caption = 'Parties';
                    ApplicationArea = All;
                    //  RunObject = Page 13735;
                }
                action("<Income Tax Accounting Period>")
                {
                    Caption = 'Income Tax Accounting Period';
                    ApplicationArea = All;
                    // RunObject = Page 13721;
                }
            }
            group("<Action42>")
            {
                Caption = 'AR';
                action("<Sale Invoice>")
                {
                    Caption = 'Sales Invoice List';
                    ApplicationArea = All;
                    RunObject = Page "Sales Invoice List";
                }
                action("<Sales Credit Memo List>")
                {
                    Caption = 'Sales Credit Memo List';
                    ApplicationArea = All;
                    RunObject = Page "Sales Credit Memos";
                }

                action("<Posted Sales Invoices>")
                {
                    Caption = 'Posted Sales Invoices List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("<Posted Sales Shipments>")
                {
                    Caption = 'Posted Sales Shipments List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Shipments";
                }
                action("<Posted Sales Credit Memos>")
                {
                    Caption = 'Posted Sales Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Sales Credit Memos";
                }

            }
            group("<Action43>")
            {
                Caption = 'AP';
                Description = 'Page Purchase Invoices';
                Image = Payables;
                action("<Purchase Invoices>")
                {
                    Caption = 'Purchase Invoices List';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Invoices";
                }
                action("<Purchase Credit Memos>")
                {
                    Caption = 'Purchase Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page "Purchase Credit Memos";
                }

                action("<Posted Purchase Invoices>")
                {
                    Caption = 'Posted Purchase Invoices List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("<Posted Purchase Credit Memos>")
                {
                    Caption = 'Posted Purchase Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("<Posted Purchase Receipts>")
                {
                    Caption = 'Posted Purchase Receipts List';
                    ApplicationArea = All;
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("<Vendor Ledger Entries>")
                {
                    Caption = 'Vendor Ledger Entries';
                    ApplicationArea = All;
                    RunObject = Page "Vendor Ledger Entries";
                }
                action("<Detailed Vendor Ledg. Entries>")
                {
                    Caption = 'Detailed Vendor Ledg. Entries';
                    ApplicationArea = All;
                    RunObject = Page "Detailed Vendor Ledg. Entries";
                }
                action("Value Entries")
                {
                    Caption = 'Value Entries';
                    ApplicationArea = All;
                    RunObject = Page "Value Entries";
                }
            }
            group(Administration1)
            {
                Caption = 'Administration';
                Image = Administration;
                action(Currencies)
                {
                    Caption = 'Currencies';
                    ApplicationArea = All;
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    ApplicationArea = All;
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    ApplicationArea = All;
                    RunObject = Page "No. Series";
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    ApplicationArea = All;
                    RunObject = Page "Analysis View List";
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    ApplicationArea = All;
                    RunObject = Page "Account Schedule Names";
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                }
                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    ApplicationArea = All;
                    RunObject = Page "Bank Account Posting Groups";
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                ApplicationArea = All;
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memos";
                RunPageMode = Create;
            }
            action("P&urchase Credit Memo")
            {
                Caption = 'P&urchase Credit Memo';
                ApplicationArea = All;
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memos";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("General Journal")
            {
                Caption = 'General Journal';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page 39;
            }
            action("Inven. G/L Recon. ")
            {
                ApplicationArea = All;
                Image = "Report";
                RunObject = Page 5845;
            }
            action("Posted Sale Invoice Line")
            {
                ApplicationArea = All;
                Image = AdjustVATExemption;
                RunObject = Page 133;
            }
            action("Posted Pur. Inv.Line")
            {
                ApplicationArea = All;
                Image = CalculateInventory;
                RunObject = Page 139;
            }
            action("Posted Transfer Shipment Line")
            {
                ApplicationArea = All;
                Image = Completed;
                RunObject = Page 5758;
            }
            action("Posted Transfer Recipt Line")
            {
                ApplicationArea = All;
                Image = Links;
                RunObject = Page 5759;
            }
            action("Posted Sale Credit Memo Line")
            {
                ApplicationArea = All;
                Image = NextSet;
                RunObject = Page 135;
            }
            action("Posetd Purchase Cred.Memo Line")
            {
                ApplicationArea = All;
                Image = Agreement;
                RunObject = Page 141;
            }

            action("<Accounting Periods>")
            {
                ApplicationArea = All;
                Caption = 'Accounting Periods';
                Image = AccountingPeriods;
                RunObject = Page "Accounting Periods";
            }
            action("<Payment Terms>")
            {
                ApplicationArea = All;
                Caption = 'Payment Terms';
                Image = Payment;
                RunObject = Page 4;
            }
            action("<FA Posting Groups> ")
            {
                ApplicationArea = All;
                Caption = 'FA Posting Groups';
                Image = FixedAssets;
                RunObject = Page 5613;
            }
            action("Cas&h Receipt Journal")
            {
                ApplicationArea = All;
                Caption = 'Cas&h Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
            }
            action("Pa&yment Journal")
            {
                ApplicationArea = All;
                Caption = 'Pa&yment Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }

            action("Analysis &Views")
            {
                Caption = 'Analysis &Views';
                ApplicationArea = All;
                Image = AnalysisView;
                RunObject = Page "Analysis View List";
            }
            action("Analysis by &Dimensions")
            {
                Caption = 'Analysis by &Dimensions';
                ApplicationArea = All;
                Image = AnalysisViewDimension;
                RunObject = Page "Analysis by Dimensions";
            }
            action("Calculate Deprec&iation")
            {
                Caption = 'Calculate Deprec&iation';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
            }
            action("Import Co&nsolidation from Database")
            {
                Caption = 'Import Co&nsolidation from Database';
                ApplicationArea = All;
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report "Import Consolidation from DB";
            }
            action("Bank Account R&econciliation")
            {
                Caption = 'Bank Account R&econciliation';
                ApplicationArea = All;
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation List";
            }
            action("Adjust E&xchange Rates")
            {
                Caption = 'Adjust E&xchange Rates';
                ApplicationArea = All;
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report "Adjust Exchange Rates";
            }
            action("P&ost Inventory Cost to G/L")
            {
                Caption = 'P&ost Inventory Cost to G/L';
                ApplicationArea = All;
                Image = PostInventoryToGL;
                RunObject = Report "Post Inventory Cost to G/L";
            }

            action("C&reate Reminders")
            {
                Caption = 'C&reate Reminders';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
            }
            action("Create Finance Charge &Memos")
            {
                Caption = 'Create Finance Charge &Memos';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report "Create Finance Charge Memos";
            }

            action("Payment Service Tax")
            {
                Caption = 'Payment Service Tax';
                ApplicationArea = All;
                RunObject = Page "Payment Services";
            }
            action("VAT Settlement")
            {
                Caption = 'VAT Settlement';
                ApplicationArea = All;
                //    RunObject = Page vat settleme
            }
            action("TDS Adjustment Journal")
            {
                Caption = 'TDS Adjustment Journal';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page "TDS Adjustment Journal";
            }

            action("Intrastat &Journal")
            {
                Caption = 'Intrastat &Journal';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page "Intrastat Journal";
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                ApplicationArea = All;
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
            }
            separator(Administration)
            {
                Caption = 'Administration';

                IsHeader = true;
            }
            action("<Company Information>")
            {
                Caption = 'Company Information';
                ApplicationArea = All;
                Image = CompanyInformation;
                RunObject = Page 1;
            }
            action("General &Ledger Setup")
            {
                Caption = 'General &Ledger Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page "General Ledger Setup";
            }
            action("&Sales && Receivables Setup")
            {
                Caption = '&Sales && Receivables Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page "Sales & Receivables Setup";
            }
            action("&Purchases && Payables Setup")
            {
                Caption = '&Purchases && Payables Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
            }
            action("&Fixed Asset Setup")
            {
                Caption = '&Fixed Asset Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page "Fixed Asset Setup";
            }
            action("Change Login")
            {
                ApplicationArea = All;
                Image = Change;
                RunObject = Page 50114;
            }
            action("TDS Setup")
            {
                Caption = 'TDS Setup';
                ApplicationArea = All;
                Image = CostAccountingSetup;
                RunObject = Page "TDS Setup";
            }
            action("<Generate e-TDS>")
            {
                Caption = 'Generate e-TDS';
                ApplicationArea = All;
                Image = Register;
                //  RunObject = Page 16507;
            }
            action("<Generate Certificate No.>")
            {
                Caption = 'Generate Certificate No';
                ApplicationArea = All;
                Image = Certificate;
                // RunObject = Page 13724;
            }
            action("<Challan Register>")
            {
                Caption = 'Challan Register';
                ApplicationArea = All;
                Image = Register;
                // RunObject = Page 16506;
            }
            action("<Update TDS Reg.>")
            {
                Caption = 'Update TDS Reg.';
                ApplicationArea = All;
                Image = Register;
                // RunObject = Page 13784;
            }
            action("Cash Flow Setup")
            {
                Caption = 'Cash Flow Setup';
                ApplicationArea = All;
                Image = CashFlowSetup;
                RunObject = Page "Cash Flow Setup";
            }
            action("<Location>")
            {
                Caption = 'Location';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page 15;
            }
            action("<Report Inventory Inbound> ")
            {
                Caption = 'Inventory Inbound Report';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 5702;
            }
            action("Cost Accounting Setup")
            {
                Caption = 'Cost Accounting Setup';
                ApplicationArea = All;
                Image = CostAccountingSetup;
                RunObject = Page "Cost Accounting Setup";
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                ApplicationArea = All;
                Image = Navigate;
                RunObject = Page Navigate;
            }
            action("Import Sale Price")
            {
                Image = ImportExcel;
                ApplicationArea = All;
                //RunObject = XMLport 50000;
            }
        }
    }
}

