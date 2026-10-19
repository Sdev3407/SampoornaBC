pageextension 50014 GeneralJournalExt extends "General Journal"
{
    layout
    {

        modify(ShortcutDimCode3)
        {
            ApplicationArea = all;
            Visible = false;
        }
        moveafter("Posting Date"; "Document Type")
        moveafter("Document Type"; "Document No.")
        moveafter("Document No."; "Account Type")
        moveafter("Account Type"; "Account No.")
        addafter("Account No.")
        {

            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
            }
        }
        moveafter("FA Posting Type"; Description)
        moveafter(Description; "GST TDS/TCS Base Amount")
        moveafter("GST TDS/TCS Base Amount"; "Gen. Posting Type")
        moveafter("Gen. Posting Type"; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; Amount)
        moveafter(Amount; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        addafter("Bal. Account No.")
        {

            field("Bal.Account Name"; Rec."Bal.Account Name")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Bal.Account Name"; "Bal. Gen. Posting Type")
        moveafter("Bal. Gen. Posting Type"; "Bal. Gen. Bus. Posting Group")
        moveafter("Bal. Gen. Bus. Posting Group"; "External Document No.")
        addafter("External Document No.")
        {
            field("Flock Code"; Rec."Flock Code")
            {
                ApplicationArea = all;
            }
            field("FEED Freight Charge"; Rec."FEED Freight Charge")
            {
                ApplicationArea = All;

            }
        }
        moveafter("FEED Freight Charge"; "Location State Code")

        addafter("Location State Code")
        {
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = all;
            }

            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            // field("Location Code"; "Location Code")

            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Security Group Code"; rec."Security Group Code")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Line Narration1"; "GST Credit")
        moveafter(Exempted; "Location Code")
        moveafter("Shortcut Dimension 3 Code"; "HSN/SAC Code")
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                //PRu_gk FPD_0.1
                IF Rec."FEED Freight Charge" = FALSE THEN BEGIN
                    IF GLAccount.GET(Rec."Account No.") THEN
                        Rec."FEED Freight Charge" := GLAccount."FEED Freight Charge";
                END;
                //Pru_gk FPD_0.1
            end;
        }
        modify("Bal. Account No.")
        {
            trigger OnAfterValidate()
            begin
                //PRu_gk FPD_0.1
                IF Rec."FEED Freight Charge" = FALSE THEN BEGIN
                    IF GLAccount.GET(Rec."Bal. Account No.") THEN
                        Rec."FEED Freight Charge" := GLAccount."FEED Freight Charge";
                END;
                //  "Bal.Account Name" := BalAccName;  // Pru sh260722
            end;
        }
        addafter(JournalLineDetails)
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
        addafter(Approval)
        {

            group(Narration)
            {
                Caption = 'Narration';
                Image = Description;


                action("Balance Transfer")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    RunObject = Report 50040;
                }
                action("Line Narration")
                {
                    ApplicationArea = All;
                    Caption = 'Line Narration';
                    Image = LineDescription;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Line Narration";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                  "Journal Batch Name" = FIELD("Journal Batch Name"),
                                  "Gen. Journal Line No." = FIELD("Line No."),
                                  "Document No." = FIELD("Document No.");
                    ShortCutKey = 'Shift+Ctrl+N';
                }
                action("Employee Data From HRMS")
                {
                    ApplicationArea = All;
                    Caption = 'Get Employee Data From HRMS';
                    Image = GetOrder;
                    Promoted = true;
                    PromotedIsBig = true;
                    //Visible = SFPL;

                    trigger OnAction()
                    var
                        GetHRMS: Codeunit "Update User Setup";
                    begin
                        //GetHRMS.GenerateToken()
                        GetHRMS.InventHRMSGETEmployee();
                        Message('Employee has been Imported from HRMS');
                    end;
                }

            }
        }
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("Calculate GST")
            {
                Caption = 'Calculate GST';
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                Applicationarea = All;
                trigger OnAction()
                var
                    GenJnPosting: Codeunit "Gen. Jnl.-Post";
                    GenJnLine: Record "Gen. Journal Line";
                begin
                    //   ValidateAndCalculateGSTforInvoiceCrMemo(Rec, '', FALSE); // Pru sh260722

                    GenJnLine.Reset();
                    GenJnLine.SetFilter("Journal Template Name", '%1|%2|%3', 'GENERAL', 'CASH RECE', 'CASH PAYM');
                    GenJnLine.SetFilter("Journal Batch Name", '%1', 'DEFAULT');
                    GenJnLine.SetRange("User ID", 'temp');
                    if GenJnLine.FindSet() then
                        GenJnPosting.Run(GenJnLine);



                end;
            }
            action("Update Reference Invoice No")
            {
                Caption = 'Update Reference Invoice No';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    GenJournalLine: Record 81;
                    UpdateReferenceInvJournals: Page "Update Reference Inv. Journals";
                begin
                    GenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    GenJournalLine.SETRANGE("Document No.", Rec."Document No.");
                    GenJournalLine.SETRANGE("GST in Journal", TRUE);
                    GenJournalLine.SETFILTER("Account Type", '%1|%2', GenJournalLine."Account Type"::Customer, GenJournalLine."Account Type"::Vendor);
                    IF GenJournalLine.FINDFIRST THEN BEGIN
                        IF NOT (Rec."Document Type" IN [Rec."Document Type"::"Credit Memo", Rec."Document Type"::Invoice]) THEN
                            ERROR(DocumentTypeErr);
                        IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor) AND
                           (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) AND NOT
                           (GenJournalLine."Purch. Invoice Type" IN [GenJournalLine."Purch. Invoice Type"::"Debit Note",
                                                                     GenJournalLine."Purch. Invoice Type"::Supplementary])
                        THEN
                            ERROR(ReferenceNoErr);
                        IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) AND
                           (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) AND NOT
                           (GenJournalLine."Sales Invoice Type" IN [GenJournalLine."Sales Invoice Type"::"Debit Note",
                                                                    GenJournalLine."Sales Invoice Type"::Supplementary])
                        THEN
                            ERROR(ReferenceNoErr);

                        // ValidateAndCalculateGSTforInvoiceCrMemo(Rec, '', FALSE); // Pru sh260722

                        ReferenceInvoiceNo.RESET;
                        ReferenceInvoiceNo.SETRANGE("Document No.", Rec."Document No.");
                        //   ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                        ReferenceInvoiceNo.SETRANGE("Source No.", GenJournalLine."Account No.");
                        ReferenceInvoiceNo.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                        ReferenceInvoiceNo.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                        IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer THEN
                            UpdateReferenceInvJournals.CustomerRecord(ReferenceInvoiceNo."Source Type"::Customer);
                        UpdateReferenceInvJournals.SETTABLEVIEW(ReferenceInvoiceNo);
                        UpdateReferenceInvJournals.RUN;
                    END ELSE
                        ERROR(ReferenceInvoiceNoErr);
                end;
            }

        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;
                UserSetup: Record "User Setup";
            begin
                CompanyInfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
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

                CheckDimension; ///Pru_gk DMV_0.1
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not Post the general journal');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not Post the general journal');
                //PRU_DD 1.10
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then Begin
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
                End;
            end;
        }
        addbefore(Preview)
        {
            action("Post&Print")
            {
                Caption = 'Post Print';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                Applicationarea = All;
                trigger OnAction()
                var
                    GLAccount: Record 15;
                    SalesReceivablesSetup: Record 311;
                    UserSetup: Record "User Setup";
                begin
                    CompanyInfo.Get;
                    Rec.TESTFIELD("Shortcut Dimension 1 Code");
                    If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        Rec.TESTFIELD("Shortcut Dimension 3 Code");
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

                    CheckDimension; ///Pru_gk DMV_0.1
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post the general journal');
                    //PRU_DD 1.10

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post the general journal');
                    //PRU_DD 1.10

                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then Begin
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

                    IF SalesReceivablesSetup.GET THEN BEGIN
                        SalesReceivablesSetup."Print Report" := TRUE;
                        SalesReceivablesSetup.MODIFY;
                    END;
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Post & Print")
            {
                Caption = 'Post & Print';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                Visible = false;

                Applicationarea = All;
                trigger OnAction()
                var
                    GLAccount: Record 15;
                    SalesReceivablesSetup: Record 311;
                    UserSetup: Record "User Setup";
                begin
                    CompanyInfo.Get;
                    Rec.TESTFIELD("Shortcut Dimension 1 Code");
                    If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        Rec.TESTFIELD("Shortcut Dimension 3 Code");
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

                    CheckDimension; ///Pru_gk DMV_0.1
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post the general journal');
                    //PRU_DD 1.10

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You can not Post the general journal');
                    //PRU_DD 1.10

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
                    SalesReceivablesSetup.RESET;
                    SalesReceivablesSetup.GET;
                    SalesReceivablesSetup."Print Report" := TRUE;
                    SalesReceivablesSetup.MODIFY;
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                    SalesReceivablesSetup.RESET;
                    SalesReceivablesSetup.GET;
                    SalesReceivablesSetup."Print Report" := FALSE;
                    SalesReceivablesSetup.MODIFY;
                end;
            }


        }
        modify("Apply Entries")
        {
            trigger OnBeforeAction()
            begin
                /* Pru sh260722
                IsGSTCalculated;
                ValidateAndCalculateGSTforInvoiceCrMemo(Rec, "Document No.", FALSE);
                */
                //Pru sh260722
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the general journal');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the general journal');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        CompanyInfo.Get;
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open General Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        SFPL := false;
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            SFPL := true;
    end;

    local procedure CheckDimension()
    var
        DimensionSetEntry_123: Record 480;
    begin
        CompanyInfo.Get;
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then begin
            IF Rec.FINDFIRST THEN
                REPEAT
                    DimensionSetEntry_123.RESET;
                    DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF DimensionSetEntry_123.FINDSET THEN
                        REPEAT
                            IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                    ERROR('General Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                            END;
                            IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                    ERROR('General Journal line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                            END;
                            IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN

                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                    ERROR('General Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                            END;
                        UNTIL DimensionSetEntry_123.NEXT = 0;
                UNTIL Rec.NEXT = 0;
        end;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        IsRateChangeEnabled: Boolean;
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        DocumentTypeErr: Label 'Reference Invoice No is  required where Document Type is Credit Memo or Invoice.';
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        DimensionMaster: Record "Dimension Master";
        GLAccount: Record 15;
        GenJournal1: Record 81;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        CurrentJnlBatchName: Code[10];
        CompanyInfo: Record "Company Information";
        SFPL: Boolean;
}
