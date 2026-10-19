Page 50163 "Power Master Setup"
{

    //CardPageID = "Posted Power Data Entry List";
    PageType = List;
    SourceTable = "Power Data Master Setup";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Power Type"; Rec."Power Type")
                {
                    ApplicationArea = All;
                }
                field("Efective From"; Rec."Efective From")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                }
                field("Unit Rate"; Rec."Unit Rate")
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin



    end;

    var

}


