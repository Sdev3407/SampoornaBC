page 50068 "Farm Data"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Data Entry Lines";
    SourceTableView = SORTING("Document No.", "Flock No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Posted = FILTER(true));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Diseases; Rec.Diseases)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reverse Qty."; Rec."Reverse Qty.")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

