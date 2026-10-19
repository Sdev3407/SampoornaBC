pageextension 50010 CustomerLedgerEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("CustomerName"; Rec."Customer Name")
            {
                ApplicationArea = All;

            }

            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = all;
            }
        }
        moveafter(CustomerName; "Document Date")

        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = true;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 3 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 4 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 5 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 6 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 7 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 8 Code")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Certificate No.")
        {
            Visible = false;
        }
        modify("TDS Certificate Amount")
        {
            Visible = false;
        }
        modify("TDS Certificate Rcpt Date")
        {
            Visible = false;
        }
        modify("TDS Certificate Receivable")
        {
            Visible = false;
        }
        modify("TDS Certificate Received")
        {
            Visible = false;
        }
        modify("TDS Section Code")
        {
            Visible = false;
        }
        modify("Certificate Received")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Remaining Amt. (LCY)")
        {
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify(RecipientBankAccount)
        {
            Visible = false;
        }
        modify("GST on Advance Payment")
        {
            Visible = false;
        }
        modify("GST Without Payment of Duty")
        {
            Visible = false;
        }
        modify("GST Customer Type")
        {
            Visible = false;
        }
        modify("Seller State Code")
        {
            Visible = false;
        }
        modify("Seller GST Reg. No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("GST Jurisdiction Type")
        {
            Visible = false;
        }
        modify("Location GST Reg. No.")
        {
            Visible = false;
        }
        moveafter("Customer Name"; "External Document No.")
        moveafter(Description; "Debit Amount")
        moveafter("Debit Amount"; "Debit Amount (LCY)")
        moveafter("Debit Amount (LCY)"; "Credit Amount")
        moveafter("Credit Amount"; "Credit Amount (LCY)")
        moveafter("On Hold"; "GST Group Code")
        moveafter("GST Group Code"; "HSN/SAC Code")

        addafter("Exported to Payment File")
        {
            field("Shortcut Dimension 3Code"; Rec."Shortcut Dimension 3Code")
            {
                ApplicationArea = All;

            }
            field("Line Narration"; Rec."Line Narration1")
            {
                ApplicationArea = All;
                Caption = 'Line Narration';
            }
            field("Order Qty"; Rec."Order Qty")
            {
                ApplicationArea = All;

            }
            field("Order Memo Qty"; Rec."Order Memo Qty")
            {
                ApplicationArea = All;

            }

            field("Closed by Amount"; Rec."Closed by Amount")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Closed by Amount"; "Closed at Date")



    }
    actions
    {
        modify("Print Voucher")
        {
            Visible = False;
        }
        addafter("Line Narration")
        {
            action("Posted Voucher")
            {
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                Caption = 'Print Voucher';
                //Visible = SFPLVisiblePostedVou;

                Applicationarea = All;
                trigger OnAction()
                var
                    GLEntry: Record 17;
                begin
                    // CompanyInfo.Get;
                    // if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", rec."Document No.");
                    GLEntry.SETRANGE("Posting Date", rec."Posting Date");
                    GLEntry.SETFILTER("Source Code", '<>%1', 'INVTPCOST');
                    IF GLEntry.FINDFIRST THEN
                        REPORT.RUNMODAL(REPORT::"Posted Voucher1", TRUE, TRUE, GLEntry);

                    // end else begin
                    //     GLEntry.SetCurrentKey("Document No.", "Posting Date");
                    //     GLEntry.SetRange("Document No.", "Document No.");
                    //     GLEntry.SetRange("Posting Date", "Posting Date");
                    //     if GLEntry.FindFirst() then
                    //         Report.RunModal(Report::"Posted Voucher", true, true, GLEntry);
                    // end;
                end;
            }
        }
        addafter("Show Document")
        {
            action("Customer Statement CBF")
            {
                ApplicationArea = All;
                Caption = 'Customer Statement CBF';
                Image = "Report";
                RunObject = Report "Customer statement CBF";
            }

            action("Update Reference Invoice No")
            {
                Caption = 'Update Reference Invoice No';
                Image = UpdateDescription;

                Applicationarea = All;
                trigger OnAction()
                var
                    CustLedgerEntry: Record 21;
                    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    UpdateReferenceInvoiceNo: Page "Update Reference Invoice No";
                    SourceType: Option Vendor,Customer;
                begin
                    CustLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                    CustLedgerEntry.SETRANGE("Customer No.", Rec."Customer No.");
                    IF CustLedgerEntry.FINDFIRST THEN BEGIN
                        DetailedGSTLedgerEntry.SETRANGE("Document No.", Rec."Document No.");
                        // DetailedGSTLedgerEntry.SETRANGE("Document Type", "Document Type");
                        DetailedGSTLedgerEntry.SETRANGE("Source No.", Rec."Customer No.");
                        IF DetailedGSTLedgerEntry.FINDFIRST THEN
                            IF (Rec."Document Type" IN [Rec."Document Type"::"Credit Memo"])
                            THEN BEGIN
                                ReferenceInvoiceNo.SETRANGE("Document No.", Rec."Document No.");
                                //  ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                                ReferenceInvoiceNo.SETRANGE("Source No.", Rec."Sell-to Customer No.");
                                //UpdateReferenceInvoiceNo.CustomerRecord(SourceType::Customer);
                                UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                                UpdateReferenceInvoiceNo.RUNMODAL;
                            END ELSE
                                MESSAGE(ReferenceNoMsg)
                        ELSE
                            ERROR(ReferenceInvoiceErr);
                    END;
                end;
            }
            action("Update Line Narration")
            {
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    NavigateandUpdateNaration: Page "Navigate and Update Naration";
                begin
                    CLEAR(NavigateandUpdateNaration);
                    NavigateandUpdateNaration.SetDoc("Posting Date", Rec."Document No.");
                    NavigateandUpdateNaration.RUN;
                end;
            }

        }
    }



    trigger OnOpenPage()
    begin
        CompanyInfo.Get;
        StarVisiblePostedVou := True;
        SFPLVisiblePostedVou := False;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Reverse Transaction", TRUE);
        IF UserSetup.FINDFIRST THEN
            ReverseTransVisible := TRUE
        ELSE
            ReverseTransVisible := FALSE;

        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
            StarVisiblePostedVou := False;
            SFPLVisiblePostedVou := True;
        end;
        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
            UserSetup.Reset();
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SetRange("User Type", UserSetup."User Type"::"Feed Plant");
            if UserSetup.FindFirst() then
                Error('You Can not open the Customer Ledger Entry');
        end;
    end;





    var
        myInt: Integer;
        UserSetup: Record 91;
        ReverseTransVisible: Boolean;
        ReferenceInvoiceErr: Label 'Reference Inovice No is not require updation for Non-GST Document.';
        ReferenceNoMsg: Label 'Reference Invoice No is required where Invoice Type Debit Note and Supplementary.';
        CompanyInfo: Record "Company Information";
        StarVisiblePostedVou: Boolean;
        SFPLVisiblePostedVou: Boolean;


}