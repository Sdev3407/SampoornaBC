page 50055 "ItemTrackingLine"
{
    CardPageID = "ItemTrackingLine";
    DeleteAllowed = True;
    Editable = true;
    PageType = API;
    DelayedInsert = true;
    EntityName = 'ItemTrackingLine';
    EntitySetName = 'ItemTrackingLine';
    SourceTable = "Reservation Entry";
    //SourceTableView = WHERE("Order Type" = FIlter('Production'), "Flushing Method" = Filter('Manual'));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)

            {
                field("Source_Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Reservation_Status"; Rec."Reservation Status")
                {
                    ApplicationArea = All;
                }
                field("Source_Subtype"; Rec."Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Source_ID"; Rec."Source ID")
                {
                    ApplicationArea = All;
                }
                field("Source_Batch_Name"; Rec."Source Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Source_Prod_Order_Line"; Rec."Source Prod. Order Line")
                {
                    ApplicationArea = All;
                }
                field("Source_Ref_No_"; Rec."Source Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Item_No"; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Location_Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Lot_No"; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Expiration_Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Base"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty_to_Handl_Base"; Rec."Qty. to Handle (Base)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}




