page 50056 "Bankkeeper Role Center"
{
    // BANK RECO & PAYMENT
    // **********************

    Caption = 'Role Center';
    PageType = RoleCenter;
    // ApplicationArea = All;
    //UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(grp)
            {
                part(Accounting; 9070)
                {
                    ApplicationArea = All;
                }
                part(Customer; 9150)
                {
                    ApplicationArea = All;
                }
            }
            group(grop)
            {
                part("JOb Queue"; 675)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Vendor; 9151)
                {
                    ApplicationArea = All;
                }
                part(reports; 681)
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
            action("A&ccount Schedule")
            {
                Caption = 'A&ccount Schedule';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 25;
            }
            group("Bank Report")
            {
                Caption = 'Bank Report';
                Image = Balance;
                action("<Report Bank Account - List>")
                {
                    Caption = 'Bank Account - List';
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Report 1402;
                }
                action("Bank &Detail Trial Balance")
                {
                    Caption = 'Bank &Detail Trial Balance';
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Report 1404;
                }
                action("<Report Bank Account Register>")
                {
                    Caption = 'Bank Account Register';
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Report 1403;
                }
                action("<Report Bank Account Statementd>")
                {
                    Caption = 'Bank Account Statement';
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Report 1407;
                }
            }


            action("&Aged Accounts Receivable")
            {
                Caption = '&Aged Accounts Receivable';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 120;
            }
            action("Aged Accou&nts Payable")
            {
                Caption = 'Aged Accou&nts Payable';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 322;
            }
            action("Reconcile Cust. and &Vend. Accs")
            {
                Caption = 'Reconcile Cust. and &Vend. Accs';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 33;
            }


        }
        area(embedding)
        {
            ToolTip = 'Collect and make payments, prepare statements, and manage reminders.';
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                ApplicationArea = All;
                RunObject = Page 16;
            }
            action("Bank Accounts")
            {
                Caption = 'Bank Accounts';
                ApplicationArea = All;
                Image = BankAccount;
                RunObject = Page "Bank Account List";
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
            action(Vendors)
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
            action(VendorsPaymentonHold)
            {
                Caption = 'Payment on Hold';
                ApplicationArea = All;
                RunObject = Page 27;
                RunPageView = WHERE(Blocked = FILTER(Payment));
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
                Caption = 'Payment Journals';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(payments),
                                    Recurring = CONST(false));
            }
            action(RecurringGeneralJournals)
            {
                Caption = 'Recurring General Journals';
                ApplicationArea = All;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(true));
            }
            action("Cash Receipt Voucher")
            {
                Caption = 'Cash Receipt Voucher';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    //"Sub Type" = CONST("Cash Receipt Voucher"),
                                    Recurring = CONST(false));
            }
            action("Bank Receipt Voucher")
            {
                Caption = 'Bank Receipt Voucher';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("General"),
                                    //   "Sub Type" = CONST("Bank Receipt Voucher"),
                                    Recurring = CONST(false));
            }
            action("Journal Voucher")
            {
                Caption = 'Journal Voucher';
                ApplicationArea = All;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    //  "Sub Type" = CONST("Journal Voucher"),
                                    Recurring = CONST(false));
            }
            action("Contra Voucher")
            {
                Caption = 'Contra Voucher';
                ApplicationArea = All;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    //   "Sub Type" = CONST("Contra Voucher"),
                                    Recurring = CONST(false));
            }
            action("Cash Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    // "Sub Type" = CONST("Cash Payment Voucher"),
                                    Recurring = CONST(false));
            }
            action("Bank Payment Voucher")
            {
                Caption = 'Bank Payment Voucher';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    //   "Sub Type" = CONST("Bank Receipt Voucher"),
                                    Recurring = CONST(false));
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View posted invoices and credit memos, and analyze G/L registers.';
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
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    ApplicationArea = All;
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Cash Re&ceipt Journal")
            {
                Caption = 'Cash Re&ceipt Journal';
                ApplicationArea = All;
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
            }
            action("<General Journal>")
            {
                Caption = 'General Journal';
                ApplicationArea = All;
                Image = Journal;
                RunObject = Page "General Journal";
            }
            action("<Bank Receipt>")
            {
                Caption = 'Bank Receipt';
                ApplicationArea = All;
                Image = Payment;
                RunObject = Page "Bank Receipt Voucher";
            }
            action("<Bank Payment>")
            {
                Caption = 'Bank Payment';
                ApplicationArea = All;
                Image = Journals;
                RunObject = Page "Bank Payment Voucher";
            }
            action("Payment &Journal")
            {
                Caption = 'Payment &Journal';
                ApplicationArea = All;
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            action("Payment Registration")
            {
                Caption = 'Payment Registration';
                ApplicationArea = All;
                Image = Payment;
                RunObject = Page 981;
            }

            action("B&ank Account Reconciliations")
            {
                Caption = 'B&ank Account Reconciliations';
                ApplicationArea = All;
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation List";
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
        }
    }
}

