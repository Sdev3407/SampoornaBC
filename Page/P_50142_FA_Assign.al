page 50142 "FA Assign"

{
    Caption = 'FA Assign';
    PageType = List;
    SourceTable = "FA Assign";
    Editable = true;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
