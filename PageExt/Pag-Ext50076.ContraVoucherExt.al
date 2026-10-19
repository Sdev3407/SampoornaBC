pageextension 50076 ContraVoucherExt extends "Contra Voucher"
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
                            Cust.SetRange(Cust.Blocked, Cust.Blocked::All);
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

        modify("Account Name")
        {
            Visible = false;
        }
        modify("Check Printed")
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

        moveafter("Account No."; Description)
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "Location Code")
        addafter("Location Code")
        {
            field("GST Bill-to/BuyFrom State Code"; Rec."GST Bill-to/BuyFrom State Code")
            {
                ApplicationArea = All;
            }
            field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
            {
                ApplicationArea = All;
            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;
            }
            field("GST on Advance Payment"; Rec."GST on Advance Payment")
            {
                ApplicationArea = All;
            }
            field("Ship-to Code"; Rec."Ship-to Code")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
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
        }
        /* addafter("Document Type")
         {
             field("Responsibility Center"; Rec."Responsibility Center")
             {
                 ApplicationArea = All;

             }
             
             field("Bal.Account Name"; Rec."Bal.Account Name")
             {
                 ApplicationArea = All;

             }
             field(CheckPayment; Rec.CheckPayment)
             {
                 ApplicationArea = All;

             }
             field(CheckRefund; Rec.CheckRefund)
             {
                 ApplicationArea = All;

             }
             field(CheckBlankPayment; Rec.CheckBlankPayment)
             {
                 ApplicationArea = All;

             }
            
             field("Creditors Type"; Rec."Creditors Type")
             {
                 ApplicationArea = All;

             }
             field("Flock Code"; Rec."Flock Code")
             {
                 ApplicationArea = All;

             }
             field("FEED Freight Charge"; Rec."FEED Freight Charge")
             {
                 ApplicationArea = All;

             }
             field("Recipient Bank Account No."; Rec."Recipient Bank Account No.")
             {
                 ApplicationArea = All;

             }
             field("Payment Mode"; Rec."Payment Mode")
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
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;
            begin

                CompanyInfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
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


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Contra Voucher');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Contra Voucher');
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
            end;

        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
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


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Contra Voucher');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Contra Voucher');
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
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                GenJnlPost: Codeunit 231;
                GLAccount: Record 15;
            begin
                CompanyInfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
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
        modify(Approve)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Contra Voucher');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Contra Voucher');
                //PRU_DD 1.10
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Contra Voucher');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Contra Voucher Details');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Contra Voucher');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Contra Voucher", '%1', UserSetup."Access Contra Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        GLAccount: Record 15;
        DimensionMaster: Record "Dimension Master";
        GenJournal1: Record 81;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        CompanyInfo: Record "Company Information";

}