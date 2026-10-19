pageextension 50075 BankReceiptVoucherExt extends "Bank Receipt Voucher"
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

        moveafter("Posting Date"; "Document Type")
        moveafter("Document Type"; "Document No.")
        moveafter("Document No."; "TDS Certificate Receivable")

        addafter("TDS Certificate Receivable")
        {

            field("Party Type"; Rec."Party Type")
            {
                ApplicationArea = All;
            }
            field("Party Code"; Rec."Party Code")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Party Code"; "Account Type")
        moveafter("Account Type"; "Account No.")
        moveafter("Account No."; Description)
        moveafter(Description; "T.A.N. No.")
        moveafter("T.A.N. No."; "TCS Nature of Collection")
        addafter("TCS Nature of Collection")
        {
            field("Recipient Bank Account"; Rec."Recipient Bank Account")
            {
                ApplicationArea = all;
            }
            field("Recipient Bank Account No."; Rec."Recipient Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Security Group Code"; Rec."Security Group Code")
            {
                ApplicationArea = All;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Responsibility Center"; Amount)
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        addafter("Credit Amount")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Shortcut Dimension 3 Code"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        //moveafter("Bal. Account No."; gst)
        moveafter("Bal. Account No."; "Location State Code")
        moveafter("Location State Code"; "GST on Advance Payment")
        moveafter("GST on Advance Payment"; "Ship-to Code")
        moveafter("Ship-to Code"; "Location Code")
        moveafter("Location Code"; "Applies-to Doc. Type")
        moveafter("Applies-to Doc. Type"; "Applies-to Doc. No.")
        moveafter("Applies-to Doc. No."; "Bank Charge")
        addafter("Bank Charge")
        {
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;
            }
            field("Order Address Code"; Rec."Order Address Code")
            {
                ApplicationArea = All;
            }
            field("Vendor GST Reg. No."; Rec."Vendor GST Reg. No.")
            {
                ApplicationArea = All;
            }
            field("Bill to-Location(POS)"; Rec."Bill to-Location(POS)")
            {
                ApplicationArea = All;
            }
            /*  field("GST TDS/GST TCS"; "GST TDS/GST TCS")
              {
                  ApplicationArea = All;
              }
              field("GST TDS/TCS Base Amount"; "GST TDS/TCS Base Amount")
              {
                  ApplicationArea = all;
              }
              */
            field("GST TDS/TCS Base Amount (LCY)"; Rec."GST TDS/TCS Base Amount (LCY)")
            {
                ApplicationArea = all;
            }
            field("GST TDS/TCS Amount (LCY)"; Rec."GST TDS/TCS Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("POS Out Of India"; Rec."POS Out Of India")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Bill to-Location(POS)"; "GST TDS/GST TCS")
        moveafter("GST TDS/GST TCS"; "GST TDS/TCS Base Amount")




        modify("Location Code")
        {
            Visible = true;
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

        modify("TDS Certificate Receivable")
        {
            Visible = false;
        }
        modify("GST on Advance Payment")
        {
            Visible = false;
        }
        modify("Amount Excl. GST")
        {
            Visible = false;
        }

        modify("GST TCS State Code")
        {
            Visible = false;
        }

        modify("GST Group Code")
        {
            Visible = false;
        }
        modify("Customer GST Reg. No.")
        {
            Visible = false;
        }
        modify("HSN/SAC Code")
        {
            Visible = false;
        }
        modify("Location State Code")
        {
            Visible = false;
        }
        modify("GST Group Type")
        {
            Visible = false;
        }
        modify("Location GST Reg. No.")
        {
            Visible = false;
        }
        modify("GST Vendor Type")
        {
            Visible = false;
        }
        modify("Bank Charge")
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("GST Place of Supply")
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

        modify("T.C.A.N. No.")
        {
            Visible = false;
        }
        modify("TCS On Recpt. Of Pmt. Amount")
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




        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
    }

    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }

        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;

                GenJournal1: Record "Gen. Journal Line";

            begin
                Companyinfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
                IF REC.FINDSET THEN
                    REPEAT
                        IF (REC."Account Type" = REC."Account Type"::"G/L Account") AND (REC."Account No." <> '') THEN BEGIN
                            GLAccount.GET(REC."Account No.");
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
                UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Bank Receipt Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Bank Receipt Voucher');
                //PRU_DD 1.10
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                    CheckDimension; ///Pru_gk DMV_0.1
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then Begin
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
                                ERROR('Dimension Master Does not exist for Document No %1 and Line No. %2', GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                End;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                Companyinfo.Get;
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Bank Receipt Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Bank Receipt Voucher');
                //PRU_DD 1.10
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then Begin
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
                                ERROR('Dimension Master Does not exist for Document No %1 and Line No. %2', GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                End;
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                GLAccount: Record 15;
            begin
                Companyinfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");
                IF REC.FINDSET THEN
                    REPEAT
                        IF (REC."Account Type" = REC."Account Type"::"G/L Account") AND (REC."Account No." <> '') THEN BEGIN
                            GLAccount.GET(REC."Account No.");
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
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna then
                    CheckDimension; ///Pru_gk DMV_0.1
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna then Begin
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
                                ERROR('Dimension Master Does not exist for Document No %1 and Line No. %2', GenJournal1."Document No.", GenJournal1."Line No.");
                        UNTIL GenJournal1.NEXT = 0;
                End;

            end;
        }
    }


    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Bank Receipt Voucher');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do  not have Permission to Change Bank Receipt Voucher Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
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
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Reciept Voucher');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Receipt Voucher", '%1', UserSetup."Access Bank Receipt Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    local procedure CheckDimension()
    begin
        IF Rec.FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Bank Receipt Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Bank Receipt Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Bank Receipt Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;

    end;

    var
        DimensionSetEntry_123: Record "Dimension Set Entry";
        myInt: Integer;
        UserSetup: Record 91;
        DimensionMaster: Record "Dimension Master";
        GLAccount: Record 15;

        GenJournal1: Record "Gen. Journal Line";
        Companyinfo: Record "Company Information";

}