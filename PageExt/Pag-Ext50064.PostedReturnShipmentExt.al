pageextension 50064 PostedReturnShipmentExt extends "Posted Return Shipment"
{
    layout
    {
        addafter("No.")
        {
            field("Line Narration1"; Rec."Line Narration1")
            {
                ApplicationArea = All;

            }
            field("Mandi Name"; Rec."Mandi Name")
            {
                ApplicationArea = All;

            }
            field("File No."; Rec."File No.")
            {
                ApplicationArea = All;

            }
        }
    }

}