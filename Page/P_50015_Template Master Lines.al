page 50015 "Template Master Lines"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     05-08-14   Page Designer               New Page Created.

    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Template Master Line";
    //   ApplicationArea = All;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Parameter No."; Rec."Parameter No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Parameter No.");
                    end;
                }
                field("Std. UOM"; Rec."Std. UOM")
                {
                    ApplicationArea = All;
                }
                field("Data Entry UOM"; Rec."Data Entry UOM")
                {
                    ApplicationArea = All;
                }
                field(Occurence; Rec.Occurence)
                {
                    ApplicationArea = All;
                }
                field("Frequency Start"; Rec."Frequency Start")
                {
                    ApplicationArea = All;
                }
                field("Frequency End"; Rec."Frequency End")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Field Quantity';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field("<Remarks>"; Rec."Machine Required")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Required';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Output Item No."; Rec."Output Item No.")
                {
                    ApplicationArea = All;
                }
                field("Output Item Description"; Rec."Output Item Description")
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
            ERROR('You do not have permission to delete Template Master');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Template Master');

        Rec.TESTFIELD("Parameter No.");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Template Master", '%1', UserSetup."Access Template Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Template Master');
    end;

    var
        ParameterMasterRec: Record "Parameter Master";
        UserSetup: Record 91;
}

