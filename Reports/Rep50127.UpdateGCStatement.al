report 50127 "Update GC Statement"
{
    //UsageCategory = Administration;
    Caption = 'Location Wise Closing Stock report Suman';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\LocationClosingStockReportsuman.rdl';

    dataset
    {


        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            //DataItemLink = "Item No." = FIELD("No.");
            //DataItemLinkReference = Item;
            // DataItemTableView = SORTING("Item No.")
            //                     ORDER(Ascending) where("Remaining Quantity" = filter(<> 0), "Location Code" = filter(<> 'IN-TRANSIT'), "Global Dimension 1 Code" = Filter('FEED|CATTLE'));
            RequestFilterFields = "Item Category Code";


            column(Item_No_; "Item Ledger Entry"."Item No.")
            { }
            column(Item_Name; "Item Ledger Entry"."Item Name")
            { }
            column(Location_Code; "Item Ledger Entry"."Location Code")
            { }
            column(Quantity; Quantity)
            { }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            { }
            column(LOB; LOB)
            { }
            column(InventoryPostSet; InventoryPostSet)
            { }

            trigger OnAfterGetRecord()
            var
                loc: Record Location;
                Item: Record Item;
            begin
                loc.get("Item Ledger Entry"."Location Code");
                Item.get("Item Ledger Entry"."Item No.");
                InventoryPostSet := Item."Inventory Posting Group";
                LOB := loc."Responsibility Center";

            end;

            trigger OnPreDataItem()
            begin

            end;
        }
    }
    //}
    var
        InventoryPostSet: Text;
        LOB: Text;
}