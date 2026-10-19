tableextension 50041 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        // modify("GST Reverse Charge")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         PurH: Record "Purchase Header";
        //     begin
        //         PurH.Get(Rec."Document Type", Rec."Document No.");
        //         if PurH."GST Vendor Type" in [PurH."GST Vendor Type"::Unregistered] then begin
        //             PurH.Validate("RCM Doc", Rec."GST Reverse Charge");
        //             //PurH.Modify();
        //         end


        //     end;
        // }

        modify("TDS Section Code")
        {
            trigger OnAfterValidate()
            var
                ASection: Record "Allowed Sections";
            begin
                if "TDS Section Code" <> '' then
                    if Not ASection.Get("Buy-from Vendor No.", "TDS Section Code") then
                        Error('Please select allowed Section for this vendor');
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeaderRec: Record "Purchase Header";
            begin
                if PurchaseHeaderRec.get("Document Type", "Document No.") then begin
                    "Vendor State Code" := PurchaseHeaderRec.State;
                    "Location State Code" := PurchaseHeaderRec."Location State Code";
                end;
            end;

        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeaderRec: Record "Purchase Header";
            begin
                if PurchaseHeaderRec.get("Document Type", "Document No.") then begin
                    "Vendor State Code" := PurchaseHeaderRec.State;
                    "Location State Code" := PurchaseHeaderRec."Location State Code";
                end;
            end;
        }

        modify("No.")
        {


            trigger OnAfterValidate()
            var
                Vendor: Record Vendor;
                ItemRec: Record Item;
                PurchaseHeaderRec: Record "Purchase Header";
            begin
                // if ItemRec.Get("No.") then
                //     "GST Exempt" := ItemRec."GST Exempt";
                // if Vendor.Get("Buy-from Vendor No.") then begin
                //     if (Vendor."GST Vendor Type" = Vendor."GST Vendor Type"::Unregistered) and (Rec."GST Group Type" = Rec."GST Group Type"::Goods) then
                //         "GST Reverse Charge" := False;
                // end;
                // Exempted := false;
                if PurchaseHeaderRec.get("Document Type", "Document No.") then begin
                    "Vendor State Code" := PurchaseHeaderRec.State;
                    "Location State Code" := PurchaseHeaderRec."Location State Code";
                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                // if Type = Type::"Charge (Item)" then
                //     if Quantity > 1 then
                //         Error('Quantity must not be greater then 1');
                //PRU-VG1.0
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IF Type = Type::Item THEN BEGIN
                        //   TESTFIELD("Location Code");
                        Item.GET("No.");
                        IF Item."Maximum Inventory" <> 0 THEN
                            IF Quantity > (Item."Maximum Inventory" - GetILEInventory("No.", "Location Code")) THEN
                                ERROR('Quantity is greater than available inventory');

                    END;
                END;
            end;



            trigger OnAfterValidate()
            var
                Vendor: Record Vendor;
            begin
                IF CurrFieldNo <> 0 THEN //PRU-VG
                    "Quantity With Bag" := Quantity;//PRU-VG
                // if Vendor.Get("Buy-from Vendor No.") then begin
                //     if Vendor."GST Vendor Type" = Vendor."GST Vendor Type"::Unregistered then
                //         "GST Reverse Charge" := true;
                // end;
                // Exempted := false;

            end;
        }
        field(50000; "QC Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50001; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-RK';
        }
        field(50002; "Challan Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'PRU-FE-003';

            trigger OnValidate()
            begin
                //PRU-FE-003->
                VALIDATE("Qty. to Receive", "Challan Qty");
                //PRU-FE-004 ->
                VALIDATE("Excess/Short Qty", "Weight Qty" - "Challan Qty")
                //PRU-FE-004 <-

            end;
        }
        field(50003; "Weight Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'PRU-FE-003';

            trigger OnValidate()
            begin
                //PRU-FE-004 ->;
                VALIDATE("Excess/Short Qty", "Weight Qty" - "Challan Qty");
                //PRU-FE-004 <-

            end;
        }
        field(50004; "Excess/Short Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'PRU-FE-003';
        }
        field(50005; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
            Editable = false;
            TableRelation = "Indent Line"."Document No.";
        }
        field(50006; "Indent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
            Editable = false;
            TableRelation = "Indent Line"."Line No." WHERE("Document No." = FIELD("Indent No."));
        }
        field(50007; "Bag Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
            TableRelation = Item;

            trigger OnValidate()
            begin
                // PRU-FE-001 ->
                //IF CompanyProcess.ISFeeds THEN BEGIN
                IF "Parent Bag Line No." <> 0 THEN BEGIN
                    "Bag Item No." := '';
                    "Bag Quantity" := 0;
                END ELSE
                    "Bag Quantity" := 0;
                //END;
                // PRU-FE-001 <-
            end;
        }
        field(50008; "Bag Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            Description = 'PRU-FE-001';

            trigger OnValidate()
            begin
                // PRU-FE-001 ->
                //IF CompanyProcess.ISFeeds THEN BEGIN
                IF "Parent Bag Line No." <> 0 THEN BEGIN
                    "Bag Item No." := '';
                    "Bag Quantity" := 0;
                END ELSE
                    TESTFIELD("Bag Item No.");
                //END;
                // PRU-FE-001 <-
            end;
        }
        field(50009; "Parent Bag Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
        }
        field(50010; "Quantity With Bag"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
        }
        field(50011; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50012; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50013; "Week Bird Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50014; "Transit Mortality Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50015; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(50016; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50017; "Extra Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50018; "Short Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50019; "Actual Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'PRU-VG';
        }
        field(50020; "Location State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS';
            FieldClass = Normal;
        }
        field(50021; "Tax Free"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH 1.1';
        }
        field(50022; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Posted Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Vendor State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            FieldClass = Normal;
            //CalcFormula = lookup("Purchase Header".State where("No." = field("Document No.")));

        }
    }

    trigger OnAfterInsert()
    var
        PurchaseHeaderRec: Record "Purchase Header";
    begin
        PurchaseHeaderRec.Reset();
        PurchaseHeaderRec.SetRange(PurchaseHeaderRec."No.", "Document No.");
        if PurchaseHeaderRec.FindFirst() then
            IF PurchaseHeaderRec.State <> PurchaseHeaderRec."Location State Code" THEN BEGIN
                "GST Jurisdiction Type" := "GST Jurisdiction Type"::Interstate;
            END ELSE
                "GST Jurisdiction Type" := "GST Jurisdiction Type"::Intrastate;

        if PurchaseHeaderRec.get("Document Type", "Document No.") then begin
            "Vendor State Code" := PurchaseHeaderRec.State;
            "Location State Code" := PurchaseHeaderRec."Location State Code";
        end;

    end;

    local procedure GetILEInventory(ItemNo: Code[20]; ParaLoc: Code[20]): Decimal
    var
        ParaItemLed: Record 32;
        Inv: Decimal;
    begin
        ParaItemLed.RESET;
        ParaItemLed.SETCURRENTKEY("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        ParaItemLed.SETRANGE("Item No.", ItemNo);
        ParaItemLed.SETRANGE("Location Code", ParaLoc);
        ParaItemLed.SETRANGE(Open, TRUE);
        IF ParaItemLed.FINDFIRST THEN BEGIN
            ParaItemLed.CALCSUMS("Remaining Quantity");
            EXIT(ParaItemLed."Remaining Quantity");
        END;
    end;



    procedure CalculateBagWeight(DocumentNo: Code[20])
    var
        PurchaseLine: Record 39;
        UserSetup: Record 91;
        PurchaseLine2: Record 39;
        BagItem: Record 27;
        Text60001: Label 'You do not have permission to calculate weight of bags';
    begin
        // PRU-FE-001 ->
        //IF CompanyProcess.ISFeeds THEN BEGIN
        UserSetup.GET(USERID);
        IF NOT UserSetup."Allow Calculate Bag Weight" THEN
            ERROR(Text60001);

        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", DocumentNo);
        PurchaseLine.SETFILTER("Bag Item No.", '<>%1', '');
        PurchaseLine.SETFILTER("Bag Quantity", '<>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseLine.TESTFIELD("Quantity Received", 0);
                BagItem.GET(PurchaseLine."Bag Item No.");
                BagItem.TESTFIELD("Net Weight");
                BagItem.TESTFIELD("Purch. Unit of Measure", 'KG');
                PurchaseLine2.RESET;
                PurchaseLine2.SETRANGE("Document Type", PurchaseLine."Document Type");
                PurchaseLine2.SETRANGE("Document No.", DocumentNo);
                PurchaseLine2.SETRANGE("Parent Bag Line No.", PurchaseLine."Line No.");
                IF NOT PurchaseLine2.FINDFIRST THEN BEGIN
                    PurchaseLine2.INIT;
                    PurchaseLine2.VALIDATE("Document Type", PurchaseLine."Document Type");
                    PurchaseLine2.VALIDATE("Document No.", PurchaseLine."Document No.");
                    PurchaseLine2.VALIDATE("Line No.", PurchaseLine."Line No." + 10);
                    PurchaseLine2.INSERT(TRUE);
                    PurchaseLine2.VALIDATE(Type, PurchaseLine2.Type::Item);
                    PurchaseLine2.VALIDATE("No.", PurchaseLine."Bag Item No.");
                    PurchaseLine2.VALIDATE(Quantity, PurchaseLine."Bag Quantity" * BagItem."Net Weight");
                    PurchaseLine2.VALIDATE("Location Code", PurchaseLine."Location Code");
                    PurchaseLine2.VALIDATE("Parent Bag Line No.", PurchaseLine."Line No.");
                    PurchaseLine2.MODIFY(TRUE);
                END ELSE BEGIN
                    PurchaseLine2.DELETE(TRUE);
                    PurchaseLine2.INIT;
                    PurchaseLine2.VALIDATE("Document Type", PurchaseLine."Document Type");
                    PurchaseLine2.VALIDATE("Document No.", PurchaseLine."Document No.");
                    PurchaseLine2.VALIDATE("Line No.", PurchaseLine."Line No." + 10);
                    PurchaseLine2.INSERT(TRUE);
                    PurchaseLine2.VALIDATE(Type, PurchaseLine2.Type::Item);
                    PurchaseLine2.VALIDATE("No.", PurchaseLine."Bag Item No.");
                    PurchaseLine2.VALIDATE(Quantity, PurchaseLine."Bag Quantity" * BagItem."Net Weight");
                    PurchaseLine2.VALIDATE("Location Code", PurchaseLine."Location Code");
                    PurchaseLine2.VALIDATE("Parent Bag Line No.", PurchaseLine."Line No.");
                    PurchaseLine2.MODIFY(TRUE);
                END;
                PurchaseLine.VALIDATE(Quantity, PurchaseLine."Quantity With Bag" - PurchaseLine2.Quantity);
                PurchaseLine.MODIFY(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        ///END;
        // PRU-FE-001 <-
    end;
}