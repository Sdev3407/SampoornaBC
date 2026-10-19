tableextension 50056 SalesLineExt extends "Sales Line"
{
    fields
    {

        modify("Qty. to Ship")
        {
            trigger OnAfterValidate()
            begin
                IF Quantity <> 0 THEN BEGIN//PRU-VG
                    IF "Document Type" = "Document Type"::Order THEN
                        "Amt. to Customer" := Amount / Quantity * "Qty. to Ship"//PRU-VG
                    ELSE
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN
                            "Amt. to Customer" := Amount / Quantity * "Return Qty. to Receive";//PRU-VG

                END;
            end;
        }

        modify("Return Qty. to Receive")
        {
            trigger OnAfterValidate()
            begin
                IF Quantity <> 0 THEN BEGIN//PRU-VG
                    IF "Document Type" = "Document Type"::Order THEN
                        "Amt. to Customer" := Amount / Quantity * "Qty. to Ship"//PRU-VG
                    ELSE
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN
                            "Amt. to Customer" := Amount / Quantity * "Return Qty. to Receive";//PRU-VG

                END;//PRU-VG

            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                SHRec: Record "Sales Header";
                SalesHeaderT: Record 36;
                OrderDateT: Date;
                SalesHeader: Record "Sales Header";
                SalesPrice: Record 7002;
            begin

            end;

            trigger OnAfterValidate()
            var
                SalesPrice: Record 7002;
                SHRec: Record "Sales Header";
                ItemRec: Record Item;
                PRICEListLine: Record "Price List Line";
                Vendor: Record Vendor;
                SalesHeaderT: Record 36;
                OrderDateT: Date;
                SalesHeader: Record "Sales Header";
            // SalesPrice: Record 7002;
            // ItemRec: Record Item;
            begin
                if SHRec.get("Document Type", "Document No.") then begin
                    SalesPrice.Reset();
                    SalesPrice.SetRange("Item No.", "No.");
                    SalesPrice.SetRange("Variant Code", SHRec."Location Code");
                    if SalesPrice.FindFirst() then
                        rec.Validate("Variant Code", SHRec."Location Code");
                    "Invoice Type" := SHRec."Invoice Type";
                    "Location State Code" := SHRec."Location State Code";//SUMAN
                    "Customer Price Group" := SHRec."Customer Price Group";
                END;


                if ItemRec.Get("No.") then begin
                    Description := ItemRec.Description;
                    "GST Exempt" := ItemRec."GST Exempt";
                end;
                // "Variant Code" := '';
                SalesHeaderT.RESET;
                SalesHeaderT.SETRANGE("No.", "Document No.");
                IF SalesHeaderT.FINDFIRST THEN
                    OrderDateT := SalesHeaderT."Order Date";

                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.", "No.");
                SalesPrice.SETRANGE("Variant Code", "Location Code");
                SalesPrice.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                SalesPrice.SETRANGE("Sales Code", "Customer Price Group");
                SalesPrice.SETFILTER("Starting Date", '<=%1', OrderDateT);
                SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDateT);
                IF SalesPrice.FINDLAST THEN
                    validate("Variant Code", "Location Code");

            END;
        }
        modify("Customer Price Group")
        {
            trigger OnAfterValidate()
            var
                SHRec: Record "Sales Header";
                ItemRec: Record Item;
                PRICEListLine: Record "Price List Line";
            begin

                if SHRec.get("Document Type", "Document No.") then begin

                    if ItemRec.Get("No.") then
                        Description := ItemRec.Description;

                END;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                SHRec: Record "Sales Header";
                ItemRec: Record Item;
                PRICEListLine: Record "Price List Line";
                SalesHeaderT: Record 36;
                OrderDateT: Date;
                SalesHeader: Record "Sales Header";
                SalesPrice: Record 7002;
            begin
                "Total MRP" := Quantity * "MRP Price";//PRU-VG
                if SHRec.get("Document Type", "Document No.") then begin

                END;
                if ItemRec.Get("No.") then
                    Description := ItemRec.Description;



            end;
        }
        modify("Customer Disc. Group")
        {
            trigger OnAfterValidate()
            var
                SHRec: Record "Sales Header";
                ItemRec: Record Item;
                PRICEListLine: Record "Price List Line";
            begin
                if SHRec.get("Document Type", "Document No.") then begin

                END;
                if ItemRec.Get("No.") then
                    Description := ItemRec.Description;

            end;
        }
        modify(Amount)
        {

            trigger OnAfterValidate()
            begin
                IF Quantity <> 0 THEN BEGIN//PRU-VG
                    IF "Document Type" = "Document Type"::Order THEN
                        "Amt. to Customer" := Amount / Quantity * "Qty. to Ship"//PRU-VG
                    ELSE
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN
                            "Amt. to Customer" := Amount / Quantity * "Return Qty. to Receive";//PRU-VG
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                RecSalesLineDiscount: Record "Price List Line";
                SalesHeaderT: Record 36;
                OrderDateT: Date;
                SalesHeader: Record "Sales Header";
                SalesPrice: Record 7002;
                ItemRec: Record Item;
            begin
                //Gk-25-03-2021-
                SalesHeaderT.RESET;
                SalesHeaderT.SETRANGE("No.", "Document No.");
                IF SalesHeaderT.FINDFIRST THEN
                    OrderDateT := SalesHeaderT."Order Date";


                //  UpdateAmounts;
                //GK-25-03-2021+
                //GK23042021
                //if Quantity <> 0 then

                IF "Freight Reimbursment Discount" <> 0 THEN
                    IF "Unit Price" <> 0 THEN
                        VALIDATE("Freight Reimbursment Discount");




                //GK23042021

                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.", "No.");
                SalesPrice.SETRANGE("Variant Code", "Location Code");
                SalesPrice.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                SalesPrice.SETRANGE("Sales Code", "Customer Price Group");
                SalesPrice.SETFILTER("Starting Date", '<=%1', OrderDateT);
                SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDateT);
                IF SalesPrice.FINDLAST THEN
                    "Price Discount" := SalesPrice."Discount Perc/Amount";
                if ItemRec.Get("No.") then
                    Description := ItemRec.Description;
                IF Quantity <> 0 THEN
                    Validate("Line Discount Amount");
                IF Quantity <> 0 THEN BEGIN//PRU-VG
                    IF "Document Type" = "Document Type"::Order THEN
                        "Amt. to Customer" := Amount / Quantity * "Qty. to Ship"//PRU-VG
                    ELSE
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN
                            "Amt. to Customer" := Amount / Quantity * "Return Qty. to Receive";//PRU-VG
                END;//PRU-VG

            end;

        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                //  if "Freight Reimbursment Discount" <> 0 then
                //    "Line Discount Amount" += "Freight Reimbursment Discount";
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
                bsdhc: Page 233;
                FreightDiscount: Record 50037;
                SalesOrderA: Record 36;
                OrderDateA: Date;
                SalesPrice: Record 7002;
                // RecSalesLineDiscount: Record "Price List Line";
                SalesHeader: Record 36;
                SHRec: Record "Sales Header";
                RecSalesLineDiscount: Record "Sales Line Discount";
            begin
                //GK24042021//GK17
                //CLEAR(OrderDateA);
                SalesOrderA.RESET;
                SalesOrderA.SETRANGE("No.", "Document No.");
                IF SalesOrderA.FINDFIRST THEN
                    OrderDateA := SalesOrderA."Order Date";

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF Type = Type::Item THEN BEGIN
                        FreightDiscount.RESET;
                        FreightDiscount.SETRANGE("Customer Code", "Sell-to Customer No.");
                        FreightDiscount.SETRANGE(UOM, "Unit of Measure Code");
                        FreightDiscount.SETFILTER("Starting Date", '<=%1', OrderDateA);
                        FreightDiscount.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDateA);
                        IF FreightDiscount.FINDLAST THEN BEGIN
                            "Freight Reimbursment Discount" := FreightDiscount.Amount * Quantity;
                        END ELSE BEGIN
                            FreightDiscount.RESET;
                            FreightDiscount.SETRANGE("Customer Code", "Sell-to Customer No.");
                            //FreightDiscount.SETRANGE(UOM, "Unit of Measure Code");// suman 01032025
                            FreightDiscount.SETFILTER("Starting Date", '<=%1', OrderDateA);
                            FreightDiscount.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDateA);
                            IF FreightDiscount.FINDLAST THEN
                                "Freight Reimbursment Discount" := FreightDiscount.Amount * Quantity;

                        END;
                    END;
                END;


                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF Type = Type::Item THEN BEGIN
                        RecSalesLineDiscount.RESET;
                        //IF RecSalesLineDiscount."Sales Type" = RecSalesLineDiscount."Sales Type"::Customer THEN
                        //  RecSalesLineDiscount.SETRANGE("Sales Code", "Sell-to Customer No.");
                        //IF RecSalesLineDiscount."Sales Type" = RecSalesLineDiscount."Sales Type"::"Customer Disc. Group" THEN
                        if "Customer Disc. Group" <> '' then
                            RecSalesLineDiscount.SETRANGE("Sales Code", "Customer Disc. Group")
                        else
                            RecSalesLineDiscount.SETRANGE("Sales Code", "Sell-to Customer No.");
                        RecSalesLineDiscount.SETRANGE(Code, "No.");
                        RecSalesLineDiscount.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                        RecSalesLineDiscount.SETFILTER("Starting Date", '<=%1', OrderDateA);
                        RecSalesLineDiscount.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDateA);
                        IF RecSalesLineDiscount.FINDFIRST THEN BEGIN
                            "Line Discount Amount" := "Freight Reimbursment Discount" + RecSalesLineDiscount."Line Discount Amount" * Quantity;
                        END
                        else begin
                            "Line Discount Amount" := "Freight Reimbursment Discount";
                        end;
                    END;
                    if "Line Discount %" = 100 Then
                        rec.Validate("Line Discount Amount", (Quantity * "Unit Price"));
                END;


            end;
        }
        modify("VAT Prod. Posting Group")
        {
            trigger OnBeforeValidate()
            var
                CannotChangeVATGroupWithPrepmInvErr: Label 'ENU=You cannot change the VAT product posting group because prepayment invoices have been posted.';
            begin
                IF "Prepmt. Amt. Inv." <> 0 THEN
                    ERROR(CannotChangeVATGroupWithPrepmInvErr);  //Pru_GK TCS
            end;
        }
        modify("TCS Nature of Collection")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                TCSSetup_R: Record "TCS Setup";
                ASection: Record "Allowed NOC";
            begin
                if "TCS Nature of Collection" <> '' then
                    if Not ASection.Get("Sell-to Customer No.", "TCS Nature of Collection") then
                        Error('Please select allowed Section for this Customer');
            end;
        }

        modify("Unit of Measure Code")
        {

            trigger OnAfterValidate()
            var
                SalesPrice: Record 7002;
                SHRec: Record "Sales Header";
                ItemRec: Record Item;
                PRICEListLine: Record "Price List Line";
            begin
                "Freight Reimbursment Discount" := 0;//GK24042021

                if ItemRec.Get("No.") then
                    Description := ItemRec.Description;
                // "Variant Code" := '';
            END;
        }
        modify(Type)
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                SelectItemCatCode; //Pru171220#P0272
                if SalesHeader.get(Rec."Document Type", Rec."Document No.") then
                    "Location State Code" := SalesHeader."Location State Code";
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            var
            begin
                // TestField("Location State Code");
            end;

            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin

                if SalesHeader.get(Rec."Document Type", Rec."Document No.") then
                    "Location State Code" := SalesHeader."Location State Code";

                SalesHeader.Reset();
                if SalesHeader.get(rec."Document Type", rec."Document No.") then
                    IF SalesHeader."GST Bill-to State Code" <> SalesHeader."Location State Code" THEN BEGIN
                        Validate("GST Jurisdiction Type", "GST Jurisdiction Type"::Interstate);
                    END ELSE
                        Validate("GST Jurisdiction Type", "GST Jurisdiction Type"::Intrastate);

            end;
        }
        field(50000; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU';
        }
        field(50001; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50002; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50003; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released),
                                                          "Short Close" = FILTER(false),
                                                          "Shortcut Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
                                                          "Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            var
                GCStatement: Record 50015;
            begin
                IF "Flock No." <> '' THEN BEGIN
                    GCStatement.RESET;
                    GCStatement.SETRANGE("Flock No.", "Flock No.");
                    GCStatement.SETRANGE(Posted, TRUE);
                    IF GCStatement.FINDFIRST THEN
                        ERROR('The Flock No. %1 can not be selected as its GC Statement has already been posted.', "Flock No.");
                END;
            end;
        }
        field(50004; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50005; "Bird Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50006; "Male Brid Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50007; "Female Bird Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50008; "Freight Reimbursment Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';

            trigger OnValidate()
            begin
                //   TESTFIELD("Line Amount");
                // VALIDATE("Line Amount", "Line Amount" - "Line Discount Amount");
            end;
        }
        field(50009; "Total MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50010; "Short Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50011; "Amt. to Customer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50012; "Shipment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50013; "Location State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            FieldClass = Normal;


        }
        field(50014; "Price Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Total MRP" := Quantity * "MRP Price";
                "Total MRP Price" := Quantity * "MRP Price";
            end;
        }
        field(50016; "Total MRP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "MRP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterModify()
    var
        SalesHeader_36: Record "Sales Header";
    begin

    end;

    trigger OnAfterInsert()
    var
        SalesHeader: Record 37;
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup1: Record "GST Setup";
        //TaxComponentName1: Record "Tax Component";
        TaxTransValue: Record "Tax Transaction Value";
        BaseAmt: Decimal;
        TaxComponentName1: Text;
        BaseAmt1: Decimal;
    begin


    end;

    procedure SelectItemCatCode()
    var
        RecUsersetup: Record "User Setup";
        recSalesHeader: Record "Sales Header";
    begin
        //Pru171220#P0272 >>
        RecUsersetup.GET(USERID);
        IF (RecUsersetup."Salesperson User") THEN BEGIN
            IF Type = Type::Item THEN BEGIN
                recSalesHeader.RESET;
                recSalesHeader.SETRANGE("Document Type", "Document Type");
                recSalesHeader.SETRANGE("No.", "Document No.");
                IF recSalesHeader.FINDFIRST THEN BEGIN
                    VALIDATE("Location Code", recSalesHeader."Location Code");
                END;
            END;
        END;
    end;

    var
        TaxTransValue1: Record "Tax Transaction Value";
}