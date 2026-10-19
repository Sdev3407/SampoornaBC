page 50087 "Item Sub Category"
{
    Caption = 'Item Sub Category';
    PageType = List;
    SourceTable = 50047;
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Sub Category"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Item Sub Category Name"; Rec."Item Sub Category Name")
                {
                    ApplicationArea = All;
                }

            }



        }
    }


    var
        UserSetup: Record 91;
}

