pageextension 50096 PurchaseQuoteSubformExt extends "Purchase Quote Subform"
{
    layout
    {


        /* addafter("No.")
         {
             field("QC Enabled"; Rec."QC Enabled")
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
             field("Excess/Short Qty"; Rec."Excess/Short Qty")
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
         }*/
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Purchase Quote');

        IF (rec.Quantity <> 0) AND rec.ItemExists(rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Purchase Quote');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Quote');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}