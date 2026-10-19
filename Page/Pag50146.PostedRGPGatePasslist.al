page 50146 "Posted RGP Gate Pass list"
{
    CardPageID = "Posted RGP Gate Pass";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = History;
    SourceTable = "Gate Pass Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(RGP),
                            Posted = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(control)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                }

                field("Location Code"; Rec."Location Code")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field("Code"; Rec."Code")
                {
                }
                field("Party Name"; Rec."Party Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(Report)
            {
            }
        }

    }
}

