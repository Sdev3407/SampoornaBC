page 50153 "Work Flow Event Edit"
{
    CardPageID = "Work Flow Event Edit";
    DeleteAllowed = false;
    InsertAllowed = True;
    ModifyAllowed = True;
    PageType = List;
    ApplicationArea = all;
    UsageCategory = History;
    SourceTable = "Workflow Event";


    layout
    {

        area(content)
        {
            repeater(Group)
            {
                field("Function Name"; Rec."Function Name")
                {
                }

                field("Table ID"; Rec."Table ID")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Request Page ID"; Rec."Request Page ID")
                {
                }
                field("Dynamic Req. Page Entity Name"; Rec."Dynamic Req. Page Entity Name")
                {
                }
                field("Used for Record Change"; Rec."Used for Record Change")
                {
                }
                field(Independent; Rec.Independent)
                {
                }

                // }

                //}

                // actions
                // {
                //     area(Reporting)
                //     {
                //         action(Report)
                //         {
                //             // Caption = 'Report';
                //             // Visible = true;
                //             // ApplicationArea = all;

                //             // trigger OnAction()
                //             // var
                //             //     GatePassHeader: Record "Gate Pass Header";
                //             // begin
                //             //     GatePassHeader := Rec;
                //             //     GatePassHeader.SETRECFILTER;
                //             //     REPORT.RUNMODAL(REPORT::"RGP/NRGP/RRGP Report", TRUE, FALSE, GatePassHeader);
                //             // end;
                //         }
                //     }

                // }
            }

        }
    }
}