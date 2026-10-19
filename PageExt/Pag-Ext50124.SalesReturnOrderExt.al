pageextension 50124 SalesReturnOrderExt extends "Sales Return Order"
{
    layout
    {
        addafter("GST Customer Type")
        {
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
        }
        modify("Invoice Type")
        {
            trigger OnAfterValidate()
            begin
                ApplyBillOf := true;
            end;
        }

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
                UserSetupRec.Get(USERID);
                if UserId <> 'JOBQUEUE' Then begin
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    //    Clear(Rec."Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    //Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        //     Message('Hellp12');
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                            //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                            // Message(UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                    end;
                end;
                //                Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Customer;
                CustList: Page "Customer List";
                UserSetupRec: Record "User Setup";
            begin
                if UserId <> 'JOBQUEUE' Then begin
                    Cust.Reset();
                    Cust.SetFilter(Blocked, '%1', Cust.Blocked::" ");
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Sell-to Customer No.", Cust."No.");
                        CurrPage.Update();
                        UserSetupRec.Get(USERID);
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        //    Clear(Rec."Shortcut Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        //Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                        IF NOT UserSetupRec."User Permission" THEN BEGIN
                            //     Message('Hellp12');
                            Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                            IF NOT UserSetupRec."HO Users" THEN BEGIN
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                                //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                                // Message(UserSetupRec."Shortcut Dimension 3 Code");
                            END;
                        end;
                    end;
                    //  Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
                END;
            end;

        }
        modify("Sell-to Customer Name")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Customer;
                CustList: Page "Customer List";
                UserSetupRec: Record "User Setup";
            begin
                if UserId <> 'JOBQUEUE' Then begin
                    Cust.Reset();
                    Cust.SetFilter(Blocked, '%1', Cust.Blocked::" ");
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Sell-to Customer No.", Cust."No.");
                        CurrPage.Update();
                        UserSetupRec.Get(USERID);
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        Clear(Rec."Shortcut Dimension 2 Code");
                        IF NOT UserSetupRec."User Permission" THEN BEGIN
                            //   Message('Hell');
                            Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                            IF NOT UserSetupRec."HO Users" THEN BEGIN
                                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                                //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                                // Message(UserSetupRec."Shortcut Dimension 3 Code");
                            END;
                        end;
                    end;
                    //Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
                END;
            end;

        }
        modify("Location Code")
        {

            trigger OnAfterValidate()
            var
                LocRec: Record Location;
                UserSetupRec: Record "User Setup";
            begin
                UserSetupRec.Get(USERID);
                if UserId <> 'JOBQUEUE' Then begin
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    Rec.SetHideValidationDialog(true);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, Rec."Location Code");
                        IF Location.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    END;

                    Rec.VALIDATE("Shortcut Dimension 2 Code");
                    Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Location;
                CustList: Page "Location List";
                UserSetupRec: Record "User Setup";
            begin
                if UserId <> 'JOBQUEUE' Then begin
                    Cust.Reset();
                    Cust.SetRange("Use As In-Transit", false);
                    Cust.SetRange(Block, false);
                    if rec."Shortcut Dimension 2 Code" <> '' then
                        Cust.SetFilter(Cust."Global Dimension 2 Code", '%1', rec."Shortcut Dimension 2 Code");
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        rec.Validate("Location Code", Cust.Code);

                        UserSetupRec.Get(USERID);
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        Rec.SetHideValidationDialog(true);
                        IF UserSetupRec."User Permission" THEN BEGIN
                            Location.RESET;
                            Location.SETRANGE(Code, Rec."Location Code");
                            IF Location.FINDFIRST THEN
                                Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                        END;
                        Rec.VALIDATE("Shortcut Dimension 2 Code");
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                    end;
                end;
            END;
        }
        //>>general
        modify("Sell-to")
        {
            Visible = false;
        }
        moveafter("Sell-to Customer No."; "Sell-to Contact No.")
        moveafter("Sell-to Contact No."; "Sell-to Customer Name")
        moveafter("Sell-to Customer Name"; "Sell-to Address")
        moveafter("Sell-to Address"; "Sell-to Address 2")
        moveafter("Sell-to Address 2"; "Sell-to Post Code")
        moveafter("Sell-to Post Code"; "Sell-to City")
        moveafter("Sell-to Contact"; "No. of Archived Versions")
        moveafter("No. of Archived Versions"; "Posting Date")
        moveafter("Posting Date"; "Order Date")
        moveafter("Order Date"; "Document Date")
        moveafter("Document Date"; "Location Code")
        moveafter("Location Code"; "External Document No.")
        moveafter("External Document No."; "Salesperson Code")
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
        }
        ///>>Invoice
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Customer Posting Group")
        {
            Visible = false;
        }
        modify("Company Bank Account Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify(BillToContactPhoneNo)
        {
            Visible = false;
        }
        modify(BillToContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify(BillToContactEmail)
        {
            Visible = false;
        }
        moveafter("Applies-to ID"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        movefirst("Invoice Details"; "Bill-to")
        movebefore("Bill-to Name"; "Bill-to Contact No.")
        moveafter("Bill-to Address 2"; "Bill-to Post Code")
        moveafter("Bill-to Post Code"; "Bill-to City")
        //>>shipping
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        movefirst("Shipping and Billing"; "Ship-to")
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Post Code"; "Ship-to City")
        moveafter("Ship-to Contact"; "Shipment Date")
        //>>foreign trade
        movefirst("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "EU 3-Party Trade")
        moveafter("EU 3-Party Trade"; "Transaction Type")
        modify("Vehicle Type")
        {
            Visible = false;
        }
        modify("LR/RR Date")
        {
            Visible = false;
        }
        modify("LR/RR No.")
        {
            Visible = false;
        }
        //>>>Tax Info
        movefirst("Tax Info"; "Sale Return Type")
        modify("POS Out Of India")
        {
            Visible = false;
        }
        modify("Post GST to Customer")
        {
            Visible = false;
        }
        modify("TDS Certificate Receivable")
        {
            Visible = false;
        }

        addafter(Status)
        {
            field("Return Receipt No. Series"; Rec."Return Receipt No. Series")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addfirst(Warehouse)
        {
            action("Page Gate Entry Attachment List")
            {
                ApplicationArea = all;
                Image = Line;
                Caption = 'attached gate Entry';
                RunObject = page "Gate Entry Attachment List";
                RunPageLink = "Source Type" = const("Sales Return Order"), "Source No." = field("No.");
            }
            action("Get Gate EntryLines")
            {
                ApplicationArea = all;
                Caption = 'Get Gate Entry Lines';
                Image = GetLines;
                trigger OnAction()
                var
                    sh: Record "Sales Header";
                begin
                    Sh.GetGateEntryLines;
                end;
            }
        }

        modify(Post)
        {
            trigger OnBeforeAction()
            begin

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Return order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Return order');

            end;
        }
        // Add changes to page actions here

        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Return order');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Return order');
                //          Post(CODEUNIT::"Sales-Post (Yes/No)");
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    var

    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete the Sales Return Order.');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        if ApplyBillOf = false then
            Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        //  Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change the Sales Return Order Details');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit 57;
    begin
        CurrPage.SAVERECORD;
        DocumentTotals.SalesRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SetLocGSTRegNoEditable()
    begin
    end;

    var
        myInt: Integer;
        SalesLine: Record "Sales Line";
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        Location: Record 14;
}