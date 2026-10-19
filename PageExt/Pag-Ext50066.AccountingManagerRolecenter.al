pageextension 50066 "AccountingManagerRolecenter" extends "Accounting Manager Role Center"
{
    actions
    {
        addlast(reporting)
        {
            action("Stock Report")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50070;
            }
            action("Item Availabilty By Location")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50128;
            }
            action("Change Branch")
            {
                Applicationarea = All;
                RunObject = Page 50036;
            }
            action("Proformance Report")
            {
                Applicationarea = All;
                RunObject = Page 50084;
            }
            action("Monthly Sales Report")
            {
                Applicationarea = All;
                Image = "Report";
                // RunObject = Report 50017;
            }
            action("Flock Performance Report")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50035;
            }
            action("Product Wise Sale")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50018;
            }
            action("Item Wise Purchase Cost")
            {
                Applicationarea = All;
                RunObject = Report 50020;
            }
            action("<Vendor Detail Trial Balance>")
            {
                Applicationarea = All;
                Caption = 'Vendor Detail Trial Balance';
                Image = "Report";
                RunObject = Report 304;
            }
            action("<Vendor Balance to Date>")
            {
                Applicationarea = All;
                Caption = 'Vendor Balance to Date';
                Image = "Report";
                RunObject = Report 321;
            }

            action("Sales Planing")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50063;
            }
            action("Liquidation Report")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50036;
            }
            action("Transfer Report")
            {
                Applicationarea = All;
                Caption = 'Transfer Report';
                Image = "Report";
                RunObject = Report 50075;
            }
            action("Sales Report (CBF)")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50067;
            }
            action("Closing Dashbord Report")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report 50021;
            }
        }
        addafter("&Fiscal Year Balance")
        {

            action("TDS Adjustment Journal")
            {
                Applicationarea = All;
                Caption = 'TDS Adjustment Journal';
                RunObject = Page "TDS Adjustment Journal";
                RunPageMode = Edit;
            }


            action("TDS entry")
            {
                Applicationarea = All;
                RunObject = Report 50072;
            }
        }
        addbefore("Aged Accounts &Receivable")
        {
            action("Get Sales Price")
            {
                Applicationarea = All;
                Caption = 'Get Sales Price';
                Image = List;
                RunObject = Page "Sales Prices";
            }
        }
        addbefore("Reconcile Cus&t. and Vend. Accs")
        {
            action("Creditor Wise")
            {
                Applicationarea = All;
                Caption = '<Aged Account Payable Creditor Wise>';
                Image = "Report";
                RunObject = Report 50001;
            }
            action("<Mini Statement>")
            {
                Applicationarea = All;
                Caption = 'Mini Statement';
                Image = "Report";
                RunObject = Report 1316;
            }

            action("Sales Price")
            {
                Applicationarea = All;
                Image = "Sales Price";
                //   RunObject = XMLport 50000;
            }
        }

        addbefore(Administration)
        {
            group("<Action40>")
            {
                Caption = 'Bank';
                action("<Page Bank Account List>")
                {
                    Applicationarea = All;
                    Caption = 'Bank Account List';
                    RunObject = Page "Bank Account List";
                }
            }
            group("<Action42>")
            {
                Caption = 'AR';
                action("<Sale Invoice>")
                {
                    Applicationarea = All;
                    Caption = 'Sales Invoice List';
                    RunObject = Page "Sales Invoice List";
                }
                action("<Sales Credit Memo List>")
                {
                    Applicationarea = All;
                    Caption = 'Sales Credit Memo List';
                    RunObject = Page "Sales Credit Memos";
                }

                action("<Posted Sales Invoices>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Sales Invoices List';
                    RunObject = Page "Posted Sales Invoices";
                }
                action("<Posted Sales Shipments>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Sales Shipments List';
                    RunObject = Page "Posted Sales Shipments";
                }
                action("<Posted Sales Credit Memos>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Sales Credit Memos List';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Purchase Credit Line")
                {
                    Applicationarea = All;
                    RunObject = Page "Purch. Cr. Memo Line";
                }
                action("Purchase Invoice Line")
                {
                    Applicationarea = All;
                    RunObject = Page 50072;
                }

            }
            group("<Action43>")
            {
                Caption = 'AP';
                Description = 'Page Purchase Invoices';
                Image = Payables;
                action("<Purchase Invoices>")
                {
                    Applicationarea = All;
                    Caption = 'Purchase Invoices List';
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Return Order")
                {
                    Applicationarea = All;
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 6643;
                }
                action("<Purchase Credit Memos>")
                {
                    Applicationarea = All;
                    Caption = 'Purchase Credit Memos List';
                    RunObject = Page "Purchase Credit Memos";
                }

                action("<Posted Purchase Invoices>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Purchase Invoices List';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("<Posted Purchase Credit Memos>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Purchase Credit Memos List';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("<Posted Purchase Receipts>")
                {
                    Applicationarea = All;
                    Caption = 'Posted Purchase Receipts List';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("<Vendor Ledger Entries>")
                {
                    Applicationarea = All;
                    Caption = 'Vendor Ledger Entries';
                    RunObject = Page "Vendor Ledger Entries";
                }
                action("<Detailed Vendor Ledg. Entries>")
                {
                    Applicationarea = All;
                    Caption = 'Detailed Vendor Ledg. Entries';
                    RunObject = Page "Detailed Vendor Ledg. Entries";
                }
                action("Value Entries")
                {
                    Applicationarea = All;
                    Caption = 'Value Entries';
                    RunObject = Page "Value Entries";
                }
            }

        }
        addafter("Cas&h Receipt Journal")
        {

            action("General Journal")
            {
                Applicationarea = All;
                RunObject = Page "General Journal";
            }
            action("<Bank Receipt Voucher>")
            {
                Applicationarea = All;
                Caption = 'Bank Receipt Voucher';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Voucher";
            }
        }
        addafter("Adjust E&xchange Rates")
        {
            action("Brokrage Commission Report")
            {
                Applicationarea = All;
                Caption = 'Brokrage Commission Report';
                Image = "Report";
                RunObject = Report 50010;
            }
        }
        addafter("&Fixed Asset Setup")
        {
            action("TDS Setup")
            {
                Applicationarea = All;
                Caption = 'TDS Setup';
                Image = CostAccountingSetup;
                RunObject = Page "TDS Setup";
            }
        }
    }
}
