pageextension 50182 InvSetupExt extends "Inventory Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field(RGP; Rec.RGP)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RGP field.', Comment = '%';
            }
            field(NRGP; Rec.NRGP)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NRGP field.', Comment = '%';
            }
            field(RRGP; Rec.RRGP)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RRGP field.', Comment = '%';
            }
        }
    }
}
