table 50005 "Data Entry Lines"
{
    DataClassification = ToBeClassified;
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Table Designer               New Table Created.


    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Parameter No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = const(" ")) "Parameter Master" Where(Type = Filter(" ")) else
            if (Type = const(Chicks)) "Parameter Master" Where(Type = Filter(Chicks), "Responsibility Center" = field("LOB Code")) else
            if (Type = const(Feed)) "Parameter Master" Where(Type = Filter(Feed), "Responsibility Center" = field("LOB Code")) else
            if (Type = const(Medicine)) "Parameter Master" Where(Type = Filter(Medicine), "Responsibility Center" = field("LOB Code")) else
            if (Type = const(Vaccine)) "Parameter Master" Where(Type = Filter(Vaccine), "Responsibility Center" = field("LOB Code")) else
            if (Type = const(Bird)) "Parameter Master" Where(Type = Filter(Bird), "Responsibility Center" = field("LOB Code")) else
            if (Type = const(EGG)) "Parameter Master" Where(Type = Filter(EGG), "Responsibility Center" = field("LOB Code"));

            trigger OnValidate()

            begin
                recParameterMaster.RESET;
                recParameterMaster.SETRANGE("No.", "Parameter No.");
                IF recParameterMaster.FINDFIRST THEN BEGIN
                    "Parameter Description" := recParameterMaster.Description;
                    "Machine No." := recParameterMaster."Machine No.";
                    Remarks := recParameterMaster.Remarks;
                END;
            end;
        }
        field(4; "Parameter Description"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //VALIDATE("Parameter No.","Parameter Description");
            end;
        }
        field(5; "Std Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(6; "Actual Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                DEL_Loc: Record 50005;
                ConsQty: Decimal;
                RPO_Loc: Record 5405;
                ActValue: Decimal;
                OldConsQty: Decimal;
                BV_Loc: Record 50004;
                ParameterMaster: Record 50001;
            begin
                //>>PRU_RPG RSE_0.1

                IF xRec."Actual Value" <> "Actual Value" THEN
                    "Applies From Entry No." := 0;
                IF ParameterMaster.GET(Rec."Parameter No.") THEN BEGIN
                    IF ParameterMaster."Reversal Entry" = TRUE THEN BEGIN
                        IF Rec."Actual Value" > 0 THEN
                            ERROR('Reversal entry must have actual value in negative');
                    END;
                END;
                IF ParameterMaster.GET(Rec."Parameter No.") THEN BEGIN
                    IF ParameterMaster."Reversal Entry" = FALSE THEN BEGIN
                        IF Rec."Actual Value" < 0 THEN
                            ERROR('Actaul Value have to be Positive only');
                    END;
                END;

                //<PRU_RPG RSE_0.1

                IF "Item No." <> '' THEN BEGIN
                    IF "Machine No." = '' THEN BEGIN
                        "Unit Cost" := CalcUnitCost(Rec);
                        "Line Amount" := "Actual Value" * "Unit Cost";
                    END ELSE BEGIN
                        IF Machine.GET("Machine No.") THEN
                            "Unit Cost" := Machine."Unit Cost";
                        "Line Amount" := "Actual Value" * "Unit Cost";
                    END;
                END;
                RPO_Loc.GET(RPO_Loc.Status::Released, "Flock No.");
                BV_Loc.RESET;
                BV_Loc.SETRANGE("Breed Code", RPO_Loc."Breed Code");
                IF BV_Loc.FINDFIRST THEN;
                DataEntry.RESET;
                DataEntry.SETRANGE("Document Type", DataEntry."Document Type"::Hatchery);
                DataEntry.SETRANGE("No.", "Document No.");
                ////DataEntry.SETFILTER(Stage,'%1|%2|%3',DataEntry.Stage::Hatcher,DataEntry.Stage::Setter,DataEntry.Stage::Production);
                DataEntry.SETFILTER(Stage, '%1|%2', DataEntry.Stage::Hatcher, DataEntry.Stage::Setter);///,DataEntry.Stage::Production);
                IF DataEntry.FINDFIRST THEN BEGIN
                    CLEAR(ConsQty);
                    T5406.RESET;
                    T5406.SETRANGE("Prod. Order No.", DataEntry."Flock No.");
                    IF T5406.FINDFIRST THEN BEGIN
                        IF ("Item No." = RPO_Loc."Source No.") OR ("Item No." = BV_Loc."Consumption Item No.") THEN BEGIN
                            IF Param.GET(DEL_Loc."Parameter No.") THEN;
                            IF Param."Type of Parameter" = Param."Type of Parameter"::" " THEN
                                ActValue := "Actual Value";
                        END;
                    END;
                    DEL_Loc.RESET;
                    DEL_Loc.SETRANGE("Document No.", DataEntry."No.");
                    DEL_Loc.SETFILTER("Item No.", '%1|%2', RPO_Loc."Source No.", BV_Loc."Consumption Item No.");
                    DEL_Loc.SETRANGE("Production Order Quantity", FALSE);
                    DEL_Loc.SETFILTER("Line No.", '<>%1', "Line No.");
                    IF DEL_Loc.FINDFIRST THEN
                        REPEAT
                            CLEAR(Param);
                            IF Param.GET(DEL_Loc."Parameter No.") THEN;
                            IF Param."Type of Parameter" = Param."Type of Parameter"::" " THEN
                                ConsQty += DEL_Loc."Actual Value";
                        UNTIL DEL_Loc.NEXT = 0;
                    ILE.RESET;
                    ILE.SETRANGE("Document No.", "Flock No.");
                    ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                    ILE.CALCSUMS(Quantity);
                    OldConsQty := ABS(ILE.Quantity);
                    DataEntryLine.RESET;
                    DataEntryLine.SETRANGE("Document No.", "Document No.");
                    DataEntryLine.SETRANGE("Production Order Quantity", TRUE);
                    IF DataEntryLine.FINDFIRST THEN
                        REPEAT
                            DataEntryLine."Actual Value" := poc."Remaining Quantity";
                            DataEntryLine.MODIFY;
                        UNTIL DataEntryLine.NEXT = 0;
                END;
                DataEntry.RESET;
                DataEntry.SETRANGE("Document Type", DataEntry."Document Type"::Hatchery);
                DataEntry.SETRANGE("No.", "Document No.");
                ////DataEntry.SETFILTER(Stage,'%1|%2|%3',DataEntry.Stage::Hatcher,DataEntry.Stage::Setter,DataEntry.Stage::Production);
                DataEntry.SETFILTER(Stage, '%1', DataEntry.Stage::Production);
                IF DataEntry.FINDFIRST THEN BEGIN
                    IF "Parameter No." = 'PARA-015' THEN BEGIN
                        IF "Actual Value" > DataEntry."Remaining Eggs" THEN
                            ERROR('Actual Value %1 can be greater than %2', "Actual Value", DataEntry."Remaining Eggs");
                        DEL_Loc.RESET;
                        DEL_Loc.SETRANGE("Document No.", "Document No.");
                        DEL_Loc.SETRANGE("Parameter No.", 'PARA-010');
                        IF DEL_Loc.FINDFIRST THEN BEGIN
                            DEL_Loc."Actual Value" := "Actual Value";
                            DEL_Loc.MODIFY;
                        END;
                    END;
                    IF "Parameter No." = 'PARA-010' THEN BEGIN
                        DEL_Loc.RESET;
                        DEL_Loc.SETRANGE("Document No.", "Document No.");
                        DEL_Loc.SETRANGE("Parameter No.", 'PARA-015');
                        IF DEL_Loc.FINDFIRST THEN BEGIN
                            IF "Actual Value" > DEL_Loc."Actual Value" THEN
                                ERROR('Actual Value for Baby chicks %1 can not be greater than %2', "Actual Value", DEL_Loc."Actual Value");
                        END;
                    END;
                END;

            end;
        }
        field(7; "Input Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prod. Order No.';
        }
        field(9; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(10; "Shed No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            //TableRelation =IF ("Type of Parameter" = const("Output"))
            TableRelation = IF ("Type of Parameter" = const("Output")) Item."No." Where("Location Filter" = field("Location Code"), "CBF Data Entry Item filter" = field(Type))
            Else
            if ("Parameter No." = Filter('<>PARA-030')) Item."No." Where("Net Change" = filter(<> 0), "Location Filter" = field("Location Code"), "CBF Data Entry Item filter" = field(Type))
            else
            if ("Parameter No." = const('PARA-030')) Item."No." Where("Location Filter" = field("Location Code"), "CBF Data Entry Item filter" = field(Type));

            trigger OnValidate()
            begin
                "Item Description" := '';
                CLEAR(T27);
                IF T27.GET("Item No.") THEN;
                "Item Description" := T27.Description;
                "Unit of Measure Code" := T27."Base Unit of Measure";
            end;
        }
        field(12; "Sub Items"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Template No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Template Master Header"."Template No.";
        }
        field(14; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnValidate()
            begin
                /*
                IF Posted = TRUE THEN
                  ERROR(Text50002);
                */

            end;
        }
        field(15; "Flock Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin;
        }
        field(17; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data Entry Sheet"."No.";
        }
        field(18; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Machine Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Breed No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Template Master Line"."Template No.";
        }
        field(21; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Additional Unit Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(24; "Additional Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
            TableRelation = "Unit of Measure";
        }
        field(25; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Production Order Quantity"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Unit of Measure Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Unit of Measure";
        }
        field(28; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Diseases; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG RSE_0.1';

            trigger OnLookup()
            var
                ReasonCode: Record 231;
            begin
                //>>PRU_RPG RSE_0.1
                ReasonCode.RESET;
                //ReasonCode.SETRANGE(Hatchery,FALSE);

                IF ReasonCode.FINDSET THEN BEGIN
                    IF PAGE.RUNMODAL(50103, ReasonCode) = ACTION::LookupOK THEN BEGIN
                        Rec.VALIDATE(Diseases, ReasonCode.Code);
                    END;
                END;

                //<<PRU_RPG RSE_0.1
            end;

            trigger OnValidate()
            begin

                Dis.RESET;
                Dis.SETRANGE(Code, Diseases);
                IF NOT Dis.FINDFIRST THEN
                    ERROR('Please enter the correct Disease');
            end;
        }
        field(31; "Mortality Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female,Neuter';
            OptionMembers = " ",Male,Female,Neuter;
        }
        field(32; "Exclude Quantity of Mortality"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Remaining Quantity"; Decimal)
        {

            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code")));
            Description = 'PRU-VG';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Reverse Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Applies From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG RSE_0.1';

            trigger OnLookup()
            var
                ItemLedgerEntry: Record 32;
            begin
                //>>PRU_RPG RSE_0.1
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Document No.", Rec."Flock No.");
                ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SETRANGE("Location Code", Rec."Location Code");
                ItemLedgerEntry.SETRANGE(Positive, FALSE);
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                    IF PAGE.RUNMODAL(38, ItemLedgerEntry) = ACTION::LookupOK THEN BEGIN
                        Rec."Applies From Entry No." := ItemLedgerEntry."Entry No.";
                    END;
                END ELSE
                    ERROR('There is no entry for this Item to do reversal');
                //<<PRU_RPG RSE_0.1
            end;

            trigger OnValidate()
            var
                ItemLedgerEntry: Record 32;
            begin
                //>>PRU_RPG RSE_0.1
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Document No.", Rec."Flock No.");
                ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SETRANGE("Location Code", Rec."Location Code");
                ItemLedgerEntry.SETRANGE(Positive, FALSE);
                ItemLedgerEntry.SETRANGE("Entry No.", Rec."Applies From Entry No.");
                IF NOT ItemLedgerEntry.FINDSET THEN
                    ERROR('There is no entry no in Item Ledger Entry');
                //<<PRU_RPG RSE_0.1
            end;
        }
        field(38; "Output Item No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';

            trigger OnValidate()
            var
                Item_Rec: Record 27;
            begin
                //>>PRU_RPG MNF_0.1

                IF Item_Rec.GET("Output Item No.") THEN
                    "Output Item Description" := Item_Rec.Description
                ELSE
                    "Output Item Description" := '';
                //<<PRU_RPG MNF_0.1
            end;
        }
        field(39; "Output Item Description"; Text[50])
        {

            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(40; "Data Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Mortality - Bird,Mortality - Chicks,Culls - Bird,Culls - Chicks,Sexing Error,Bird - Sale,Infertile Egg-Hatch,Culls-Hatch,Baby Chicks-Hatch,Settable Egg-Hatch,Cracked Egg-Hatch,Waste Egg-Hatch,Commercial Eggs';
            OptionMembers = " ","Mortality - Bird","Mortality - Chicks","Culls - Bird","Culls - Chicks","Sexing Error","Bird - Sale","Infertile Egg-Hatch","Culls-Hatch","Baby Chicks-Hatch","Settable Egg-Hatch","Cracked Egg-Hatch","Waste Egg-Hatch","Commercial Eggs";
        }
        field(41; "Laying Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Hatching Egg,Pullet Egg,Jumbo Egg,Crack Egg,Waste Egg,Misshapes Egg';
            OptionMembers = " ","Hatching Egg","Pullet Egg","Jumbo Egg","Crack Egg","Waste Egg","Misshapes Egg";
        }
        field(42; "Hatching Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Culls,Mortality,Dead in Shell,Egg Blast,Settable Egg, Salable Eggs,Hatchable Egg,Reject/Unhatched Egg,Infertile/Commercial Egg';
            OptionMembers = " ",Culls,Mortality,"Dead in Shell","Egg Blast","Settable Egg"," Salable Eggs","Hatchable Egg","Reject/Unhatched Egg","Infertile/Commercial Egg";
        }
        field(43; "Descriptive Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Weight Neuter,Weight Male,Weight Female,Temperature,CV,Water,Humidity,Lighting';
            OptionMembers = " ","Weight Neuter","Weight Male","Weight Female",Temperature,CV,Water,Humidity,Lighting;
        }
        field(44; "Stock Available"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG';
            OptionMembers = " ",Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG;
        }
        field(46; "Type of Parameter"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
            OptionCaption = ' ,Consumption,Output,Direct/Indirect Cost,Descriptive';
            OptionMembers = " ",Consumption,Output,"Direct/Indirect Cost",Descriptive;
        }
        field(47; "LOB Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Flock No.", "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
        key(Key3; "Location Code", "Flock No.", "Shed No.", "Item No.", "Template No", "Posting Date")
        {
            Clustered = true;
        }
        key(Key4; "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN
            ERROR(Text50001);
    end;

    trigger OnModify()
    begin
        /*IF Posted = TRUE THEN
          ERROR(Text50002);
        */

    end;

    var
        recParameterMaster: Record 50001;
        Text50001: Label 'You Cannot Delete the Posted Lines…!';
        Text50002: Label 'You Cannot Modify the Posted Lines…!';
        Text50003: Label 'You Cannot Add Machine for this Parameter...!';
        AvgCost: Decimal;
        Machine: Record 99000758;
        DataEntry: Record 50003;
        DataEntryLine: Record 50005;
        Param: Record 50001;
        T5406: Record 5406;
        T27: Record 27;
        ILE: Record 32;
        poc: Record 5407;
        Dis: Record 231;


    procedure HatcheryDistribution()
    var
        TotalQuantity: Decimal;
    begin
        IF "Machine Required" = FALSE THEN
            ERROR(Text50003);
    end;


    procedure AssignLotNumber()
    begin
        TESTFIELD("Posting Date");
        TESTFIELD("Parameter No.");
        TESTFIELD("Item No.");
        TESTFIELD("Actual Value");
        CallItemTracking(Rec);
    end;


    procedure ItemTracking(var RecDataEntryLines: Record 50005; var TrackingSpecification: Record 336)
    var
        ite: Record "Item Journal Line";
        "Farm Location": Code[10];
        "Data Entry No.": Code[10];
        JournalTamplate: Code[10];
        "Batch Name": Code[10];
        ParameterMaster: Record 50001;
        ParameterType: Text[30];
        recDataEntry: Record 50003;
        MfgSetup: Record 99000765;
        FlockNo: Code[20];
        TrackingSpecification1: Record "Tracking Specification";
    begin
        MfgSetup.GET;
        CLEAR("Farm Location");
        CLEAR(JournalTamplate);
        CLEAR("Batch Name");
        CLEAR(FlockNo);

        recDataEntry.RESET;
        recDataEntry.SETRANGE("No.", "Document No.");
        IF recDataEntry.FINDFIRST THEN BEGIN
            "Farm Location" := recDataEntry."Farm/Location";
            JournalTamplate := recDataEntry."Journal Template Name";
            "Batch Name" := recDataEntry."Journal Batch Name";
            FlockNo := recDataEntry."Flock No.";
        END;

        IF RecDataEntryLines."Actual Value" > 0 THEN BEGIN
            ParameterMaster.SETRANGE("No.", RecDataEntryLines."Parameter No.");
            IF ParameterMaster.FINDFIRST THEN;
            ParameterType := FORMAT(ParameterMaster."Type of Parameter");
            //Message('%1..%2..%3', ParameterType, RecDataEntryLines."Parameter No.", RecDataEntryLines."Item No.");
            //Consumption..PARA-227..MED0192
            IF ParameterType = 'Consumption' THEN BEGIN
                TrackingSpecification.INIT;
                TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
                TrackingSpecification."Entry No." += 1;
                TrackingSpecification."Item No." := "Item No.";
                TrackingSpecification."Location Code" := "Farm Location";
                TrackingSpecification."Source Subtype" := 5;
                //   TrackingSpecification."Source ID" := 'CONSUMP';
                // if RecDataEntryLines."Posting Date" <= 20250331D Then
                //if StrLen(RecDataEntryLines."Document No.") = 15 Then
                TrackingSpecification."Source ID" := DelChr(CopyStr(RecDataEntryLines."Document No.", 5, 12), '=', '/');

                // if StrLen(RecDataEntryLines."Document No.") = 16 Then
                //     TrackingSpecification."Source ID" := DelChr(CopyStr(RecDataEntryLines."Document No.", 5, 12), '=', '/');

                // Else
                //     TrackingSpecification."Source ID" := 'Prod.Order';
                // TrackingSpecification."Source Batch Name" := 'CONSUMP';
                TrackingSpecification."Source Batch Name" := 'DEFAULT';
                //TrackingSpecification."Source Batch Name" := UserId;
                TrackingSpecification.Description := "Parameter Description";
                TrackingSpecification."Creation Date" := RecDataEntryLines."Posting Date";
                TrackingSpecification."Qty. per Unit of Measure" := 1;
                //    TrackingSpecification."Quantity (Base)" := "Actual Value" * 1;
                TrackingSpecification."Source Prod. Order Line" := 0;
                TrackingSpecification."Source Ref. No." := "Line No.";
                TrackingSpecification."Quantity (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Handle" := "Actual Value";
                TrackingSpecification."Qty. to Handle (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Invoice" := "Actual Value";
                TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value";
                TrackingSpecification."Quantity Handled (Base)" := "Actual Value";
                TrackingSpecification."Quantity Invoiced (Base)" := "Actual Value";
                //TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
                //TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value"*"Qty. per Unit of Measure";
                //TrackingSpecification."Quantity Invoiced (Base)" := "Actual Value"*"Qty. per Unit of Measure";
                //TrackingSpecification."Qty. to Invoice" := "Actual Value"*"Qty. per Unit of Measure";
                // TrackingSpecification.INSERT;



            END;
            IF ParameterType = 'Output' THEN BEGIN
                TrackingSpecification.INIT;
                TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
                TrackingSpecification."Entry No." += 1;
                TrackingSpecification."Item No." := "Item No.";
                TrackingSpecification."Location Code" := "Farm Location";
                TrackingSpecification."Source Subtype" := 6;
                TrackingSpecification."Source ID" := RecDataEntryLines."Document No.";
                //    TrackingSpecification."Source ID" := RecDataEntryLines."Document No.";
                TrackingSpecification."Source Batch Name" := 'DEFAULT';
                TrackingSpecification.Description := "Parameter Description";
                TrackingSpecification."Creation Date" := "Posting Date";
                TrackingSpecification."Quantity (Base)" := "Actual Value" * 1;
                TrackingSpecification."Source Prod. Order Line" := 0;
                TrackingSpecification."Source Ref. No." := "Line No.";
                TrackingSpecification."Qty. per Unit of Measure" := 1;
                TrackingSpecification."Quantity (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Handle" := "Actual Value";
                TrackingSpecification."Qty. to Handle (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Invoice" := "Actual Value";
                TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value";
                TrackingSpecification."Quantity Handled (Base)" := 0;
                TrackingSpecification."Quantity Invoiced (Base)" := 0;
                // TrackingSpecification.INSERT;
            END;

            IF ParameterType = 'Production' THEN BEGIN
                TrackingSpecification.INIT;
                TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
                TrackingSpecification."Entry No." += 1;
                TrackingSpecification."Item No." := "Item No.";
                TrackingSpecification."Location Code" := "Farm Location";
                TrackingSpecification."Source Subtype" := 6;
                TrackingSpecification."Source ID" := RecDataEntryLines."Document No.";
                TrackingSpecification."Source Batch Name" := MfgSetup."Output Batch Name";
                TrackingSpecification.Description := "Parameter Description";
                TrackingSpecification."Creation Date" := "Posting Date";
                TrackingSpecification."Quantity (Base)" := "Actual Value" * 1;
                TrackingSpecification."Source Prod. Order Line" := 0;
                TrackingSpecification."Source Ref. No." := "Line No.";
                TrackingSpecification."Qty. per Unit of Measure" := 1;
                TrackingSpecification."Quantity (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Handle" := "Actual Value";
                TrackingSpecification."Qty. to Handle (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Invoice" := "Actual Value";
                TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value";
                TrackingSpecification."Quantity Handled (Base)" := 0;
                TrackingSpecification."Quantity Invoiced (Base)" := 0;
                //   TrackingSpecification.INSERT;
                /*
                TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value"*"Qty. per Unit of Measure";
                //TrackingSpecification."Quantity Invoiced (Base)" := "Actual Value"*"Qty. per Unit of Measure";
                TrackingSpecification."Qty. to Invoice" := "Actual Value"*"Qty. per Unit of Measure";
                */
            END;
        END;

    end;



    procedure CallItemTracking(var DataEntryLine: Record 50005)
    var
        TrackingSpecification: Record 336;
        ItemTrackingPage: Page 6510;
        ItemJnlLine: Record 83;
        SOP: Page "Sales Order Subform";
    begin
        ItemTracking(DataEntryLine, TrackingSpecification);
        ItemTrackingPage.SetSourceSpec(TrackingSpecification, DataEntryLine."Posting Date");
        ItemTrackingPage.SetInbound(FALSE);
        COMMIT;
        ItemTrackingPage.RUNMODAL;
    end;

    local procedure CalcUnitCost(var Para50005: Record 50005): Decimal
    var
        QtyAccum: Decimal;
        CostAmtAccumulated: Decimal;
        ValueEntry: Record 5802;
        ItemRec: Record 27;
        DataEntryLoc: Record 50003;
    begin

        DataEntryLoc.RESET;
        DataEntryLoc.SETRANGE("No.", Para50005."Document No.");
        IF DataEntryLoc.FINDFIRST THEN;
        IF ItemRec.GET(Para50005."Item No.") THEN BEGIN
            IF Para50005."Item No." = DataEntryLoc."Item No." THEN
                EXIT(DataEntryLoc."Running Cost")
            ELSE
                EXIT(ItemRec."Unit Cost");
        END;

    end;
}

