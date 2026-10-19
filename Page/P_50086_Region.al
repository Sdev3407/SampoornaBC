page 50086 "Region"
{

    PageType = List;
    SourceTable = Region;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Region Code"; rec."Region Code")
                {
                    ApplicationArea = all;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; rec."MobileNo.")
                {
                    ApplicationArea = all;
                }
                field("Email ID"; rec."Email ID")
                {
                    ApplicationArea = all;
                }

            }
        }

    }

}