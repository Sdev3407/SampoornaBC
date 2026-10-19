pageextension 50110 SalesCreditMemoExt extends "Sales Credit Memo"
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
        modify("No.")
        {
            Visible = false;
        }

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
        //         END;
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
        //         //       Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        //     end;

        // }
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
                //     Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
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
            //     END;
            //     CurrPage.Update();
            //     UserSetupRec.Get(UserId);
            //     Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //     //    Clear(Rec."Shortcut Dimension 2 Code");
            //     Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //     IF NOT UserSetupRec."User Permission" THEN BEGIN
            //         Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            //         Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            //         IF NOT UserSetupRec."HO Users" THEN BEGIN
            //             Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
            //             //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
            //             // Message(UserSetupRec."Shortcut Dimension 3 Code");
            //         END;
            //     end;
            //     //   Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
            // end;

        }

        /* addafter("No.")
         {
             field("P.A.N. No."; Rec."P.A.N. No.")
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
             field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
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
            
             field(Statistics; Rec.Statistics)
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

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                LocRec: Record Location;
                UserSetupRec: Record "User Setup";
            begin
                Companyinfo.get;
                if UserId <> 'JOBQUEUE' Then begin
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
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
                        Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Location;
                CustList: Page "Location List";
                UserSetupRec: Record "User Setup";
                Location: Record Location;
            begin
                Companyinfo.Get;
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
                    if UserId <> 'JOBQUEUE' Then begin
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
                        If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
                            Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");
                    end;
                end;
            END;
        }
        // moveafter("Sell-to Contact No."; "Sell-to Customer Name")
        // moveafter("Sell-to Customer Name"; "Sell-to")
        moveafter("Salesperson Code"; "Location Code")
        moveafter(Status; "Invoice Type")
        //moveafter("Invoice Type";)
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("Due Date")
        {
            Visible = true;
        }
        modify("Payment Discount %")
        {
            Visible = true;
        }
        modify("Pmt. Discount Date")
        {
            Visible = true;
        }
        modify("Payment Method Code")
        {
            Visible = true;
        }
        modify("Prices Including VAT")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }

        addafter("Invoice Type")
        {


            field("Driver Mobile No."; rec."Driver Mobile No.")
            {
                ApplicationArea = all;

            }
            field("Vehicle No."; rec."Vehicle No.")
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
            field("Line Narration"; rec."Line Narration")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
        ////credit memo details
        modify("Credit Memo Details")
        {
            Visible = false;
        }
        ///>>invoice
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
        addbefore("Bill-to Name")
        {
            field("Bill-to Customer No."; rec."Bill-to Customer No.")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Bill-to Customer No."; "Bill-to Contact No.")
        moveafter("Bill-to Address 2"; "Bill-to Post Code")
        moveafter("Bill-to City"; "Bill-to Contact")
        moveafter("Bill-to Contact"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        // moveafter("Payment Terms Code"; "Due Date")
        //moveafter("Due Date"; "Payment Discount %")
        //moveafter("Payment Discount %"; "Payment Method Code")
        moveafter("Payment Method Code"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "VAT Bus. Posting Group")

        //>>>Shipping
        addbefore("Foreign Trade")
        {
            group("Shipping")
            {
            }
        }
        movefirst(Shipping; "Ship-to Code")
        moveafter("Ship-to Code"; "Shipment Date")
        //ship-to fields missing
        ///>>weight details
        addbefore("Shipping")
        {
            group("Weight Details")
            {
            }
        }
        addfirst("Weight Details")
        {
            field("DC No."; Rec."DC No.")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Tier Weight"; Rec."Tier Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("No. of Birds"; Rec."No. of Birds")
            {
                ApplicationArea = All;
            }
            field(Average; Rec.Average)
            {
                ApplicationArea = All;
            }
        }
        ///>>Foreign trade
        modify("Currency Code")
        {
            Visible = true;
        }
        movefirst("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "EU 3-Party Trade")
        moveafter("EU 3-Party Trade"; "Transaction Type")
        ///vehicle type missing
        //>>>Application
        addbefore("Tax Info")
        {
            group("Application")
            {
            }
        }
        movefirst(Application; "Applies-to Doc. Type")
        moveafter("Applies-to Doc. Type"; "Applies-to Doc. No.")
        moveafter("Applies-to Doc. No."; "Applies-to ID")

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


    }

    actions
    {

        // Add changes to page actions here
        addlast("&Credit Memo")
        {
            action("Short Close")
            {
                ApplicationArea = all;
                Image = Close;

                trigger OnAction()
                var
                    SalesLine: Record 37;
                    T37_Loc: Record 37;
                begin
                    //PRU-Vg 2.0
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    SalesLine.CALCSUMS(SalesLine.Quantity, SalesLine."Return Qty. Received");
                    IF (SalesLine.Quantity <> SalesLine."Return Qty. Received") THEN BEGIN
                        Status := Status::"Short Closed";
                        MODIFY;
                        T37_Loc.RESET;
                        T37_Loc.SETRANGE("Document No.", Rec."No.");
                        IF T37_Loc.FINDFIRST THEN
                            REPEAT
                                T37_Loc."Short Closed" := TRUE;
                                T37_Loc.MODIFY;
                            UNTIL T37_Loc.NEXT = 0;
                        MESSAGE(TextPartial);
                    END;
                    //PRU-Vg 2.0
                end;
            }
            action("Attached Gate Entry Line")
            {
                ApplicationArea = all;
                Image = Line;

                RunObject = page "Gate Entry Attachment List";
                RunPageLink = "Entry Type" = const(Inward), "Sales Credit Memo No." = field("No.");
            }
            action("Get Gate Entry Lines")
            {
                ApplicationArea = all;
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
            var
                T_SalesLine: Record 37;
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Credit Memo');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Credit Memo');
                //PRU_DD 1.10

                ///Pru_GK1.1
                Rec.TESTFIELD("Vehicle No.");
                Rec.TESTFIELD("External Document No.");
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
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Credit Memo');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post Sales Credit Memo');
                //PRU_DD 1.10

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
        modify("Preview Posting")
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
                /// 
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete the Sales Credit Memo');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    var
        PSI: Record "Sales Invoice Header";
    begin
        if ApplyBillOf = false then
            Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        SetLocGSTRegNoEditable;
        //   Rec."Invoice Type" := rec."Invoice Type"::"Bill of Supply";
        if Rec.Status = Rec.Status::Open then
            flag := true
        else
            flag := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    trigger OnModifyRecord(): Boolean
    begin
        //     Rec."Invoice Type" := rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change the Sales Credit Memo Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Invoice Type" := rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        PSI: Record "Sales Invoice Header";
    begin
        Rec."Invoice Type" := rec."Invoice Type"::"Bill of Supply";

        if PSI.get(Rec."Applies-to Doc. No.") then
            Rec."Invoice Type" := PSI."Invoice Type";
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
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Credit Memo');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        if Rec.Status = Rec.Status::Open then
            flag := true
        else
            flag := false;
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
        DocumentTotals.SalesRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SetLocGSTRegNoEditable()
    begin
        IsRateChangeEnabled := Rec."Rate Change Applicable";
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        TextPartial: Label 'Document Short Closed, If require create new order for remaining Qty.  ';
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        Location: Record 14;
        flag: Boolean;
        Companyinfo: Record "Company Information";
}
