pageextension 50077 JournalVoucherExt extends "Journal Voucher"
{
    layout
    {
        modify("Bal. Account Type")
        {
            Visible = true;
        }
        modify("Account Type")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
            trigger OnLookup(var Text: Text): Boolean
            var
                Vend: Record Vendor;
                Cust: Record Customer;
                Emp: Record Employee;
                GLAcc: Record "G/L Account";
                BankAcc: Record "Bank Account";
                FixAsset: Record "Fixed Asset";
                ICPartner: Record "IC Partner";
                VendList: Page "Vendor List";
                CustList: Page "Customer List";
                EmpList: Page "Employee List";
                GLAccList: Page "G/L Account List";
                BankAccList: Page "Bank Account List";
                FixAssetList: Page "Fixed Asset List";
                ICPartList: Page "IC Partner List";
            begin
                GLAcc.Reset();
                Vend.Reset();
                Cust.Reset();
                FixAsset.Reset();
                ICPartner.Reset();
                BankAcc.Reset();
                GLAcc.Reset();
                if rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account" then begin
                    GLAcc.SetRange(GLAcc."Account Type", GLAcc."Account Type"::Posting);
                    GLAcc.SetRange(GLAcc.Blocked, false);
                    //  if GLAcc.FindFirst() then begin
                    GLAccList.SETTABLEVIEW(GLAcc);
                    GLAccList.LOOKUPMODE(TRUE);
                    if (GLAccList.RunModal() = Action::LookupOK) then begin
                        GLAccList.GetRecord(GLAcc);
                        Rec.Validate("Bal. Account No.", GLAcc."No.");
                    END;
                    // end;
                end else
                    if rec."Bal. Account Type" = Rec."Bal. Account Type"::Vendor then begin
                        Vend.SetRange(Vend.Blocked, Vend.Blocked::" ");
                        // if Vend.FindFirst() then begin
                        VendList.SETTABLEVIEW(Vend);
                        VendList.LOOKUPMODE(TRUE);
                        if (VendList.RunModal() = Action::LookupOK) then begin
                            VendList.GetRecord(Vend);
                            Rec.Validate("Bal. Account No.", Vend."No.");
                            //  END;
                        end;
                    end else
                        if rec."Bal. Account Type" = Rec."Bal. Account Type"::Customer then begin
                            Cust.SetRange(Cust.Blocked, Cust.Blocked::" ");
                            // if Cust.FindFirst() then begin
                            CustList.SETTABLEVIEW(Cust);
                            CustList.LOOKUPMODE(TRUE);
                            if (CustList.RunModal() = Action::LookupOK) then begin
                                CustList.GetRecord(Cust);
                                Rec.Validate("Bal. Account No.", Cust."No.");
                                //   END;
                            end;
                        end else
                            if rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account" then begin
                                BankAcc.SetFilter(BankAcc.Blocked, '%1', false);
                                // if BankAcc.FindFirst() then begin
                                BankAccList.SETTABLEVIEW(BankAcc);
                                BankAccList.LOOKUPMODE(TRUE);
                                if (BankAccList.RunModal() = Action::LookupOK) then begin
                                    BankAccList.GetRecord(BankAcc);
                                    Rec.Validate("Bal. Account No.", BankAcc."No.");
                                    //   END;
                                end;
                            end else
                                if rec."Bal. Account Type" = Rec."Bal. Account Type"::"Fixed Asset" then begin
                                    FixAsset.SetFilter(FixAsset.Blocked, '%1', false);
                                    // if FixAsset.FindFirst() then begin
                                    FixAssetList.SETTABLEVIEW(FixAsset);
                                    FixAssetList.LOOKUPMODE(TRUE);
                                    if (FixAssetList.RunModal() = Action::LookupOK) then begin
                                        FixAssetList.GetRecord(FixAsset);
                                        Rec.Validate("Bal. Account No.", FixAsset."No.");
                                        //  END;
                                    end;
                                end else
                                    if rec."Bal. Account Type" = Rec."Bal. Account Type"::"IC Partner" then begin
                                        ICPartList.SETTABLEVIEW(ICPartner);
                                        ICPartList.LOOKUPMODE(TRUE);
                                        if (ICPartList.RunModal() = Action::LookupOK) then begin
                                            ICPartList.GetRecord(ICPartner);
                                            Rec.Validate("Bal. Account No.", ICPartner.Code);
                                        END;
                                    end else
                                        if rec."Bal. Account Type" = Rec."Bal. Account Type"::Employee then begin
                                            EmpList.SETTABLEVIEW(Emp);
                                            EmpList.LOOKUPMODE(TRUE);
                                            if (EmpList.RunModal() = Action::LookupOK) then begin
                                                EmpList.GetRecord(Emp);
                                                Rec.Validate("Bal. Account No.", Emp."No.");
                                            END;
                                        end;
            end;
        }
        modify("Account No.")
        {
            Visible = false;
            trigger OnLookup(var Text: Text): Boolean
            var
                Vend: Record Vendor;
                Cust: Record Customer;
                Emp: Record Employee;
                GLAcc: Record "G/L Account";
                BankAcc: Record "Bank Account";
                FixAsset: Record "Fixed Asset";
                ICPartner: Record "IC Partner";
                VendList: Page "Vendor List";
                CustList: Page "Customer List";
                EmpList: Page "Employee List";
                GLAccList: Page "G/L Account List";
                BankAccList: Page "Bank Account List";
                FixAssetList: Page "Fixed Asset List";
                ICPartList: Page "IC Partner List";
            begin
                GLAcc.Reset();
                Vend.Reset();
                Cust.Reset();
                FixAsset.Reset();
                ICPartner.Reset();
                BankAcc.Reset();
                GLAcc.Reset();
                if rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                    GLAcc.SetRange(GLAcc."Account Type", GLAcc."Account Type"::Posting);
                    GLAcc.SetRange(GLAcc.Blocked, false);
                    // if GLAcc.FindFirst() then begin
                    GLAccList.SETTABLEVIEW(GLAcc);
                    GLAccList.LOOKUPMODE(TRUE);
                    if (GLAccList.RunModal() = Action::LookupOK) then begin
                        GLAccList.GetRecord(GLAcc);
                        Rec.Validate("Account No.", GLAcc."No.");
                        //  end;
                    end;
                end else
                    if rec."Account Type" = Rec."Account Type"::Vendor then begin
                        Vend.SetFilter(Vend.Blocked, '%1', Vend.Blocked::" ");
                        // if Vend.FindFirst() then begin
                        VendList.SETTABLEVIEW(Vend);
                        VendList.LOOKUPMODE(TRUE);
                        if (VendList.RunModal() = Action::LookupOK) then begin
                            VendList.GetRecord(Vend);
                            Rec.Validate("Account No.", Vend."No.");
                            // END;
                        end;
                    end else
                        if rec."Account Type" = Rec."Account Type"::Customer then begin
                            Cust.SetFilter(Cust.Blocked, '<>%1', Cust.Blocked::All);
                            // if Cust.FindFirst() then begin
                            CustList.SETTABLEVIEW(Cust);
                            CustList.LOOKUPMODE(TRUE);
                            if (CustList.RunModal() = Action::LookupOK) then begin
                                CustList.GetRecord(Cust);
                                Rec.Validate("Account No.", Cust."No.");
                                //  END;
                            end;
                        end else
                            if rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
                                BankAcc.SetFilter(BankAcc.Blocked, '%1', false);
                                // if BankAcc.FindFirst() then begin
                                BankAccList.SETTABLEVIEW(BankAcc);
                                BankAccList.LOOKUPMODE(TRUE);
                                if (BankAccList.RunModal() = Action::LookupOK) then begin
                                    BankAccList.GetRecord(BankAcc);
                                    Rec.Validate("Account No.", BankAcc."No.");
                                    //   END;
                                end;
                            end else
                                if rec."Account Type" = Rec."Account Type"::"Fixed Asset" then begin
                                    FixAsset.SetFilter(FixAsset.Blocked, '%1', false);
                                    //  if FixAsset.FindFirst() then begin
                                    FixAssetList.SETTABLEVIEW(FixAsset);
                                    FixAssetList.LOOKUPMODE(TRUE);
                                    if (FixAssetList.RunModal() = Action::LookupOK) then begin
                                        FixAssetList.GetRecord(FixAsset);
                                        Rec.Validate("Account No.", FixAsset."No.");
                                        //  END;
                                    end;
                                end else
                                    if rec."Account Type" = Rec."Account Type"::"IC Partner" then begin
                                        ICPartList.SETTABLEVIEW(ICPartner);
                                        ICPartList.LOOKUPMODE(TRUE);
                                        if (ICPartList.RunModal() = Action::LookupOK) then begin
                                            ICPartList.GetRecord(ICPartner);
                                            Rec.Validate("Account No.", ICPartner.Code);
                                        END;
                                    end else
                                        if rec."Account Type" = Rec."Account Type"::Employee then begin
                                            EmpList.SETTABLEVIEW(Emp);
                                            EmpList.LOOKUPMODE(TRUE);
                                            if (EmpList.RunModal() = Action::LookupOK) then begin
                                                EmpList.GetRecord(Emp);
                                                Rec.Validate("Account No.", Emp."No.");
                                            END;
                                        end;
            end;
        }

        modify(Description)
        {

            Visible = true;
        }

        modify("Location Code")
        {
            Visible = true;
        }
        modify("Document No.")
        {
            Visible = false;
        }

        modify("TDS Section Code")
        {
            Visible = false;
        }
        modify("Nature of Remittance")
        {
            Visible = false;
        }
        modify("Act Applicable")
        {
            Visible = false;
        }
        modify("T.A.N. No.")
        {
            Visible = false;
        }
        modify("TDS Certificate Receivable")
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
        modify("Party Type")
        {
            Visible = false;
        }
        modify("Provisional Entry")
        {
            Visible = false;
        }
        modify("Applied Provisional Entry")
        {
            Visible = false;
        }
        modify("Include GST in TDS Base")
        {
            Visible = false;
        }
        modify("Check Printed")
        {
            Visible = false;
        }



        modify("Account Name")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
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
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
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
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
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
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Reason Code")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }

        moveafter("Posting Date"; "Document Type")
        moveafter("Document Type"; "Document No.")
        addafter("Document No.")
        {
            field("Tax Type"; Rec."Tax Type")
            {
                ApplicationArea = All;
            }
            field("GST Component Code"; Rec."GST Component Code")
            {
                ApplicationArea = All;
            }

        }
        moveafter("GST Component Code"; "Location Code")
        moveafter("Location Code"; "Account Type")
        moveafter("Account Type"; "Account No.")
        addafter("Account No.")
        {
            field("Sales Invoice Type"; Rec."Sales Invoice Type")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Sales Invoice Type"; Description)
        moveafter(Description; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        addafter("Credit Amount")
        {
            field("Excl. GST in TCS Base"; Rec."Excl. GST in TCS Base")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Excl. GST in TCS Base"; "Gen. Posting Type")
        moveafter("Gen. Posting Type"; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; Amount)
        addafter(Amount)
        {
            field("Amount Excl. GST"; Rec."Amount Excl. GST")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Amount Excl. GST"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Bal. Gen. Posting Type")
        moveafter("Bal. Gen. Posting Type"; "Bal. Gen. Bus. Posting Group")
        moveafter("Bal. Gen. Bus. Posting Group"; "Bal. Gen. Prod. Posting Group")
        addafter("Bal. Gen. Prod. Posting Group")
        {
            field("GST Bill-to/BuyFrom State Code"; Rec."GST Bill-to/BuyFrom State Code")
            {
                ApplicationArea = all;
            }
            field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
            {
                ApplicationArea = all;
            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;
            }
            field("GST on Advance Payment"; Rec."GST on Advance Payment")
            {
                ApplicationArea = all;
            }
            field("Ship-to Code"; Rec."Ship-to Code")
            {
                ApplicationArea = all;
            }

            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
            }
            field("POS Out Of India"; Rec."POS Out Of India")
            {
                ApplicationArea = all;
            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = all;
            }
            field("GST Inv. Rounding Precision"; Rec."GST Inv. Rounding Precision")
            {
                ApplicationArea = all;
            }
            field("GST Inv. Rounding Type"; Rec."GST Inv. Rounding Type")
            {
                ApplicationArea = all;
            }
        }

        moveafter("Ship-to Code"; "GST Credit")




        // {
        // field("Responsibility Center"; Rec."Responsibility Center")
        // {
        //     ApplicationArea = All;

        // }
        // field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
        // {
        //     ApplicationArea = All;

        // }
        // field("Bal.Account Name"; Rec."Bal.Account Name")
        // {
        //     ApplicationArea = All;

        // }
        // field(CheckPayment; Rec.CheckPayment)
        // {
        //     ApplicationArea = All;

        // }
        // field(CheckRefund; Rec.CheckRefund)
        // {
        //     ApplicationArea = All;

        // }
        // field(CheckBlankPayment; Rec.CheckBlankPayment)
        // {
        //     ApplicationArea = All;

        // }
        // field("Line Narration1"; Rec."Line Narration1")
        // {
        //     ApplicationArea = All;

        // }
        // field("Creditors Type"; Rec."Creditors Type")
        // {
        //     ApplicationArea = All;

        // }
        // field("Flock Code"; Rec."Flock Code")
        // {
        //     ApplicationArea = All;

        // }
        // field("FEED Freight Charge"; Rec."FEED Freight Charge")
        // {
        //     ApplicationArea = All;

        // }
        // field("Recipient Bank Account No."; Rec."Recipient Bank Account No.")
        // {
        //     ApplicationArea = All;

        // }
        // field("Payment Mode"; Rec."Payment Mode")
        // {
        //     ApplicationArea = All;

        // }
        // field("Applied PO No."; Rec."Applied PO No.")
        // {
        //     ApplicationArea = All;

        // }
        //}
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
                CompanyInfo.get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
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


                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Journal Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Journal Voucher');
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
                    CheckDimension; //Pru_gk DMV_0.1
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
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
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then begin
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
                GLAccount: Record "G/L Account";
            begin
                CompanyInfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
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
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
                    CheckDimension; //Pru_gk DMV_0.1
            end;

        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Journal Voucher');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Journal Voucher Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Journal Voucher');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Journal Voucher", '%1', UserSetup."Access Journal Voucher"::View);
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
                                ERROR('Journal Voucher Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Journal Voucher Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Journal Voucher Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        ShowWorkflowStatusOnLine: Boolean;
        UserSetup: Record 91;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        GenJournal1: Record 81;
        DimensionMaster: Record "Dimension Master";
        CompanyInfo: Record "Company Information";
}