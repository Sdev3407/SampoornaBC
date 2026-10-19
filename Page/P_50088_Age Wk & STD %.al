page 50088 "Age Wk & STD %"
{
    PageType = List;
    SourceTable = "Age Wk & STD %";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("AGE WK"; Rec."AGE WK")
                {
                    ApplicationArea = All;
                }
                field("CHICKS PRODUCTION %"; Rec."CHICKS PRODUCTION %")
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

