page 50156 "Section"
{
    Caption = 'Section List';
    //CardPageID = "Parameter Card";
    DeleteAllowed = True;
    Editable = true;
    PageType = List;
    SourceTable = Section;
    SourceTableView = SORTING("Section Code")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
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

