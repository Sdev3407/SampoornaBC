pageextension 50132 TDSSetupExt extends "TDS Setup"
{
    layout
    {
        addafter("Nil Pay TDS Document Nos.")
        {
            field("Include GST Base in TDS"; Rec."Include GST Base in TDS")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete new TDS setup');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create new TDS setup');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify new TDS setup');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create new TDS setup');
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open TDS NOD/NOC Setup');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."TDS NOD/NOC Setup", '%1', UserSetup."TDS NOD/NOC Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //END;
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;

    var
        myInt: Integer;
}