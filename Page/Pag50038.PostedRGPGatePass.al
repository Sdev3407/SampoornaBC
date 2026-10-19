page 50038 "Posted RGP Gate Pass"
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
                      WHERE("Document Type" = FILTER(RGP),
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
                    Editable = "No.Editable";
                    Caption = 'RGP No.';
                    Style = Standard;
                    StyleExpr = TRUE;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
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
                field("Road Permit No."; Rec."Road Permit No.")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Truck Number"; Rec."Truck Number")
                {
                    Visible = false;
                }
                field("LR Date"; Rec."LR Date")
                {

                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    Caption = 'LR No.';
                }
                field("Date Of Return"; Rec."Date Of Return")
                {
                    Caption = 'Due Date';
                }

                field("Total Qty"; Rec."Total Qty")
                {
                }
                field("Pending Qty"; Rec."Pending Qty")
                {
                }

            }
            part(RGPLine; "Gate Pass Subform")
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

                    trigger OnAction()
                    begin
                        GatePassHeader := Rec;
                        GatePassHeader.SETRECFILTER;
                        REPORT.RUNMODAL(REPORT::"RGP/NRGP/RRGP Report", TRUE, FALSE, GatePassHeader); //cs-ds-bc
                    end;
                }

            }
        }
        area(processing)
        {
        }

    }

    trigger OnInit()
    begin
        "No.Editable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //CurrForm."Road Permit No.".EDITABLE := TRUE;
        "No.Editable" := FALSE;
    end;

    var

        GatePassHeader: Record "Gate Pass Header";
        "No.Editable": Boolean;
}

