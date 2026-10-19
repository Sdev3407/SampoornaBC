page 50044 "Normal GC Statements"
{
    CardPageID = "GC Statement";
    Editable = false;
    PageType = List;
    SourceTable = "GC Statement";
    SourceTableView = WHERE("Shed Type" = CONST(Normal),
                            Posted = CONST(false));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Farmer No."; Rec."Farmer No.")
                {
                    ApplicationArea = All;
                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;
                }
                field("Farm Code"; Rec."Farm Code")
                {
                    ApplicationArea = All;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                }
                field("Last Modified USERID"; Rec."Last USERID")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified USERID';
                    Editable = false;
                }
                field("Last Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new record');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        userset: Record 91;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open GC statement');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Normal GC Statement", '%1', UserSetup."Access Normal GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10


        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
        IF NOT userset."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var
        UserSetup: Record 91;
}

