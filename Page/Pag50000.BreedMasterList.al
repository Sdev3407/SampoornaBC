page 50000 "Breed Master List"
{
    CardPageID = "Breed Master Card";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Breed Master";
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
                    AssistEdit = false;
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
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not Modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        userset.GET(USERID);
        userset.TESTFIELD("Responsibility Center");
        Rec.SETFILTER("Responsibility Center", '%1|%2', userset."Responsibility Center", '');
        Rec.FILTERGROUP(0);


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Breed Master List');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Breed Master", '%1', UserSetup."Access Breed Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        userset: Record 91;
        UserSetup: Record 91;
}

