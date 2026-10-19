pageextension 50006 GLAccountListExt extends "G/L Account List"
{
    layout
    {
        addafter(Name)
        {
            field("SMS Alert Mobile No."; Rec."SMS Alert Mobile No.")
            {
                ApplicationArea = All;

            }
            field("Prevent Negative Balance"; Rec."Prevent Negative Balance")
            {
                ApplicationArea = All;

            }
            field("FEED Freight Charge"; Rec."FEED Freight Charge")
            {
                ApplicationArea = All;

            }
            field("Group By"; Rec."Group By")
            {
                ApplicationArea = All;

            }
            field("Group by Shorting"; Rec."Group by Shorting")
            {
                ApplicationArea = All;

            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open G/L Account');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        //PRU_NEELESH
        // if BaseCodeunit.CheckingGLAccountApprovalsWorkflowEnabled(Rec) Then
        //     Rec.SetFilter(Status, '%1', Rec.Status::Approved);

        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Access G\L Account" <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("No.", UserSetup."Access G\L Account");
                Rec.FILTERGROUP(0);
            END;
        END;

        //PRU_NEELESH

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        Companyinfo: Record "Company Information";
}