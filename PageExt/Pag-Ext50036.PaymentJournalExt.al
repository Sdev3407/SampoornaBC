pageextension 50036 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        modify("Account No.")
        {
            Visible = true;
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

        modify("Posting Date")
        {
            Visible = true;
        }
        modify("Location Code")
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
        moveafter(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        modify("Document Type")
        {
            trigger OnBeforeValidate()
            begin
                IF NOT (Rec."Document Type" IN [Rec."Document Type"::Payment, Rec."Document Type"::Refund]) THEN
                    EnableBankChargePage := FALSE
                ELSE
                    EnableBankChargePage := TRUE;
            end;
        }
        addafter("Account Type")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    UserSetupRec: Record "User Setup";
                    Location: Record Location;
                begin
                    UserSetupRec.GET(USERID);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, "Shortcut Dimension 3 Code");
                        IF Location.FINDFIRST THEN
                            VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");

                    END;
                end;

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
            field("Line Narration1"; Rec."Line Narration1")
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
        }
    }

    actions
    {
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Bank Charges")
        {
            Enabled = EnableBankChargePage;
        }
        modify(PrintCheck)
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD("Shortcut Dimension 3 Code");
            end;
        }
        modify(ExportPaymentsToFile)
        {
            trigger OnBeforeAction()
            begin
                Rec.CheckIfPrivacyBlocked;
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
                Rec.TESTFIELD("Shortcut Dimension 3 Code");
                ///Pru_gk


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Payment Journal');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Payment Journal');
                //PRU_DD 1.10
                CheckDimension;  ///Pru_gk DMV_0.1
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                CheckDimension;  ///Pru_gk DMV_0.1
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()

            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Payment Journal');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Payment Journal');
                //PRU_DD 1.10

            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Payment Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
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
                                ERROR('Payment Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Payment Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Payment Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        EnableBankChargePage: Boolean;
}