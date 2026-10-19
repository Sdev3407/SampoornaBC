pageextension 50125 SalesShipmentLinesExt extends "Sales Shipment Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;

            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;

            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;

            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("Bird Type"; Rec."Bird Type")
            {
                ApplicationArea = All;

            }
            field("Male Brid Qty."; Rec."Male Brid Qty.")
            {
                ApplicationArea = All;

            }
            field("Female Bird Qty."; Rec."Female Bird Qty.")
            {
                ApplicationArea = All;

            }
            field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
            {
                ApplicationArea = All;

            }
            field("Amt. to Customer"; Rec."Amt. to Customer")
            {
                ApplicationArea = All;

            }
            field("Shipment Amount"; Rec."Shipment Amount")
            {
                ApplicationArea = All;

            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;

            }
            field("Price Discount"; Rec."Price Discount")
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
        //UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        // SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        // //IF NOT UserSetup."User Permission" THEN BEGIN
        // SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        // IF NOT UserSetup."HO Users" THEN
        //     SETFILTER("Location Code", UserSetup."Shortcut Dimension 3 Code");
        // //  END;
        InventoryPeriod.IsValidDate(InventoryOpenedFrom);
        IF InventoryOpenedFrom <> 0D THEN
            IF Rec.GETFILTER("Posting Date") = '' THEN
                Rec.SETFILTER("Posting Date", '%1..', CALCDATE('<+1D>', InventoryOpenedFrom))
            ELSE BEGIN
                IF Rec.GETFILTER("Posting Date") <> STRSUBSTNO('%1..', CALCDATE('<+1D>', InventoryOpenedFrom)) THEN
                    Rec.SETFILTER("Posting Date",
                      STRSUBSTNO('%2&%1..', CALCDATE('<+1D>', InventoryOpenedFrom), Rec.GETFILTER("Posting Date")))
            END;
        Rec.FILTERGROUP(0);


    end;

    var
        myInt: Integer;
        InventoryPeriod: Record 5814;
        InventoryOpenedFrom: Date;
        UserSetup: Record 91;

}