pageextension 50188 PostedReturnShipmentSubform extends "Posted Return Shipment Subform"
{
    layout
    {
        addbefore("No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            {
                ApplicationArea = All;}
        }
    }
}
