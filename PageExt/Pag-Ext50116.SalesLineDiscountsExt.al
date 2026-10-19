pageextension 50116 SalesLineDiscountsExt extends "Sales Line Discounts"
{
    layout
    {
        addafter(SalesCode)
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
}