page 50006 "Parameter Card"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     01-08-14   Page Designer               New Page Created.

    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Parameter Master";
    //ApplicationArea = All;
    //UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type of Parameter"; Rec."Type of Parameter")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                { ApplicationArea = All; }

                field("Period Length"; Rec."Period Length")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        recTemplateMasterHeader: Record "Template Master Header";
                    begin
                        /*
                        recTemplateMasterHeader.RESET;
                        recTemplateMasterHeader.SETRANGE("Parameter No.","No.");
                        recTemplateMasterHeader.SETFILTER("Parameter Period Start Date",'<>%1',0D);
                        IF recTemplateMasterHeader.FINDFIRST THEN BEGIN
                          recTemplateMasterHeader."Parameter Period End Date" := recTemplateMasterHeader."Parameter Period Start Date" + "Period Length" - 1;
                          recTemplateMasterHeader.MODIFY;
                        END;
                        */

                    end;
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
                field("Hatchery Parameter"; Rec."Hatchery Parameter")
                {
                    ApplicationArea = All;
                }
                field("Include With Cost"; Rec."Include With Cost")
                {
                    ApplicationArea = All;
                }
                field("Machine No."; Rec."Machine No.")
                {
                    ApplicationArea = All;
                }
                field("In-transit Mortality"; Rec."In-transit Mortality")
                {
                    ApplicationArea = All;
                }
                field("Make Mandatory In Daily"; "Make Mandatory In Daily")
                {
                    ApplicationArea = all;
                }
                field("Make Mandatory In a Week"; Rec."Make Mandatory In a Week")
                {
                    ApplicationArea = All;
                }
                field("Exclude Quantity of Mortality"; Rec."Exclude Quantity of Mortality")
                {
                    ApplicationArea = All;
                }
                field("Reversal Entry"; Rec."Reversal Entry")
                {
                    ApplicationArea = All;
                }
            }
            group(Reporting)
            {
                Caption = 'Reporting';
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
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Parameter List", '%1', UserSetup."Access Parameter List"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You canot delete the record');
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
            ERROR('You canot modify the record');
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
        Rec.FILTERGROUP(2);
        UserSet.GET(USERID);
        UserSet.TESTFIELD("Responsibility Center");
        Rec.SETFILTER("Responsibility Center", '%1|%2', UserSet."Responsibility Center", '');
        Rec.FILTERGROUP(0);


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

