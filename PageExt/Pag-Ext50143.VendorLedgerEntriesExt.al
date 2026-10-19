pageextension 50143 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Remit-to Code")
        {
            Visible = false;
        }
        modify("GST Vendor Type")
        {
            Visible = false;
        }
        modify("GST Input Service Distribution")
        {
            Visible = false;
        }
        modify("Buyer State Code")
        {
            Visible = false;
        }
        modify("Buyer GST Reg. No.")
        {
            Visible = false;
        }
        modify("GST Jurisdiction Type")
        {
            Visible = false;
        }
        modify("Location State Code")
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


        addafter("Vendor No.")
        {
            field("VendorName"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Applied PO No."; Rec."Applied PO No.")
            {
                ApplicationArea = All;
            }

        }

        moveafter("Vendor Name"; Description)
        moveafter(Description; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Original Amount"; Amount)
        moveafter(Amount; "TDS Section Code")
        moveafter("TDS Section Code"; "Amount (LCY)")
        modify("Remaining Amt. (LCY)")
        {
            Visible = false;
        }
        moveafter("Remaining Amount"; "Closed at Date")
        moveafter("Closed at Date"; "Document Date")

        moveafter("On Hold"; "Currency Code")
        modify(RecipientBankAcc)
        {
            Visible = false;
        }
        moveafter("Location Code"; "Location GST Reg. No.")
        moveafter("Location GST Reg. No."; "GST on Advance Payment")
        moveafter("GST on Advance Payment"; "GST Group Code")
        addafter("GST Reverse Charge")
        {
            field("Shortcut Dimension 3Code"; Rec."Shortcut Dimension 3Code")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;

            }
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Closed by Amount"; Rec."Closed by Amount")
            {
                ApplicationArea = All;
            }
            field("Security Group Code"; rec."Security Group Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(SystemCreatedAt; SystemCreatedAt)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        /*
                    }
                   
                   
                    
                    field("Vendor P.A.N No"; Rec."Vendor P.A.N No")
                    {
                        ApplicationArea = All;

                    }
                    field("Applied PO No."; Rec."Applied PO No.")
                    {
                        ApplicationArea = All;

                    }
                }*/
    }
    actions
    {
        modify(ActionApplyEntries)
        {
            ApplicationArea = All;

            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Message('Test')
            end;
        }
        modify("Print Voucher")
        {
            Visible = false;


        }
        addafter("Line Narration")
        {
            action("Posted Voucher")
            {
                ApplicationArea = All;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                Caption = 'Print Voucher';
                //Visible = SFPLVisiblePostedVou;

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

            action("Update Line Narration")
            {
                ApplicationArea = All;
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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

        StarVisiblePostedVou := true;
        SFPLVisiblePostedVou := false;
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
    end;

    var
        Navigate: Page Navigate;
        StyleTxt: Text;
        HasIncomingDocument: Boolean;
        UserSetup: Record 91;
        ReverseTransVisible: Boolean;
        ReferenceNoMsg: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        ReferenceInvoiceErr: Label 'Reference Inovice No is not require updation for Non-GST Document.';
        StarVisiblePostedVou: Boolean;
        SFPLVisiblePostedVou: Boolean;
        CompanyInfo: Record "Company Information";
}
