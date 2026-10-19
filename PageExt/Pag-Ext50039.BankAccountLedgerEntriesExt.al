pageextension 50039 "Bank Account Ledger EntriesExt" extends "Bank Account Ledger Entries"
{
    layout
    {

    }

    actions
    {
        modify("Print Voucher")
        {
            Visible = false;
        }
        addafter(Narration)
        {
            action("Posted Voucher")
            {
                ApplicationArea = All;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = New;
                Ellipsis = true;
                Caption = 'Print Voucher';
                //Visible = SFPLVisiblePostedVou;

                trigger OnAction()
                var
                    GLEntry: Record 17;
                begin
                    CompanyInfo.Get;
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
                        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                        GLEntry.SETRANGE("Document No.", rec."Document No.");
                        GLEntry.SETRANGE("Posting Date", rec."Posting Date");
                        GLEntry.SETFILTER("Source Code", '<>%1', 'INVTPCOST');
                        IF GLEntry.FINDFIRST THEN
                            REPORT.RUNMODAL(REPORT::"Posted Voucher1", TRUE, TRUE, GLEntry);

                    end else begin
                        GLEntry.SetCurrentKey("Document No.", "Posting Date");
                        GLEntry.SetRange("Document No.", "Document No.");
                        GLEntry.SetRange("Posting Date", "Posting Date");
                        if GLEntry.FindFirst() then
                            Report.RunModal(Report::"Posted Voucher", true, true, GLEntry);
                    end;
                end;

            }

        }
    }
    var
        CompanyInfo: Record "Company Information";
}