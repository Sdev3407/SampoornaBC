page 50104 "Diseases Master Editable"
{
    PageType = List;
    SourceTable = 231;
    SourceTableView = SORTING(Code)
                      ORDER(Ascending)
                      WHERE(Hatchery = CONST(false));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

