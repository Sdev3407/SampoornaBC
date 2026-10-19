query 50006 "LotWiseInventorySummary"
{
    QueryType = API;
    EntitySetName = 'LotWiseInventorySummary';
    EntityName = 'LotWiseInventorySummary';

    elements
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableFilter = "Remaining Quantity" = filter('<>0');
            column(Location_Code; "Location Code") { }
            column(ItemNo; "Item No.") { }
            column(LotNo; "Lot No.") { }

            // Aggregate Remaining Quantity per Lot
            column(RemainingQty; "Remaining Quantity")
            {
                Method = Sum;
            }
            column(Expiration_Date; "Expiration Date") { }


            // dataitem(ReservationEntry; "Reservation Entry")
            // {
            //     DataItemLink = "Lot No." = ItemLedgerEntry."Lot No.",
            //                    "Item No." = ItemLedgerEntry."Item No.",
            //                    "Location Code" = ItemLedgerEntry."Location Code";
            //     column(ReservedQty; "Quantity (Base)")
            //     {
            //         Method = Sum;
            //     }
            // }
        }
    }

    // Calculated column for Available Stock
    // trigger OnAfterGetRecord()
    // var
    //     AvailableStock: Decimal;
    // begin
    //     AvailableStock := ItemLedgerEntry.RemainingQty - ReservationEntry.ReservedQty;
    //     CurrQuery.AddColumnValue('AvailableStock', AvailableStock);
    // end;
}