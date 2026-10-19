tableextension 50023 TransferLineExt extends "Transfer Line"
{
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                TransferHeader: Record "Transfer Header";
            begin
                if Item.Get("Item No.") then;
                "Chicks Item" := Item."Chicks Item"; //RK-PRU;
                "Breed Code" := Item."Breed Code";//PRU-VG
                "Item Type" := Item."Item Type";//PRu-VG
                                                ////Pru_gk
                "GST Exempt" := Item."GST Exempt";
                TransferHeader.RESET;
                TransferHeader.SETRANGE("No.", "Document No.");
                IF TransferHeader.FINDFIRST THEN
                    VALIDATE("Shortcut Dimension 3 Code", TransferHeader."Shortcut Dimension 3 Code");
                ///Pru_gk
                //Exempted := false;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                DocNo: Code[20];
                TRPrice: Decimal;
                PRPrice: Decimal;
                TransferReceiptLine: Record "Transfer Receipt Line";
                PurchRcptLine: Record "Purch. Rcpt. Line";
                TransHeader: Record "Transfer Header";
                Item: Record Item;
            begin
                //GK22102021
                // CLEAR(DocNo);
                // ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE("Location Code", "Transfer-from Code");
                // ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                // ItemLedgerEntry.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
                // ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                // ItemLedgerEntry.SETFILTER("Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Purchase Receipt", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                // IF ItemLedgerEntry.FINDFIRST THEN
                //     DocNo := ItemLedgerEntry."Document No.";
                // //======================TransferReceiptLine=============
                // CLEAR(TRPrice);
                // CLEAR(PRPrice);
                // TransferReceiptLine.RESET;
                // TransferReceiptLine.SETRANGE("Document No.", DocNo);
                // TransferReceiptLine.SETRANGE("Item No.", "Item No.");
                // IF TransferReceiptLine.FINDFIRST THEN
                //     TRPrice := TransferReceiptLine."Unit Price";
                // //===================PurchRcptLine==================
                // PurchRcptLine.RESET;
                // PurchRcptLine.SETRANGE("Document No.", DocNo);
                // PurchRcptLine.SETRANGE("No.", "Item No.");
                // IF PurchRcptLine.FINDFIRST THEN
                //     PRPrice := PurchRcptLine."Unit Cost";


                // //GK
                // Item.Get("Item No.");
                // IF TRPrice <> 0 THEN
                //     VALIDATE("Transfer Price", TRPrice)
                // ELSE
                //     IF PRPrice <> 0 THEN
                //         VALIDATE("Transfer Price", PRPrice)
                //     ELSE
                //         VALIDATE("Transfer Price", Item."Unit Cost" * "Qty. per Unit of Measure");
                //Exempted := false;
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                DocNo: Code[20];
                TRPrice: Decimal;
                PRPrice: Decimal;
                TransferReceiptLine: Record "Transfer Receipt Line";
                PurchRcptLine: Record "Purch. Rcpt. Line";
                TransHeader: Record "Transfer Header";
                Item: Record Item;
            begin
                //GK22102021
                CLEAR(DocNo);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Location Code", "Transfer-from Code");
                ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                ItemLedgerEntry.SetRange("Unit of Measure Code", Rec."Unit of Measure Code");
                ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
                ItemLedgerEntry.SETFILTER("Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Purchase Receipt", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                IF ItemLedgerEntry.FINDFIRST THEN
                    DocNo := ItemLedgerEntry."Document No.";
                //======================TransferReceiptLine=============
                CLEAR(TRPrice);
                CLEAR(PRPrice);
                TransferReceiptLine.RESET;
                TransferReceiptLine.SETRANGE("Document No.", DocNo);
                TransferReceiptLine.SETRANGE("Item No.", "Item No.");
                IF TransferReceiptLine.FINDFIRST THEN
                    TRPrice := TransferReceiptLine."Unit Price";
                //===================PurchRcptLine==================
                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE("Document No.", DocNo);
                PurchRcptLine.SETRANGE("No.", "Item No.");
                IF PurchRcptLine.FINDFIRST THEN
                    PRPrice := PurchRcptLine."Unit Cost";


                //GK
                Item.Get("Item No.");
                IF TRPrice <> 0 THEN
                    VALIDATE("Transfer Price", TRPrice)
                ELSE
                    IF PRPrice <> 0 THEN
                        VALIDATE("Transfer Price", PRPrice)
                    ELSE
                        VALIDATE("Transfer Price", Item."Unit Cost" * "Qty. per Unit of Measure");

            end;
        }
        field(50000; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Breed Master";
        }
        field(50001; "RPO Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50002; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50003; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50004; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50005; "Weak Bird Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50006; "Transit Mortality Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50007; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            Editable = true;

            trigger OnLookup()
            var
                TransHeaderRec: Record 5740;
                T5405_Loc: Record 5405;
            begin
                // PRU_AS0.003 03 JULY 2019 - start
                TransHeaderRec.RESET;
                TransHeaderRec.SETRANGE("No.", "Document No.");
                IF TransHeaderRec.FINDFIRST THEN BEGIN
                    IF TransHeaderRec.Shipped = TRUE THEN BEGIN
                        T5405_Loc.RESET;
                        T5405_Loc.SETFILTER(T5405_Loc.Status, '%1', T5405_Loc.Status::Released);
                        T5405_Loc.SETRANGE("Location Code", TransHeaderRec."Transfer-to Code");
                        IF T5405_Loc.FINDFIRST THEN
                            IF PAGE.RUNMODAL(50099, T5405_Loc) = ACTION::LookupOK THEN BEGIN
                                VALIDATE("Flock No.", T5405_Loc."No.");
                            END;
                    END
                    ELSE BEGIN
                        T5405_Loc.RESET;
                        T5405_Loc.SETFILTER(T5405_Loc.Status, '%1', T5405_Loc.Status::Released);
                        T5405_Loc.SETRANGE("Location Code", TransHeaderRec."Transfer-from Code");
                        IF T5405_Loc.FINDFIRST THEN
                            IF PAGE.RUNMODAL(50099, T5405_Loc) = ACTION::LookupOK THEN BEGIN
                                VALIDATE("Flock No.", T5405_Loc."No.");
                            END;
                    END;
                END;
                // PRU_AS0.003 03 JULY 2019 - end
            end;

            trigger OnValidate()
            var
                T5405_Loc: Record 5405;
                T50015: Record 50015;
            begin
                T5405_Loc.RESET;
                T5405_Loc.SETRANGE("No.", "Flock No.");
                IF T5405_Loc.FINDFIRST THEN
                    "Flock Description" := T5405_Loc."Description 2"
                ELSE
                    "Flock Description" := '';

                // PRU_AS0.003 02 JULY 2019 - START
                IF "Flock No." <> '' THEN BEGIN
                    T50015.RESET;
                    T50015.SETRANGE("Flock No.", "Flock No.");
                    T50015.SETRANGE(Posted, TRUE);
                    IF T50015.FINDFIRST THEN
                        ERROR('GC Statement for the selected Flock is already Posted');
                END;
                // PRU_AS0.003 02 JULY 2019 - END
            end;
        }
        field(50008; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50009; "Flock Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            Editable = false;
        }
        field(50010; "Location State code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //           CalcFormula = Lookup(Location."State Code" WHERE(Code = FIELD("Transfer-from Code")));
            Description = 'PRU_AS';
            //         FieldClass = FlowField;
        }
        field(50011; "Total Taxable Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
            Editable = false;
        }
        field(50012; "New LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New LOB';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50013; "New Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Branch';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50014; "New Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Dimension Set ID';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50015; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU_RPG NDF 0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50017; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; MRP; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
    }
    trigger OnAfterInsert()
    begin
        //>>PRU_RPG NDF_0.1
        IF TransHeader.GET(Rec."Document No.") THEN BEGIN
            "New LOB" := TransHeader."New LOB";
            "New Branch" := TransHeader."New Branch";
            "New Dimension Set ID" := TransHeader."New Dimension Set ID";
        END;
        //<<PRU_RPG NDF_0.1
    end;

    trigger OnAfterModify()
    begin
        //>>PRU_RPG NDF_0.1
        IF TransHeader.GET(Rec."Document No.") THEN BEGIN
            "New LOB" := TransHeader."New LOB";
            "New Branch" := TransHeader."New Branch";
            "New Dimension Set ID" := TransHeader."New Dimension Set ID";
        END;
        //<<PRU_RPG NDF_0.1
    end;

    var

        TransHeader: Record "Transfer Header";
}