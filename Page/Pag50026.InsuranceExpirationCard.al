page 50026 "Insurance Expiration Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Insurance Expiration Alert";
    //   ApplicationArea = All;
    // UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                }
                field("Old Policy"; Rec."Old Policy")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                }
                field("Premium Amount"; Rec."Premium Amount")
                {
                    ApplicationArea = All;
                }
                field("Insured Amount"; Rec."Insured Amount")
                {
                    ApplicationArea = All;
                }
                field(Building; rec.Building)
                {
                    ApplicationArea = All;
                }
                field("Plant & Mach"; rec."Plant & Mach")
                {
                    ApplicationArea = All;
                }
                field("Furniture & Fixture"; rec."Furniture & Fixture")
                {
                    ApplicationArea = All;
                }
                field("Electricals"; rec."Electricals")
                {
                    ApplicationArea = All;
                }
                field("Office Equipment"; rec."Office Equipment")
                {
                    ApplicationArea = All;
                }

                field("Vehicles"; rec."Vehicles")
                {
                    ApplicationArea = All;
                }

                field("Gen Set"; rec."Gen Set")
                {
                    ApplicationArea = All;
                }

                field("Boiler"; rec."Boiler")
                {
                    ApplicationArea = All;
                }

                field("Transformer"; rec."Transformer")
                {
                    ApplicationArea = All;
                }
                field(Stock; rec.Stock)
                {
                    ApplicationArea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Ins. Policy Start Date"; Rec."Ins. Policy Start Date")
                {
                    ApplicationArea = All;
                }
                field("Ins. Policy Renewal Date"; Rec."Ins. Policy Renewal Date")
                {
                    ApplicationArea = All;
                }
                field("Ins. Policy Alert Date"; Rec."Ins. Policy Alert Date")
                {
                    ApplicationArea = All;
                }
                field("E-Mail ID"; Rec."E-Mail ID")
                {
                    ApplicationArea = All;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = All;
                }
                field(Sold; Rec.Sold)
                {
                    ApplicationArea = All;
                }
                field(Renewed; Rec.Renewed)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

