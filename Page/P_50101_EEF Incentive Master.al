page 50101 "EEF Incentive Master"
{
    PageType = List;
    SourceTable = "EEF Range";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Shed Type"; Rec."Shed Type")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                }
                field("GC Type"; Rec."GC Type")
                {
                    ApplicationArea = All;
                }
                field("EEF Range From"; Rec."EEF Range From")
                {
                    ApplicationArea = All;
                    Caption = 'Range From';
                }
                field("EEF Range To"; Rec."EEF Range To")
                {
                    ApplicationArea = All;
                    Caption = 'Range To';
                }
                field("RS/KG"; Rec."RS/KG")
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

