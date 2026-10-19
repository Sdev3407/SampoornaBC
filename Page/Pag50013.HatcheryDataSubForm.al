page 50013 "Hatchery Data SubForm"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    AutoSplitKey = true;
    //DeleteAllowed = false;
    InsertAllowed = true;
    PageType = ListPart;
    SourceTable = "Data Entry Lines";
    SourceTableView = SORTING("Document No.", "Flock No.", "Line No.");
    //  ApplicationArea = All;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        DataEntry: Record "Data Entry Sheet";
                    begin
                        if rec.Type <> Rec.Type::" " then
                            Rec."Parameter No." := '';
                        DataEntry.Get(Rec."Document No.", DataEntry."Document Type"::Hatchery);

                        Rec."Location Code" := DataEntry."Farm/Location";
                        Rec."Posting Date" := DataEntry."Entry Date";
                        Rec."LOB Code" := DataEntry."Shortcut Dimension 1 Code";
                    end;

                }

                field("Parameter No."; Rec."Parameter No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        DataentryLine: Record "Data Entry Lines";
                    begin
                        DataentryLine.Reset();
                        DataentryLine.SetRange("Document No.", rec."Document No.");
                        DataentryLine.SetRange("Parameter No.", Rec."Parameter No.");
                        if DataentryLine.FindFirst() then
                            Rec."Output Item No." := DataentryLine."Output Item No.";
                    end;

                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        DataEntrySheet: Record "Data Entry Sheet";
                        ILE: Record 32;
                    begin
                        DataEntrySheet.RESET;
                        DataEntrySheet.SETRANGE("No.", Rec."Document No.");
                        IF DataEntrySheet.FINDFIRST THEN BEGIN
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", Rec."Item No.");
                            ILE.SETRANGE("Posting Date", 0D, DataEntrySheet."Entry Date");
                            ILE.SETRANGE("Location Code", Rec."Location Code");
                            IF ILE.FINDSET THEN BEGIN
                                ILE.CALCSUMS("Remaining Quantity");
                                Rec."Stock Available" := ILE."Remaining Quantity";
                            END;
                        END;
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Stock Available"; Rec."Stock Available")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Std Value"; ABS(Rec."Std Value"))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ApplicationArea = All;
                    Editable = BcEditable;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Item Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item Tracking Lines';

                    trigger OnAction()
                    var
                        ResEn: Record "Reservation Entry";
                    begin
                        ResEn.Reset();
                        ResEn.SetRange("Item No.", Rec."Item No.");
                        ResEn.SetRange("Location Code", Rec."Location Code");
                        //    ResEn.SetRange("Source ID", 'CONSUMP');
                        ResEn.SETRANGE("Source ID", DelChr(CopyStr(Rec."Document No.", 5, 12), '=', '/'));
                        //ResEn.SetRange("Source ID", 'Prod.Order');
                        ResEn.SetRange("Source Batch Name", 'DEFAULT');
                        ResEn.DeleteAll();
                        Commit();
                        Rec.AssignLotNumber;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Machine Required" = FALSE THEN
            ActualValue := TRUE
        ELSE
            ActualValue := FALSE;
        /*
        IF "Production Order Quantity" THEN
          FieldEditable := FALSE
        ELSE
          FieldEditable := FALSE;
        */
        IF Rec."Parameter No." = 'PARA-010' THEN
            BcEditable := FALSE
        ELSE
            BcEditable := TRUE;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to delete Hatchery Entry Sheet');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Hatchery Entry Sheet');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Hatchery Entry Sheet');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Modify Hatchery Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Hatchery Entry List ');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        IF Rec."Parameter No." = 'PARA-010' THEN
            BcEditable := FALSE
        ELSE
            BcEditable := TRUE;
    end;

    var
        ActualValue: Boolean;
        DataEntry: Record "Data Entry Sheet";
        ParameterRec: Record "Parameter Master";
        DataEntryLine: Record "Data Entry Lines";
        FieldEditable: Boolean;
        UserSetup: Record 91;
        BcEditable: Boolean;
}

