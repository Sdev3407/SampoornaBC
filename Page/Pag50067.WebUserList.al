page 50067 "Web User List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = WebUsers;
    CardPageId = "Web User Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Modile No."; Rec."Modile No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Team Code"; Rec."Sales Team Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        // area(Processing)
        // {
        //     action("Web user Setup")
        //     {
        //         ApplicationArea = all;
        //         RunObject = page "Web User Setup";
        //         RunPageLink = "User Name" = field("User Name");
        //     }
        // }
    }
}