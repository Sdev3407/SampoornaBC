query 50004 "Item Location Inventory"
{
    Caption = 'Item Location Inventory';
    QueryType = Normal;
    DataAccessIntent = ReadOnly;
    elements
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.") { }
            column(LocationCode; "Location Code") { }
            column(Posting_Date; "Posting Date") { }
            column(Inventory; Quantity)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}