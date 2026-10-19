page 50100 "Mandi Master"
{
    Caption = 'Mandi Master';
    DataCaptionFields = "Code", Description, Blocked;
    PageType = List;
    SourceTable = "Mandi master";
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
                field(Blocked; Rec.Blocked)
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

