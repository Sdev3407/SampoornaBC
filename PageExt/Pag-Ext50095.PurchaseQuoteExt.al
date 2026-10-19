pageextension 50095 PurchaseQuoteExt extends "Purchase Quote"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            Visible = true;
        }

        moveafter("No."; "Buy-from Vendor No.")
        moveafter("Buy-from Vendor No."; "Buy-from Contact No.")
        moveafter("Buy-from Contact No."; "Buy-from Vendor Name")
        moveafter("Buy-from Vendor Name"; "Buy-from City")
        moveafter("Buy-from City"; "Buy-from Contact")
        moveafter("Buy-from Contact"; "No. of Archived Versions")
        moveafter("No. of Archived Versions"; "Order Date")
        moveafter("Order Date"; "Document Date")
        moveafter("Document Date"; "Requested Receipt Date")
        moveafter("Requested Receipt Date"; "Vendor Order No.")
        moveafter("Vendor Order No."; "Vendor Shipment No.")
        moveafter("Vendor Shipment No."; "Order Address Code")
        moveafter("Assigned User ID"; "Location Code")

        addfirst("Invoice Details")
        {
            field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Pay-to Vendor No."; "Pay-to Contact No.")
        moveafter("Pay-to Contact No."; "Pay-to Name")
        moveafter("Pay-to Name"; "Pay-to Address")
        moveafter("Pay-to Address"; "Pay-to Address 2")
        moveafter("Pay-to Address 2"; "Pay-to Post Code")
        moveafter("Pay-to Post Code"; "Pay-to City")
        movebefore("Due Date"; "Payment Terms Code")
        movebefore("Payment Discount %"; "Due Date")
        moveafter("Payment Discount %"; "Payment Method Code")
        moveafter("On Hold"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //>>>shipping
        moveafter("Ship-to City"; "Ship-to Contact")
        moveafter("Ship-to Contact"; "Location Code")
        moveafter("Location Code"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Expected Receipt Date")
        //>>foreign trade
        movebefore("Transaction Type"; "Currency Code")
        movebefore("Transaction Specification"; "Transaction Type")
        //>>tax info
        addfirst("Tax Information ")
        {
            field("GST Input Service Distribution"; rec."GST Input Service Distribution")
            {
                ApplicationArea = all;
            }
        }
        moveafter("GST Input Service Distribution"; "Location State Code")
        moveafter("Location State Code"; "Location GST Reg. No.")
        moveafter("Location GST Reg. No."; "GST Vendor Type")
        moveafter("GST Vendor Type"; "Invoice Type")
        moveafter("Invoice Type"; "Associated Enterprises")
        moveafter("Associated Enterprises"; "Bill of Entry No.")
        moveafter("Bill of Entry No."; "Bill of Entry Date")
        moveafter("Bill of Entry Date"; "Bill of Entry Value")
        moveafter("Bill of Entry Value"; "GST Order Address State")
        moveafter("GST Order Address State"; "Order Address GST Reg. No.")
        moveafter("Order Address GST Reg. No."; "Vendor GST Reg. No.")


    }
    actions
    {
        // Add changes to page actions here
        modify(MakeOrder)
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::" ");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Convert Purchase Quote into Purchase Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Convert Purchase Quote into Purchase Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Convert Purchase Quote into Purchase Order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Convert Purchase Quote into Purchase Order');
                //PRU_DD 1.10
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Create Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Quote');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        /*=======*/ ///TARGET
        SetLocGSTRegNoEditable;
        /*<<<<<<<*/

    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit 57;
    begin
        CurrPage.SAVERECORD;
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SetLocGSTRegNoEditable()
    begin

    end;

    var
        myInt: Integer;

        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
}