page 50113 "Customer Scheme Detail"
{
    PageType = List;
    SourceTable = "Customer Scheme Detail";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("FREIGHT ON BROILER"; Rec."FREIGHT ON BROILER")
                {
                    ApplicationArea = All;
                }
                field("FREIGHT ON LAYER"; Rec."FREIGHT ON LAYER")
                {
                    ApplicationArea = All;
                }
                field("MONTHLY SCHEME ON BROILER"; Rec."MONTHLY SCHEME ON BROILER")
                {
                    ApplicationArea = All;
                }
                field("MONTHLY SCHEME ON LAYER"; Rec."MONTHLY SCHEME ON LAYER")
                {
                    ApplicationArea = All;
                }
                field("YEARLY SCHEME ON BROILER"; Rec."YEARLY SCHEME ON BROILER")
                {
                    ApplicationArea = All;
                }
                field("YEARLY SCHEME ON LAYER"; Rec."YEARLY SCHEME ON LAYER")
                {
                    ApplicationArea = All;
                }
                field("FREIGHT AMOUNT"; Rec."FREIGHT AMOUNT")
                {
                    ApplicationArea = All;
                }
                field(OVERRDING; Rec.OVERRDING)
                {
                    ApplicationArea = All;
                }
                field("COMMISION ON SALE"; Rec."COMMISION ON SALE")
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

