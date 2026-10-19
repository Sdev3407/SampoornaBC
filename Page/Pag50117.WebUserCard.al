page 50117 "Web User Card"

{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = WebUsers;

    layout
    {
        area(Content)
        {
            group(GroupName)
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
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
                field("Modile No."; Rec."Modile No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
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
                field("Sales Person"; Rec."Sales Person")
                {
                    ApplicationArea = All;
                }
                field("Sales Team"; Rec."Sales Team")
                {
                    ApplicationArea = All;
                }
                field("Date Freeze"; Rec."Date Freeze")
                {
                    ApplicationArea = all;
                }
                field("Days Access"; Rec."Days Access")
                {
                    ApplicationArea = All;
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                    ApplicationArea = All;
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                    ApplicationArea = All;
                }
                field("Access Purchase Credit Memo"; Rec."Access Purchase Credit Memo")
                {
                    ApplicationArea = All;
                }
                field("Access Purchase Invoice"; Rec."Access Purchase Invoice")
                {
                    ApplicationArea = All;
                }
                field("Access Purchase Order"; Rec."Access Purchase Order")
                {
                    ApplicationArea = All;
                }
                field("Access Purchase Return Order"; Rec."Access Purchase Return Order")
                {
                    ApplicationArea = All;
                }
                field("Access Sales Credit Memo"; Rec."Access Sales Credit Memo")
                {
                    ApplicationArea = All;
                }
                field("Access Sales Invoice"; Rec."Access Sales Invoice")
                {
                    ApplicationArea = All;
                }
                field("Access Sales Order"; Rec."Access Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Access Sales Return Order"; Rec."Access Sales Return Order")
                {
                    ApplicationArea = All;
                }
                field("Access Consume Inventory"; Rec."Access Consume Inventory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Web user Setup")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Web User Setup";
                RunPageLink = "User Name" = field("User Name");
            }
        }
    }

    var
        myInt: Integer;
}
