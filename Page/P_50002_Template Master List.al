page 50002 "Template Master List"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     04-08-14   Page Designer               New Page Created.

    CardPageID = "Template Master Card";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Template Master Header";
    SourceTableView = SORTING("Template No.", "Template For")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new template');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new template');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Userset.GET(USERID);
        Userset.TESTFIELD("Responsibility Center");
        Rec.SETFILTER("Responsibility Center", '%1|%2', Userset."Responsibility Center", '');
        Rec.FILTERGROUP(0);


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Template Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        Userset: Record 91;
        UserSetup: Record 91;
}

