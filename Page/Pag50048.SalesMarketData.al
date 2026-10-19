page 50048 "Sales Market Data"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Market Data";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Father Name"; Rec."Father Name")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = all;
                }
                field(Village; Rec.Village)
                {
                    ApplicationArea = all;
                }
                field(Tehsil; rec.Tehsil)
                {
                    ApplicationArea = all;
                }
                field("Distt."; Rec."Distt.")
                {
                    ApplicationArea = all;
                }
                field("PIN Code"; Rec."PIN Code")
                {
                    ApplicationArea = all;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                }
                field("Type Of Consumer"; Rec."Type Of Consumer")
                {
                    ApplicationArea = all;
                }
                field("Sales Person"; Rec."Sales Person")
                {
                    ApplicationArea = all;
                }
                field("Team Leader"; Rec."Team Leader")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }




}

