page 50155 "Sub Location List"
{


    Caption = 'Sub Location List';
    //CardPageID = "Parameter Card";
    DeleteAllowed = True;
    Editable = true;
    PageType = List;
    SourceTable = "Sub Location";
    SourceTableView = SORTING("Sub Location Code")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Location Code"; Rec."Sub Location Code")
                {
                    ApplicationArea = All;
                }
                field("Sub Location Name"; Rec."Sub Location Name")
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

