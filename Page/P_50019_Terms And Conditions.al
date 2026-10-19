page 50019 "Terms And Conditions"
{
    AutoSplitKey = false;
    DeleteAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Terms And Conditions1";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Terms; Rec.Terms)
                {
                    ApplicationArea = All;
                    Caption = 'Terms';
                }
                field(Conditions; Rec.Conditions)
                {
                    ApplicationArea = All;
                    Caption = 'Conditions';
                }
                field(Conditions2; Rec.Conditions2)
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

