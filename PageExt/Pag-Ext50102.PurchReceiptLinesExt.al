pageextension 50102 PurchReceiptLinesExt extends "Purch. Receipt Lines"
{
    layout
    {
        addafter("No.")
        {
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
            }
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Challan Qty"; Rec."Challan Qty")
            {
                ApplicationArea = All;

            }
            field("Weight Qty"; Rec."Weight Qty")
            {
                ApplicationArea = All;

            }
            field("Excess Qty"; Rec."Excess Qty")
            {
                ApplicationArea = All;

            }
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;

            }
            field("Indent Line No."; Rec."Indent Line No.")
            {
                ApplicationArea = All;

            }
            field("Bag Item No."; Rec."Bag Item No.")
            {
                ApplicationArea = All;

            }
            field("Bag Quantity"; Rec."Bag Quantity")
            {
                ApplicationArea = All;

            }
            field("Parent Bag Line No."; Rec."Parent Bag Line No.")
            {
                ApplicationArea = All;

            }
            field("Quantity With Bag"; Rec."Quantity With Bag")
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
            field("Week Bird Quantity"; Rec."Week Bird Quantity")
            {
                ApplicationArea = All;

            }
            field("Transit Mortality Quantity"; Rec."Transit Mortality Quantity")
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
            field("Extra Quantity"; Rec."Extra Quantity")
            {
                ApplicationArea = All;

            }
            field("Short Closed"; Rec."Short Closed")
            {
                ApplicationArea = All;

            }
            field("Actual Qty."; Rec."Actual Qty.")
            {
                ApplicationArea = All;

            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;

            }
            field("Tax Free"; Rec."Tax Free")
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
        // UserSetup.GET(USERID);
        // FILTERGROUP(2);
        // SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        // // IF NOT UserSetup."User Permission" THEN BEGIN
        // SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        // IF NOT UserSetup."HO Users" THEN
        //     SETFILTER("Location Code", UserSetup."Shortcut Dimension 3 Code");
        // //END;
        // FILTERGROUP(0);

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
        Rec.FILTERGROUP(0);
    end;

    var
        myInt: Integer;
        InventoryPeriod: Record 5814;
        InventoryOpenedFrom: Date;
        UserSetup: Record 91;

}