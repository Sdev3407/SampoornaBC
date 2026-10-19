namespace Microsoft.Manufacturing.Forecast;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.CRM.Team;

query 50002 "Item With Variants & SP"
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
            dataitem(Item_Variant; "Item Variant")
            {
                DataItemLink = "Item No." = Item."No.";

                column(VariantCode; Code)
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