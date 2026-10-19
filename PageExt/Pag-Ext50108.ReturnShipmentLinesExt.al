pageextension 50108 ReturnShipmentLinesExt extends "Return Shipment Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Tax Free"; Rec."Tax Free")
            {
                ApplicationArea = All;

            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            field("Return Qty. Shipped Not Invd."; Rec."Return Qty. Shipped Not Invd.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);

        InventoryPeriod.IsValidDate(InventoryOpenedFrom);
        IF InventoryOpenedFrom <> 0D THEN
            IF Rec.GETFILTER("Posting Date") = '' THEN
                Rec.SETFILTER("Posting Date", '%1..', CALCDATE('<+1D>', InventoryOpenedFrom))
            ELSE BEGIN
                IF Rec.GETFILTER("Posting Date") <> STRSUBSTNO('%1..', CALCDATE('<+1D>', InventoryOpenedFrom)) THEN
                    Rec.SETFILTER("Posting Date",
                      STRSUBSTNO('%2&%1..', CALCDATE('<+1D>', InventoryOpenedFrom), Rec.GETFILTER("Posting Date")))
            END;
    end;

    var
        myInt: Integer;
        InventoryPeriod: Record 5814;
        InventoryOpenedFrom: Date;
}