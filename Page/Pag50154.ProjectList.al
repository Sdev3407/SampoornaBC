page 50154 "Project List"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     01-08-14   Page Designer               New Page Created.

    Caption = 'Project List';
    //CardPageID = "Parameter Card";
    DeleteAllowed = True;
    Editable = true;
    PageType = List;
    SourceTable = Project;
    SourceTableView = SORTING("Project Code")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
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

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin


    end;

    var
        UserSet: Record 91;
        UserSetup: Record 91;
}

