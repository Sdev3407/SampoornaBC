page 50051 "GC Standard Cost"
{
    PageType = List;
    SourceTable = "GC Standard Cost";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Shed Type"; Rec."Shed Type")
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("Std. Production Cost"; Rec."Std. Production Cost")
                {
                    ApplicationArea = All;
                }
                field("Std. Sales Rate"; Rec."Std. Sales Rate")
                {
                    ApplicationArea = All;
                }
                field("Std. Admin Cost"; Rec."Std. Admin Cost")
                {
                    ApplicationArea = All;
                }
                field("Std. GC Rate"; Rec."Std. GC Rate")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
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

