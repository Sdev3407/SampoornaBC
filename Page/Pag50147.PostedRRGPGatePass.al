page 50147 "Posted RRGP Gate Pass"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
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
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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

                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Truck Number"; Rec."Truck Number")
                {
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                }

                field("Total Qty"; Rec."Total Qty")
                {
                }
                field("RGP No."; Rec."RGP No.")
                {
                }
            }
            part(RRGPLine; "Gate Pass Subform")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Report")
            {
                Caption = '&Report';
                action(Report)
                {
                    Caption = 'Report';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        GatePassHeader := Rec;
                        GatePassHeader.SETRECFILTER;
                        REPORT.RUNMODAL(REPORT::"RGP/NRGP/RRGP Report", TRUE, FALSE, GatePassHeader);
                    end;
                }
            }
        }
    }

    var
        GatePassHeader: Record "Gate Pass Header";
}

