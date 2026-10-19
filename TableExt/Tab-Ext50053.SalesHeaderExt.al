
tableextension 50053 SalesHeaderExt extends "Sales Header"
{
    fields
    {


        modify("Sell-to Customer No.")
        {
            TableRelation = Customer."No." where(Blocked = filter(' '));

            trigger OnBeforeValidate()
            var
                I: Integer;
            begin
                I := 0;
            end;

            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                RecCustomer: Record Customer;
                RecLocation: Record Location;
                UserSetupRec: Record "User Setup";
                CustRec: Record Customer;
                TeamMaster: Record "Team Salesperson";
            begin
                CompanyInfo.Get;
                UserSetup.GET(USERID);
                if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                    VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU-VG

                //+RK-PRU
                RecCustomer.GET("Sell-to Customer No.");
                "P.A.N. No." := RecCustomer."P.A.N. No.";
                Freight := RecCustomer."Freight Term";
                IF RecCustomer."Farmer Location" <> '' THEN begin
                    RecLocation.GET(RecCustomer."Farmer Location");
                    "Farmer Grade" := RecLocation.Grade;
                end;
                Validate("Invoice Type", "Invoice Type"::"Bill of Supply");// Suman
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                    "Bank Account No." := 'BANK-006';
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then
                    "Bank Account No." := 'HDFC BANK CC';
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Vetadd] Then
                    "Bank Account No." := 'HDFC';


                //-RK-PRU
                //PRU_NEELESH
                //   COMMIT;
                // IF "Location Code" <> '' THEN BEGIN
                //   Rec.VALIDATE("Location Code");
                //END ELSE BEGIN
                // Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");

                // END;
                //PRU_NEELESH
                if CustRec.get("Sell-to Customer No.") then begin
                    if CustRec."Salesperson Code" = UserId then begin
                        "Salesperson Code" := CustRec."Salesperson Code";
                        TeamMaster.Reset();
                        TeamMaster.SetRange("Salesperson Code", CustRec."Salesperson Code");
                        if TeamMaster.FindFirst() then
                            "Team Code" := TeamMaster."Team Code";
                    end
                    else
                        if CustRec."Salesperson Code 2" = UserId then begin
                            "Salesperson Code" := CustRec."Salesperson Code 2";
                            TeamMaster.Reset();
                            TeamMaster.SetRange("Salesperson Code", CustRec."Salesperson Code 2");
                            if TeamMaster.FindFirst() then
                                "Team Code" := TeamMaster."Team Code";
                        end
                        else
                            if CustRec."Salesperson Code 3" = UserId then begin
                                "Salesperson Code" := CustRec."Salesperson Code 3";
                                TeamMaster.Reset();
                                TeamMaster.SetRange("Salesperson Code", CustRec."Salesperson Code 3");
                                if TeamMaster.FindFirst() then
                                    "Team Code" := TeamMaster."Team Code";
                            end else begin
                                "Salesperson Code" := CustRec."Salesperson Code";
                                TeamMaster.Reset();
                                TeamMaster.SetRange("Salesperson Code", CustRec."Salesperson Code");
                                if TeamMaster.FindFirst() then
                                    "Team Code" := TeamMaster."Team Code";

                                //   Message('check');
                            end;
                END;

            END;

        }

        modify("Sell-to Customer Name")
        {
            TableRelation = Customer."No." where(Blocked = filter(' '));
            trigger OnAfterValidate()
            begin
                "Invoice Type" := "Invoice Type"::"Bill of Supply";
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                SALesPer: Record 13;
            begin
                if SALesPer.Get("Salesperson Code") then
                    if SALesPer.Blocked = true then
                        Error('You can not select this sales person because sales person block');
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            var
                LocRec: Record Location;
            begin
                CompanyInfo.Get;
                If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then Begin
                    if rec."Shortcut Dimension 2 Code" <> '' then begin
                        if LocRec.Get(rec."Location Code") then begin
                            if LocRec."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" then
                                Error('Dimension is not same in this location code %1', LocRec."Global Dimension 2 Code");
                        end;
                    end;
                END;
            end;

            trigger OnAfterValidate()
            var
                UserSetupRec: Record "User Setup";
                T_14: Record Location;

                CheckRepeation: Boolean;
            begin
                IF ("Location Code" <> xRec."Location Code") AND
                   (xRec."Sell-to Customer No." = "Sell-to Customer No.")
                THEN
                    MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));
                //PRU_NEELESH 18022020
                IF T_14.GET("Location Code") THEN BEGIN
                    IF T_14."Agreement End Date" <> 0D THEN
                        IF ((T_14."Agreement End Date" - TODAY) > -1) AND ((T_14."Agreement End Date" - TODAY) < 61) THEN
                            IF CheckRepeation = FALSE THEN BEGIN  // PRU_KH_Exp1.2_26022020
                                MESSAGE('Agreement End Date will be expired on %1 of Farm %2', T_14."Agreement End Date", T_14.Code);
                                CheckRepeation := TRUE;  // PRU_KH_Exp1.2_26022020
                            END;
                END;


                if Rec."No." <> '' Then
                    If (UserId = 'JOBQUEUE') and (Rec."Created From Web" = True) then
                        If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Sampoorna Then
                            If Rec."Location Code" <> '' Then begin
                                Rec.Validate("Shortcut Dimension 1 Code", T_14."Global Dimension 1 Code");
                                Rec.Validate("Shortcut Dimension 2 Code", T_14."Global Dimension 2 Code");
                                Rec.Validate("Shortcut Dimension 3 Code", T_14.Code);
                            end;
                //PRU_NEELESH 18022020

            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
            begin
                IF xRec."Document Type" = xRec."Document Type"::"Return Order" THEN BEGIN
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have Permission to Create Sales Retun Order');
                END;
                //PRU_DD 1.10
            end;

            trigger OnAfterValidate()
            begin
            end;
        }
        modify("Order Date")
        {
            trigger OnBeforeValidate()
            begin
                IF "Order Date" > WORKDATE THEN
                    ERROR('Order date should not grater then workdate');
            end;
        }
        field(50000; "P.A.N. No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "No. of Birds"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Farmer Grade"; Option)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(50004; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE(Blocked = FILTER(false));
        }
        field(50005; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE(Transporter = Const(true), Blocked = Filter(" "));
            trigger OnValidate()
            var
                Transporter: Record Vendor;
            begin
                if "Transporter Code" <> '' then begin
                    If Transporter.get("Transporter Code") then
                        "Transporter Name" := Transporter.Name;
                end;
            end;
        }
        field(50006; Freight; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOR,EX';
            OptionMembers = " ","FOR",EX;
        }
        field(50007; "Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Terms and Conditions1";
        }
        field(50008; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50009; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Against Original Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Against Original Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "DC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Tier Weight"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Net Weight" := "Gross Weight" - "Tier Weight";
                CALCFIELDS("Total Birds");
                IF "Total Birds" <> 0 THEN
                    Average := "Net Weight" / "Total Birds"
            end;

        }
        field(50015; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Total Birds"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Alternate Quantity" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       "Item Type" = FILTER('Bird')));
            FieldClass = FlowField;
        }

        field(50017; "Average"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; Statistics; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "Amt. to Customer"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                                     "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }

        field(50020; "Shipment Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Shipment Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                    "Document No." = FIELD("No.")));
            Description = 'PRU-VG';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50021; "Driver Mobile No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            Numeric = true;
        }
        field(50022; "Broker Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Category Code';
            Description = 'Pru171220#P0272';
            //               TableRelation = "Item Category".Code WHERE("Def. Inventory Posting Group" = CONST("FG"));
        }
        field(50026; "Product Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Product Group Code';

            Description = 'Pru171220#P0272';
            //    TableRelation ="Product Group".Code
            //   "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(50027; "Entry Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50028; "Saels Person Name"; Code[50])
        {

            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Salesperson Code")));
            FieldClass = FlowField;
        }
        field(50029; "Branch Name"; Code[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = CONST('BRANCH'),
                                                               Code = FIELD("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }

        field(50030; "Line Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Team Code"; Code[20])
        {
            Caption = 'Team Code';
            DataClassification = ToBeClassified;
        }
        field(50032; "Expected Dispatch Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            // Editable = false;

            trigger OnLookup()
            var
                SMSBody: Text[1024];
                CustomerPhone: Text;
                SalesPersonPhone: Text;
                SMSfunctions: Codeunit 50018;
                salesperson: Record "Salesperson/Purchaser";
                SalesandRec: Record "Sales & Receivables Setup";
                SMSDetail: Codeunit "SMS Details";
            begin
                Validate("Expected Dispatch Date/Time", LookupDateTime("Expected Dispatch Date/Time", "Expected Dispatch Date/Time", CurrentDateTime));
                if xRec."Expected Dispatch Date/Time" = 0DT then begin
                    SalesandRec.Get;
                    salesperson.Get("Salesperson Code");
                    SMSBody := 'Dear Team, Your Sales Order ' + FORMAT("No.") + ' ' + 'will be dispatch on expected' + ' ' + FORMAT("Expected Dispatch Date/Time") + ', From Sampoorna Feeds Pvt. Ltd.';
                    //SMSfunctions.SendSMSByURL(SMSBody);
                    SMSDetail.APISMSSingalNo(salesperson."Phone No.", SMSBody, '', salesperson.Code, '1307171654926830711');

                end else begin

                    SMSBody := 'Dear Team, The expected dispatch date of your' + ' ' + FORMAT("No.") + ' ' + 'sales order, it has been Rescheduled to' + ' ' + FORMAT("Expected Dispatch Date/Time") + '. From Sampoorna Feeds Pvt Ltd';
                    //SMSfunctions.SendSMSByURL(SMSBody);
                    SMSDetail.APISMSSingalNo(salesperson."Phone No.", SMSBody, '', salesperson.Code, '1307171654969301399');

                end;
            end;

        }
        field(50033; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            //   TableRelation = Vendor."No." WHERE(Transporter = FILTER(true));
        }
        field(50035; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Created From Web"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Shiiping From"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50044; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50300; "ApplyBillOf"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
        Bank: Record "Bank Account";

    begin
        CompanyInfo.Get;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create Sales Credit Memo');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create Sales Invoice');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Order THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create Sales Order');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to Create Sales Return Order');
        END;
        // IF "Salesperson Code" = '' THEN
        //     SetDefaultSalesperson;
        //PRU_DD 1.10
        "Entry Date" := CURRENTDATETIME;

    end;

    trigger OnAfterModify()
    begin
        IF "Document Type" = "Document Type"::Order THEN
            TESTFIELD("Order Date");
        //TESTFIELD("Shortcut Dimension 1 Code");
        //TESTFIELD("Shortcut Dimension 2 Code");
        //   TESTFIELD("Shortcut Dimension 3 Code");
    end;

    procedure UpdateSalesPrice1(DocumentNo: Code[20]; CustomerPriceGroup: Code[20])
    var
        SalesPrice: Record "Price List Line";
        Customer: Record 18;
        SalesLine: Record 37;
        SalesHeaderRec: Record 36;
        Text50000: Label 'Do you wants to update Item Prices.';
        SalesHeaderUpdate: Record 36;
        RecSalesLineDiscount: Record 7004;
        OrderDateT: Date;
        Flag: Boolean;
        FreightDiscountRec: Record 50037;
        SalesLineDiscountAmount: Decimal;
        FreightDiscontAmount: Decimal;
        TotalDiscount: Decimal;
    begin
        Flag := FALSE;
        SalesHeaderRec.RESET;
        SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
        SalesHeaderRec.SETRANGE(SalesHeaderRec."Shortcut Dimension 1 Code", 'FEED');
        SalesHeaderRec.SETFILTER(SalesHeaderRec."Location Code", '<>%1', 'SFPL0054');
        SalesHeaderRec.SETRANGE(SalesHeaderRec.Status, SalesHeaderRec.Status::Released);
        IF SalesHeaderRec.FINDFIRST THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE(SalesLine."Document No.", DocumentNo);
            SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
            IF SalesLine.FINDSET THEN BEGIN
                REPEAT
                    Customer.RESET;
                    IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE(SalesPrice."Variant Code", SalesLine."Location Code");
                    SalesPrice.SETRANGE(SalesPrice."Product No.", SalesLine."No.");
                    SalesPrice.SETRANGE(SalesPrice."Source Type", SalesPrice."Source Type"::"Customer Price Group");
                    SalesPrice.SETRANGE(SalesPrice."Source No.", CustomerPriceGroup);
                    SalesPrice.SETRANGE(SalesPrice."Unit of Measure Code", SalesLine."Unit of Measure Code");
                    SalesPrice.SETFILTER(SalesPrice."Starting Date", '<=%1', SalesHeaderRec."Posting Date");
                    SalesPrice.SETCURRENTKEY("Starting Date");
                    SalesPrice.SETASCENDING("Starting Date", TRUE);
                    IF SalesPrice.FINDLAST THEN BEGIN
                        IF (SalesLine."Unit Price" > SalesPrice."Unit Price") OR (SalesLine."MRP Price" > SalesPrice."MRP Price") THEN BEGIN
                            IF SalesHeaderRec.Status = SalesHeaderRec.Status::Released THEN
                                SalesHeaderRec.Status := SalesHeaderRec.Status::Open;
                            SalesHeaderRec.MODIFY;
                            //IF CONFIRM(Text50000,TRUE) THEN
                            SalesLine.VALIDATE("MRP Price", SalesPrice."MRP Price");
                            SalesLine.VALIDATE("Unit Price", SalesPrice."Unit Price");
                            SalesLine.MODIFY;
                            // SalesLineDiscountAmount += SalesPrice."Line Discount Amount" * SalesLine.Quantity;
                            Flag := TRUE;
                        END;
                    END;
                UNTIL SalesLine.NEXT = 0;
                ;
            END;
            //
            //GK23092021
            IF Flag THEN BEGIN
                CLEAR(OrderDateT);
                SalesHeaderRec.RESET;
                SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
                IF SalesHeaderRec.FINDFIRST THEN
                    OrderDateT := SalesHeaderRec."Order Date";


                SalesHeaderRec.RESET;
                SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
                SalesHeaderRec.SETRANGE(SalesHeaderRec."Document Type", SalesHeaderRec."Document Type"::Order);
                IF SalesHeaderRec.FINDFIRST THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document No.", DocumentNo);
                    SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                    IF SalesLine.FINDSET THEN BEGIN
                        REPEAT
                            Customer.RESET;
                            SalesLineDiscountAmount := 0;
                            IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                            SalesPrice.RESET;
                            SalesPrice.SETRANGE(SalesPrice."Variant Code", SalesLine."Location Code");
                            SalesPrice.SETRANGE(SalesPrice."Product No.", SalesLine."No.");
                            SalesPrice.SETRANGE(SalesPrice."Source Type", SalesPrice."Source Type"::"Customer Price Group");
                            SalesPrice.SETRANGE(SalesPrice."Source No.", CustomerPriceGroup);
                            SalesPrice.SETRANGE(SalesPrice."Unit of Measure Code", SalesLine."Unit of Measure Code");
                            SalesPrice.SETFILTER(SalesPrice."Starting Date", '<=%1', SalesHeaderRec."Posting Date");
                            SalesPrice.SETCURRENTKEY("Starting Date");
                            SalesPrice.SETASCENDING("Starting Date", TRUE);
                            IF SalesPrice.FINDLAST THEN BEGIN
                                IF (SalesLine."Unit Price" > SalesPrice."Unit Price") OR (SalesLine."MRP Price" > SalesPrice."MRP Price") THEN BEGIN
                                    SalesLineDiscountAmount := SalesPrice."Line Discount Amount" * SalesLine.Quantity;
                                END;
                            END;



                            Customer.RESET;
                            IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                            FreightDiscontAmount := 0;
                            FreightDiscountRec.RESET;
                            FreightDiscountRec.SETRANGE(FreightDiscountRec."Customer Code", SalesLine."Sell-to Customer No.");
                            FreightDiscountRec.SETRANGE(FreightDiscountRec.UOM, SalesLine."Unit of Measure Code");
                            FreightDiscountRec.SETFILTER(FreightDiscountRec."Starting Date", '<=%1', OrderDateT);
                            FreightDiscountRec.SETFILTER(FreightDiscountRec."Ending Date", '%1|>=%2', 0D, OrderDateT);
                            IF FreightDiscountRec.FINDLAST THEN BEGIN
                                REPEAT
                                    FreightDiscontAmount += FreightDiscountRec.Amount * SalesLine.Quantity;
                                UNTIL FreightDiscountRec.NEXT = 0;
                            END ELSE BEGIN
                                FreightDiscountRec.RESET;
                                FreightDiscountRec.SETRANGE(FreightDiscountRec."Customer Code", SalesLine."Sell-to Customer No.");
                                FreightDiscountRec.SETFILTER(FreightDiscountRec."Starting Date", '<=%1', OrderDateT);
                                FreightDiscountRec.SETFILTER(FreightDiscountRec."Ending Date", '%1|>=%2', 0D, OrderDateT);
                                IF FreightDiscountRec.FINDLAST THEN
                                    REPEAT
                                        FreightDiscontAmount += FreightDiscountRec.Amount * SalesLine.Quantity;
                                    UNTIL FreightDiscountRec.NEXT = 0;
                            END;
                            CLEAR(TotalDiscount);
                            TotalDiscount := FreightDiscontAmount + SalesLineDiscountAmount;
                            // MESSAGE('D-%1',TotalDiscount);
                            SalesLine.VALIDATE("Freight Reimbursment Discount", FreightDiscontAmount);
                            SalesLine.VALIDATE("Line Discount Amount", TotalDiscount);
                            SalesLine.MODIFY;
                        UNTIL SalesLine.NEXT = 0;
                    END;
                END;
            END;
            //GK23092021
            //
            COMMIT;
        END;
        IF Flag THEN BEGIN
            SalesHeaderRec.RESET;
            SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
            IF SalesHeaderRec.FINDFIRST THEN BEGIN
                IF SalesHeaderRec.Status = SalesHeaderRec.Status::Open THEN
                    SalesHeaderRec.Status := SalesHeaderRec.Status::Released;
                SalesHeaderRec.MODIFY;
            END;
        END;
    end;

    procedure UpdateSalesPrice(DocumentNo: Code[20]; CustomerPriceGroup: Code[20])
    var
        SalesPrice: Record 7002;
        Customer: Record 18;
        SalesLine: Record 37;
        SalesHeaderRec: Record 36;
        Text50000: Label 'Do you wants to update Item Prices.';
        SalesHeaderUpdate: Record 36;
        RecSalesLineDiscount: Record 7004;
        OrderDateT: Date;
        Flag: Boolean;
        FreightDiscountRec: Record 50037;
        SalesLineDiscountAmount: Decimal;
        FreightDiscontAmount: Decimal;
        TotalDiscount: Decimal;
    begin
        Flag := FALSE;
        SalesHeaderRec.RESET;
        SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
        SalesHeaderRec.SETRANGE(SalesHeaderRec."Shortcut Dimension 1 Code", 'FEED');
        SalesHeaderRec.SETFILTER(SalesHeaderRec."Location Code", '<>%1', 'SFPL0054');
        SalesHeaderRec.SETRANGE(SalesHeaderRec.Status, SalesHeaderRec.Status::Released);
        IF SalesHeaderRec.FINDFIRST THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE(SalesLine."Document No.", DocumentNo);
            SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
            IF SalesLine.FINDSET THEN BEGIN
                REPEAT
                    Customer.RESET;
                    IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE(SalesPrice."Variant Code", SalesLine."Location Code");
                    SalesPrice.SETRANGE(SalesPrice."Item No.", SalesLine."No.");
                    SalesPrice.SETRANGE(SalesPrice."Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE(SalesPrice."Sales Code", CustomerPriceGroup);
                    SalesPrice.SETRANGE(SalesPrice."Unit of Measure Code", SalesLine."Unit of Measure Code");
                    SalesPrice.SETFILTER(SalesPrice."Starting Date", '<=%1', SalesHeaderRec."Posting Date");
                    SalesPrice.SETCURRENTKEY("Starting Date");
                    SalesPrice.SETASCENDING("Starting Date", TRUE);
                    IF SalesPrice.FINDLAST THEN BEGIN
                        //IF (SalesPrice."Starting Date" > SalesLine."Posting Date") THEN BEGIN
                        IF (SalesLine."Unit Price" > SalesPrice."Unit Price") OR (SalesLine."MRP Price" > SalesPrice."MRP Price") THEN BEGIN
                            IF SalesHeaderRec.Status = SalesHeaderRec.Status::Released THEN begin
                                SalesHeaderRec.Status := SalesHeaderRec.Status::Open;
                                SalesHeaderRec.MODIFY;
                            END;
                            //IF CONFIRM(Text50000,TRUE) THEN
                            SalesLine.VALIDATE("MRP Price", SalesPrice."MRP Price");
                            SalesLine.VALIDATE("Unit Price", SalesPrice."Unit Price");
                            SalesLine.MODIFY;
                            Flag := TRUE;
                        END;
                        //END;
                    END;
                UNTIL SalesLine.NEXT = 0;
                ;
            END;
            //
            //GK23092021
            IF Flag THEN BEGIN
                CLEAR(OrderDateT);
                SalesHeaderRec.RESET;
                SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
                IF SalesHeaderRec.FINDFIRST THEN
                    OrderDateT := SalesHeaderRec."Order Date";


                SalesHeaderRec.RESET;
                SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
                SalesHeaderRec.SETRANGE(SalesHeaderRec."Document Type", SalesHeaderRec."Document Type"::Order);
                IF SalesHeaderRec.FINDFIRST THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document No.", DocumentNo);
                    SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                    IF SalesLine.FINDSET THEN BEGIN
                        REPEAT
                            Customer.RESET;
                            IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                            SalesLineDiscountAmount := 0;
                            RecSalesLineDiscount.RESET;
                            if SalesHeaderRec."Customer Disc. Group" <> '' then
                                RecSalesLineDiscount.SETRANGE("Sales Code", SalesHeaderRec."Customer Disc. Group")
                            else
                                //RecSalesLineDiscount.SETRANGE("Sales Code", "Sell-to Customer No.");
                                RecSalesLineDiscount.SETRANGE(RecSalesLineDiscount."Sales Code", SalesLine."Sell-to Customer No.");
                            RecSalesLineDiscount.SETRANGE(RecSalesLineDiscount.Code, SalesLine."No.");
                            RecSalesLineDiscount.SETFILTER(RecSalesLineDiscount."Starting Date", '<=%1', OrderDateT);
                            RecSalesLineDiscount.SETFILTER(RecSalesLineDiscount."Ending Date", '%1|>=%2', 0D, OrderDateT);
                            IF RecSalesLineDiscount.FINDFIRST THEN BEGIN
                                REPEAT
                                    SalesLineDiscountAmount += RecSalesLineDiscount."Line Discount Amount" * SalesLine.Quantity;
                                UNTIL RecSalesLineDiscount.NEXT = 0;
                            END;

                            Customer.RESET;
                            IF Customer.GET(SalesLine."Sell-to Customer No.") THEN;
                            FreightDiscontAmount := 0;
                            FreightDiscountRec.RESET;
                            FreightDiscountRec.SETRANGE(FreightDiscountRec."Customer Code", SalesLine."Sell-to Customer No.");
                            FreightDiscountRec.SETRANGE(FreightDiscountRec.UOM, SalesLine."Unit of Measure Code");
                            FreightDiscountRec.SETFILTER(FreightDiscountRec."Starting Date", '<=%1', OrderDateT);
                            FreightDiscountRec.SETFILTER(FreightDiscountRec."Ending Date", '%1|>=%2', 0D, OrderDateT);
                            IF FreightDiscountRec.FINDLAST THEN BEGIN
                                REPEAT
                                    FreightDiscontAmount += FreightDiscountRec.Amount * SalesLine.Quantity;
                                UNTIL FreightDiscountRec.NEXT = 0;
                            END ELSE BEGIN
                                FreightDiscountRec.RESET;
                                FreightDiscountRec.SETRANGE(FreightDiscountRec."Customer Code", SalesLine."Sell-to Customer No.");
                                FreightDiscountRec.SETFILTER(FreightDiscountRec."Starting Date", '<=%1', OrderDateT);
                                FreightDiscountRec.SETFILTER(FreightDiscountRec."Ending Date", '%1|>=%2', 0D, OrderDateT);
                                IF FreightDiscountRec.FINDLAST THEN
                                    REPEAT
                                        FreightDiscontAmount += FreightDiscountRec.Amount * SalesLine.Quantity;
                                    UNTIL FreightDiscountRec.NEXT = 0;
                            END;
                            CLEAR(TotalDiscount);
                            TotalDiscount := FreightDiscontAmount + SalesLineDiscountAmount;
                            // MESSAGE('D-%1',TotalDiscount);
                            SalesLine.VALIDATE("Freight Reimbursment Discount", FreightDiscontAmount);
                            SalesLine.VALIDATE("Line Discount Amount", TotalDiscount);
                            SalesLine.MODIFY;
                        UNTIL SalesLine.NEXT = 0;
                    END;
                END;
            END;
            //GK23092021
            //

        END;

        IF Flag THEN BEGIN
            SalesHeaderRec.RESET;
            SalesHeaderRec.SETRANGE(SalesHeaderRec."No.", DocumentNo);
            IF SalesHeaderRec.FINDFIRST THEN BEGIN
                IF SalesHeaderRec.Status = SalesHeaderRec.Status::Open THEN begin
                    SalesHeaderRec.Status := SalesHeaderRec.Status::Released;
                    SalesHeaderRec.MODIFY;
                END;
            END;
        END;
        COMMIT;
    end;

    procedure SetDefaultSalesperson()
    var
        UserSetup: Record "User Setup";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        IF NOT UserSetup.GET(USERID) THEN
            EXIT;

        IF UserSetup."Salespers./Purch. Code" <> '' THEN
            IF Salesperson.GET(UserSetup."Salespers./Purch. Code") THEN
                IF NOT Salesperson.VerifySalesPersonPurchaserPrivacyBlocked(Salesperson) THEN
                    VALIDATE("Salesperson Code", UserSetup."Salespers./Purch. Code");
    END;

    procedure GetGateEntryLines()
    var
        PostedGateEntryLine: Record "Posted Gate Entry Line";
        GateEntryAttachment: Record "Gate Entry Attachment";
        PostedGateEntryLineList: Page "Posted Gate Entry Line List";
    begin
        PostedGateEntryLine.MODIFYALL(Mark, FALSE);
        PostedGateEntryLine.RESET;
        PostedGateEntryLine.SETCURRENTKEY("Entry Type", "Source Type", "Source No.", Status);
        CASE "Document Type" OF
            "Document Type"::"Return Order":
                BEGIN
                    PostedGateEntryLine.SETRANGE("Entry Type", PostedGateEntryLine."Entry Type"::Inward);
                    PostedGateEntryLine.SETRANGE("Source Type", PostedGateEntryLine."Source Type"::"Sales Return Order");
                    PostedGateEntryLine.SETRANGE("Source No.", "No.");
                    PostedGateEntryLine.SETRANGE(Status, PostedGateEntryLine.Status::Open);
                END;
            "Document Type"::"Credit Memo":
                BEGIN
                    PostedGateEntryLine.SETRANGE("Entry Type", PostedGateEntryLine."Entry Type"::Inward);
                    PostedGateEntryLine.SETRANGE("Source Type", PostedGateEntryLine."Source Type"::" ");
                    PostedGateEntryLine.SETRANGE(Status, PostedGateEntryLine.Status::Open);
                END;
        END;
        GateEntryAttachment.SETCURRENTKEY("Source Type", "Source No.", "Entry Type", "Gate Entry No.", "Line No.");
        IF PostedGateEntryLine.FINDSET THEN
            REPEAT
                GateEntryAttachment.SETRANGE("Source No.", PostedGateEntryLine."Source No.");
                GateEntryAttachment.SETRANGE("Gate Entry No.", PostedGateEntryLine."Gate Entry No.");
                GateEntryAttachment.SETRANGE("Line No.", PostedGateEntryLine."Line No.");
                IF NOT GateEntryAttachment.FINDFIRST THEN BEGIN
                    PostedGateEntryLine.Mark := TRUE;
                    PostedGateEntryLine.MODIFY;
                    COMMIT;
                END;
            UNTIL PostedGateEntryLine.NEXT = 0;

        PostedGateEntryLine.RESET;
        PostedGateEntryLine.SETCURRENTKEY("Entry Type", "Source Type", "Source No.", Status);
        PostedGateEntryLine.SETRANGE(Mark, TRUE);

        IF PostedGateEntryLine.FINDFIRST THEN BEGIN
            PostedGateEntryLineList.SETTABLEVIEW(PostedGateEntryLine);
            IF PAGE.RUNMODAL(PAGE::"Posted Gate Entry Line List", PostedGateEntryLine) = ACTION::LookupOK THEN BEGIN
                GateEntryAttachment.INIT;
                GateEntryAttachment."Source Type" := PostedGateEntryLine."Source Type";
                GateEntryAttachment."Source No." := PostedGateEntryLine."Source No.";
                GateEntryAttachment."Entry Type" := PostedGateEntryLine."Entry Type";
                GateEntryAttachment."Gate Entry No." := PostedGateEntryLine."Gate Entry No.";
                GateEntryAttachment."Line No." := PostedGateEntryLine."Line No.";
                GateEntryAttachment."Sales Credit Memo No." := "No.";
                GateEntryAttachment.INSERT;
            END;
        END;
    end;


    procedure InitPostingNoSeries1()
    var
        PostingNoSeries: Code[20];
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup1: Record "Responsibility Center";
        UserSetup: Record "User Setup";
        Location: Record Location;

    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        SalesSetup1.GET(UserSetup."Responsibility Center");
        VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");
        GLSetup.GetRecordOnce();
        if GLSetup."Journal Templ. Name Mandatory" then begin
            if "Journal Templ. Name" = '' then begin
                if not IsCreditDocType() then
                    GenJournalTemplate.Get(SalesSetup."S. Invoice Template Name")
                else
                    GenJournalTemplate.Get(SalesSetup."S. Cr. Memo Template Name");
                "Journal Templ. Name" := GenJournalTemplate.Name;
            end else
                GenJournalTemplate.Get("Journal Templ. Name");
            PostingNoSeries := GenJournalTemplate."Posting No. Series";
        end else
            if IsCreditDocType() then
                PostingNoSeries := SalesSetup."Posted Credit Memo Nos."
            else
                PostingNoSeries := SalesSetup."Posted Invoice Nos.";

        case "Document Type" of
            "Document Type"::Quote, "Document Type"::Order:
                begin
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
                    NoSeriesMgt.SetDefaultSeries("Shipping No. Series", SalesSetup1."Posted Shipment Nos.");
                    if "Document Type" = "Document Type"::Order then begin
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series", SalesSetup1."Posted Prepmt. Inv. Nos.");
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series", SalesSetup1."Posted Prepmt. Cr. Memo Nos.");
                    end;
                    VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU_NEELESH
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF NOT Trading THEN BEGIN
                            IF Location."Sales Shipment Nos." <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Shipping No. Series", Location."Sales Shipment Nos.");
                        END ELSE BEGIN
                            IF Location."Sales Invoice Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Sales Invoice Nos. (Trading)");
                            IF Location."Sales Shpt. Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Shipping No. Series", Location."Sales Shpt. Nos. (Trading)");
                        END;
                    END;
                end;
            "Document Type"::Invoice:
                begin
                    if ("No. Series" <> '') and (SalesSetup."Invoice Nos." = PostingNoSeries) then
                        "Posting No. Series" := "No. Series"
                    else
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SalesSetup1."Posted Invoice Nos.");
                    if SalesSetup."Shipment on Invoice" then
                        NoSeriesMgt.SetDefaultSeries("Shipping No. Series", SalesSetup1."Posted Shipment Nos.");
                    VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU_NEELESH
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF NOT Trading THEN BEGIN
                            NoSeriesMgt.SetDefaultSeries("Shipping No. Series", Location."Sales Shipment Nos.");
                        END ELSE BEGIN
                            IF Location."Sales Invoice Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Sales Invoice Nos. (Trading)");
                            IF (Location."Sales Shpt. Nos. (Trading)" <> '') AND SalesSetup."Shipment on Invoice" THEN
                                NoSeriesMgt.SetDefaultSeries("Shipping No. Series", Location."Sales Shpt. Nos. (Trading)");
                        END;
                    END;
                end;
            "Document Type"::"Return Order":
                begin
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
                    NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", SalesSetup1."Posted Return Receipt Nos.");
                    VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU_NEELESH
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF NOT Trading THEN BEGIN
                            IF Location."Sales Return Receipt Nos." <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", Location."Sales Return Receipt Nos.");
                        END ELSE BEGIN
                            IF Location."Sale Cr. Memo Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Sale Cr. Memo Nos. (Trading)");
                            IF Location."Sales Ret Rcpt Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", Location."Sales Ret Rcpt Nos. (Trading)");
                        END;
                    END;
                end;
            "Document Type"::"Credit Memo":
                begin
                    if ("No. Series" <> '') and (SalesSetup."Credit Memo Nos." = PostingNoSeries) then
                        "Posting No. Series" := "No. Series"
                    else
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SalesSetup1."Posted Credit Memo Nos.");
                    if SalesSetup."Return Receipt on Credit Memo" then
                        NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", SalesSetup1."Posted Return Receipt Nos.");
                    VALIDATE("Location Code", UserSetup."Shortcut Dimension 3 Code");//PRU_NEELESH
                    IF "Location Code" <> '' THEN BEGIN
                        Location.GET("Location Code");
                        IF NOT Trading THEN BEGIN
                            IF (Location."Sales Return Receipt Nos." <> '') AND SalesSetup."Return Receipt on Credit Memo" THEN
                                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", Location."Sales Return Receipt Nos.");
                        END ELSE BEGIN
                            IF Location."Sale Cr. Memo Nos. (Trading)" <> '' THEN
                                NoSeriesMgt.SetDefaultSeries("Posting No. Series", Location."Sale Cr. Memo Nos. (Trading)");
                            IF (Location."Sales Ret Rcpt Nos. (Trading)" <> '') AND SalesSetup."Return Receipt on Credit Memo" THEN
                                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series", Location."Sales Ret Rcpt Nos. (Trading)");
                        END;
                    END;
                end;
        end;

        // OnAfterInitPostingNoSeries(Rec, xRec);
    end;

    local procedure LookupDateTime(InitDateTime: DateTime; EarliestDateTime: DateTime; LatestDateTime: DateTime): DateTime
    var
        DateTimeDialog: Page "Date-Time Dialog";
        NewDateTime: DateTime;
    begin
        NewDateTime := InitDateTime;
        if InitDateTime < EarliestDateTime then
            InitDateTime := EarliestDateTime;
        //if (LatestDateTime <> 0DT) and (InitDateTime > LatestDateTime) then
        InitDateTime := LatestDateTime;

        DateTimeDialog.SetDateTime(RoundDateTime(InitDateTime, 1000));

        if DateTimeDialog.RunModal() = ACTION::OK then
            NewDateTime := DateTimeDialog.GetDateTime();
        exit(NewDateTime);


    end;

    var
        CompanyInfo: Record "Company Information";

}
