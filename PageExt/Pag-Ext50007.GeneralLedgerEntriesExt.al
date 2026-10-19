pageextension 50007 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    layout
    {

        modify("Shortcut Dimension 3 Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 4 Code")
        {
            Visible = true;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addafter(Amount)
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = all;
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;

            }
            field("Bal.Account Name"; Rec."Bal.Account Name")
            {
                ApplicationArea = All;

            }

            field("Line Narration"; Rec."Line Narration1")
            {
                ApplicationArea = All;
                Caption = 'Line Narration';
            }
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Flock Code"; Rec."Flock Code")
            {
                ApplicationArea = All;

            }
            field("FEED Freight Charge"; Rec."FEED Freight Charge")
            {
                ApplicationArea = All;

            }
            field("Entry Date"; Rec."Entry Date")
            {
                ApplicationArea = All;

            }
            field("Group By"; Rec."Group By")
            {
                ApplicationArea = All;

            }
            field("Group by Shorting"; Rec."Group by Shorting")
            {
                ApplicationArea = All;

            }


        }
        addafter(IncomingDocAttachFactBox)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"G/L Entry"),
                              "No." = field("Document No.");
                //Visible = NOT IsOfficeAddin;
            }
        }
    }
    actions
    {
        modify("Print Voucher")
        {
            Visible = false;

            // trigger OnAfterAction()
            // var
            //     GLEntry: Record "G/L Entry";
            // begin
            //     GLEntry.SetCurrentKey("Document No.", "Posting Date");
            //     GLEntry.SetRange("Document No.", "Document No.");
            //     GLEntry.SetRange("Posting Date", "Posting Date");
            //     if GLEntry.FindFirst() then
            //         Report.RunModal(Report::"Posted Voucher", true, true, GLEntry);
            // end;
        }
        addafter(DocsWithoutIC)
        {
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
                //"50083";
                begin
                    CLEAR(NavigateandUpdateNaration);
                    NavigateandUpdateNaration.SetDoc(Rec."Posting Date", Rec."Document No.");
                    NavigateandUpdateNaration.RUN;
                end;
            }
        }
        addafter("Line Narration")
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
    }


    trigger OnOpenPage()
    begin
        CompanyInfo.get;
        StarVisiblePostedVou := true;
        SFPLVisiblePostedVou := false;

        UserSetup.GET(USERID);
        IF NOT UserSetup."HO Users" THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            Rec.SETFILTER("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            //SETFILTER("Shortcut Dimension 3 Code",UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

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
        myInt: Integer;
        ReverseTransVisible: Boolean;
        UserSetup: Record 91;
        StarVisiblePostedVou: Boolean;
        SFPLVisiblePostedVou: Boolean;
        CompanyInfo: Record "Company Information";
}