query 50008 "ItemLOCwisesummary"
{
    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.") { }
            column(LocationCode; "Location Code") { }
            column(Posting_Date; "Posting Date") { }
            column(Quantity; Quantity)
            {
                Method = Sum;
            }

            // Define relation with Value Entry
            dataitem(ValueEntry; "Value Entry")
            {
                DataItemLink = "Item No." = Item_Ledger_Entry."Item No.",
                               "Location Code" = Item_Ledger_Entry."Location Code",
                               "Posting Date" = Item_Ledger_Entry."Posting Date";

                column(CostAmount; "Cost Amount (Actual)")
                {
                    Method = Sum;
                }
            }
        }
    }
}
