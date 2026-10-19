page 50131 "Security Group"
{
    DeleteAllowed = true;
    Caption = 'Security Group';
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "SFPL_Security Group";
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
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Posting Group"; rec."Posting Group")
                {
                    ApplicationArea = all;
                }
            }


        }
    }
}