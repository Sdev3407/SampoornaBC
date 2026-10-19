pageextension 50078 CashPaymentVoucherExt extends "Cash Payment Voucher"
{
    layout
    {

        modify("Bal. Account Type")
        {
            Visible = true;
        }
        modify("Account Type")
        {
            Visible = true;
        }
        modify("Bal. Account No.")
        {
            Visible = true;

        }
        modify("Account No.")
        {
            Visible = false;
        }

        modify("Account Name")
        {
            Visible = false;
        }
        modify("T.A.N. No.")
        {
            Visible = false;

        }
        addafter("Document No.")
        {
            field("Party Type"; rec."Party Type")
            {
                ApplicationArea = all;
            }
            field("Party Code"; rec."Party Code")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Account No."; Description)
        addafter("Account Type")
        {
            field("Responsibility Center"; rec."Responsibility Center")
            {
                ApplicationArea = all;
            }
        }
        moveafter(Description; "Nature of Remittance")
        moveafter("Nature of Remittance"; "Act Applicable")
        moveafter("Act Applicable"; "TCS Nature of Collection")
        moveafter("TCS Nature of Collection"; "Currency Code")
        addafter("Currency Code")
        {
            field("FA Posting Type"; Rec."FA Posting Type")
            {

            }
        }
        moveafter("FA Posting Type"; Amount)
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; "Amount (LCY)")
        moveafter("Amount (LCY)"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        addafter("Bal. Account No.")
        {


        }

        moveafter("GST on Advance Payment"; "Ship-to/Order Address Code")
        addafter("Ship-to/Order Address Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
            }
        }
        modify("TCS Nature of Collection")
        {
            Visible = true;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("T.C.A.N. No.")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = true;

        }
        modify("Credit Amount")
        {
            Visible = true;

        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Check Printed")
        {
            Visible = false;
        }
        modify("Cheque No.")
        {
            Visible = false;
        }
        modify("Cheque Date")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }

        modify("GST Group Code")
        {
            Visible = false;
        }
        modify("HSN/SAC Code")
        {
            Visible = false;
        }

        modify("Applies-to Doc. Type")
        {
            Visible = true;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = true;
        }

        modify("Bank Payment Type")
        {
            Visible = true;
        }
        moveafter("Shortcut Dimension 3 Code"; "Applies-to Doc. Type")
        moveafter("Applies-to Doc. Type"; "Applies-to Doc. No.")
        moveafter("Applies-to Doc. No."; "Bank Payment Type")
        addafter("Bank Payment Type")
        {
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;
            }

            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }

        moveafter("GST TDS/GST TCS"; "GST TCS State Code")
        moveafter("GST TCS State Code"; "GST TDS/TCS Base Amount")
        addafter("GST TDS/TCS Base Amount")
        {


        }
        addafter(Control1900919607)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Gen. Journal Line"),
                              "No." = field("Document No.");
                //Visible = NOT IsOfficeAddin;
            }
        }


    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;
            begin
                Companyinfo.get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                if Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    DOCAtt.Reset();
                    DOCAtt.SetRange("Table ID", 81);
                    DOCAtt.SetRange("No.", Rec."Document No.");
                    if DOCAtt.IsEmpty then
                        Error('Attachment is missing for Document No. %1 and Line No. %2', Rec."Document No.", Rec."Line No.");
                end;
                IF Rec.FINDSET THEN
                    REPEAT
                        IF (Rec."Account Type" = Rec."Account Type"::"G/L Account") AND (Rec."Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" < 0 THEN BEGIN
                                    IF GLAccount.Balance < ABS(Rec."Amount (LCY)") THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                GLAccount.Balance);
                                END;
                            END;
                        END;
                        IF (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account") AND (Rec."Bal. Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Bal. Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" > 0 THEN BEGIN
                                    IF GLAccount.Balance < Rec."Amount (LCY)" THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                  GLAccount.Balance);
                                END;
                            END;
                        END;
                    UNTIL Rec.NEXT = 0;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Cash Payment Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Cash Payment Voucher');

                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    GenJournal1.RESET;
                    GenJournal1.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJournal1.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF GenJournal1.FINDSET THEN
                        REPEAT
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", GenJournal1."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", GenJournal1."Shortcut Dimension 2 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", GenJournal1."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR(DimnErr, GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                end;

                //PRU_DD 1.10
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    CheckDimension;//Pru_gk DMV_0.1
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Cash Payment Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Cash Payment Vocuher');
                //PRU_DD 1.10
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                if Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    DOCAtt.Reset();
                    DOCAtt.SetRange("Table ID", 81);
                    DOCAtt.SetRange("No.", Rec."Document No.");
                    if DOCAtt.IsEmpty then
                        Error('Attachment is missing for Document No. %1 and Line No. %2', Rec."Document No.", Rec."Line No.");
                end;
                IF Rec.FINDSET THEN
                    REPEAT
                        IF (Rec."Account Type" = Rec."Account Type"::"G/L Account") AND (Rec."Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" < 0 THEN BEGIN
                                    IF GLAccount.Balance < ABS(Rec."Amount (LCY)") THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                GLAccount.Balance);
                                END;
                            END;
                        END;
                        IF (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account") AND (Rec."Bal. Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Bal. Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" > 0 THEN BEGIN
                                    IF GLAccount.Balance < Rec."Amount (LCY)" THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                  GLAccount.Balance);
                                END;
                            END;
                        END;
                    UNTIL Rec.NEXT = 0;

                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    GenJournal1.RESET;
                    GenJournal1.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJournal1.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF GenJournal1.FINDSET THEN
                        REPEAT
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", GenJournal1."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", GenJournal1."Shortcut Dimension 2 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", GenJournal1."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR(DimnErr, GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                end;
            end;

        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;

            begin
                Companyinfo.get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                if Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    DOCAtt.Reset();
                    DOCAtt.SetRange("Table ID", 81);
                    DOCAtt.SetRange("No.", Rec."Document No.");
                    if DOCAtt.IsEmpty then
                        Error('Attachment is missing for Document No. %1 and Line No. %2', Rec."Document No.", Rec."Line No.");
                end;
                //Rec.TestField("Incoming Document Entry No.");
                IF Rec.FINDSET THEN
                    REPEAT
                        IF (Rec."Account Type" = Rec."Account Type"::"G/L Account") AND (Rec."Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" < 0 THEN BEGIN
                                    IF GLAccount.Balance < ABS(Rec."Amount (LCY)") THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                GLAccount.Balance);
                                END;
                            END;
                        END;
                        IF (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account") AND (Rec."Bal. Account No." <> '') THEN BEGIN
                            GLAccount.GET(Rec."Bal. Account No.");
                            GLAccount.CALCFIELDS(Balance);
                            IF GLAccount."Prevent Negative Balance" = TRUE THEN BEGIN
                                IF Rec."Amount (LCY)" > 0 THEN BEGIN
                                    IF GLAccount.Balance < Rec."Amount (LCY)" THEN
                                        ERROR('The Balance is insufficient in selected GL Account %1 Line No. %2 The current balance is %3', GLAccount."No.", Rec."Line No.",
                                                  GLAccount.Balance);
                                END;
                            END;
                        END;
                    UNTIL Rec.NEXT = 0;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    CheckDimension;//Pru_gk DMV_0.1

                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
                    GenJournal1.RESET;
                    GenJournal1.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJournal1.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF GenJournal1.FINDSET THEN
                        REPEAT
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", GenJournal1."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", GenJournal1."Shortcut Dimension 2 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", GenJournal1."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR(DimnErr, GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                end;
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Cash Payment Voucher');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Cash Payment Voucher Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Cash Payment Voucher');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Cash Payment Voucher", '%1', UserSetup."Access Cash Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    local procedure CheckDimension()
    var
        DimensionSetEntry_123: Record 480;
    begin
        IF Rec.FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Cash Payment Voucher Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Cash Payment Voucher Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Cash Payment Voucher Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        GLAccount: Record 15;
        GenJournal1: Record 81;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        DimensionMaster: Record "Dimension Master";
        Companyinfo: Record "Company Information";
        DOCAtt: Record "Document Attachment";


}