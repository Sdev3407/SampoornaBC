page 50077 "GC Parameter Master"
{
    PageType = List;
    SourceTable = "GC Parameter Master";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Block; Rec.Block)
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

