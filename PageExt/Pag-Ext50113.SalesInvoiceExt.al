pageextension 50113 SalesInvoiceExt extends "Sales Invoice"
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
        modify("Salesperson Code")
        {
            Editable = flag;
            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Customer;
                SalesPerson: Code[100];
                Item: Record 13;
                ItemList: Page "Salespersons/Purchasers";
                TeamSales: Record 5084;
            begin
                Clear(SalesPerson);
                if Cust.get(Rec."Sell-to Customer No.") then begin
                    if Cust."Salesperson Code" <> '' then
                        SalesPerson := Cust."Salesperson Code";

                    if Cust."Salesperson Code 2" <> '' then begin
                        if SalesPerson = '' then
                            SalesPerson := Cust."Salesperson Code 2"
                        else
                            SalesPerson := SalesPerson + '|' + Cust."Salesperson Code 2";
                    END;
                    if Cust."Salesperson Code 3" <> '' then begin
                        if SalesPerson = '' then
                            SalesPerson := Cust."Salesperson Code 3"
                        else
                            SalesPerson := SalesPerson + '|' + Cust."Salesperson Code 3";
                    end;
                    if SalesPerson = '' then
                        SalesPerson := '';
                end;
                Item.Reset();
                IF SalesPerson <> '' then
                    Item.SetFilter(Code, SalesPerson)
                ELSE
                    Item.SetRange(Code, '');
                ItemList.SETTABLEVIEW(Item);
                ItemList.LOOKUPMODE(TRUE);
                if (ItemList.RunModal() = Action::LookupOK) then begin
                    ItemList.GetRecord(Item);
                    rec."Salesperson Code" := Item.Code;
                    rec."Saels Person Name" := Item.Name;
                    TeamSales.Reset();
                    TeamSales.SetRange("Salesperson Code", Item.Code);
                    if TeamSales.FindFirst() then
                        Rec."Team Code" := TeamSales."Team Code";
                end;
            END;
        }
        addafter("Salesperson Code")
        {
            field("Team Code"; Rec."Team Code")
            {
                Editable = flag;
                ApplicationArea = all;
            }
        }

        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
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
                Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            end;
        }
        modify(ShippingOptions)
        {

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
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
                Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            end;


        }
        modify("Invoice Type")
        {
            trigger OnAfterValidate()
            begin
                ApplyBillOf := true;
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

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Location;
                CustList: Page "Location List";
                UserSetupRec: Record "User Setup";
            begin
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
            END;
        }
        modify("No.")
        {
            Visible = false;
        }
        ///
        movebefore("Sell-to Customer Name"; "Sell-to Contact No.")
        moveafter("Sell-to Customer Name"; "Sell-to")
        moveafter("Sell-to Address 2"; "Sell-to Post Code")
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify(SellToPhoneNo)
        {
            Visible = false;
        }
        modify(SellToEmail)
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Exclude GST in TCS Base")
        {
            Visible = false;
        }

        addafter("Sell-to Contact No.")
        {
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }

        }
        moveafter("P.A.N. No."; "Your Reference")
        moveafter("Your Reference"; "Posting Date")
        moveafter("Posting Date"; "Document Date")
        moveafter("Document Date"; "External Document No.")
        moveafter("External Document No."; "Salesperson Code")
        moveafter("Salesperson Code"; "Campaign No.")
        moveafter("Campaign No."; "Responsibility Center")
        moveafter("Responsibility Center"; "Assigned User ID")
        moveafter("Assigned User ID"; "Job Queue Status")
        moveafter("Job Queue Status"; Status)
        modify("Job Queue Status")
        {
            Visible = true;
        }

        //moveafter(Status; "Terms Code")
        addafter(Status)
        {

            field("Terms Code"; rec."Terms Code")
            {
                ApplicationArea = all;
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Cust: Record "Bank Account";
                    CustList: Page "Bank Account List";
                    UserSetupRec: Record "User Setup";
                begin
                    Cust.Reset();
                    Cust.SetFilter(Cust.Blocked, '%1', false);
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Bank Account No.", Cust."No.");
                    END;
                END;

            }
            field(Freight; rec.Freight)
            {
                ApplicationArea = all;
            }

            field("Line Narration"; Rec."Line Narration")
            {
                ApplicationArea = All;
                Visible = true;
            }


        }
        moveafter(Freight; "Location Code")
        addafter("Location Code")
        {
            field("Driver Mobile No."; rec."Driver Mobile No.")
            {
                ApplicationArea = all;
            }
            field("No. of Birds"; rec."No. of Birds")
            {
                ApplicationArea = all;
            }
            field(Weight; rec.Weight)
            {
                ApplicationArea = All;
            }

        }
        moveafter(Weight; "Invoice Type")
        addafter("Invoice Type")
        {
            field("Posting No. Series"; rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Against Original Invoice No."; rec."Against Original Invoice No.")
            {
                ApplicationArea = all;
            }
            field("Against Original Invoice Date"; rec."Against Original Invoice Date")
            {
                ApplicationArea = all;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Transporter Code"; rec."Transporter Code")
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Cust: Record Vendor;
                    CustList: Page "Vendor List";
                    UserSetupRec: Record "User Setup";
                begin
                    Cust.Reset();
                    Cust.SetFilter(Cust.Transporter, '%1', true);
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Transporter Code", Cust."No.");
                    END;
                END;
            }

        }
        moveafter("Transporter Code"; "LR/RR No.")
        moveafter("LR/RR No."; "LR/RR Date")
        moveafter("LR/RR Date"; "Vehicle No.")

        ///
        // modify("Sell-to Customer Name")
        // {

        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         Cust: Record Customer;
        //         CustList: Page "Customer List";
        //         UserSetupRec: Record "User Setup";
        //     begin
        //         Cust.Reset();
        //         Cust.SetFilter(Blocked, '%1', Cust.Blocked::" ");
        //         CustList.SETTABLEVIEW(Cust);
        //         CustList.LOOKUPMODE := TRUE;
        //         IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
        //             CustList.GetRecord(Cust);
        //             Rec.Validate("Sell-to Customer No.", Cust."No.");
        //             CurrPage.Update();
        //             UserSetupRec.Get(UserId);
        //             Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        //             //    Clear(Rec."Shortcut Dimension 2 Code");
        //             Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
        //             IF NOT UserSetupRec."User Permission" THEN BEGIN
        //                 Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        //                 Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
        //                 IF NOT UserSetupRec."HO Users" THEN BEGIN
        //                     Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
        //                     //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
        //                     // Message(UserSetupRec."Shortcut Dimension 3 Code");
        //                 END;
        //             end;
        //             //    Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        //         END;
        //     end;

        // }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
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
                // Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            end;

            // trigger OnLookup(var Text: Text): Boolean
            // var
            //     Cust: Record Customer;
            //     CustList: Page "Customer List";
            //     UserSetupRec: Record "User Setup";
            // begin
            //     Cust.Reset();
            //     Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
            //     CustList.SETTABLEVIEW(Cust);
            //     CustList.LOOKUPMODE := TRUE;
            //     IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
            //         CustList.GetRecord(Cust);
            //         Rec.Validate("Sell-to Customer No.", Cust."No.");
            //         CurrPage.Update();
            //         UserSetupRec.Get(UserId);
            //         Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //         //    Clear(Rec."Shortcut Dimension 2 Code");
            //         Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //         IF NOT UserSetupRec."User Permission" THEN BEGIN
            //             Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //             Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //             IF NOT UserSetupRec."HO Users" THEN BEGIN
            //                 Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
            //                 //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
            //                 // Message(UserSetupRec."Shortcut Dimension 3 Code");
            //             END;
            //         end;
            //         //  Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            //     END;
            // end;

        }
        //>>invoice
        addfirst("Invoice Details")
        {
            field("Bill-to Customer No."; rec."Bill-to Customer No.")
            {
                ApplicationArea = all;
            }

            /* addafter("No.")
             {
                 field("P.A.N. No."; Rec."P.A.N. No.")
                 {
                     ApplicationArea = All;

                 }
                 field("No. of Birds"; Rec."No. of Birds")
                 {
                     ApplicationArea = All;

                 }
                 field(Weight; Rec.Weight)
                 {
                     ApplicationArea = All;

                 }
                 field("Farmer Grade"; Rec."Farmer Grade")
                 {
                     ApplicationArea = All;

                 }
                 field("Bank Account No."; Rec."Bank Account No.")
                 {
                     ApplicationArea = All;

                 }
                 field("Transporter Code"; Rec."Transporter Code")
                 {
                     ApplicationArea = All;

                 }
                 field(Freight; Rec.Freight)
                 {
                     ApplicationArea = All;

                 }
                 field("Terms Code"; Rec."Terms Code")
                 {
                     ApplicationArea = All;

                 }

                 field("Freight Value"; Rec."Freight Value")
                 {
                     ApplicationArea = All;

                 }
                 field("Against Original Invoice Date"; Rec."Against Original Invoice Date")
                 {
                     ApplicationArea = All;

                 }
                 field("Against Original Invoice No."; Rec."Against Original Invoice No.")
                 {
                     ApplicationArea = All;

                 }
                 field("DC No."; Rec."DC No.")
                 {
                     ApplicationArea = All;

                 }
                 field("Gross Weight"; Rec."Gross Weight")
                 {
                     ApplicationArea = All;

                 }
                 field("Net Weight"; Rec."Net Weight")
                 {
                     ApplicationArea = All;

                 }
                 field("Tier Weight"; Rec."Tier Weight")
                 {
                     ApplicationArea = All;

                 }
                 field(Average; Rec.Average)
                 {
                     ApplicationArea = All;

                 }


                 field("Driver Mobile No."; Rec."Driver Mobile No.")
                 {
                     ApplicationArea = All;

                 }
                 field("Broker Code"; Rec."Broker Code")
                 {
                     ApplicationArea = All;

                 }
                 field("Item Category Code"; Rec."Item Category Code")
                 {
                     ApplicationArea = All;

                 }

                 field("Product Group Code"; Rec."Product Group Code")
                 {
                     ApplicationArea = All;

                 }
                 field("Entry Date"; Rec."Entry Date")
                 {
                     ApplicationArea = All;

                 }

                 field("Line Narration"; Rec."Line Narration")
                 {
                     ApplicationArea = All;

                 }

             }*/
        }
        moveafter("Bill-to Customer No."; "Bill-to Name")
        moveafter("Bill-to Name"; "Bill-to Address")
        moveafter("Bill-to Address"; "Bill-to Address 2")
        moveafter("Bill-to Address 2"; "Bill-to Post Code")
        moveafter("Bill-to Post Code"; "Bill-to City")
        moveafter("Bill-to City"; "Bill-to Contact")
        moveafter("Bill-to Contact"; "Payment Terms Code")
        moveafter("Payment Terms Code"; "Due Date")
        moveafter("Due Date"; "Payment Discount %")
        moveafter("Payment Discount %"; "Pmt. Discount Date")
        moveafter("Payment Date"; "Payment Method Code")
        moveafter("Direct Debit Mandate ID"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")
        //...weight details
        addafter("Invoice Details")
        {
            group("Weight Details")
            {
                field("DC No."; rec."DC No.")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Tier Weight"; rec."Tier Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Total Birds"; rec."Total Birds")
                {
                    ApplicationArea = all;
                }
                field(Average; rec.Average)
                {
                    ApplicationArea = all;
                }
            }
        }
        //......shipping
        modify("Ship-to Name")
        {
            Visible = true;
        }
        moveafter("Ship-to Code"; "Ship-to Name")
        moveafter("Ship-to Name"; "Ship-to Address")
        moveafter("Ship-to Address"; "Ship-to Address 2")
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        moveafter("Ship-to Post Code"; "Ship-to City")
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        moveafter("Package Tracking No."; "Shipment Date")
        //>>>>foreign trade
        modify("Currency Code")
        {
            Visible = true;
        }
        modify("EU 3-Party Trade")
        {
            Visible = true;
        }
        moveafter("Currency Code"; "EU 3-Party Trade")
        moveafter("Transaction Type"; "Transaction Specification")
        //>>tax info
        movefirst("Tax Info"; Trading)
        moveafter(Trading; "TDS Certificate Receivable")
        moveafter("TDS Certificate Receivable"; "Date of Removal")
        moveafter("Date of Removal"; "Time of Removal")
        moveafter("Time of Removal"; "Mode of Transport")
        moveafter("Mode of Transport"; "Vehicle Type")
        moveafter("Vehicle Type"; "Distance (Km)")
        moveafter("Distance (Km)"; "GST Bill-to State Code")
        moveafter("GST Bill-to State Code"; "Location State Code")
        moveafter("GST Customer Type"; "GST Without Payment of Duty")
        moveafter("GST Without Payment of Duty"; "Bill Of Export No.")
        moveafter("Bill Of Export No."; "Bill Of Export Date")
        moveafter("Bill Of Export date"; "E-Commerce Customer")
        moveafter("E-Commerce Customer"; "E-Comm. Merchant Id")
        moveafter("E-Comm. Merchant Id"; "Rate Change Applicable")
        moveafter("E-Comm. Merchant Id"; "Supply Finish Date")
        moveafter("Payment Date"; "POS Out Of India")
    }
    actions
    {
        // Add changes to page actions herevi
        modify(Statistics)
        {
            Visible = true;
        }


        modify(Post)
        {
            trigger OnBeforeAction()
            var
                T_SalesLine: Record 37;
                SalesOrder: Page 42;
            begin
                CLEAR(SalesOrder);
                SalesOrder.UpdateCustomerGST(Rec."Sell-to Customer No.");
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Invoice');
                //PRU_DD 1.10


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Invoice');
                //PRU_DD 1.10

                ///Pru_GK1.1
                Rec.TESTFIELD("Vehicle No.");
                Rec.TESTFIELD("External Document No.");
                Rec.TESTFIELD("Bank Account No.");
                ///Pru_GK1.1
                IF Rec."Shortcut Dimension 1 Code" = 'CBF' THEN BEGIN
                    Rec.TESTFIELD("Gross Weight");
                END;
                ///Pru_GK1.1
                T_SalesLine.RESET;
                T_SalesLine.SETRANGE("Document Type", Rec."Document Type");
                T_SalesLine.SETRANGE("Document No.", Rec."No.");
                T_SalesLine.SETRANGE(Type, T_SalesLine.Type::Item);
                T_SalesLine.SETRANGE("Shortcut Dimension 1 Code", 'CBF');
                IF T_SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        T_SalesLine.TESTFIELD("Alternate Quantity");
                        T_SalesLine.TESTFIELD("Alternate UOM");
                    UNTIL T_SalesLine.NEXT = 0;
                END;
                ///Pru_GK1.1
            end;

        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                Customerrec: Record Customer;
            begin
                if Customerrec.get(Rec."Sell-to Customer No.") then begin
                    if ((Customerrec."Salesperson Code" <> '') OR (Customerrec."Salesperson Code 2" <> '') OR (Customerrec."Salesperson Code 3" <> '')) then
                        if Rec."Salesperson Code" = '' then
                            Error('Salesperson Code is mendotory for this order');
                END;
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                T_SalesLine: Record 37;
            begin
                ///Pru_GK1.1
                Rec.TESTFIELD("Vehicle No.");
                Rec.TESTFIELD("External Document No.");
                Rec.TESTFIELD("Gross Weight");
                ///Pru_GK1.1

                ///Pru_GK1.1
                T_SalesLine.RESET;
                T_SalesLine.SETRANGE("Document Type", Rec."Document Type");
                T_SalesLine.SETRANGE("Document No.", Rec."No.");
                T_SalesLine.SETRANGE(Type, T_SalesLine.Type::Item);
                T_SalesLine.SETRANGE("Shortcut Dimension 1 Code", 'CBF');
                IF T_SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        T_SalesLine.TESTFIELD("Alternate Quantity");
                        T_SalesLine.TESTFIELD("Alternate UOM");
                    UNTIL T_SalesLine.NEXT = 0;
                END;
                ///Pru_GK1.1
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to delete Sales Invoice');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        if ApplyBillOf = false then
            Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        //   Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        SetLocGSTRegNoEditable;
        if Rec.Status = Rec.Status::Open then
            flag := true
        else
            flag := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean

    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Sales Invoice Details');
        //PRU_DD 1.10
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        /*>>>>>>>*/ /*ORIGINAL
        {=======} MODIFIED*/
                    //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."User Permission" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        END;
        Rec.FILTERGROUP(0);
        //>>RPU_RC


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Invoice');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        /*=======*///// TARGET
        SetLocGSTRegNoEditable;

        if Rec.Status = Rec.Status::Open then
            flag := true
        else
            flag := false;
        /*<<<<<<<*/
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


        IsRateChangeEnabled := Rec."Rate Change Applicable";
    end;

    var
        myInt: Integer;
        SalesLine: Record 37;
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        Location: Record 14;
        flag: Boolean;
        SalesSetup: Record 311;

}