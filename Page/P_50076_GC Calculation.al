page 50076 "GC Calculation"
{
    PageType = List;
    SourceTable = "GC Calculation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Type1; Rec.Type1)
                {
                    ApplicationArea = All;
                }
                field(Type2; Rec.Type2)
                {
                    ApplicationArea = All;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Value1; Rec.Value1)
                {
                    ApplicationArea = All;
                }
                field(Value2; Rec.Value2)
                {
                    ApplicationArea = All;
                }
                field(Value3; Rec.Value3)
                {
                    ApplicationArea = All;
                }
                field(Value4; Rec.Value4)
                {
                    ApplicationArea = All;
                }
                field(Value5; Rec.Value5)
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
            }
        }
    }

    actions
    {
    }
}

