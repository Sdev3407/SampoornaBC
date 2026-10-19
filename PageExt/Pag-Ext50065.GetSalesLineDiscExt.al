pageextension 50065 GetSalesLineDiscExt extends "Get Sales Line Disc."
{
    layout
    {
        addafter("Sales Code")
        {
            field("Line Discount Amount"; Rec."Line Discount Amount")
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