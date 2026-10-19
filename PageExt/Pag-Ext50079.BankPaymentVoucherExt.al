pageextension 50079 BankPaymentVoucherExt extends "Bank Payment Voucher"
{
    layout
    {
        modify("Deferral Code")
        {
            trigger OnAssistEdit()
            begin
                CurrPage.SaveRecord();
                Commit();
                Rec.ShowDeferralSchedule();
            end;
        }
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
            Visible = True;

        }
        modify("Account No.")
        {
            Visible = true;

        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                FixedAssetRec: Record "Fixed Asset";
                DefaultDimension: Record 352;
            begin
                UserSetupRec.GET(USERID);
                IF "Journal Template Name" <> 'ASSETS' THEN BEGIN
                    UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    END;
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    ////Pru_gk
                END;
                IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
                    FixedAssetRec.RESET;
                    FixedAssetRec.GET("Account No.");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", FixedAssetRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", FixedAssetRec."Global Dimension 2 Code");
                    DefaultDimension.RESET;
                    DefaultDimension.SETRANGE("Table ID", 5600);
                    DefaultDimension.SETRANGE("No.", "Account No.");
                    DefaultDimension.SETRANGE("Dimension Code", 'LOC');
                    IF DefaultDimension.FINDFIRST THEN
                        Rec.VALIDATE("Shortcut Dimension 3 Code", DefaultDimension."Dimension Value Code");

                    ///MESSAGE('%1',FixedAssetRec."Global Dimension 2 Code");
                    ////Rec.VALIDATE("Shortcut Dimension 3 Code",FixedAssetRec.
                END;
            end;
        }


        modify("GST TDS/GST TCS")
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

        modify("HSN/SAC Code")
        {
            Visible = false;
        }

        modify("GST Group Type")
        {
            Visible = false;
        }
        modify("Vendor GST Reg. No.")
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
        modify("Account Name")
        {
            Visible = false;
        }
        modify("Check Printed")
        {
            Visible = true;
        }
        modify("TDS Section Code")
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
        modify("TCS Nature of Collection")
        {
            Visible = false;
        }
        modify("T.C.A.N. No.")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
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

        modify("Cheque No.")
        {
            Visible = false;
        }
        modify("Cheque Date")
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
        moveafter("Posting Date"; "Document Type")
        moveafter("Document Type"; "Document No.")
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
        modify(Description)
        {
            Visible = true;
        }
        moveafter("Party Code"; "Account Type")
        moveafter("Account Type"; "Account No.")
        moveafter("Account No."; Description)
        modify("T.A.N. No.")
        {
            Visible = true;
        }
        modify("Nature of Remittance")
        {
            Visible = true;
        }
        modify("Act Applicable")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        modify(Amount)
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
        modify("Amount Excl. GST")
        {
            Visible = true;
        }

        moveafter("T.A.N. No."; "Nature of Remittance")
        moveafter("Nature of Remittance"; "Act Applicable")
        moveafter("Act Applicable"; "Currency Code")
        moveafter("Currency Code"; Amount)
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; "Amount Excl. GST")
        moveafter("Amount Excl. GST"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        addafter("Bal. Account No.")
        {


        }

        moveafter("Location State Code"; "GST on Advance Payment")
        addafter("GST on Advance Payment")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                ApplicationArea = ALL;
            }

        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Shortcut Dimension 3 Code"; "Applies-to Doc. Type")
        moveafter("Applies-to Doc. Type"; "Applies-to Doc. No.")
        moveafter("Applies-to Doc. No."; "Bank Payment Type")
        moveafter("Bank Payment Type"; "Check Printed")


        addafter("Bank Charge")
        {
            field("Line Narration1"; rec."Line Narration1")
            {
                ApplicationArea = all;
            }

            field("Recipient Bank Account"; rec."Recipient Bank Account")
            {
                ApplicationArea = all;
            }
            field("Recipient Bank Account No."; rec."Recipient Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Payment Mode"; rec."Payment Mode")
            {
                ApplicationArea = all;
            }
            field("Security Group Code"; rec."Security Group Code")
            {
                ApplicationArea = all;
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
                Companyinfo.Get;

                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
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
                UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Bank Payment Voucher');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to Post Bank Payment Voucher');
                //Pru_gk DMV_0.1
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then Begin
                    CheckDimension;
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

        addafter(Post)
        {
            action("Post&Print")
            {
                Caption = 'Post & Print';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                Applicationarea = All;
                trigger OnAction()
                var
                    GLAccount: Record 15;
                    SalesReceivablesSetup: Record 311;
                begin
                    Companyinfo.Get;
                    //PRU_NEELESH_ 13022020 Prevent Negative in GL
                    Rec.TESTFIELD("Shortcut Dimension 1 Code");
                    If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
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
                    UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to post Bank Payment Voucher');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to Post Bank Payment Voucher');
                    If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                        CheckDimension;//Pru_gk DMV_0.1

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
                                    ERROR(DimnErr, GenJournal1."Document No.", GenJournal1."Line No.");
                            UNTIL GenJournal1.NEXT = 0;
                    End;
                    SalesReceivablesSetup.RESET;
                    IF SalesReceivablesSetup.GET THEN BEGIN
                        SalesReceivablesSetup."Print Report" := TRUE;
                        SalesReceivablesSetup.MODIFY;
                    END;
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Update Po Details")
            {

                Applicationarea = All;
                trigger OnAction()
                begin
                    Selection := STRMENU(Text002, 3);
                    IF Selection = 1 THEN BEGIN
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE(PurchaseHeader.Status, PurchaseHeader.Status::Released);
                        PurchaseHeader.SETRANGE(PurchaseHeader."Pay-to Vendor No.", Rec."Account No.");
                        PurchaseHeader.SETRANGE(PurchaseHeader."Completely Received", FALSE);
                        IF PAGE.RUNMODAL(50085, PurchaseHeader) = ACTION::LookupOK THEN BEGIN
                            PurchaseLine.RESET;
                            PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                            PurchaseLine.SETFILTER(PurchaseLine.Quantity, '<>%1', 0);
                            IF PurchaseLine.FINDSET THEN
                                REPEAT
                                    POBaseAmount += PurchaseLine.Amount;
                                UNTIL PurchaseLine.NEXT = 0;
                            VLE.RESET;
                            VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Payment);
                            VLE.SETRANGE(VLE."Applied PO No.", PurchaseHeader."No.");
                            IF VLE.FINDSET THEN
                                REPEAT
                                    VLE.CALCFIELDS(VLE."Amount (LCY)");
                                    TotalPayment += VLE."Amount (LCY)";
                                UNTIL VLE.NEXT = 0;
                            Rec."Applied PO No." := PurchaseHeader."No.";
                            Rec.VALIDATE(Amount, (POBaseAmount - TotalPayment));
                        END;
                    END ELSE
                        IF Selection = 2 THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE(PurchaseHeader.Status, PurchaseHeader.Status::Released);
                            PurchaseHeader.SETRANGE(PurchaseHeader."Pay-to Vendor No.", Rec."Account No.");
                            PurchaseHeader.SETRANGE(PurchaseHeader."Completely Received", FALSE);
                            IF PAGE.RUNMODAL(50085, PurchaseHeader) = ACTION::LookupOK THEN BEGIN
                                PurchaseLine.RESET;
                                PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                                PurchaseLine.SETFILTER(PurchaseLine.Quantity, '<>%1', 0);
                                IF PurchaseLine.FINDSET THEN
                                    REPEAT
                                        //POBaseAmount += PurchaseLine.Amount;
                                        POAmountTotal += PurchaseLine.Amount;

                                        Clear(IGST_Amt3);
                                        Clear(CGST_Amt3);
                                        Clear(SGST_Amt3);

                                        GSTSetup1.Get();//PT
                                        TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                                        TaxTransValue1.SetRange("Tax Record ID", PurchaseLine.RecordId());
                                        TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                                        TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                                        if TaxTransValue1.FindSet() then
                                            repeat
                                                TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                                case TaxComponentName1 of
                                                    'IGST':
                                                        begin
                                                            //  IgstPer := TaxTransValue1.Percent;
                                                            evaluate(IGST_Amt3, TaxTransValue1."Column Value");
                                                            POAmountTotal += IGST_Amt3;
                                                        end;
                                                    'CGST':
                                                        begin
                                                            evaluate(CGST_Amt3, TaxTransValue1."Column Value");
                                                            //CgstPer += TaxTransValue1.Percent;
                                                            POAmountTotal += CGST_Amt3;
                                                        end;
                                                    'SGST':
                                                        begin
                                                            evaluate(SGST_Amt3, TaxTransValue1."Column Value");
                                                            //SgstPer += TaxTransValue1.Percent;
                                                            POAmountTotal += SGST_Amt3;
                                                        end;
                                                end;
                                            until TaxTransValue1.Next() = 0;

                                    UNTIL PurchaseLine.NEXT = 0;
                                VLE.RESET;
                                VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Payment);
                                VLE.SETRANGE(VLE."Applied PO No.", PurchaseHeader."No.");
                                IF VLE.FINDSET THEN
                                    REPEAT
                                        VLE.CALCFIELDS(VLE."Amount (LCY)");
                                        TotalPayment += VLE."Amount (LCY)";
                                    UNTIL VLE.NEXT = 0;
                                //Rec."Applied PO No." := PurchaseHeader."No.";
                                //Rec.VALIDATE(Amount,(POBaseAmount-TotalPayment)) ;
                                Rec."Applied PO No." := PurchaseHeader."No.";
                                Rec.VALIDATE(Amount, (POAmountTotal - TotalPayment));
                            END;
                        END;
                end;
            }
            action("Post & Print")
            {
                Caption = 'Post & Print';
                Image = Post;
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
                begin
                    Companyinfo.get;
                    //PRU_NEELESH_ 13022020 Prevent Negative in GL
                    Rec.TESTFIELD("Shortcut Dimension 1 Code");
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                    If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
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
                    UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to post Bank Payment Voucher');
                    //PRU_DD 1.10
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to Post Bank Payment Voucher');
                    If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                        CheckDimension;//Pru_gk DMV_0.1

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
                                    ERROR(DimnErr, GenJournal1."Document No.", GenJournal1."Line No.");
                            UNTIL GenJournal1.NEXT = 0;
                    End;
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
        modify("Print Check")
        {
            TRIGGER OnAfterAction()
            begin
                GenJournalLine_T.RESET;
                GenJournalLine_T.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJournalLine_T.SETRANGE("Journal Batch Name", "Journal Batch Name");
                IF GenJournalLine_T.FINDFIRST THEN
                    REPORT.RUNMODAL(50050, TRUE, TRUE, GenJournalLine_T);
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                GenJnlPost: Codeunit 231;
                GLAccount: Record 15;
            begin
                Companyinfo.Get;
                //PRU_NEELESH_ 13022020 Prevent Negative in GL
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
                    Rec.TESTFIELD("Shortcut Dimension 2 Code");
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
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
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                    CheckDimension;//Pru_gk DMV_0.1

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
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Bank Payment Voucher');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Bank Payment Voucher Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Payment Voucher');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Payment Voucher", '%1', UserSetup."Access Bank Payment Voucher"::View);
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
                                ERROR('Bank Payment Voucher Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Bank Payment Voucher Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Bank Payment Voucher Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        GenJournalLine_T: Record 81;
        EnableBankChargePage: Boolean;
        DimensionMaster: Record "Dimension Master";
        Text002: Label '&BaseAmount,&TotalPoAmount';
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        GenJournal1: Record 81;
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
        POBaseAmount: Decimal;
        POAmountTotal: Decimal;
        VLE: Record 25;
        TotalPayment: Decimal;
        Selection: Integer;
        CurrentJnlBatchName: Text[50];
        Companyinfo: Record "Company Information";
        IGST_Amt3: Decimal;
        CGST_Amt3: Decimal;
        SGST_Amt3: Decimal;
        GSTSetup1: record "GST Setup";
        TaxTransValue1: Record "Tax Transaction Value";
        TaxComponentName1: Text;
}