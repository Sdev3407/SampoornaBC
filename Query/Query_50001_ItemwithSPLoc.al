namespace Microsoft.Manufacturing.Forecast;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.CRM.Team;

query 50001 "Item With SP & Locations"
{
    QueryType = Normal;
    ReadState = ReadUncommitted;
    DataAccessIntent = ReadOnly;
    TopNumberOfRows = 10000;

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = Blocked = filter(false);
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Type; Type)
            { }

            dataitem(Item_Location; Location)
            {
                SqlJoinType = CrossJoin;
                DataItemTableFilter = "Use As In-Transit" = filter(False);
                column(LocationCode; Code)
                { }
                column(LocationName; Name)
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
}