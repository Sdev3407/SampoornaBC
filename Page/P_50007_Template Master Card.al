page 50007 "Template Master Card"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     04-08-14   Page Designer               New Page Created.

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Template Master Header";
    //  ApplicationArea = All;
    // UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Hatchery Template"; Rec."Hatchery Template")
                {
                    ApplicationArea = All;
                }
            }
            part("Template Master Lines"; "Template Master Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Template No." = FIELD("Template No.");
                SubPageView = SORTING("Template No.", "Line No")
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
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
            ERROR('You can not create template master');
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
            ERROR('You can not create template master');
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
        PeriodLength: Integer;
        ParameterType: Text[50];
        userset: Record 91;
        UserSetup: Record 91;
}

