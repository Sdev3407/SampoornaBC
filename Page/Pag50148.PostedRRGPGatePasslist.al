page 50148 "Posted RRGP Gate Pass list"
{
    CardPageID = "Posted RRGP Gate Pass";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(RRGP),
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
                Caption = 'Report';
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GatePassHeader: Record "Gate Pass Header";
                begin
                    GatePassHeader := Rec;
                    GatePassHeader.SETRECFILTER;
                    REPORT.RUNMODAL(REPORT::"RGP/NRGP/RRGP Report", TRUE, FALSE, GatePassHeader);
                end;
            }
        }

    }
}

