page 50001 "Parameters List"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     01-08-14   Page Designer               New Page Created.

    Caption = 'Parameters List GP';
    CardPageID = "Parameter Card";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Parameter Master";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
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
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type of Parameter"; Rec."Type of Parameter")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Period Length"; Rec."Period Length")
                {
                    ApplicationArea = All;
                }
                field("Period UOM"; Rec."Period UOM")
                {
                    ApplicationArea = All;
                }
                field("Std Calculation Base"; Rec."Std Calculation Base")
                {
                    ApplicationArea = All;
                }
                field("Std UOM"; Rec."Std UOM")
                {
                    ApplicationArea = All;
                }
                field("Data Entry UOM"; Rec."Data Entry UOM")
                {
                    ApplicationArea = All;
                }
                field("In-transit Mortality"; Rec."In-transit Mortality")
                {
                    ApplicationArea = All;
                }
                field("Mortality Type"; Rec."Mortality Type")
                {
                    ApplicationArea = All;
                }
                field("Data Entry Type"; Rec."Data Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Laying Entry Type"; Rec."Laying Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Hatching Entry Type"; Rec."Hatching Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Descriptive Entry Type"; Rec."Descriptive Entry Type")
                {
                    ApplicationArea = All;
                }
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
        area(processing)
        {
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page 540;
                RunPageLink = "Table ID" = CONST(50021),
                              "No." = FIELD("No.");
                ShortCutKey = 'Shift+Ctrl+D';
            }

            action(FarmLocation)
            {
                ApplicationArea = All;
                Caption = 'Farm Location';
                Image = Dimensions;
                RunObject = codeunit 50005;
                ShortCutKey = 'Shift+Ctrl+D';
                Visible = false;
            }

        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Parameter List');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Parameter List');
    end;

    trigger OnOpenPage()
    begin
        /*
        FILTERGROUP(2);
        UserSet.GET(USERID);
        UserSet.TESTFIELD("Responsibility Center");
        SETFILTER("Responsibility Center",'%1|%2',UserSet."Responsibility Center",'');
        FILTERGROUP(0);
        */
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Parameter List');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    var
        UserSet: Record 91;
        UserSetup: Record 91;
}

