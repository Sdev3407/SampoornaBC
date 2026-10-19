page 50112 "Line Name"
{
    PageType = List;
    SourceTable = "Line Name (CBF)";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Line Code"; Rec."Line Code")
                {
                    ApplicationArea = All;
                }
                field("Line Discription"; Rec."Line Discription")
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

