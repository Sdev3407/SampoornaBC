page 50157 "Consumption Posting Setup"
{
    Caption = 'Consumption Posting Setup';
    //CardPageID = "Parameter Card";
    DeleteAllowed = True;
    Editable = true;
    PageType = List;
    SourceTable = "Consumable Setup";
    SourceTableView = SORTING("Posting Group")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
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

