pageextension 50103 ReasonCodesExt extends "Reason Codes"
{
    layout
    {
        addafter(Description)
        {
            field(Hatchery; Rec.Hatchery)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}