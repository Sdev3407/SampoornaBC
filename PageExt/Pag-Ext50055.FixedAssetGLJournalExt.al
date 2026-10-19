pageextension 50055 "FixedAsset_GLJournalExt" extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter("Document Type")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Bal.Account Name"; Rec."Bal.Account Name")
            {
                ApplicationArea = All;

            }
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
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
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("P&ost")
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR(' You can not post the Fixed Asset G/L Journal');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR(' You can not post the Fixed Asset G/L Journal');
                //PRU_DD 1.10

                CheckDimension; ///Pru_gk DMV_0.1
            end;
        }
        modify(Preview)
        {
            trigger OnAfterAction()
            begin
                CheckDimension; ///Pru_gk DMV_0.1
            end;
        }
        modify("Post and &Print")
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR(' You can not post the Fixed Asset G/L Journal');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR(' You can not post the Fixed Asset G/L Journal');
                //PRU_DD 1.10
            end;
        }

    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR(' You can not delete the Fixed Asset G/L Journal');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR(' You can not modify the Fixed Asset G/L Journal');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Fixed Asset G/L Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA G/L Journals", '%1', UserSetup."Access FA G/L Journals"::View);
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
                                ERROR('Fixed Asset G/L Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Fixed Asset G/L Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Fixed Asset G/L Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        DocumentTypeErr: Label 'Reference Invoice No is  required where Document Type is Credit Memo or Invoice.';

}