pageextension 50094 PurchasePricesExt extends "Purchase Prices"
{
    layout
    {
        addafter("Item No.")
        {
            field("Location Code"; Rec."Location Code")
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
        PurchasePrice: Record 7012;
}