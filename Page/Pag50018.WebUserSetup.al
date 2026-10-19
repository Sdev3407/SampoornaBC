page 50018 "Web User Setup"
{
    PageType = List;
    SourceTable = "Web User Setup";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field(LOB; Rec.LOB)
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("LOC Code"; Rec."LOC Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

            }
        }
    }

    actions
    {
    }
}

