namespace Microsoft.Manufacturing.Forecast;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.CRM.Team;

query 50000 "Item With SalesPerson"
{
    QueryType = Normal;
    ReadState = ReadUncommitted;
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Type; Type)
            { }
            dataitem(Item_SP; "Salesperson/Purchaser")
            {
                SqlJoinType = CrossJoin;
                column(SalesPersonCode; Code)
                { }
                column(SalesPersonName; Name)
                { }
            }
        }
    }
}