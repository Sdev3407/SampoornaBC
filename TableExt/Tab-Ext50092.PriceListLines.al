tableextension 50092 PriceListLines extends "Price List Line"
{
    fields
    {


        modify("Variant Code Lookup")
        {
            trigger OnAfterValidate()
            var
                VarRec: Record "Item Variant";
            begin
                if "Variant Code" <> '' then
                    if Not VarRec.Get("Product No1", "Variant Code Lookup") then
                        Error('Variant Code does not exist');


            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            var
                VarRec: Record "Item Variant";
            begin
                if "Variant Code" <> '' then
                    if Not VarRec.Get("Product No1", "Variant Code") then
                        Error('Variant Code does not exist');
            end;
        }
        modify("Unit of Measure Code Lookup")
        {
            trigger OnAfterValidate()
            begin
                "Unit of Measure Code" := "Unit of Measure Code Lookup";
            end;
        }
        modify("Starting Date")
        {
            trigger OnAfterValidate()
            var
                PriLisH: Record "Price List Line";
                T7002: Record "Price List Line";
                apppc: Page 233;
            begin
                IF "Variant Code" <> '' THEN BEGIN
                    T7002.RESET;
                    
                    T7002.SETRANGE(T7002."Product No.", rec."Product No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Variant Code", '%1', "Variant Code");
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        IF T7002."Starting Date" < "Starting Date" THEN BEGIN
                            T7002."Ending Date" := CALCDATE('-1D', "Starting Date");
                            T7002.MODIFY;
                        END;
                    END;
                END ELSE BEGIN
                    T7002.RESET;
                    T7002.SETRANGE(T7002."Product No.", rec."Product No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Variant Code", '%1', '');
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        REPEAT
                            IF T7002."Starting Date" <= "Starting Date" THEN BEGIN
                                T7002."Ending Date" := CALCDATE('-1D', "Starting Date");
                                T7002.MODIFY;
                            END;
                        UNTIL T7002.NEXT = 0;
                    END;

                END;

            end;
        }
        field(50000; "Discount Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Per,Value';
            OptionMembers = " ",Per,Value;

            trigger OnValidate()
            begin
                IF xRec."Discount Type" <> xRec."Discount Type"::" " THEN
                    IF xRec."Discount Type" <> "Discount Type" THEN
                        VALIDATE("Discount Perc/Amount", 0);
            end;
        }
        field(50001; "Discount Perc/Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';

            trigger OnValidate()
            begin

                IF "Discount Perc/Amount" = 0 THEN
                    "Unit Price" := "MRP Price"
                ELSE BEGIN
                    IF "Discount Type" = "Discount Type"::Per THEN
                        "Unit Price" := "MRP Price" - ("MRP Price" * "Discount Perc/Amount" / 100)
                    ELSE
                        IF "Discount Type" = "Discount Type"::Value THEN
                            "Unit Price" := "MRP Price" - "Discount Perc/Amount";
                END;
                

            end;
        }

        field(50003; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_Gk';
            TableRelation = Location;
        }

        field(50006; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "MRP PRICE"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TESTFIELD(MRP);
                IF "Discount Type" = "Discount Type"::" " THEN
                    "Unit Price" := "MRP Price"
                ELSE
                    IF "Discount Type" = "Discount Type"::Per THEN BEGIN
                        TESTFIELD("Discount Perc/Amount");
                        "Unit Price" := "MRP Price" - ("MRP Price" * "Discount Perc/Amount" / 100);
                    END ELSE
                        IF "Discount Type" = "Discount Type"::Value THEN BEGIN
                            TESTFIELD("Discount Perc/Amount");
                            "Unit Price" := "MRP Price" - "Discount Perc/Amount";
                        END;
            end;
        }
        field(50008; "MRP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Product No1"; Code[20])
        {
            Caption = 'Product No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Asset Type" = CONST(Item)) Item
            ELSE
            IF ("Asset Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Asset Type" = CONST(Resource)) Resource
            ELSE
            IF ("Asset Type" = CONST("Resource Group")) "Resource Group"
            ELSE
            IF ("Asset Type" = CONST("Item Discount Group")) "Item Discount Group"
            ELSE
            IF ("Asset Type" = CONST("Service Cost")) "Service Cost";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ItemRec: Record Item;
                PriceListH: Record "Price List Header";
            begin
                if ItemRec.Get(rec."Product No1") then begin
                    "Product No." := "Product No1";
                    "Asset No." := "Product No1";
                    Description := ItemRec.Description;
                    "Unit of Measure Code" := ItemRec."Base Unit of Measure";
                    "Unit of Measure Code Lookup" := ItemRec."Base Unit of Measure";
                    "Variant Code" := '';
                    if PriceListH.Get("Price List Code") then begin
                        "Source No." := PriceListH."Assign-to No.";
                        "Source Type" := PriceListH."Source Type";
                        Validate("Starting Date", PriceListH."Starting Date");
                        "Ending Date" := PriceListH."Ending Date";
                        "Ending Data" := PriceListH."Ending Date";
                    end;
                END;
            end;
        }
        field(50010; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
        }
        field(50011; "Ending Data"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PriLisH: Record "Price List Line";
            begin

                "Ending Date" := "Ending Data";
            end;
        }
        field(50012; "Staring Data"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PriLisH: Record "Price List Line";
                T7002: Record "Price List Line";
                apppc: Page 233;
            begin
                "Starting Date" := "Staring Data";
                IF "Variant Code" <> '' THEN BEGIN
                    T7002.RESET;
                    T7002.SETRANGE(T7002."Product No.", rec."Product No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Variant Code", '%1', "Variant Code");
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        IF T7002."Starting Date" < "Starting Date" THEN BEGIN
                            T7002."Ending Date" := CALCDATE('-1D', "Staring Data");
                            T7002."Ending Data" := CALCDATE('-1D', "Staring Data");
                            T7002.MODIFY;
                        END;
                    END;
                END ELSE BEGIN
                    //PRU-VG
                    T7002.RESET;
                    T7002.SETRANGE(T7002."Product No.", rec."Product No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Variant Code", '%1', '');
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        REPEAT
                            IF T7002."Starting Date" <= "Starting Date" THEN BEGIN
                                T7002."Ending Date" := CALCDATE('-1D', "Staring Data");
                                T7002."Ending Data" := CALCDATE('-1D', "Staring Data");
                                T7002.MODIFY;
                            END;
                        UNTIL T7002.NEXT = 0;
                    END;
                    //PRU-VG
                END;
            end;
        }

    }
    trigger OnBeforeModify()
    var
        ph: Record "Price List Header";
    begin
        ph.Reset();
        ph.SetRange(code, "Price List Code");
        if ph.FindFirst() then begin
            if ph.Status = ph.Status::Active then
                Error('You can not modify the fields while status is Active');
        end;
    end;

    procedure ReopenSalesPrice(SalesCode: Code[30]; ItemNo: Code[30]; DocStatus: Option Open,Released,"Pending Approval")
    var
        Text000: Label 'Indent Status must be ''Indent'' in the Indent Lines';
        Text007: Label 'Can not Reopen the indent if status is Cancel/Closed.';
        Text008: Label 'Sales Price Must be Released.';
        SalesPrice: Record "Sales Price";
        Text009: Label 'Sales Document Reopen Sucessfully';
    begin
        IF DocStatus = DocStatus::Released THEN BEGIN
            SalesPrice.RESET;
            SalesPrice.SETRANGE(SalesPrice."Sales Type", SalesPrice."Sales Type"::Customer);
            SalesPrice.SETRANGE(SalesPrice."Sales Code", SalesCode);
            SalesPrice.SETRANGE(SalesPrice."Item No.", ItemNo);
            IF SalesPrice.FINDFIRST THEN BEGIN
                SalesPrice.Status := SalesPrice.Status::Open;
                SalesPrice.MODIFY;
            END;
            MESSAGE(Text009);
        END ELSE
            ERROR(Text008);
    end;
}