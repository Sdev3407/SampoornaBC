page 50029 "RRGP Gate Pass List"
{
    ApplicationArea = All;
    Caption = 'RRGP Gate Pass List';
    PageType = List;
    CardPageId = "RRGP Gate Pass";
    SourceTable = "Gate Pass Header";
    UsageCategory = Lists;
    SourceTableView = WHERE("Document Type" = FILTER(RRGP),
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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
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
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Order No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Code field.';
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Name field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Party Type field.';
                }
                field("Pending Qty"; Rec."Pending Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Qty field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
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
