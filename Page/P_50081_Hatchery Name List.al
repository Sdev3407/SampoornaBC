page 50081 "Hatchery Name List"
{
    CardPageID = "Hatchery Card";
    PageType = List;
    SourceTable = "Hatchery Name";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hatchery No."; Rec."Hatchery No.")
                {
                    ApplicationArea = All;
                }
                field("Hatchery Name"; Rec."Hatchery Name")
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

