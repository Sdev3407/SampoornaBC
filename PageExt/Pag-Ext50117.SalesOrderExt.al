pageextension 50117 SalesOrderExt extends "Sales Order"
{


    layout
    {

        addafter("GST Customer Type")
        {
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
            field("Amt. Ship. Not Inv. (LCY) Base"; Rec."Amt. Ship. Not Inv. (LCY) Base")
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = EditableInvoiceDetailGroup;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = EditableInvoiceDetailGroup;
        }

        modify("Salesperson Code")
        {
            Editable = True;
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
        addafter("Customer Posting Group")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Salesperson Code")
        {
            field("Team Code"; Rec."Team Code")
            {
                Editable = flag;
                ApplicationArea = all;
            }
            field("Expected Dispatch Date/Time"; Rec."Expected Dispatch Date/Time")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;

                trigger OnValidate()
                var
                begin

                end;

            }
        }

        modify("Ship-to Code")
        {
            Editable = True;
            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
            begin
                UserSetupRec.Get(USERID);
                if NOT Rec."Created From Web" then begin
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
        modify("No.")
        {
            Visible = false;
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

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Customer;
                CustList: Page "Customer List";
                UserSetupRec: Record "User Setup";
            begin

                exit(LookupSellToCustomernoC(Text));
            END;

        }
        modify("Sell-to Customer Name")
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

            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Customer;
                CustList: Page "Customer List";
                UserSetupRec: Record "User Setup";
            begin

                exit(LookupSellToCustomerNameC(text));
                //END;
            end;

        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                LocRec: Record Location;
                UserSetupRec: Record "User Setup";
            begin
                CompanyInfo.Get;
                UserSetupRec.Get(USERID);
                If UserSetupRec."Global Dimension 1 Code" <> '' Then
                    If Rec."Created From Web" = false Then begin
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    end;
                Rec.SetHideValidationDialog(true);
                IF UserSetupRec."User Permission" THEN BEGIN
                    Location.RESET;
                    Location.SETRANGE(Code, Rec."Location Code");
                    IF Location.FINDFIRST THEN
                        Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                END;

                Rec.VALIDATE("Shortcut Dimension 2 Code");

            end;


            trigger OnLookup(var Text: Text): Boolean
            var
                Cust: Record Location;
                CustList: Page "Location List";
                UserSetupRec: Record "User Setup";
            begin
                CompanyInfo.Get;

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
                    UserSetupRec.Get(UserId);
                    Rec.SetHideValidationDialog(true);
                    IF UserSetupRec."User Permission" THEN BEGIN
                        Location.RESET;
                        Location.SETRANGE(Code, Rec."Location Code");
                        IF Location.FINDFIRST THEN
                            Rec.VALIDATE("Shortcut Dimension 2 Code", Location."Global Dimension 2 Code");
                    END;
                end;
                //end;

                Rec.VALIDATE("Shortcut Dimension 2 Code");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", Rec."Location Code");


            END;
        }
        addbefore(ShippingOptions)
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
        moveafter("Sell-to Customer Name"; "Ship-to Code")
        moveafter("Ship-to Code"; "Ship-to Name")

        modify("Sell-to Address")
        {
            Visible = Visible;
        }
        modify("Sell-to Address 2")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Phone No.")
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Sell-to E-Mail")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = Visible;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
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

        modify("Sell-to City")
        {
            Visible = Visible;
        }
        modify("Posting Date")
        {
            Visible = Visible;
        }
        modify("Order Date")
        {
            Visible = Editable;
        }
        modify("Document Date")
        {
            Visible = Visible;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        moveafter(Status; "Location Code")
        moveafter("Location Code"; "Invoice Type")
        addafter("Ship-to Name")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
                Visible = Visible;
                Editable = false;

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
                Visible = Visible;
                Editable = false;
            }
            field("Created From Web"; Rec."Created From Web")
            {
                ApplicationArea = all;
                Editable = True;
            }
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = All;
                Visible = StarVisible;

            }
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
                Visible = Visible;

            }
            //SIM


            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field(Freight; Rec.Freight)
            {
                ApplicationArea = All;
                Visible = Visible;
            }
            field("Terms Code"; Rec."Terms Code")
            {
                ApplicationArea = All;
                Visible = Visible;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Visible = Visible;

                trigger OnValidate()
                begin
                    //ValidateShortcutDimension(3);
                    ShortcutDimCode[3] := rec."Shortcut Dimension 3 Code";
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;

            }
            field("Freight Value"; Rec."Freight Value")
            {
                ApplicationArea = All;

            }


            field(Statistics; Rec.Statistics)
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

            field("Driver Mobile No."; Rec."Driver Mobile No.")
            {
                ApplicationArea = All;
                Visible = Visible;

            }
            field("LR/RR No"; Rec."LR/RR No.")
            {
                ApplicationArea = All;
                Visible = Visible;
            }


            field("LR/ RR Date"; Rec."LR/RR Date")
            {
                ApplicationArea = All;
                Visible = Visible;
            }


            field("Broker Code"; Rec."Broker Code")
            {
                ApplicationArea = All;

            }

            field("Entry Date"; Rec."Entry Date")
            {
                ApplicationArea = All;

            }
            field("Saels Person Name"; Rec."Saels Person Name")
            {
                ApplicationArea = All;

            }
            field("Branch Name"; Rec."Branch Name")
            {
                ApplicationArea = All;

            }
            field("Line Narration"; Rec."Line Narration")
            {
                ApplicationArea = All;

            }

        }
        addafter("Location Code")
        {

        }
        modify("Vehicle No.")
        {
            Visible = Visible;
        }
        movebefore("Driver Mobile No."; "Vehicle No.")

        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = Dimensions;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                Visible = True;


                trigger OnValidate()
                begin
                    ValidateShortcutDimension(3);
                end;
            }
        }


    }



    actions
    {
        addafter(Post)
        {
            action("ApplyEntries")
            {
                Image = ApplyEntries;
                Caption = 'Apply Entries';
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = True;
                PromotedIsBig = true;

                trigger OnAction()
                var
                Begin
                    Codeunit.Run(Codeunit::"Sales Header Apply", Rec)
                End;
            }
        }
        addafter(Reopen)
        {
            action("Approval Reopen")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    AppENtry: Record "Approval Entry";
                begin
                    if (UserId = 'RDADHWAL') OR (UserId = 'SERVICES') then begin
                        AppENtry.Reset();
                        AppENtry.SetFilter(Status, '%1|%2', AppENtry.Status::Open, AppENtry.Status::Approved);
                        AppENtry.SetRange("Document No.", rec."No.");
                        if AppENtry.FindFirst() then
                            AppENtry.DeleteAll();
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    END;

                end;
            }
        }


        addafter(Post)
        {

        }
        // Add changes to page actions here
        addafter(AssemblyOrders)
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
                    SalesLine.CALCSUMS(SalesLine.Quantity, SalesLine."Quantity Shipped");
                    IF (SalesLine.Quantity <> SalesLine."Quantity Shipped") THEN BEGIN
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
        }
        modify(Release)
        {
            trigger OnBeforeAction()

            var
                ApprovalsMgmt: Codeunit 1535;
                C50006: Codeunit 50006;
                SalesLine_Rec: Record 37;
                SalesHeader_Rec: Record 36;
                TotalAmount_G: Decimal;
                TotalGatamt_G: Decimal;
                Customer_A: Record 18;
                SalesLine: Record "Sales Line";
                TaxTransValue1: Record "Tax Transaction Value";
                SGST_perc1: Decimal;
                GSTSetup1: Record "GST Setup";
                TaxComponentName1: Text;
                CGST_perc1: Decimal;
                IGST_perc1: Decimal;
                TotalPer: Decimal;
            begin
                CompanyInfo.Get();
                SalesLine_Rec.RESET;
                SalesLine_Rec.SETRANGE("Document Type", Rec."Document Type");
                SalesLine_Rec.SETRANGE("Document No.", Rec."No.");
                //SalesLine_Rec.SETRANGE("Responsibility Center",'%1|%2','CATTLE|FEED');
                SalesLine_Rec.SETFILTER("No.", '<>%1', '');
                //SalesLine_Rec.SETFILTER("Unit Price",'<>%1',0);
                IF SalesLine_Rec.FINDSET THEN
                    REPEAT
                        IF ((SalesLine_Rec."No." = '') OR (SalesLine_Rec."Unit Price" = 0)) THEN
                            ERROR('Blank Line and Unit price should not blank or Zero if item no.entered');

                    UNTIL SalesLine_Rec.NEXT = 0;

                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
                    If (UserId <> 'SAM4500') AND (UserId <> 'SAM4248') AND (UserId <> 'STFACC') AND (UserId <> 'STF21011') AND (UserId <> 'JOBQUEUE') then
                        CheckLimit(Rec."Sell-to Customer No.");
                end;

                CLEAR(CreditLimitAmt);
                TemporaryCreditLimit.RESET;
                TemporaryCreditLimit.SETRANGE("Customer No", Rec."Sell-to Customer No.");
                TemporaryCreditLimit.SETFILTER("Starting Date", '<=%1', Rec."Order Date");
                TemporaryCreditLimit.SETFILTER("Ending Date", '%1|>=%2', 0D, Rec."Order Date");
                IF TemporaryCreditLimit.FINDLAST THEN
                    CreditLimitAmt := TemporaryCreditLimit.Amount;

                //Gk19082021
                ApproovalAmt := 0;
                SalesHeader36.RESET;
                SalesHeader36.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
                SalesHeader36.SETRANGE("Document Type", SalesHeader36."Document Type"::Order);
                IF SalesHeader36.FINDSET THEN
                    REPEAT
                        SalesLine_Rec.RESET;
                        SalesLine_Rec.SETRANGE("Document No.", SalesHeader36."No.");
                        IF SalesLine_Rec.FINDFIRST THEN
                            REPEAT
                                IF ((SalesHeader36.Status = SalesHeader36.Status::Released) OR (SalesHeader36.Status = SalesHeader36.Status::"Pending Approval")) THEN begin
                                    ApproovalAmt += SalesLine_Rec."Outstanding Amount";
                                    ApproovalAmt += SalesLine_Rec."Shipped Not Invoiced";

                                end;
                            UNTIL SalesLine_Rec.NEXT = 0;
                    UNTIL SalesHeader36.NEXT = 0;
                /////Pru_gk
                CLEAR(TotalAmount_G);
                SalesHeader_Rec.RESET;
                SalesHeader_Rec.SETFILTER(Status, '<>%1', SalesHeader_Rec.Status::"Short Closed");
                SalesHeader_Rec.SETRANGE("Document Type", SalesHeader_Rec."Document Type"::Order);
                SalesHeader_Rec.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
                SalesHeader_Rec.SETRANGE("No.", Rec."No.");
                IF SalesHeader_Rec.FINDFIRST THEN
                    REPEAT
                        SalesLine_Rec.RESET;
                        SalesLine_Rec.SETRANGE("Document No.", SalesHeader_Rec."No.");
                        IF SalesLine_Rec.FINDFIRST THEN
                            REPEAT
                                clear(CGST_perc1);
                                Clear(SGST_perc1);
                                Clear(IGST_perc1);
                                GSTSetup1.Get();//PT
                                TaxTransValue1.Reset();
                                ;
                                TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                                TaxTransValue1.SetRange("Tax Record ID", SalesLine_Rec.RecordId());
                                TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                                TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                                if TaxTransValue1.FindSet() then
                                    repeat
                                        TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                        case TaxComponentName1 of
                                            'IGST':
                                                begin
                                                    IGST_perc1 := TaxTransValue1.Percent;

                                                end;
                                            'CGST':
                                                begin
                                                    CGST_perc1 := TaxTransValue1.Percent;
                                                end;
                                            'SGST':
                                                begin
                                                    CGST_perc1 := TaxTransValue1.Percent;
                                                end;
                                        end;
                                    until TaxTransValue1.Next() = 0;
                                TotalPer := CGST_perc1 + IGST_perc1 + SGST_perc1;
                                TotalGatamt_G := (((SalesLine_Rec."Outstanding Quantity" * SalesLine_Rec."Unit Price") - SalesLine_Rec."Line Discount Amount") * TotalPer / 100);
                                TotalAmount_G += (((SalesLine_Rec."Outstanding Quantity" * SalesLine_Rec."Unit Price") - SalesLine_Rec."Line Discount Amount") + TotalGatamt_G);
                            ////MESSAGE('%1',TotalAmount_G);
                            UNTIL SalesLine_Rec.NEXT = 0;
                    UNTIL SalesHeader_Rec.NEXT = 0;
                Customer_A.GET(Rec."Sell-to Customer No.");
                Customer_A.CALCFIELDS("Balance (LCY)");
                IF Customer_A."Credit Limit (LCY)" <> 0 THEN BEGIN
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
                        If (UserId <> 'SAM4500') AND (UserId <> 'SAM4248') AND (UserId <> 'STFACC') AND (UserId <> 'STF21011') AND (UserId <> 'JOBQUEUE') then
                            IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" < (TotalAmount_G + ApproovalAmt) THEN
                                ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', Rec."No." + '.');
                    end else
                        IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" < (TotalAmount_G + ApproovalAmt) THEN
                            ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', Rec."No." + '.');
                END;
                IF Customer_A."Credit Limit (LCY)" <> 0 THEN BEGIN
                    Customer_A.CALCFIELDS("Balance (LCY)");
                    if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
                        If (UserId <> 'SAM4500') AND (UserId <> 'SAM4248') AND (UserId <> 'STFACC') AND (UserId <> 'STF21011') AND (UserId <> 'JOBQUEUE') then
                            IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" <= 0 THEN
                                ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', "No." + '.');
                    end else
                        IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" <= 0 THEN
                            ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', "No." + '.');
                END;
                //////Pru_gk
                //C50006.CheckCreditLimitShip(Rec);
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                    Rec.TESTFIELD("Shortcut Dimension 3 Code");//PRU-VG

            end;

        }

        modify(SendApprovalRequest)
        {

            trigger OnBeforeAction()

            var
                ApprovalsMgmt: Codeunit 1535;
                C50006: Codeunit 50006;
                SalesLine_Rec: Record 37;
                SalesHeader_Rec: Record 36;
                TotalAmount_G: Decimal;
                TotalGatamt_G: Decimal;
                Customer_A: Record 18;
                SalesLine: Record "Sales Line";
                TaxTransValue1: Record "Tax Transaction Value";
                SGST_perc1: Decimal;
                GSTSetup1: Record "GST Setup";
                TaxComponentName1: Text;
                CGST_perc1: Decimal;
                IGST_perc1: Decimal;
                TotalPer: Decimal;
                Customerrec: Record Customer;
            begin
                CompanyInfo.Get;
                SalesLine_Rec.RESET;
                SalesLine_Rec.SETRANGE("Document Type", Rec."Document Type");
                SalesLine_Rec.SETRANGE("Document No.", Rec."No.");
                //SalesLine_Rec.SETRANGE("Responsibility Center",'%1|%2','CATTLE|FEED');
                SalesLine_Rec.SETFILTER("No.", '<>%1', '');
                //SalesLine_Rec.SETFILTER("Unit Price",'<>%1',0);
                IF SalesLine_Rec.FINDSET THEN
                    REPEAT
                        IF ((SalesLine_Rec."No." = '') OR (SalesLine_Rec."Unit Price" = 0)) THEN
                            ERROR('Blank Line and Unit price should not blank or Zero if item no.entered');
                        IF Rec."GST Bill-to State Code" <> Rec."Location State Code" THEN BEGIN
                            SalesLine_Rec.Validate("GST Jurisdiction Type", SalesLine_Rec."GST Jurisdiction Type"::Interstate);
                        END ELSE
                            SalesLine_Rec.Validate("GST Jurisdiction Type", SalesLine_Rec."GST Jurisdiction Type"::Intrastate);

                    UNTIL SalesLine_Rec.NEXT = 0;


                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                    CheckLimit(Rec."Sell-to Customer No.");

                CLEAR(CreditLimitAmt);
                TemporaryCreditLimit.RESET;
                TemporaryCreditLimit.SETRANGE("Customer No", Rec."Sell-to Customer No.");
                TemporaryCreditLimit.SETFILTER("Starting Date", '<=%1', Rec."Order Date");
                TemporaryCreditLimit.SETFILTER("Ending Date", '%1|>=%2', 0D, Rec."Order Date");
                IF TemporaryCreditLimit.FINDLAST THEN
                    CreditLimitAmt := TemporaryCreditLimit.Amount;

                //Gk19082021
                ApproovalAmt := 0;
                SalesHeader36.RESET;
                SalesHeader36.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
                SalesHeader36.SETRANGE("Document Type", SalesHeader36."Document Type"::Order);
                IF SalesHeader36.FINDSET THEN
                    REPEAT
                        SalesLine_Rec.RESET;
                        SalesLine_Rec.SETRANGE("Document No.", SalesHeader36."No.");
                        IF SalesLine_Rec.FINDFIRST THEN
                            REPEAT
                                IF ((SalesHeader36.Status = SalesHeader36.Status::Released) OR (SalesHeader36.Status = SalesHeader36.Status::"Pending Approval")) THEN Begin
                                    ApproovalAmt += SalesLine_Rec."Outstanding Amount";
                                    ApproovalAmt += SalesLine_Rec."Shipped Not Invoiced";
                                End;
                            UNTIL SalesLine_Rec.NEXT = 0;
                    UNTIL SalesHeader36.NEXT = 0;
                /////Pru_gk
                CLEAR(TotalAmount_G);
                SalesHeader_Rec.RESET;
                SalesHeader_Rec.SETFILTER(Status, '<>%1', SalesHeader_Rec.Status::"Short Closed");
                SalesHeader_Rec.SETRANGE("Document Type", SalesHeader_Rec."Document Type"::Order);
                SalesHeader_Rec.SETRANGE("Sell-to Customer No.", Rec."Sell-to Customer No.");
                SalesHeader_Rec.SETRANGE("No.", Rec."No.");
                IF SalesHeader_Rec.FINDFIRST THEN
                    REPEAT
                        SalesLine_Rec.RESET;
                        SalesLine_Rec.SETRANGE("Document No.", SalesHeader_Rec."No.");
                        IF SalesLine_Rec.FINDFIRST THEN
                            REPEAT
                                clear(CGST_perc1);
                                Clear(SGST_perc1);
                                Clear(IGST_perc1);
                                GSTSetup1.Get();//PT
                                TaxTransValue1.Reset();
                                ;
                                TaxTransValue1.SetRange("Tax Type", GSTSetup1."GST Tax Type");
                                TaxTransValue1.SetRange("Tax Record ID", SalesLine_Rec.RecordId());
                                TaxTransValue1.SetRange("Value Type", TaxTransValue1."Value Type"::COMPONENT);
                                TaxTransValue1.SetFilter(Percent, '<>%1', 0);
                                if TaxTransValue1.FindSet() then
                                    repeat
                                        TaxComponentName1 := TaxTransValue1.GetAttributeColumName();
                                        case TaxComponentName1 of
                                            'IGST':
                                                begin
                                                    IGST_perc1 := TaxTransValue1.Percent;

                                                end;
                                            'CGST':
                                                begin
                                                    CGST_perc1 := TaxTransValue1.Percent;
                                                end;
                                            'SGST':
                                                begin
                                                    CGST_perc1 := TaxTransValue1.Percent;
                                                end;
                                        end;
                                    until TaxTransValue1.Next() = 0;
                                TotalPer := CGST_perc1 + IGST_perc1 + SGST_perc1;
                                TotalGatamt_G := (((SalesLine_Rec."Outstanding Quantity" * SalesLine_Rec."Unit Price") - SalesLine_Rec."Line Discount Amount") * TotalPer / 100);
                                TotalAmount_G += (((SalesLine_Rec."Outstanding Quantity" * SalesLine_Rec."Unit Price") - SalesLine_Rec."Line Discount Amount") + TotalGatamt_G);
                            ////MESSAGE('%1',TotalAmount_G);
                            UNTIL SalesLine_Rec.NEXT = 0;
                    UNTIL SalesHeader_Rec.NEXT = 0;
                Customer_A.GET(Rec."Sell-to Customer No.");
                Customer_A.CALCFIELDS("Balance (LCY)");
                IF Customer_A."Credit Limit (LCY)" <> 0 THEN BEGIN
                    IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" < (TotalAmount_G + ApproovalAmt) THEN
                        ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', Rec."No." + '.');
                END;
                IF Customer_A."Credit Limit (LCY)" <> 0 THEN BEGIN
                    Customer_A.CALCFIELDS("Balance (LCY)");
                    IF (Customer_A."Credit Limit (LCY)" + CreditLimitAmt) - Customer_A."Balance (LCY)" <= 0 THEN
                        ERROR('Remaining Credit Limit is insufficient to send the Approval for the Sale Order No. %1', "No." + '.');
                END;
                //////Pru_gk
                //C50006.CheckCreditLimitShip(Rec);
                Rec.TESTFIELD("Shortcut Dimension 3 Code");//PRU-VG
                if Customerrec.get(Rec."Sell-to Customer No.") then begin
                    if ((Customerrec."Salesperson Code" <> '') OR (Customerrec."Salesperson Code 2" <> '') OR (Customerrec."Salesperson Code 3" <> '')) then
                        if Rec."Salesperson Code" = '' then
                            Error('Salesperson Code is mendotory for this order');
                END;
            end;
        }


        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GeneralLedgerSetup: Record 98;
                SHLoc: Record 36;
                T_SalesLine: Record 37;
                SalesHeader: Record 36;

            begin
                CompanyInfo.Get;

                Clear(RemQty);

                SL.RESET;
                SL.SETRANGE("Document No.", Rec."No.");
                SL.SETRANGE(Type, SL.Type::Item);
                SL.SETFILTER("Qty. to Ship", '<>%1', 0);
                IF SL.FINDSET THEN
                    REPEAT
                        CLEAR(RemQty);
                        ILE.RESET;
                        ILE.SETRANGE("Item No.", SL."No.");
                        ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                        ILE.SETRANGE("Location Code", SL."Location Code");
                        IF ILE.FINDSET THEN
                            REPEAT
                                RemQty += ILE."Remaining Quantity";
                            UNTIL ILE.NEXT = 0;
                        // MESSAGE('RemQty %1',RemQty);
                        //MESSAGE('sl qty %1',SL.Quantity);
                        IF RemQty < SL."Qty. to Ship (Base)" THEN
                            ERROR('Stock is not available Of Item No %1 Of Location %2', SL."No.", SL."Location Code");
                    UNTIL SL.NEXT = 0;

                //PruRaj_RQ_0.01
                //TESTFIELD(Statistics,TRUE); ////Pru_gk
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Order');


                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Order');

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
                ///Pru_GK1.1
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    IF (Rec."Shortcut Dimension 1 Code" = 'CBF') OR (Rec."Shortcut Dimension 1 Code" = 'FEED') THEN BEGIN
                        Rec.TESTFIELD("Gross Weight");
                    END;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    IF Rec."Shortcut Dimension 1 Code" = 'FEED' THEN
                        Rec.TESTFIELD("Driver Mobile No.");
                ///Pru_GK1.1
                Rec.TESTFIELD("Vehicle No.");
                Rec.TESTFIELD("External Document No.");
                //Rec.TESTFIELD("Bank Account No.");

                SL.RESET;
                SL.SETRANGE("Document Type", Rec."Document Type");
                SL.SETRANGE("Document No.", Rec."No.");
                SL.SETRANGE("Item Type", SL."Item Type"::Bird);
                IF SL.FINDFIRST THEN
                    SL.TESTFIELD("Flock No.");
                //PruRaj 211019
                /*  GCStatementRec.RESET;
                  GCStatementRec.SETRANGE("Flock No.",SL."Flock No.");
                  GCStatementRec.SETRANGE(Posted,TRUE);
                  IF GCStatementRec.FINDFIRST THEN BEGIN
                    ERROR('In Line No. %1 GC Statement is Already Posted',SL."Line No.");
                  //PruRaj 211019
                  END ELSE*/
                //Rec.OpenSalesOrderStatistics;

                if rec.Status <> Rec.Status::Released then
                    Error('Order Must be Release');

                UpdateCustomerGST(Rec."Sell-to Customer No.");// Suman
                Rec.UpdateSalesPrice(Rec."No.", Rec."Customer Price Group");

            end;

        }

        modify(PreviewPosting)
        {
            trigger OnBeforeAction()
            var
                T_SalesLine: Record "Sales Line";
            begin
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
                ///Pru_GK1.1
                Rec.TESTFIELD("Vehicle No.");
                Rec.TESTFIELD("External Document No.");
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                    Rec.TESTFIELD("Gross Weight");
                ///Pru_GK1.1
          //      Rec.UpdateSalesPrice(Rec."No.", Rec."Customer Price Group");
            end;

        }
        addafter("Post and Print Prepmt. Cr. Mem&o")
        {
            action("Change Log ")
            {
                ApplicationArea = all;
                Image = Log;
                RunObject = Page 595;
                RunPageLink = "Primary Key Field 2 Value" = FIELD("No."), "Table No." = filter(Database::"Sales Header");
            }

        }
    }




    trigger OnAfterGetRecord()
    var
        AppENtry: Record "Approval Entry";
    begin
        ShowShortcutDimCode(ShortcutDimCode);

        if Rec.Status = Rec.Status::Open then
            flag := true
        else
            flag := false;

        EditableInvoiceDetailGroupF()
    end;


    trigger OnDeleteRecord(): Boolean
    begin
        // UserSetup.RESET;
        //UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        //IF UserSetup.FINDFIRST THEN
        If UserId <> 'JOBQUEUE' Then
            ERROR('You do not have Permission to Delete Sales Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to enter Sales Order Details');
        //PRU_DD 1.10
        Rec.Validate("Shipment Method Code", 'ROAD');
        Rec.Validate("Vehicle Type", rec."Vehicle Type"::Regular);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to change Sales Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create New Sales Order');


        //PRU_DD 1.10
    end;


    trigger OnOpenPage()
    begin
        CompanyInfo.Get;
        Rec."Invoice Type" := Rec."Invoice Type"::"Bill of Supply";
        if (UserId <> 'JOBQUEUE') and (UserId <> 'SAM4496') and (UserId <> 'SAM1586') and (UserId <> 'SAM4834') Then
            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then Begin
                UserSetup.GET(USERID);
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                IF NOT UserSetup."User Permission" THEN BEGIN
                    Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
                    IF NOT UserSetup."HO Users" THEN
                        Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
                END;
                Rec.FILTERGROUP(0);
            end;
        SFPLVisible := false;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            SFPLVisible := True;
        StarVisible := False;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
            StarVisible := True;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE(Department, UserSetup.Department::Accounts);
        UserSetup.SETRANGE("HO Users", TRUE);
        IF UserSetup.FINDFIRST THEN
            VisibleStatics := TRUE
        ELSE
            VisibleStatics := FALSE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;
        SetLocGSTRegNoEditable;
        EditableInvoiceDetailGroupF();
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


    procedure UpdateCustomerGST(CustNo: Code[20])
    var
        UpdateGSTDetailsFromPortal: Codeunit 50023;
        Status: Text;
        Lastdate: Date;
        GSTName: Text;
        GSTAddr: Text;
        GStAddr2: Text;
        GSTStCode: Text;
        GStpCode: Code[20];
        Customer: Record 18;
    begin
        // SKS <<
        Customer.RESET;
        IF Customer.GET(CustNo) THEN BEGIN
            IF Customer."GST Customer Type" = Customer."GST Customer Type"::Registered THEN BEGIN
                UpdateGSTDetailsFromPortal.UpdateCustomer(Customer."No.", Customer."GST Registration No.", Status, Lastdate, GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, FALSE);
                IF Customer."Last Updated Date" <> TODAY THEN BEGIN
                    Customer."GST Status" := Status;
                    Customer."Last Updated Date" := Lastdate;
                    Customer."GST Name" := GSTName;
                    Customer."GST Address" := GSTAddr;
                    Customer."GST Address 2" := GStAddr2;
                    Customer."GST State Code" := GSTStCode;
                    Customer."GST Post Code" := GStpCode;
                    Customer.MODIFY(false);
                    IF Status <> '' THEN BEGIN
                        IF Status <> 'Active' THEN
                            MESSAGE(GSTMsg001, Status);
                    END;
                END ELSE
                    IF Status <> 'Active' THEN
                        MESSAGE(GSTMsg001, Status);
            END;
        END;
        //SKS >>
    end;

    var

        ShortcutDimCode: array[8] of Code[20];
        DimMgt: Codeunit DimensionManagement;
        myInt: Integer;
        UserSetup: Record 91;
        RecCustomer: Record 18;
        RecLocation: Record 14;
        ILE: Record 32;
        SL: Record 37;
        TotalRemainingQty: Decimal;
        SLQty: Decimal;
        TotalRemainingQty1: Decimal;
        TextPartial: Label 'Document Short Closed, If require create new order for remaining Qty.  ';
        GCStatementRec: Record "GC Statement";
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        Visible: Boolean;
        RemQty: Decimal;
        Editable: Boolean;
        CheckApprovalEntry: Record 454;
        DeleteApprovalEntry: Record 454;
        totalQty: Decimal;
        ApprovalEntry: Record 454;
        ApproovalAmt: Decimal;
        SalesHeader36: Record 36;
        GSTMsg001: Label 'Customer Current Gst Status is %1.';
        VisibleStatics: Boolean;
        TemporaryCreditLimit: Record "Temporary Credit Limit";
        CreditLimitAmt: Decimal;
        Location: Record 14;
        flag: Boolean;
        CompanyInfo: Record "Company Information";
        SFPLVisible: Boolean;
        StarVisible: Boolean;
        Cust: record Customer;
        Paymentterm: record "Payment Terms";
        EditableInvoiceDetailGroup: Boolean;


    procedure CheckLimit(CustCode: Code[20])
    var
        Custledgerentry: record "Cust. Ledger Entry";
        OverDuefromCreditdays: Decimal;
    begin
        OverDuefromCreditdays := 0;
        Cust.Get(CustCode);

        if (Cust."Activate Credit Days Limit") then begin
            Paymentterm.get(Cust."Payment Terms Code");
            Paymentterm.TestField("Due Date Calculation");
            Custledgerentry.Reset();
            Custledgerentry.SetCurrentKey("Customer No.", "Due Date");
            Custledgerentry.SetRange(Custledgerentry."Customer No.", Cust."No.");
            Custledgerentry.SetRange(Open, true);
            Custledgerentry.SetFilter("Document Type", '%1|%2', Custledgerentry."Document Type"::"Credit Memo", Custledgerentry."Document Type"::Invoice);
            Custledgerentry.CalcFields("Remaining Amount");
            Custledgerentry.SetFilter("Remaining Amount", '<>%1', 0);
            Custledgerentry.Setfilter("Posting Date", '<=%1', CalcDate('-' + Format(PaymentTerm."Due Date Calculation"), WorkDate()));
            if Custledgerentry.FindSet() then
                repeat
                    Custledgerentry.CalcFields("Remaining Amount");
                    OverDuefromCreditdays += Custledgerentry."Remaining Amount";
                until Custledgerentry.Next() = 0;


            if OverDuefromCreditdays <> 0 then
                Error('Order Could not be released due to the Rs. %1 beyond the credit days', OverDuefromCreditdays);
        end;
    end;

    procedure EditableInvoiceDetailGroupF()
    begin
        EditableInvoiceDetailGroup := True;
        If rec.Status <> Rec.Status::Open then
            EditableInvoiceDetailGroup := false;
    end;

    procedure LookupSellToCustomerNameC(var CustomerName: Text): Boolean
    var
        Customer: Record Customer;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchCustomerName: Text;
    begin
        SearchCustomerName := CustomerName;
        Customer.SetFilter(Blocked, '<>%1', Enum::"Customer Blocked"::Ship);
        if "Sell-to Customer No." <> '' then
            Customer.Get("Sell-to Customer No.");

        if Customer.LookupCustomer(Customer) then begin
            if Rec."Sell-to Customer Name" = Customer.Name then
                CustomerName := SearchCustomerName
            else
                CustomerName := Customer.Name;
            RecVariant := Customer;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;

    procedure LookupSellToCustomernoC(var CustomerName: Text): Boolean
    var
        Customer: Record Customer;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchCustomerName: Text;
    begin
        SearchCustomerName := CustomerName;
        Customer.SetFilter(Blocked, '<>%1', Enum::"Customer Blocked"::Ship);
        if "Sell-to Customer No." <> '' then
            Customer.Get("Sell-to Customer No.");

        if Customer.LookupCustomer(Customer) then begin
            if Rec."Sell-to Customer No." = Customer."No." then
                CustomerName := SearchCustomerName
            else
                CustomerName := Customer."No.";
            RecVariant := Customer;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;

    local procedure ValidateShortcutDimension(DimIndex: Integer)
    var
        AssembleToOrderLink: Record "Assemble-to-Order Link";
    begin
        Rec.ValidateShortcutDimCode(DimIndex, ShortcutDimCode[DimIndex]);
        //AssembleToOrderLink.UpdateAsmDimFromSalesLine(Rec);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

}