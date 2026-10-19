page 50141 ITAssetsRegisterList
{
    ApplicationArea = All;
    Caption = 'IT Assets Register';
    PageType = List;
    SourceTable = ITAssetsRegister;
    UsageCategory = Lists;
    //Editable = true;
    CardPageID = IT_Assets_Register;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Fixed Assets No."; Rec."Fixed Assets No.")
                {
                }
                field("FA Name"; Rec."FA Name")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Owner; Rec.Owner)
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }

            }
        }
    }
}