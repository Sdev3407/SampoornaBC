pageextension 50093 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {


        addafter(Exempted)
        {

        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax group Code")
        {
            Visible = false;
        }



        moveafter("No."; "Gen. Prod. Posting Group")
        addafter("Direct Unit Cost")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
            field("GST Reverse Charge"; "GST Reverse Charge")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Depreciation Book Code"; rec."Depreciation Book Code")
            {
                ApplicationArea = all;
            }
            field("Salvage Value"; rec."Salvage Value")
            {
                ApplicationArea = all;
            }
            field("FA Posting Type"; rec."FA Posting Type")
            {
                ApplicationArea = all;
            }

        }
        moveafter("FA Posting Type"; "FA Posting Date")

        addafter("Quantity Invoiced")
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
                Visible = SFPLVisible;

            }
            field("Weight Qty"; Rec."Weight Qty")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;

            }
            field("Excess/Short Qty"; Rec."Excess/Short Qty")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Indent Line No."; Rec."Indent Line No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Bag Item No."; Rec."Bag Item No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Bag Quantity"; Rec."Bag Quantity")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Parent Bag Line No."; Rec."Parent Bag Line No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Quantity With Bag"; Rec."Quantity With Bag")
            {
                ApplicationArea = All;
                Visible = false;

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
                Visible = SFPLVisible;

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


    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Purchase Order');

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
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Purchase Order');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Order');
    end;

    trigger OnOpenPage()

    begin
        Companyinfo.Get;
        SFPLVisible := False;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            SFPLVisible := True;

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        Companyinfo: Record "Company Information";
        StarVisibile: Boolean;
        SFPLVisible: Boolean;
        Visible: Boolean;
}