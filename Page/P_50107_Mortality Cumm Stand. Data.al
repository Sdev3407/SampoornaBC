page 50107 "Mortality Cumm Stand. Data"
{
    PageType = List;
    SourceTable = "Cumm Mortality";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bread Code"; Rec."Bread Code")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field("Daily Intake (Gms)"; Rec."Daily Intake (Gms)")
                {
                    ApplicationArea = All;
                }
                field("Cum.Intake (Gms)"; Rec."Cum.Intake (Gms)")
                {
                    ApplicationArea = All;
                }
                field("Weight (Gms)"; Rec."Weight (Gms)")
                {
                    ApplicationArea = All;
                }
                field(FCR; Rec.FCR)
                {
                    ApplicationArea = All;
                }
                field("Cumm. Mortality"; Rec."Cumm. Mortality")
                {
                    ApplicationArea = All;
                }
                field("Daily Gain (Gms)"; Rec."Daily Gain (Gms)")
                {
                    ApplicationArea = All;
                }
                field("Avg Daily Gain/Week (Gms)"; Rec."Avg Daily Gain/Week (Gms)")
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

