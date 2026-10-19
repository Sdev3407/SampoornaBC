page 50016 "Sales Person Target"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Sales Person Target";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Qty In MT"; Rec."Qty In MT")
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

