page 50028 "RGP Gate Pass List"
{
    ApplicationArea = All;
    Caption = 'RGP Gate Pass List';
    PageType = List;
    CardPageId = "RGP Gate Pass";
    SourceTable = "Gate Pass Header";
    UsageCategory = Lists;
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(RGP),
                            Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Type field.';
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Code field.';
                }
                field("Pending Qty"; Rec."Pending Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Qty field.';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("RGP No."; Rec."RGP No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }

                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Qty field.';
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
                Visible = false;

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
