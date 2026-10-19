page 50014 "Breed Variation"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     08-08-14   Page Designer               New Page Created.

    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Breed Variation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Breed Code"; Rec."Breed Code")
                {
                    ApplicationArea = All;
                }
                field("Type of Line"; Rec."Type of Line")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                }
                field("Hatchery Template"; Rec."Hatchery Template")
                {
                    ApplicationArea = All;
                }
                field("Consumption Item No."; Rec."Consumption Item No.")
                {
                    ApplicationArea = All;
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
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete breed master');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new breed master');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify breed master');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new breed master');
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}

