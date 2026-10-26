pageextension 50101 PurchInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = all;
            }
        }

        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = all;
            Visible = true;
            Editable = true;
        }
        modify("FA Posting Type")
        {
            Visible = true;
            Editable = true;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SHRec: Record "Purchase Header";

            begin
                if SHRec.get(Rec."Document Type", Rec."Document No.") then
                    if SHRec."Shortcut Dimension 3 Code" <> '' then
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
            end;
        }

        addafter("Line Discount %")
        {
            field("Transit Mortality Quantity"; Rec."Transit Mortality Quantity")
            {
                ApplicationArea = All;

            }
            field("Week Bird Quantity"; Rec."Week Bird Quantity")
            {
                ApplicationArea = All;

            }
            field("Actual Qty."; Rec."Actual Qty.")
            {
                ApplicationArea = All;

            }
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                ApplicationArea = all;
                Visible = true;
                Editable = false;
            }
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Qty. Assigned"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "Custom Duty Amount")

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
        addlast("Item Availability by")
        {
            action("Comments")
            {
                ApplicationArea = all;
                Caption = 'Co&mments';
                Image = ViewComments;

                trigger OnAction()
                begin
                    Rec.ShowLineComments;
                end;
            }

        }
        modify(GetReceiptLines)
        {
            Visible = false;
        }
        addafter(GetReceiptLines)
        {
            action(GetReceiptLines1)
            {
                AccessByPermission = TableData "Purch. Rcpt. Header" = R;
                ApplicationArea = Suite;
                Caption = '&Get Receipt Lines';
                Ellipsis = true;
                Image = Receipt;
                ToolTip = 'Select a posted purchase receipt for the item that you want to assign the item charge to.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Purch.-Get Receipt1", Rec);
                    DocumentTotals.PurchaseDocTotalsNotUpToDate();
                    RedistributeTotalsOnAfterValidate();
                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Purchase Invoice');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Purchase Invoice');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Invoice');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}