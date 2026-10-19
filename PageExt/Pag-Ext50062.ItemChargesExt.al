pageextension 50062 ItemChargesExt extends "Item Charges"
{
    layout
    {
        addafter(Description)
        {
            field(Block; Rec.Block)
            {
                ApplicationArea = All;

            }

        }

    }
}