page 50089 "NAV Farm Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(Group)
            {
                part(Finance; 762)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part("Account Manager activities"; 9030)
                {
                    ApplicationArea = All;
                }
                part("Customer"; 9150)
                {
                    ApplicationArea = All;
                }
            }
            group(Grp)
            {
                part("Sales Order Chart"; 760)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part("My Job Queue"; 675)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part("Vendor"; 9151)
                {
                    ApplicationArea = All;
                }
                part(Reports; 681)
                {
                    ApplicationArea = All;
                }

                systempart(Notes; MyNotes)
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
            action("<Vendor Detail Trial Balance>")
            {
                Caption = 'Vendor Detail Trial Balance';
                Image = "Report";
                RunObject = Report 304;
                ApplicationArea = All;
            }
            action("<Vendor Balance to Date>")
            {
                Caption = 'Vendor Balance to Date';
                Image = "Report";
                RunObject = Report 321;
                ApplicationArea = All;
            }
            action("<Vendor Item wise MRN Report>")
            {
                Caption = 'Vendor Item wise MRN Report';
                Image = "Report";
                RunObject = Report 50054;
                ApplicationArea = All;
            }
            action("Vendor Statement")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50007;
                ApplicationArea = All;
            }
            action("&G/L Trial Balance")
            {
                Caption = '&G/L Trial Balance';
                Image = "Report";
                RunObject = Report 6;
                ApplicationArea = All;
            }
            action("&Bank Detail Trial Balance")
            {
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report 1404;
                ApplicationArea = All;
            }
            action("&Account Schedule")
            {
                Caption = '&Account Schedule';
                Image = "Report";
                RunObject = Report 25;
                ApplicationArea = All;
            }
            action("Bu&dget")
            {
                Caption = 'Bu&dget';
                Image = "Report";
                RunObject = Report 8;
                ApplicationArea = All;
            }
            action("Trial Bala&nce/Budget")
            {
                Caption = 'Trial Bala&nce/Budget';
                Image = "Report";
                RunObject = Report 9;
                ApplicationArea = All;
            }
            action("Trial Balance by &Period")
            {
                Caption = 'Trial Balance by &Period';
                Image = "Report";
                RunObject = Report 38;
                ApplicationArea = All;
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report 36;
                ApplicationArea = All;
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                Caption = 'Balance Comp. - Prev. Y&ear';
                Image = "Report";
                RunObject = Report 37;
                ApplicationArea = All;
            }
            action("&Closing Trial Balance")
            {
                Caption = '&Closing Trial Balance';
                Image = "Report";
                RunObject = Report 10;
                ApplicationArea = All;
            }

            action("Cash Flow Date List")
            {
                Caption = 'Cash Flow Date List';
                Image = "Report";
                RunObject = Report 846;
                ApplicationArea = All;
            }


            action("TDS entry")
            {
                RunObject = Report 50014;
                ApplicationArea = All;
            }


            action("Aged Accounts &Receivable")
            {
                Caption = 'Aged Accounts &Receivable';
                Image = "Report";
                RunObject = Report 120;
                ApplicationArea = All;
            }
            action("Aged Accounts Pa&yable")
            {
                Caption = 'Aged Accounts Pa&yable';
                Image = "Report";
                RunObject = Report 322;
                ApplicationArea = All;
            }
            action("<Mini Statement>")
            {
                Caption = 'Mini Statement';
                Image = "Report";
                RunObject = Report 1316;
                ApplicationArea = All;
            }


            action("Reconcile Cus&t. and Vend. Accs")
            {
                Caption = 'Reconcile Cus&t. and Vend. Accs';
                Image = "Report";
                RunObject = Report 33;
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page 16;
                ApplicationArea = All;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
                ApplicationArea = All;
            }
            action(VendorsBalance)
            {
                Caption = 'Balance';
                ApplicationArea = All;
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                ApplicationArea = All;
                RunObject = Page "Purchase Orders";
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
            action(Customers)
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
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                ApplicationArea = All;
                Image = "Order";
                RunObject = Page "Sales Orders";
            }

            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                ApplicationArea = All;
                RunObject = Page 1306;
            }

            action(Reminders)
            {
                Caption = 'Reminders';
                ApplicationArea = All;
                Image = Reminder;
                RunObject = Page Reminder;
            }
            action("Finance Charge Memos")
            {
                Caption = 'Finance Charge Memos';
                ApplicationArea = All;
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo";
            }
            action("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                ApplicationArea = All;
                Image = Documents;
                RunObject = Page "Incoming Document";
            }
            action("NOD/NOC")
            {
                Caption = 'NOD/NOC';
                ApplicationArea = All;
                //   RunObject = Page 13708;
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
                                        // "Sub Type" = CONST("Bank Receipt Voucher"),
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
                                        //   "Sub Type" = CONST('Cash Payment Voucher'),
                                        Recurring = CONST(false));
                }
                action("Bank Payment Voucher")
                {
                    Caption = 'Bank Payment Voucher';
                    ApplicationArea = All;
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //  "Sub Type" = CONST('Bank Payment Voucher'),
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
                                        //   "Sub Type" = CONST('Journal Voucher'),
                                        Recurring = CONST(false));
                }
                action("Contra Voucher")
                {
                    Caption = 'Contra Voucher';
                    ApplicationArea = All;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        //     "Sub Type" = CONST("Cash Payment Voucher"),
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
            group("Fixed Assets1")
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
                    RunObject = Page "Fixed Asset G/L Journal";
                    //   RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    ApplicationArea = All;
                    RunObject = Page "Fixed Asset G/L Journal";
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    ApplicationArea = All;
                    RunObject = Page "Insurance Journal";
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
                    RunObject = Page "Recurring Fixed Asset Journal";
                    //      RunPageView = WHERE(Recurring = CONST(true));
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
                    RunObject = Page "Cash Flow Account List";
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    ApplicationArea = All;
                    RunObject = Page "Cash Flow Comment List";
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
            group("Posted Documents1")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page 143;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page 144;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    ApplicationArea = All;
                    RunObject = Page 146;
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    ApplicationArea = All;
                    RunObject = Page 147;
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    ApplicationArea = All;
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Issued Fin. Charge Memos")
                {
                    Caption = 'Issued Fin. Charge Memos';
                    ApplicationArea = All;
                    Image = PostedMemo;
                    RunObject = Page 452;
                }
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    ApplicationArea = All;
                    Image = GLRegisters;
                    RunObject = Page 116;
                }
                action("Cost Accounting Registers")
                {
                    Caption = 'Cost Accounting Registers';
                    ApplicationArea = All;
                    RunObject = Page 1104;
                }
                action("Cost Accounting Budget Registers")
                {
                    Caption = 'Cost Accounting Budget Registers';
                    ApplicationArea = All;
                    RunObject = Page 1121;
                }
            }
            group("<Action40>")
            {
                Caption = 'Bank';
                action("<Page Bank Account List>")
                {
                    Caption = 'Bank Account List';
                    ApplicationArea = All;
                    RunObject = Page 371;
                }
            }
            group("<Action42>")
            {
                Caption = 'AR';
                action("<Sale Invoice>")
                {
                    Caption = 'Sales Invoice List';
                    ApplicationArea = All;
                    RunObject = Page 9301;
                }
                action("<Sales Credit Memo List>")
                {
                    Caption = 'Sales Credit Memo List';
                    ApplicationArea = All;
                    RunObject = Page 9302;
                }

                action("<Posted Sales Invoices>")
                {
                    Caption = 'Posted Sales Invoices List';
                    ApplicationArea = All;
                    RunObject = Page 143;
                }
                action("<Posted Sales Shipments>")
                {
                    Caption = 'Posted Sales Shipments List';
                    ApplicationArea = All;
                    RunObject = Page 142;
                }
                action("<Posted Sales Credit Memos>")
                {
                    Caption = 'Posted Sales Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page 144;
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
                    RunObject = Page 9308;
                }
                action("Purchase Return Order")
                {
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 6643;
                    ApplicationArea = All;
                }
                action("<Purchase Credit Memos>")
                {
                    Caption = 'Purchase Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page 9309;
                }


                action("<Posted Purchase Invoices>")
                {
                    Caption = 'Posted Purchase Invoices List';
                    ApplicationArea = All;
                    RunObject = Page 146;
                }
                action("<Posted Purchase Credit Memos>")
                {
                    Caption = 'Posted Purchase Credit Memos List';
                    ApplicationArea = All;
                    RunObject = Page 147;
                }
                action("<Posted Purchase Receipts>")
                {
                    Caption = 'Posted Purchase Receipts List';
                    ApplicationArea = All;
                    RunObject = Page 145;
                }
                action("<Vendor Ledger Entries>")
                {
                    Caption = 'Vendor Ledger Entries';
                    ApplicationArea = All;
                    RunObject = Page 29;
                }
                action("<Detailed Vendor Ledg. Entries>")
                {
                    Caption = 'Detailed Vendor Ledg. Entries';
                    ApplicationArea = All;
                    RunObject = Page 574;
                }
                action("Value Entries")
                {
                    Caption = 'Value Entries';
                    ApplicationArea = All;
                    RunObject = Page 5802;
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
                    RunObject = Page 5;
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    ApplicationArea = All;
                    Image = AccountingPeriods;
                    RunObject = Page 100;
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    ApplicationArea = All;
                    RunObject = Page 456;
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    ApplicationArea = All;
                    RunObject = Page 556;
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    ApplicationArea = All;
                    RunObject = Page 103;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    Image = Dimensions;
                    RunObject = Page 536;
                }
                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    ApplicationArea = All;
                    RunObject = Page 373;
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
                RunObject = Page 44;
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
                RunObject = Page 52;
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
            action("Cas&h Receipt Journal")
            {
                Caption = 'Cas&h Receipt Journal';
                ApplicationArea = All;
                Image = CashReceiptJournal;
                RunObject = Page 255;
            }
            action("General Journal")
            {
                RunObject = Page 39;
                ApplicationArea = All;
            }
            action("<Bank Receipt Voucher>")
            {
                Caption = 'Bank Receipt Voucher';
                ApplicationArea = All;
                Image = CashReceiptJournal;
                RunObject = Page "Bank Receipt Voucher";
            }
            action("Pa&yment Journal")
            {
                Caption = 'Pa&yment Journal';
                ApplicationArea = All;
                Image = PaymentJournal;
                RunObject = Page 256;
            }

            action("Analysis &Views")
            {
                Caption = 'Analysis &Views';
                ApplicationArea = All;
                Image = AnalysisView;
                RunObject = Page 556;
            }
            action("Analysis by &Dimensions")
            {
                Caption = 'Analysis by &Dimensions';
                ApplicationArea = All;
                Image = AnalysisViewDimension;
                RunObject = Page 554;
            }
            action("Calculate Deprec&iation")
            {
                Caption = 'Calculate Deprec&iation';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report 5692;
            }
            action("Import Co&nsolidation from Database")
            {
                Caption = 'Import Co&nsolidation from Database';
                ApplicationArea = All;
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report 90;
            }
            action("Bank Account R&econciliation")
            {
                Caption = 'Bank Account R&econciliation';
                ApplicationArea = All;
                Image = BankAccountRec;
                RunObject = Page 379;
            }
            action("Adjust E&xchange Rates")
            {
                Caption = 'Adjust E&xchange Rates';
                ApplicationArea = All;
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report 595;
            }
            action("Brokrage Commission Report")
            {
                Caption = 'Brokrage Commission Report';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 50010;
            }
            action("P&ost Inventory Cost to G/L")
            {
                Caption = 'P&ost Inventory Cost to G/L';
                ApplicationArea = All;
                Image = PostInventoryToGL;
                RunObject = Report 1002;
            }

            action("C&reate Reminders")
            {
                Caption = 'C&reate Reminders';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report 188;
            }
            action("Create Finance Charge &Memos")
            {
                Caption = 'Create Finance Charge &Memos';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report 191;
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
                //  RunObject = Page vat settle
            }
            action("TDS Adjustment Journal")
            {
                Caption = 'TDS Adjustment Journal';
                ApplicationArea = All;
                RunObject = Page "TDS Adjustment Journal";
            }

            action("Intrastat &Journal")
            {
                Caption = 'Intrastat &Journal';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page 327;
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                ApplicationArea = All;
                Image = SettleOpenTransactions;
                RunObject = Report 20;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("General &Ledger Setup")
            {
                Caption = 'General &Ledger Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page 118;
            }
            action("&Sales && Receivables Setup")
            {
                Caption = '&Sales && Receivables Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page 459;
            }
            action("&Purchases && Payables Setup")
            {
                Caption = '&Purchases && Payables Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page 460;
            }
            action("&Fixed Asset Setup")
            {
                Caption = '&Fixed Asset Setup';
                ApplicationArea = All;
                Image = Setup;
                RunObject = Page 5607;
            }
            action("TDS Setup")
            {
                Caption = 'TDS Setup';
                ApplicationArea = All;
                Image = CostAccountingSetup;
                RunObject = Page "TDS Setup";
            }
            action("Cash Flow Setup")
            {
                Caption = 'Cash Flow Setup';
                ApplicationArea = All;
                Image = CashFlowSetup;
                RunObject = Page 846;
            }
            action("Cost Accounting Setup")
            {
                Caption = 'Cost Accounting Setup';
                ApplicationArea = All;
                Image = CostAccountingSetup;
                RunObject = Page 1113;
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
                RunObject = Page 344;
            }
        }
    }
}

