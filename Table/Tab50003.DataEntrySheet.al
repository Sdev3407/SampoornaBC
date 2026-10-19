table 50003 "Data Entry Sheet"
{
    DataClassification = ToBeClassified;
    Caption = 'Data Entry Sheet';
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Table Designer               New Table Created.


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    //GeneralLedgerSetup.GET;
                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("Responsibility Center");
                    GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
                "Entry Date" := WORKDATE;
            end;
        }
        field(2; "Farm/Location"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = IF ("Shortcut Dimension 1 Code" = FILTER('CBF')) Location WHERE("Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
                                                                                          Block = CONST(false),
                                                                                          "Line No." = FIELD("Line Code"))
            ELSE
            IF ("Shortcut Dimension 1 Code" = FILTER(<> 'CBF')) Location WHERE("Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
                                                                                                                                                            Block = CONST(false));

            //TableRelation = Location;
            trigger OnValidate()
            begin
                Location.GET("Farm/Location");
                "Farmer No" := Location."Farmer Code";
                "Farm Name" := Location.Name;
                IF Vendor.GET("Farmer No") THEN
                    "Farmer Name" := Vendor.Name;


                IF "Farm/Location" <> '' THEN BEGIN
                    IF "Flock No." <> '' THEN BEGIN
                        IF xRec."Farm/Location" <> Rec."Farm/Location" THEN
                            ERROR('You do not change the old location')
                    END;
                END;
                Companyinfo.Get;
                If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
                    Rec.VALIDATE("Shortcut Dimension 3 Code", "Farm/Location");

            end;
        }
        field(3; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released),
                                                          "Location Code" = FIELD("Farm/Location"),
                                                          "Short Close" = FILTER(false));

            trigger OnValidate()
            var
                GCStat_Loc: Record 50015;
                T5407_Loc: Record 5407;
                ILE: Record 32;
            begin

                IF xRec."Flock No." <> '' THEN BEGIN
                    IF xRec."Flock No." <> Rec."Flock No." THEN BEGIN
                        DataEntryLine.RESET;
                        DataEntryLine.SETRANGE("Document No.", "No.");
                        IF DataEntryLine.FINDFIRST THEN
                            DataEntryLine.DELETEALL;
                    END;
                END;

                //PRU-VG 20022019
                IF "Document Type" = "Document Type"::"Data Entry" THEN BEGIN
                    GCStat_Loc.RESET;
                    GCStat_Loc.SETRANGE("Flock No.", "Flock No.");
                    GCStat_Loc.SETRANGE(Posted, TRUE);
                    IF GCStat_Loc.FINDFIRST THEN
                        ERROR('GC Statement is already Posted for Flock No. %1', "Flock No.");
                END;
                //PRU-VG 20022019

                DataEntryLine.RESET;
                DataEntryLine.SETRANGE("Document No.", "No.");
                DataEntryLine.SETRANGE(Posted, FALSE);
                IF DataEntryLine.FINDFIRST THEN
                    DataEntryLine.DELETEALL;



                IF RPO.GET(RPO.Status::Released, "Flock No.") THEN BEGIN
                    IF RPO."Shortcut Dimension 1 Code" = 'CBF' THEN BEGIN
                        RPO.TESTFIELD("Hatchery No.");
                    END;
                    IF RPO."Shortcut Dimension 1 Code" = 'HATCH' THEN BEGIN
                        RPO.TESTFIELD("STD %");
                        RPO.TESTFIELD("Laying EGG Week");
                    END;
                    IF RPO."Shortcut Dimension 1 Code" = 'CBF' THEN BEGIN
                        RPO.TESTFIELD("Description 2");
                    END;
                    "Hatching Date" := RPO."Hatching Date";
                    "Production Date" := RPO."Starting Date";
                    "STD %" := RPO."STD %";  //Pru_gk
                    "Laying EGG Week" := RPO."Laying EGG Week"; //Pru_gk
                    "User ID" := USERID;
                    "Entry Date" := WORKDATE;
                    //"Farm Location" := RPO."Location Code";
                    IF "Document Type" = "Document Type"::"Data Entry" THEN
                        VALIDATE("Breed Code", RPO."Breed Code")
                    ELSE BEGIN
                        IF RPO."Source Type" = RPO."Source Type"::Item THEN
                            "Item No." := RPO."Source No.";
                        //RequiredValidation1(Stage);
                    END;
                    ResEntry.RESET;
                    ResEntry.SETRANGE("Source ID", '5407');
                    ResEntry.SETRANGE("Source Subtype", 3);
                    ResEntry.SETRANGE("Source ID", "Flock No.");
                    IF ResEntry.FINDFIRST THEN
                        "Lot No." := ResEntry."Lot No.";
                END;

                "PS DOC Placing Date" := RPO."DOC Placing Date";

                IF (Rec."Document Type" = Rec."Document Type"::"Data Entry") THEN BEGIN
                    Age := ("Entry Date" - "PS DOC Placing Date");
                    "Age (Week)" := ROUND(Age / 7, 1, '>');
                END ELSE BEGIN
                    Age := 0;
                    "Age (Week)" := 0;
                END;
                //<<PRU_RPG MNF_0.1

                IF "Document Type" = "Document Type"::Hatchery THEN BEGIN
                    IF RPO.GET(RPO.Status::Released, "Flock No.") THEN BEGIN
                        T5407_Loc.RESET;
                        T5407_Loc.SETRANGE("Prod. Order No.", RPO."No.");
                        IF T5407_Loc.FINDFIRST THEN;
                        ILE.RESET;
                        ILE.SETRANGE("Document No.", RPO."No.");
                        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.SETRANGE("Item Type", ILE."Item Type"::Egg);
                        ILE.SETRANGE("Item No.", T5407_Loc."Item No.");
                        ILE.CALCSUMS(Quantity);
                        "Remaining Eggs" := RPO.Quantity - ABS(ILE.Quantity);
                    END;
                END;

            end;
        }
        field(4; "Shed No."; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Shed A,Shed B';
            OptionMembers = " ","Shed A","Shed B";
        }
        field(5; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,A,B,C,D,Default';
            OptionMembers = " ",A,B,C,D,Default;

            trigger OnValidate()
            begin


            end;
        }
        field(6; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Hatching Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Production Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Last Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(13; "Flock Item Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Farmer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE(Farmer = FILTER(true));

            trigger OnValidate()
            var
                ContactRec: Record 5050;
                Vend: Record 23;
            begin

                IF Vend.GET("Farmer No") THEN
                    "Farmer Name" := Vend.Name;

            end;
        }
        field(15; "Farmer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Supervisor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Area Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Cluster; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin;
        }
        field(20; "Lot No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Breed Master"."Breed Code";

            trigger OnValidate()
            begin
                BreedVariation.RESET;
                BreedVariation.SETRANGE("Breed Code", "Breed Code");
                //BreedVariation.SETRANGE("Type of Line","Line Type");
                IF BreedVariation.FINDFIRST THEN BEGIN
                    "Line Type" := BreedVariation."Type of Line";
                    "Item No." := BreedVariation."Item No.";
                    Quantity := GetQuantity;
                    IF (Quantity = 0) THEN
                        ERROR('Quantity must not be Zero');
                    "Total Cost" := CalcTotalCost(Rec);
                    "Running Cost" := "Total Cost" / Quantity;
                    IF "Document Type" = "Document Type"::"Data Entry" THEN BEGIN
                        RequiredValidation("Document Type");
                    END ELSE
                        RequiredValidation1(Stage::" ");

                END;
            end;
        }
        field(22; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Data Entry,Hatchery';
            OptionMembers = "Data Entry",Hatchery;
        }
        field(23; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template".Name;
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(FALSE));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(28; "Egg Set Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Setter,Hatcher,Production';
            OptionMembers = " ",Setter,Hatcher,Production;

            trigger OnValidate()
            begin
                TESTFIELD("Flock No.");
                IF Stage = Stage::Setter THEN BEGIN
                    DataEntry.RESET;
                    DataEntry.SETRANGE("Document Type", Rec."Document Type"::Hatchery);
                    DataEntry.SETFILTER("No.", '<>%1', "No.");
                    DataEntry.SETRANGE("Flock No.", "Flock No.");
                    DataEntry.SETRANGE(Stage, DataEntry.Stage::Setter);
                    IF DataEntry.FINDFIRST THEN
                        ERROR('Setter Entry Already Created');

                END;
                IF Stage = Stage::Hatcher THEN BEGIN
                    DataEntry.RESET;
                    DataEntry.SETRANGE("Document Type", Rec."Document Type"::Hatchery);
                    DataEntry.SETFILTER("No.", '<>%1', "No.");
                    DataEntry.SETRANGE("Flock No.", "Flock No.");
                    DataEntry.SETRANGE(Stage, DataEntry.Stage::Hatcher);
                    IF DataEntry.FINDFIRST THEN
                        ERROR('Hatcher Entry Already Created');
                END;

                IF Stage = Stage::Production THEN BEGIN
                    DataEntry.RESET;
                    DataEntry.SETRANGE("Document Type", Rec."Document Type"::Hatchery);
                    ////DataEntry.SETFILTER("No.",'<>%1',"No.");
                    DataEntry.SETRANGE("Flock No.", "Flock No.");
                    DataEntry.SETFILTER(Stage, '%1|%2', DataEntry.Stage::Setter, DataEntry.Stage::Hatcher);
                    DataEntry.SETRANGE(Posted, TRUE);
                    IF NOT DataEntry.FINDFIRST THEN
                        ERROR('Setter and Hatcher Entry Not Posted');

                END;
                IF Stage = Stage::Hatcher THEN BEGIN
                    DataEntry.RESET;
                    DataEntry.SETRANGE("Document Type", Rec."Document Type"::Hatchery);
                    DataEntry.SETFILTER("No.", '<>%1', "No.");
                    DataEntry.SETRANGE("Flock No.", "Flock No.");
                    DataEntry.SETRANGE(Stage, DataEntry.Stage::Setter);
                    DataEntry.SETRANGE(Posted, TRUE);
                    IF DataEntry.FINDFIRST THEN BEGIN
                        "Entry Date" := CALCDATE('18D', DataEntry."Entry Date");
                        "Egg Set Date" := DataEntry."Egg Set Date";
                    END ELSE
                        ERROR('Entry Not Posted with Setter Stage for %1 Flock No.', DataEntry."Flock No.");
                END;
                IF Stage = Stage::Production THEN BEGIN
                    DataEntry.RESET;
                    DataEntry.SETRANGE("Document Type", Rec."Document Type"::Hatchery);
                    DataEntry.SETFILTER("No.", '<>%1', "No.");
                    DataEntry.SETRANGE("Flock No.", "Flock No.");
                    DataEntry.SETRANGE(Stage, DataEntry.Stage::Hatcher);
                    IF DataEntry.FINDFIRST THEN BEGIN
                        "Entry Date" := CALCDATE('3D', DataEntry."Entry Date");
                        "Egg Set Date" := DataEntry."Egg Set Date";
                    END ELSE
                        ERROR('Entry Not Posted with Hatcher Stage for %1 Flock No.', DataEntry."Flock No.");
                END;

            end;
        }
        field(30; "Responsibility Center"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-RC';
            TableRelation = "Responsibility Center";
        }
        field(31; "Running Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(36; Age; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Setter/Hatcher"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Setter-1,Setter-2,Setter-3,Setter-4,Setter-5,Setter-6,Setter-7,Setter-8,Setter-9,Setter-10,Hatcher-1,Hatcher-2,Setter-11,Setter-12,Hatcher-3';
            OptionMembers = " ","Setter-1","Setter-2","Setter-3","Setter-4","Setter-5","Setter-6","Setter-7","Setter-8","Setter-9","Setter-10","Hatcher-1","Hatcher-2","Setter-11","Setter-12","Hatcher-3";
        }
        field(38; "Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(50000; "STD %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50001; "Laying EGG Week"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
        }
        field(50003; "Remaining Eggs"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "PS DOC Placing Date"; Date)
        {
            Caption = 'PS DOC Placing Date';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(50005; "Age (Week)"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG MNF_0.1';
        }
        field(50006; "Line Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "Line Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Line Name (CBF)"."Line Code" WHERE("Branch Code" = FIELD("Shortcut Dimension 2 Code"));

            trigger OnValidate()
            begin

                IF "Line Code" <> xRec."Line Code" THEN BEGIN
                    "Farm/Location" := '';
                    "Farm Name" := '';
                    "Flock No." := '';
                END;

                LineNameCBF.RESET;
                LineNameCBF.SETRANGE("Line Code", "Line Code");
                IF LineNameCBF.FINDFIRST THEN
                    "Line Name" := LineNameCBF."Line Discription";
            end;
        }
        field(50008; "Farm Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DataEntryLines: Record 50005;
    begin
        DataEntryLines.RESET;
        DataEntryLines.SETRANGE("Document No.", "No.");
        IF DataEntryLines.FINDSET THEN
            DataEntryLines.DELETEALL;
    end;

    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create Data Entry Sheet');
        //PRU_DD 1.10

        //GeneralLedgerSetup.GET;
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        GeneralLedgerSetup.GET(UserSetup."Responsibility Center");
        IF "No." = '' THEN BEGIN
            //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Data Sheet Nos");
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
        END;
        /*
        //PRU-RC >>
        UserSetup.GET(USERID);
        RCSetup.GET(UserSetup."Responsibility Center");
        "Responsibility Center" := UserMgt.GetRespCentre();
        VALIDATE("Shortcut Dimension 1 Code",UserSetup."Shortcut Dimension 1 Code");
        //PRU-RC <<
        */
        Rec.VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        //Rec.VALIDATE("Farm/Location",UserSetup."Shortcut Dimension 3 Code");

        UserSetup.GET(USERID);
        IF UserSetup."CBF Line No." <> '' THEN
            Rec.VALIDATE("Line Code", UserSetup."CBF Line No.");

    end;

    var

    var
        Companyinfo: Record "Company Information";
        recItem: Record 27;
        GeneralLedgerSetup: Record 5714;
        NoSeriesMgt: Codeunit 396;
        RespCenter: Record 5714;
        UserSetup: Record 91;
        RCSetup: Record 5714;
        UserMgt: Codeunit 5700;
        RPO: Record 5405;
        BreedVariation: Record 50004;
        ResEntry: Record 337;
        ConsumptionQty: Decimal;
        OtptQty: Decimal;
        DimMgt: Codeunit 408;
        DataEntry: Record 50003;
        UOMMgt: Codeunit 5402;
        Vendor: Record 23;
        Location: Record 14;
        DataEntryLine: Record 50005;
        LineNameCBF: Record 50033;


    procedure AssistEdit(OldDataSheet: Record 50003): Boolean
    var
        DataSheet: Record 50003;
    begin
        WITH DataSheet DO BEGIN
            DataSheet := Rec;
            //GeneralLedgerSetup.GET;
            UserSetup.GET(USERID);
            UserSetup.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(UserSetup."Responsibility Center");

            //GeneralLedgerSetup.TESTFIELD("Data Sheet Nos");
            TestNoSeries;
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldDataSheet."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := DataSheet;
                EXIT(TRUE);
            END;
        END;
    end;


    procedure EnterDetails(Stage: Option " ",Hatcher,Setter,Production)
    var
        RecDataEntryLines1: Record 50005;
        LineNo: Integer;
        TemplateNo: Code[20];
        HatchngDate: Date;
        DateDiff: Integer;
        WeekDiff: Decimal;
        MonthDiff: Decimal;
        YearDiff: Decimal;
        RecDataEntryLines: Record 50005;
        recTemplateMasterLines: Record 50006;
        Text50001: Label 'Please Define Hatching Date In Flock %1.';
        recTemplateMasterHeader: Record 50002;
        BreedVariationRec: Record 50004;
        recFlockMaster: Record 5405;
        T5406: Record 5406;
        ParameterMaster: Record 50001;
        Item: Record 27;
        ParameterMaster_Loc: Record 50001;
        ItemLedgerEntry: Record 32;
        ItemCheck: Boolean;
        MachineCenter: Record 99000758;
        ProdOrderLine: Record 5406;
        Param: Record "Parameter Master";
    begin
        IF "Document Type" = "Document Type"::Hatchery THEN BEGIN
            RequiredValidation1(Stage)
        END ELSE BEGIN
            TESTFIELD("Flock No.");
            TESTFIELD("Breed Code");
            TESTFIELD("Line Type");

            //PRUSB 180315 BEGIN
            RecDataEntryLines1.RESET;
            RecDataEntryLines1.SETCURRENTKEY("Line No.");
            RecDataEntryLines1.SETRANGE("Document No.", "No.");
            IF RecDataEntryLines1.FINDLAST THEN
                LineNo := RecDataEntryLines1."Line No.";

            //***** Get Templates Code From Breed Variation *****
            BreedVariationRec.RESET;
            BreedVariationRec.SETRANGE("Breed Code", "Breed Code");
            BreedVariationRec.SETRANGE("Type of Line", "Line Type");
            IF BreedVariationRec.FINDFIRST THEN
                TemplateNo := BreedVariationRec."Template No.";

            recFlockMaster.RESET;
            recFlockMaster.SETRANGE("No.", "Flock No.");
            IF recFlockMaster.FINDFIRST THEN
                IF recFlockMaster."Hatching Date" <> 0D THEN
                    HatchngDate := recFlockMaster."DOC Placing Date"   //PRU_RPG MNF_0.1
                                                                       //HatchngDate := recFlockMaster."Hatching Date"
                ELSE
                    ERROR(Text50001, "Flock No.");

            DateDiff := WORKDATE - HatchngDate;
            WeekDiff := (WORKDATE - HatchngDate) / 7;
            MonthDiff := (WORKDATE - HatchngDate) / 30;
            YearDiff := (WORKDATE - HatchngDate) / 365;
            //MESSAGE('%1',DateDiff);
            recTemplateMasterLines.RESET;
            IF "Document Type" = "Document Type"::Hatchery THEN BEGIN
                recTemplateMasterHeader.RESET;
                recTemplateMasterHeader.SETRANGE("Hatchery Template", TRUE);
                //recTemplateMasterHeader.SETRANGE("Template For",recFlockMaster."Item Type");
                IF recTemplateMasterHeader.FINDFIRST THEN
                    recTemplateMasterLines.SETRANGE("Template No.", recTemplateMasterHeader."Template No.");
                recTemplateMasterLines.SETRANGE(Status, Stage);
            END ELSE BEGIN
                recTemplateMasterLines.SETRANGE("Template No.", TemplateNo);
            END;

            IF recTemplateMasterLines.FINDFIRST THEN
                REPEAT
                    //>>PRU_RPG RSE_0.1

                    ParameterMaster_Loc.RESET;
                    ParameterMaster_Loc.SETRANGE("No.", recTemplateMasterLines."Parameter No.");
                    IF ParameterMaster_Loc.FINDSET THEN BEGIN
                        CLEAR(ItemCheck);
                        IF (Rec."Shortcut Dimension 1 Code" = 'CBF') THEN BEGIN
                            IF (ParameterMaster_Loc."Reversal Entry" = FALSE) THEN BEGIN
                                IF (recTemplateMasterLines."Item No." <> '') AND (ParameterMaster_Loc."Type of Parameter" <> ParameterMaster_Loc."Type of Parameter"::Output) THEN
                                    ItemCheck := TRUE
                                ELSE
                                    ItemCheck := FALSE;

                                IF (ItemCheck = TRUE) THEN BEGIN
                                    ItemLedgerEntry.RESET;
                                    ItemLedgerEntry.SETRANGE("Item No.", recTemplateMasterLines."Item No.");
                                    ItemLedgerEntry.SETRANGE("Location Code", Rec."Farm/Location");
                                    ItemLedgerEntry.SETFILTER("Remaining Quantity", '>%1', 0);
                                    IF (ItemLedgerEntry.FINDFIRST) THEN
                                        ItemCheck := FALSE
                                    ELSE
                                        ItemCheck := TRUE;
                                END;
                            END;
                            IF (ItemCheck = FALSE) THEN BEGIN
                                //<<PRU_RPG RSE_0.1
                                IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Daily) THEN BEGIN
                                    IF (DateDiff >= recTemplateMasterLines."Frequency Start") AND (DateDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                        RecDataEntryLines.INIT;
                                        RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                        RecDataEntryLines.VALIDATE("Document No.", "No.");
                                        RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                        RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                        RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                        RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                        RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                        Param.Get(recTemplateMasterLines."Parameter No.");
                                        RecDataEntryLines.VALIDATE(Type, Param.Type);
                                        RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                        RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                        RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                        RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                        RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");


                                        IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                        RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");

                                        RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                        RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                        IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                            RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                        //>>//PRU_RPG MNF_0.1`
                                        IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                            ProdOrderLine.RESET;
                                            ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                            ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                            IF NOT ProdOrderLine.FINDSET THEN
                                                ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                        END;
                                        RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                        RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                        RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                        IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                            RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                        RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                        RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                        RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                        RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";

                                        // END;
                                        //<<//PRU_RPG MNF_0.1
                                        RecDataEntryLines.INSERT;
                                        LineNo := LineNo + 10000;
                                    END;
                                END ELSE
                                    IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Weekly) THEN BEGIN
                                        IF (WeekDiff >= recTemplateMasterLines."Frequency Start") AND (WeekDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                            RecDataEntryLines.INIT;
                                            RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                            RecDataEntryLines.VALIDATE("Document No.", "No.");
                                            RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                            RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                            RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                            RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                            Param.Get(recTemplateMasterLines."Parameter No.");
                                            RecDataEntryLines.VALIDATE(Type, Param.Type);
                                            RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                            RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                            RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                            RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                            RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                            RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                            RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                            IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                            RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                            RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                            RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                            IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                                RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                            //>>//PRU_RPG MNF_0.1
                                            IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                                ProdOrderLine.RESET;
                                                ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                                ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                                IF NOT ProdOrderLine.FINDSET THEN
                                                    ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                            END;
                                            RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                            RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                            RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                            IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                                RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                            RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                            RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                            RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                            RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                            // END;
                                            //<<//PRU_RPG MNF_0.1
                                            RecDataEntryLines.INSERT;
                                            LineNo := LineNo + 10000;
                                        END;
                                    END ELSE
                                        IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Monthly) THEN BEGIN
                                            IF (MonthDiff >= recTemplateMasterLines."Frequency Start") AND (MonthDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                                RecDataEntryLines.INIT;
                                                RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                                RecDataEntryLines.VALIDATE("Document No.", "No.");
                                                RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                                RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                                RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                                Param.Get(recTemplateMasterLines."Parameter No.");
                                                RecDataEntryLines.VALIDATE(Type, Param.Type);
                                                RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                                RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                                RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                                RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                                RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                                RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                                RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                                RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                                RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                                RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                                IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                                    RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                                //>>//PRU_RPG MNF_0.1
                                                IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                                    ProdOrderLine.RESET;
                                                    ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                                    ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                                    IF NOT ProdOrderLine.FINDSET THEN
                                                        ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                                END;
                                                RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                                RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                                RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                                IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                                    RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                                RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                                RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                                RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                                RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                                // END;
                                                //<<//PRU_RPG MNF_0.1
                                                RecDataEntryLines.INSERT;
                                                LineNo := LineNo + 10000;
                                            END;
                                        END ELSE
                                            IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Yearly) THEN BEGIN
                                                IF (YearDiff >= recTemplateMasterLines."Frequency Start") AND (YearDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                                    RecDataEntryLines.INIT;
                                                    RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                                    RecDataEntryLines.VALIDATE("Document No.", "No.");
                                                    RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                                    RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                                    RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                    RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                                    Param.Get(recTemplateMasterLines."Parameter No.");
                                                    RecDataEntryLines.VALIDATE(Type, Param.Type);
                                                    RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                                    RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                                    RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                                    RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                                    RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                                    RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                                    RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                    IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                                    RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                                    RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                                    RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                                    IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                                        RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                                    //>>//PRU_RPG MNF_0.1
                                                    IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                                        ProdOrderLine.RESET;
                                                        ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                                        ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                                        IF NOT ProdOrderLine.FINDSET THEN
                                                            ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                                    END;
                                                    RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                                    RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                                    RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                                    IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                                        RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                                    RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                                    RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                                    RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                                    RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                                    // END;
                                                    //<<//PRU_RPG MNF_0.1
                                                    RecDataEntryLines.INSERT;
                                                    LineNo := LineNo + 10000;
                                                END;
                                            END;
                            END;
                        END ELSE BEGIN  //PRU_RPG RSE_0.1
                            IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Daily) THEN BEGIN
                                IF (DateDiff >= recTemplateMasterLines."Frequency Start") AND (DateDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                    RecDataEntryLines.INIT;
                                    RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                    RecDataEntryLines.VALIDATE("Document No.", "No.");
                                    RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                    RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                    RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                    RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                    Param.Get(recTemplateMasterLines."Parameter No.");
                                    RecDataEntryLines.VALIDATE(Type, Param.Type);
                                    RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                    RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                    RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                    RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                    RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                    RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                    RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                    IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                    RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                    RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                    RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                    IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                        RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                    //>>//PRU_RPG MNF_0.1
                                    IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                        ProdOrderLine.RESET;
                                        ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                        ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                        IF NOT ProdOrderLine.FINDSET THEN
                                            ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                    END;
                                    RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                    RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                    RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                    IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                        RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                    RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                    RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                    RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                    RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                    // END;
                                    //<<//PRU_RPG MNF_0.1

                                    RecDataEntryLines.INSERT;
                                    LineNo := LineNo + 10000;
                                END;
                            END ELSE
                                IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Weekly) THEN BEGIN
                                    IF (WeekDiff >= recTemplateMasterLines."Frequency Start") AND (WeekDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                        RecDataEntryLines.INIT;
                                        RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                        RecDataEntryLines.VALIDATE("Document No.", "No.");
                                        RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                        RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                        RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                        RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                        Param.Get(recTemplateMasterLines."Parameter No.");
                                        RecDataEntryLines.VALIDATE(Type, Param.Type);
                                        RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                        RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                        RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                        RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                        RecDataEntryLines."Item No." := recTemplateMasterLines."Item No.";
                                        RecDataEntryLines."Item Description" := recTemplateMasterLines."Item Description";
                                        RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");

                                        IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                        RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                        RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                        RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                        IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                            RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                        //>>//PRU_RPG MNF_0.1
                                        IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                            ProdOrderLine.RESET;
                                            ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                            ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                            IF NOT ProdOrderLine.FINDSET THEN
                                                ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                        END;
                                        RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                        RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                        RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                        IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                            RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                        RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                        RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                        RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                        RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                        // END;
                                        //<<//PRU_RPG MNF_0.1
                                        RecDataEntryLines.INSERT;
                                        LineNo := LineNo + 10000;
                                    END;
                                END ELSE
                                    IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Monthly) THEN BEGIN
                                        IF (MonthDiff >= recTemplateMasterLines."Frequency Start") AND (MonthDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                            RecDataEntryLines.INIT;
                                            RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                            RecDataEntryLines.VALIDATE("Document No.", "No.");
                                            RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                            RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                            RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                            RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                            Param.Get(recTemplateMasterLines."Parameter No.");
                                            RecDataEntryLines.VALIDATE(Type, Param.Type);
                                            RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                            RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                            RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                            RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                            RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                            RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                            RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                            IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                            RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                            RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                            RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                            IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                                RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                            //>>//PRU_RPG MNF_0.1
                                            IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                                ProdOrderLine.RESET;
                                                ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                                ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                                IF NOT ProdOrderLine.FINDSET THEN
                                                    ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                            END;
                                            RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                            RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                            RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                            IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                                RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                            RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                            RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                            RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                            RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                            // END;
                                            //<<//PRU_RPG MNF_0.1
                                            RecDataEntryLines.INSERT;
                                            LineNo := LineNo + 10000;
                                        END;
                                    END ELSE
                                        IF (recTemplateMasterLines.Frequency = recTemplateMasterLines.Frequency::Yearly) THEN BEGIN
                                            IF (YearDiff >= recTemplateMasterLines."Frequency Start") AND (YearDiff <= recTemplateMasterLines."Frequency End") THEN BEGIN
                                                RecDataEntryLines.INIT;
                                                RecDataEntryLines.VALIDATE("Line No.", LineNo + 10000);
                                                RecDataEntryLines.VALIDATE("Document No.", "No.");
                                                RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                                                RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                                                RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                                                Param.Get(recTemplateMasterLines."Parameter No.");
                                                RecDataEntryLines.VALIDATE(Type, Param.Type);
                                                RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                                                RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                                                RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                                                RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                                                RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                                                RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");
                                                RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                                                IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                                                RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                                RecDataEntryLines.VALIDATE("Mortality Type", ParameterMaster."Mortality Type");
                                                RecDataEntryLines.VALIDATE("Exclude Quantity of Mortality", ParameterMaster."Exclude Quantity of Mortality");
                                                IF Item.GET(recTemplateMasterLines."Item No.") THEN
                                                    //>>//PRU_RPG MNF_0.1
                                                    IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                                                        ProdOrderLine.RESET;
                                                        ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                                                        ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                                                        IF NOT ProdOrderLine.FINDSET THEN
                                                            ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                                                    END;
                                                RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                                                RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                                                RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                                                IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                                                    RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                                                RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                                                RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                                                RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                                                RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                                                // END;
                                                //<<//PRU_RPG MNF_0.1
                                                RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                                                RecDataEntryLines.INSERT;
                                                LineNo := LineNo + 10000;
                                            END;
                                        END;//PRU_RPG RSE_0.1
                        END;  //PRU_RPG RSE_0.1
                    END;  //PRU_RPG RSE_0.1
                UNTIL recTemplateMasterLines.NEXT = 0;
        END;
        //PRUSB 180315 END
        //PRU-VG
    end;


    procedure RequiredValidation(Stage: Option " ",Hatcher,Setter,Production)
    var
        PostingDate: Date;
        RecDataEntryLines: Record 50005;
    begin
        //PRUSB 200315 BEGIN
        CLEAR(PostingDate);
        RecDataEntryLines.RESET;
        RecDataEntryLines.SETCURRENTKEY("Line No.");
        RecDataEntryLines.SETRANGE("Document No.", "No.");
        RecDataEntryLines.SETRANGE("Posting Date", WORKDATE);
        IF RecDataEntryLines.FINDFIRST THEN
            PostingDate := RecDataEntryLines."Posting Date";

        IF PostingDate <> WORKDATE THEN
            EnterDetails(Stage)
        ELSE
            ERROR('Lines Already inserted for the Current Date!');
        //PRUSB 200315 END
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //GeneralLedgerSetup.GET;
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Responsibility Center");
        GeneralLedgerSetup.GET(UserSetup."Responsibility Center");

        CASE "Document Type" OF
            "Document Type"::"Data Entry":
                BEGIN
                    /*
                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("Responsibility Center");
                    IF UserSetup."Responsibility Center" <> '' THEN BEGIN
                      RCSetup.GET(UserSetup."Responsibility Center");
                      EXIT(RCSetup."Data Entry Sheet Nos.");
                    END ELSE BEGIN
                    */
                    GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Data Sheet Nos");
                    EXIT(GeneralLedgerSetup."Data Sheet Nos");
                END;
            // END;
            "Document Type"::Hatchery:
                BEGIN
                    /*
                      UserSetup.GET(USERID);
                      UserSetup.TESTFIELD("Responsibility Center");
                      IF UserSetup."Responsibility Center" <> '' THEN BEGIN
                        RCSetup.GET(UserSetup."Responsibility Center");
                        EXIT(RCSetup."Hatchery Entry Sheet Nos.");
                      END ELSE BEGIN
                      */
                    GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Hatchery Nos");
                    EXIT(GeneralLedgerSetup."Hatchery Nos");
                    //END;
                END;
        END;

    end;

    local procedure TestNoSeries(): Boolean
    begin
        // PRU-RC commented
        /*
        CASE "Document Type" OF
          "Document Type":: "Data Entry":
          BEGIN
        
          UserSetup.GET(USERID);
          RespCenter.GET(UserSetup."Responsibility Center");
          //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Data Sheet Nos");
          RespCenter.TESTFIELD(RespCenter."Data Entry Sheet Nos."); //RK-PRU
          END;
        
          "Document Type":: Hatchery:
          BEGIN
          UserSetup.GET(USERID);
          RespCenter.GET(UserSetup."Responsibility Center");
          //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Hatchery Nos");
          RespCenter.TESTFIELD(RespCenter."Hatchery Entry Sheet Nos."); //RK-PRU
          END;
        END;
        */

    end;


    procedure ShowDimensions()
    var
        DimMgt: Codeunit 408;
    begin
        "Dimension Set ID" :=
          //  DimMgt.EditDimensionSet()
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", 10000),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure HatcheryEnterDetails(Stage: Option " ",Hatcher,Setter,Production)
    var
        RecDataEntryLines1: Record 50005;
        LineNo: Integer;
        TemplateNo: Code[10];
        HatchngDate: Date;
        DateDiff: Integer;
        WeekDiff: Decimal;
        MonthDiff: Decimal;
        YearDiff: Decimal;
        RecDataEntryLines: Record 50005;
        recTemplateMasterLines: Record 50006;
        Text50001: Label 'Please Define Hatching Date In Flock %1.';
        recTemplateMasterHeader: Record 50002;
        Text50002: Label 'There is no template for hatchery in %1 breed.';
        T5406: Record 5406;
        ParameterMaster: Record 50001;
        Item: Record 27;
        ILE: Record 32;
        OldConsQty: Decimal;
        MachineCenter: Record 99000758;
        ProdOrderLine: Record 5406;
        Param: Record "Parameter Master";

    begin
        //TESTFIELD("Flock No.");
        //TESTFIELD("Breed Code");
        //TESTFIELD("Line Type");
        IF Stage <> Stage::" " THEN BEGIN
            //PRUSB 180315 BEGIN
            RecDataEntryLines1.RESET;
            RecDataEntryLines1.SETCURRENTKEY("Line No.");
            RecDataEntryLines1.SETRANGE("Document No.", "No.");
            IF RecDataEntryLines1.FINDLAST THEN
                LineNo := RecDataEntryLines1."Line No.";
            RPO.GET(RPO.Status::Released, "Flock No.");
            BreedVariation.RESET;
            BreedVariation.SETRANGE("Breed Code", RPO."Breed Code");
            //BreedVariation.SETRANGE("Type of Line","Line Type");
            BreedVariation.FINDFIRST;


            /*
            //***** Get Templates Code From Breed Variation *****
            BreedVariationRec.RESET;
            BreedVariationRec.SETRANGE("Breed Code","Breed Code");
            BreedVariationRec.SETRANGE("Hatchery Template",TRUE);
            IF BreedVariationRec.FINDFIRST THEN
              TemplateNo := BreedVariationRec."Template No."
            ELSE
              ERROR(Text50002,"Breed Code");
            */

            recTemplateMasterLines.RESET;
            IF "Document Type" = "Document Type"::Hatchery THEN BEGIN
                recTemplateMasterHeader.RESET;
                recTemplateMasterHeader.SETRANGE("Template No.", BreedVariation."Template No.");
                recTemplateMasterHeader.SETRANGE("Hatchery Template", TRUE);
                IF recTemplateMasterHeader.FINDFIRST THEN;
                recTemplateMasterLines.SETRANGE("Template No.", recTemplateMasterHeader."Template No.");
                recTemplateMasterLines.SETRANGE(Status, Stage);
            END ELSE
                recTemplateMasterLines.SETRANGE("Template No.", TemplateNo);

            IF recTemplateMasterLines.FINDFIRST THEN BEGIN
                REPEAT
                    RecDataEntryLines.INIT;
                    RecDataEntryLines.VALIDATE("Line No.", LineNo);
                    RecDataEntryLines.VALIDATE("Document No.", "No.");
                    RecDataEntryLines.VALIDATE("Posting Date", WORKDATE);
                    RecDataEntryLines.VALIDATE("Template No", recTemplateMasterLines."Template No.");
                    RecDataEntryLines.VALIDATE("Location Code", "Farm/Location");
                    RecDataEntryLines."LOB Code" := "Shortcut Dimension 1 Code";
                    Param.Get(recTemplateMasterLines."Parameter No.");
                    RecDataEntryLines.VALIDATE(Type, Param.Type);
                    RecDataEntryLines.VALIDATE("Type of Parameter", Param."Type of Parameter");
                    RecDataEntryLines.VALIDATE("Parameter No.", recTemplateMasterLines."Parameter No.");
                    RecDataEntryLines."Parameter Description" := recTemplateMasterLines."Parameter Description";
                    RecDataEntryLines.VALIDATE("Std Value", recTemplateMasterLines.Quantity);
                    RecDataEntryLines.VALIDATE("Item No.", recTemplateMasterLines."Item No.");
                    RecDataEntryLines.VALIDATE("Flock No.", "Flock No.");

                    IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                    RecDataEntryLines.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                    RecDataEntryLines.VALIDATE("Machine Required", recTemplateMasterLines."Machine Required");
                    IF ParameterMaster.GET(recTemplateMasterLines."Parameter No.") THEN;
                    IF ParameterMaster."Production Order Qty." THEN BEGIN
                        OldConsQty := 0;
                        ILE.RESET;
                        ILE.SETRANGE("Document No.", "Flock No.");
                        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.CALCSUMS(Quantity);
                        OldConsQty := ABS(ILE.Quantity);
                        T5406.RESET;
                        T5406.SETRANGE("Prod. Order No.", "Flock No.");
                        IF T5406.FINDFIRST THEN BEGIN
                            IF Stage <> Stage::Production THEN
                                RecDataEntryLines."Actual Value" := T5406."Remaining Quantity" - OldConsQty;
                            RecDataEntryLines."Production Order Quantity" := TRUE;
                        END;
                    END;
                    IF Item.GET(recTemplateMasterLines."Item No.") THEN
                        RecDataEntryLines.VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, ParameterMaster."Data Entry UOM"));
                    //>>//PRU_RPG MNF_0.1
                    IF (recTemplateMasterLines."Output Item No." <> '') THEN BEGIN
                        ProdOrderLine.RESET;
                        ProdOrderLine.SETRANGE("Prod. Order No.", "Flock No.");
                        ProdOrderLine.SETRANGE("Item No.", recTemplateMasterLines."Output Item No.");
                        IF NOT ProdOrderLine.FINDSET THEN
                            ERROR(STRSUBSTNO('Flock No. %1 has not Item No. %2 which is in template master', "Flock No.", recTemplateMasterLines."Output Item No."));
                    END;
                    RecDataEntryLines.VALIDATE("Output Item No.", recTemplateMasterLines."Output Item No.");
                    RecDataEntryLines.VALIDATE("Output Item Description", recTemplateMasterLines."Output Item Description");
                    RecDataEntryLines.VALIDATE("Machine No.", ParameterMaster."Machine No.");
                    IF MachineCenter.GET(ParameterMaster."Machine No.") THEN
                        RecDataEntryLines."Unit Cost" := MachineCenter."Unit Cost";

                    RecDataEntryLines."Data Entry Type" := recTemplateMasterLines."Data Entry Type";
                    RecDataEntryLines."Laying Entry Type" := recTemplateMasterLines."Laying Entry Type";
                    RecDataEntryLines."Hatching Entry Type" := recTemplateMasterLines."Hatching Entry Type";
                    RecDataEntryLines."Descriptive Entry Type" := recTemplateMasterLines."Descriptive Entry Type";
                    // END;
                    //<<//PRU_RPG MNF_0.1
                    RecDataEntryLines.INSERT;
                    LineNo := LineNo + 10000;
                UNTIL recTemplateMasterLines.NEXT = 0;
            END;
        END;
        //PRUSB 180315 END
        //PRU-VG

    end;


    procedure RequiredValidation1(Stage: Option " ",Hatcher,Setter,Production)
    var
        PostingDate: Date;
        RecDataEntryLines: Record 50005;
    begin
        CLEAR(PostingDate);
        RecDataEntryLines.RESET;
        RecDataEntryLines.SETCURRENTKEY("Line No.");
        RecDataEntryLines.SETRANGE("Document No.", "No.");
        RecDataEntryLines.SETRANGE("Posting Date", WORKDATE);
        IF RecDataEntryLines.FINDFIRST THEN
            PostingDate := RecDataEntryLines."Posting Date";
        IF PostingDate <> WORKDATE THEN
            HatcheryEnterDetails(Stage)
        ELSE
            ERROR('Lines Already inserted for the Current Date!');
    end;


    procedure CalcTotalCost(var RecDataEntry: Record 50003): Decimal
    var
        RecDataEntryLine: Record 50005;
        T5407: Record 5407;
        DES: Record 50003;
        T50005: Record 50005;
        PM: Record 50001;
        T32: Record 32;
        ItemNoVar: Code[20];
    begin
        RecDataEntryLine.RESET;
        RecDataEntryLine.SETCURRENTKEY("Posting Date");
        RecDataEntryLine.SETRANGE("Flock No.", RecDataEntry."Flock No.");
        IF RecDataEntryLine.FINDLAST THEN BEGIN
            T5407.RESET;
            T5407.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
            IF T5407.FINDFIRST THEN
                ItemNoVar := T5407."Item No.";
            DES.RESET;
            DES.SETCURRENTKEY("No.");
            DES.SETRANGE("Document Type", DES."Document Type"::"Data Entry");
            DES.SETFILTER("No.", '<>%1', RecDataEntry."No.");
            IF DES.FINDLAST THEN BEGIN
                T50005.RESET;
                T50005.SETRANGE("Document No.", DES."No.");
                IF T50005.FINDFIRST THEN
                    REPEAT
                        IF PM.GET(T50005."Parameter No.") THEN BEGIN
                            IF PM."Include With Cost" THEN BEGIN
                                IF PM."Type of Parameter" = PM."Type of Parameter"::" " THEN BEGIN
                                    T32.RESET;
                                    T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
                                    T32.SETRANGE("Document No.", DES."Flock No.");
                                    T32.SETRANGE("Data Entry Sheet No.", DES."No.");
                                    T32.SETRANGE("Item No.", T50005."Item No.");
                                    T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)", T32."Cost Amount (Expected)");
                                    IF T32.FINDFIRST THEN BEGIN
                                        IF T50005."Actual Value" = -1 * T32.Quantity THEN BEGIN
                                            ConsumptionQty += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                                        END;
                                    END;
                                END ELSE
                                    IF PM."Type of Parameter" = PM."Type of Parameter"::Output THEN BEGIN
                                        T32.RESET;
                                        T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
                                        T32.SETRANGE("Document No.", DES."Flock No.");
                                        T32.SETRANGE("Data Entry Sheet No.", DES."No.");
                                        T32.SETRANGE("Item No.", ItemNoVar);
                                        T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)", T32."Cost Amount (Expected)");
                                        IF T32.FINDFIRST THEN BEGIN
                                            IF T50005."Actual Value" = -1 * T32.Quantity THEN BEGIN
                                                OtptQty += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                                            END;
                                        END;
                                    END;
                            END;
                        END;
                    UNTIL T50005.NEXT = 0;

            END;
        END ELSE BEGIN
            T5407.RESET;
            T5407.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
            IF T5407.FINDFIRST THEN BEGIN
                EXIT(T5407."Cost Amount");
            END;
        END;
        DES.RESET;
        DES.SETRANGE("Flock No.", RecDataEntry."Flock No.");
        DES.SETFILTER("No.", '<>%1', RecDataEntry."No.");
        IF DES.FINDLAST THEN BEGIN
            EXIT(DES."Total Cost" + (-1 * ConsumptionQty) + OtptQty);
        END;
    end;

    local procedure GetQuantity(): Decimal
    var
        RecData: Record 50003;
        T5407: Record 5407;
        GetQty: Decimal;
        T32: Record 32;
        ConsumeQty: Decimal;
        RPO: Record 5405;
    begin
        RecData.RESET;
        RecData.SETRANGE("Flock No.", "Flock No.");
        RecData.SETFILTER("No.", '<>%1', "No.");
        IF RecData.FINDLAST THEN BEGIN
            T5407.RESET;
            T5407.SETRANGE("Prod. Order No.", "Flock No.");
            IF T5407.FINDFIRST THEN BEGIN
                T32.RESET;
                T32.SETRANGE("Document No.", RecData."Flock No.");
                T32.SETRANGE("Data Entry Sheet No.", RecData."No.");
                T32.SETRANGE("Item No.", T5407."Item No.");
                T32.SETRANGE("Entry Type", T32."Entry Type"::Consumption);
                IF T32.FINDSET THEN
                    REPEAT
                        ConsumeQty += T32.Quantity;
                    UNTIL T32.NEXT = 0;
                EXIT((T5407."Remaining Quantity" - ConsumeQty));
            END;
        END ELSE BEGIN
            IF RPO.GET(RPO.Status::Released, "Flock No.") THEN
                EXIT(RPO.Quantity);
        END;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


}

