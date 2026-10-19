namespace Microsoft.Manufacturing.Forecast;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.CRM.Team;

query 50003 "Item With Var & Loc & SP"
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
                // SqlJoinType = InnerJoin;
                DataItemLink = "Item No." = Item."No.";

                column(VariantCode; Code)
                { }
                dataitem(Item_Location; Location)
                {
                    SqlJoinType = CrossJoin;
                    column(LocationCode; Code)
                    { }
                    column(LocationName; Name)
                    { }
                    column(Use_As_In_Transit; "Use As In-Transit")
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
}