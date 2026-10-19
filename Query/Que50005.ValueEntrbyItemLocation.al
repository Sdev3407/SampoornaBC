query 50005 "ValueEntr by Item-Location"
{
    elements
    {
        dataitem(ValueEntry; "Value Entry")
        {
            column(ItemNo; "Item No.") { }
            column(LocationCode; "Location Code") { }
            column(Posting_Date; "Posting Date") { }
            column(CostAmount; "Cost Amount (Actual)")
            {
                Method = Sum;
            }
        }
    }
}
