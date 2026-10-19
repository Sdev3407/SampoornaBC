table 50017 "Gate Pass Header"
{
    DrillDownPageID = "RGP Gate Pass list";
    LookupPageID = "RGP Gate Pass list";

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionCaption = 'NRGP,RGP,RRGP';
            OptionMembers = NRGP,RGP,RRGP;
        }
        field(2; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                //cs-ds start 
                IF "No." <> xRec."No." THEN BEGIN
                    InvtSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
                //cs-ds end
            end;

        }
        field(5; "Location Code"; Code[20])
        {
            Editable = true;
            TableRelation = Location;
            Caption = 'Location Code';
        }
        field(6; "Type"; Option)
        {
            Editable = true;
            OptionMembers = " ",Location,Vendor,Customer,Employee,;

            trigger OnValidate()
            begin

                "Party Name" := '';
                "Code" := '';
            end;
        }
        field(7; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = IF ("Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Type" = CONST(Customer)) Customer
            else
            if (Type = const(Employee)) Employee
            else
            If (Type = const(Location)) Location;

            trigger OnValidate()
            var
                RecLoc: Record Location;
                RecEmp: Record Employee;
            begin
                TESTFIELD("Type");
                "Party Name" := '';
                IF "Type" = "Type"::Customer THEN
                    IF CustTab.GET("Code") THEN
                        "Party Name" := CustTab.Name;

                IF "Type" = "Type"::Vendor THEN
                    IF VendorTab.GET("Code") THEN
                        "Party Name" := VendorTab.Name;

                IF "Type" = "Type"::Location THEN
                    IF RecLoc.GET("Code") THEN
                        "Party Name" := RecLoc.Name;

                IF "Type" = "Type"::Employee THEN
                    IF RecEmp.GET("Code") THEN
                        "Party Name" := RecEmp.FullName();
            end;
        }
        field(8; "Party Name"; Text[50])
        {
            Editable = false;
            Caption = 'Name';
        }
        field(9; Description; Text[80])
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            Editable = true;
        }
        field(11; "Gate Pass Issued"; Boolean)
        {
            Editable = false;
        }
        field(12; "Posting Date"; Date)
        {
            Editable = true;
            trigger OnValidate()
            var
                RGPHeader: Record "Gate Pass Header";
            begin
                if "Document Type" in ["Document Type"::RRGP] then begin
                    TestField("RGP No.");
                    RGPHeader.Get(RGPHeader."Document Type"::RGP, "RGP No.");
                    if Rec."Posting Date" < RGPHeader."Posting Date" then
                        Error('Posting Date Should be greater than or equal to %1', RGPHeader."Posting Date");
                    Validate("Date Of Return");
                end;

            end;

        }
        field(13; Remarks; Text[80])
        {
            Editable = false;
        }
        field(14; "Truck Number"; Code[20])
        {
            Editable = true;
        }
        field(15; "LR/RR No."; Code[20])
        {
            Editable = true;
        }
        field(16; "No. Printed"; Integer)
        {
        }
        field(17; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                GatePassLine.RESET;
                GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                GatePassLine.SETRANGE("Document Type", "Document Type");
                GatePassLine.SETRANGE("Document No.", "No.");
                IF GatePassLine.FIND('-') THEN BEGIN
                    REPEAT
                        GatePassLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        GatePassLine.MODIFY;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(18; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                GatePassLine.RESET;
                GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                GatePassLine.SETRANGE("Document Type", "Document Type");
                GatePassLine.SETRANGE("Document No.", "No.");
                IF GatePassLine.FIND('-') THEN BEGIN
                    REPEAT
                        GatePassLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                        GatePassLine.MODIFY;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(50; "RGP No."; Code[20])
        {

            // TableRelation = "Gate Pass Header"."RGP No." where(POSTED = filter(true), "Document Type" = filter(RGP), "Pending Qty" = filter(<> 0));
            Editable = true;

            trigger OnLookup()
            var
                gatepassnew: Record "Gate Pass Header";
                RESERV: Record "Reservation Entry";
            begin
                GatePass.RESET;
                GatePass.SETRANGE("Document Type", "Document Type"::RGP);
                GatePass.SETRANGE(Posted, true);
                GatePass.CalcFields("Pending Qty");
                GatePass.SetFilter("Pending Qty", '<>%1', 0);

                IF PAGE.RUNMODAL(50146, GatePass) = ACTION::LookupOK THEN
                    "RGP No." := GatePass."No.";

                "Type" := GatePass."Type";
                "Code" := GatePass."Location Code";
                "Location Code" := GatePass."Code";

                "Code" := GatePass."Code";
                "Party Name" := GatePass."Party Name";
                "Shortcut Dimension 1 Code" := GatePass."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := GatePass."Shortcut Dimension 2 Code";

                VALIDATE("RGP No.");
            end;

            trigger OnValidate()
            var
            begin
                InsertRGP;
            end;
        }
        field(100; "LR Date"; Date)
        {
        }
        field(120; "Mode of Transport"; Text[50])
        {
        }
        field(125; "Road Permit No."; Code[30])
        {
        }
        field(250; "Transport Company"; Text[30])
        {
        }
        field(270; "Driver Name"; Text[30])
        {
        }
        field(300; "Driver Phone No."; Integer)
        {
        }

        field(50000; "Goods Inward Posted"; Boolean)
        {
        }
        field(50008; "Attachment Code"; Code[20])
        {
        }
        field(50009; "Attachment No."; Integer)
        {
            CalcFormula = Lookup("Interaction Tmpl. Language"."Attachment No." WHERE("Interaction Template Code" = FIELD("Attachment Code"),
                                                                                      "Language Code" = FIELD("Language Code (Default)")));
            FieldClass = FlowField;
        }
        field(50010; "Language Code (Default)"; Code[20])
        {
        }
        field(50019; "Customer Order No."; Code[20])
        {
        }
        field(50020; "Order Date"; Date)
        {
        }
        field(50022; "Start Date"; Date)
        {
        }
        field(50023; "End Date"; Date)
        {
        }
        field(50024; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                GatePassLine.RESET;
                GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                GatePassLine.SETRANGE("Document Type", "Document Type");
                GatePassLine.SETRANGE("Document No.", "No.");
                IF GatePassLine.FIND('-') THEN BEGIN
                    REPEAT
                        GatePassLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                        GatePassLine.MODIFY;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(50025; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                GatePassLine.RESET;
                GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                GatePassLine.SETRANGE("Document Type", "Document Type");
                GatePassLine.SETRANGE("Document No.", "No.");
                IF GatePassLine.FIND('-') THEN BEGIN
                    REPEAT
                        GatePassLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                        GatePassLine.MODIFY;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(50026; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
                GatePassLine.RESET;
                GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                GatePassLine.SETRANGE("Document Type", "Document Type");
                GatePassLine.SETRANGE("Document No.", "No.");
                IF GatePassLine.FIND('-') THEN BEGIN
                    REPEAT
                        GatePassLine."Shortcut Dimension 5 Code" := "Shortcut Dimension 5 Code";
                        GatePassLine.MODIFY;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(50027; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                myInt: Integer;
            begin
                ShowDocDim();
            end;
        }
        field(60098; "User ID"; Code[26])
        {
            NotBlank = true;
            TableRelation = Integer;
            ValidateTableRelation = false;
        }
        field(60099; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(60100; Posted; Boolean)
        {
        }
        field(60101; "Pending Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Gate Pass Line"."Pending Qty" WHERE("Document Type" = FILTER(RGP),
                                                                    "Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(60102; "Total Qty"; Decimal)
        {
            CalcFormula = Sum("Gate pass Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60103; "Date Of Return"; Date)
        {
            trigger OnValidate()
            var
                RGPHeader: Record "Gate Pass Header";
            begin
                if "Document Type" in ["Document Type"::RRGP] then begin
                    TestField("RGP No.");
                    RGPHeader.Get(RGPHeader."Document Type"::RGP, "RGP No.");
                    if Rec."Date Of Return" < RGPHeader."Posting Date" then
                        Error('Date of Return should be greater than or equal to %1', RGPHeader."Posting Date");
                    if Rec."Date Of Return" > Rec."Posting Date" then
                        Error('Date of Return should be less than or equal to %1', "Posting Date");
                end;
            end;
        }
        field(60105; Cancellation; Boolean)
        {
        }
        field(60106; "Cancellation Date"; Date)
        {
        }
        field(60107; "Not Found Qty"; Integer)
        {
            CalcFormula = Count("Gate Pass Header" WHERE("RGP No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60125; "RRGP POSTED"; Boolean)
        { }
        field(90050; "Sequence No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
        key(Key3; "Code")
        {
        }
        key(Key4; "Document Type", Posted, "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        ERROR('You cannot delete any document');
    end;

    trigger OnInsert()
    begin

        "Posting Date" := WORKDATE;
        if "Document Type" = "Document Type"::NRGP then
            "Date Of Return" := WorkDate();

        InvtSetup.GET;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin

        "User ID" := USERID;
        "Last Date Modified" := TODAY;
    end;

    var
        InvtSetup: Record "Inventory Setup";
        GatePass: Record "Gate Pass Header";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Err_G_001: Label 'You cannot delete .';
        Err_G_002: Label 'You cannot rename.';
        DimMgt: Codeunit "DimensionManagement";
        VendorTab: Record "Vendor";
        CustTab: Record "Customer";
        GatePassLine: Record "Gate Pass Line";
        ItemJnlLine: Record "Item Journal Line";
        Text_0007: Label 'The Material Issue Slip No  %1 already exists.';
        Text_0008: Label 'Do you wants to Post this Issue Slip ?';
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        GatePassHead1: Record "Gate Pass Header";
        Employee: Record "Employee";
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
        ItemJournalBatch: Record "Item Journal Batch";
        DocumentNo: Code[20];
        NoSeries: Code[20];
        DimensionValue: Record "Dimension Value";
        RRGPHead: Record "Gate Pass Header";
        NoSeries1: Record "No. Series";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        ItemJournalLine: Record "Item Journal Line";
        GatePassHeader1: Record "Gate Pass Header";
        GatepassLine1: Record "Gate Pass Line";


    procedure GetInvtSetup()
    begin
        InvtSetup.GET;
    end;


    procedure GetNoSeriesCode(): Code[20]
    begin
        CASE "Document Type" OF
            "Document Type"::NRGP:
                EXIT(InvtSetup.NRGP);
            "Document Type"::RGP:
                EXIT(InvtSetup.RGP);
            "Document Type"::RRGP:
                EXIT(InvtSetup.RRGP);
        END;
    end;

    procedure AssistEdit(OldGatePass: Record "Gate Pass Header"): Boolean
    begin
        InvtSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldGatePass."No. Series", "No. Series") THEN BEGIN
            InvtSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    procedure TestNoSeries()
    begin

        CASE "Document Type" OF
            "Document Type"::NRGP:
                InvtSetup.TESTFIELD(NRGP);
            "Document Type"::RGP:
                InvtSetup.TESTFIELD(RGP);
            "Document Type"::RRGP:
                InvtSetup.TESTFIELD(RRGP);
        END;
    end;


    procedure MakeItemJnlAndPost(JournalTempName: Code[50]; JournalBatchName: Code[50]): Boolean
    var
        RGPLine: Record "Gate Pass Line";
        ItemRec: Record Item;
        ReserEntry: record "Reservation Entry";
        GLSETUP: Record "General Ledger Setup";
    begin

        IF "Document Type" = "Document Type"::NRGP THEN BEGIN
            GatePassLine.RESET;
            GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
            GatePassLine.SETRANGE("Document Type", "Document Type");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FIND('-') THEN BEGIN
                REPEAT
                    //
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Item No.");
                    ItemJournalLine.SETRANGE("Journal Template Name", 'ITEM');
                    ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
                    ItemJournalLine.SETRANGE("Document No.", GatePassLine."Document No.");
                    // ItemJournalLine.SETRANGE("Indent Line No", GatePassLine."Line No.");
                    ItemJournalLine.SETRANGE("Item No.", GatePassLine."Item No.");
                    IF ItemJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                            ItemJnlPostBatch.RUN(ItemJournalLine);
                        UNTIL ItemJournalLine.NEXT = 0;
                    END;
                UNTIL GatePassLine.NEXT = 0;
                MESSAGE(GatePassLine."Document No." + '-> Posted Successfully.');
            END;
        END;
        IF "Document Type" = "Document Type"::RGP THEN BEGIN
            GatePassLine.RESET;
            GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
            GatePassLine.SETRANGE("Document Type", "Document Type");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FindSet() THEN BEGIN
                REPEAT
                    ItemRec.Reset();
                    ItemRec.Get(GatePassLine."Item No.");
                    if ItemRec."Item Tracking Code" <> '' then begin
                        ItemJournalLine.RESET;
                        ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Item No.");
                        ItemJournalLine.SETRANGE("Journal Template Name", JournalTempName);
                        ItemJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
                        ItemJournalLine.SETRANGE("Document No.", GatePassLine."Document No.");
                        // ItemJournalLine.SETRANGE("Indent Line No", GatePassLine."Line No.");
                        ItemJournalLine.SETRANGE("Item No.", GatePassLine."Item No.");
                        if ItemJournalLine.FindFirst() then begin
                            ReserEntry.Reset();
                            ReserEntry.SetRange("Source Type", 83);
                            ReserEntry.SetRange("Source Ref. No.", ItemJournalLine."Line No.");
                            ReserEntry.SetRange("Item Ledger Entry No.", 0);
                            ReserEntry.SetRange("Creation Date", ItemJournalLine."Document Date");
                            ReserEntry.SetRange("Item No.", ItemJournalLine."Item No.");
                            if not ReserEntry.FindFirst() then
                                Error('You must assign Lot No for item No. %1', ItemJournalLine."Item No.");
                        end;
                    end;

                UNTIL GatePassLine.NEXT = 0;
            end;
            GatePassLine.RESET;
            GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
            GatePassLine.SETRANGE("Document Type", "Document Type");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FindSet() THEN BEGIN
                REPEAT
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Item No.");
                    ItemJournalLine.SETRANGE("Journal Template Name", JournalTempName);
                    ItemJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
                    ItemJournalLine.SETRANGE("Document No.", GatePassLine."Document No.");
                    // ItemJournalLine.SETRANGE("Indent Line No", GatePassLine."Line No.");
                    ItemJournalLine.SETRANGE("Item No.", GatePassLine."Item No.");
                    IF ItemJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                            ItemJnlPostBatch.RUN(ItemJournalLine);
                        UNTIL ItemJournalLine.NEXT = 0;
                    END;
                UNTIL GatePassLine.NEXT = 0;
                MESSAGE(GatePassLine."Document No." + '-> Posted Successfully.');
            END;
        END;
        IF "Document Type" = "Document Type"::RRGP THEN BEGIN
            GatePassLine.RESET;
            GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
            GatePassLine.SETRANGE("Document Type", "Document Type");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FIND('-') THEN BEGIN
                REPEAT
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Item No.");
                    ItemJournalLine.SETRANGE("Journal Template Name", JournalTempName);
                    ItemJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
                    ItemJournalLine.SETRANGE("Document No.", GatePassLine."Document No.");
                    // ItemJournalLine.SETRANGE("Indent Line No", GatePassLine."Line No.");
                    ItemJournalLine.SETRANGE("Item No.", GatePassLine."Item No.");
                    IF ItemJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                            ItemJnlPostBatch.RUN(ItemJournalLine);
                        UNTIL ItemJournalLine.NEXT = 0;
                    END;
                    RGPLine.RESET;
                    RGPLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    RGPLine.SETRANGE("Document Type", RGPLine."Document Type"::RGP);
                    RGPLine.SETRANGE("Document No.", GatePassLine."RGP No.");
                    RGPLine.SETRANGE("Line No.", GatePassLine."RGP Line No.");
                    IF RGPLine.FIND('-') THEN BEGIN
                        RGPLine."Pending Qty" -= GatePassLine.Quantity;
                        RGPLine.MODIFY;
                    END;
                UNTIL GatePassLine.NEXT = 0;
                MESSAGE(GatePassLine."Document No." + '-> Posted Successfully.');
            END;
        END;

        IF "Document Type" = "Document Type"::RRGP THEN BEGIN
            GatePassLine.RESET;
            GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
            GatePassLine.SETRANGE("Document Type", "Document Type");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FIND('-') THEN BEGIN
                REPEAT
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Item No.");
                    ItemJournalLine.SETRANGE("Journal Template Name", JournalTempName);
                    ItemJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
                    ItemJournalLine.SETRANGE("Document No.", GatePassLine."Document No.");
                    // ItemJournalLine.SETRANGE("Indent Line No", GatePassLine."Line No.");
                    ItemJournalLine.SETRANGE("Item No.", GatePassLine."Item No.");
                    IF ItemJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                            ItemJnlPostBatch.RUN(ItemJournalLine);
                        UNTIL ItemJournalLine.NEXT = 0;
                    END;
                UNTIL GatePassLine.NEXT = 0;
                MESSAGE(GatePassLine."Document No." + '-> Posted Successfully.');
            END;
        END;
    end;


    procedure InsertRGP()
    var
        RRGPLine: Record "Gate Pass Line";
        GateLineRGP: Record "Gate Pass Line";
        ILE: Record "Item Ledger Entry";
        Reserve: Record "Reservation Entry";
    begin

        RRGPLine.RESET;
        RRGPLine.SETCURRENTKEY("Document Type", "Document No.");
        RRGPLine.SETRANGE("Document Type", "Document Type");
        RRGPLine.SETRANGE("Document No.", "No.");
        IF RRGPLine.FIND('-') THEN
            RRGPLine.DELETEALL(TRUE);

        RRGPLine.RESET;
        RRGPLine.SETCURRENTKEY("Document Type", "Document No.");
        RRGPLine.SETRANGE("Document Type", RRGPLine."Document Type"::RGP);
        RRGPLine.SETRANGE("Document No.", "RGP No.");
        RRGPLine.SETFILTER("Pending Qty", '<>%1', 0);
        IF RRGPLine.FIND('-') THEN BEGIN
            REPEAT
                GateLineRGP.RESET;
                GateLineRGP.INIT;
                GateLineRGP."Document Type" := "Document Type";
                GateLineRGP."Document No." := "No.";
                GateLineRGP."Line No." += 10000;
                GateLineRGP.Type := RRGPLine.Type;
                GateLineRGP.VALIDATE("Item No.", RRGPLine."Item No.");
                if GateLineRGP."Item No." = '' then begin
                    GateLineRGP.Description := RRGPLine.Description;
                end;
                GateLineRGP.Validate(Quantity, RRGPLine."Pending Qty");
                GateLineRGP.VALIDATE("Unit of Measure Code", RRGPLine."Unit of Measure Code");
                GateLineRGP.VALIDATE("Unit Cost", RRGPLine."Unit Cost");
                GateLineRGP."RGP No." := RRGPLine."Document No.";
                GateLineRGP."RGP Line No." := RRGPLine."Line No.";
                GateLineRGP."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                GateLineRGP."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                GateLineRGP.Validate("To Location", RRGPLine.Location);
                GateLineRGP.Validate(Location, RRGPLine."TO Location");
                GateLineRGP.Validate("RGP Qty.", RRGPLine."Pending Qty");
                GateLineRGP.INSERT(true);
            UNTIL RRGPLine.NEXT = 0;
        END;
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        DimMgt: Codeunit DimensionManagement;

    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Document Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF RGPLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;



    LOCAL procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        Text051: Label 'Do you want to update the dimensions on lines';
        PurchLine: Record "Gate Pass Line";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text051) THEN
            EXIT;

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", "Document Type");
        PurchLine.SETRANGE("Document No.", "No.");
        PurchLine.LOCKTABLE;
        IF PurchLine.FIND('-') THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF PurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    PurchLine."Dimension Set ID" := NewDimSetID;

                    // IF NOT HideValidationDialog AND GUIALLOWED THEN
                    //     VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY;
                END;
            UNTIL PurchLine.NEXT = 0;
    end;

    procedure RGPLinesExist(): Boolean
    VAR
        RGPLINE: Record "Gate Pass Line";
    begin
        RGPLINE.RESET;
        RGPLINE.SETRANGE("Document Type", "Document Type");
        RGPLINE.SETRANGE("Document No.", "No.");
        EXIT(RGPLINE.FINDFIRST);
    end;


    procedure CheckPostedDocNo()
    begin

        GatePass.RESET;
        GatePass.SETRANGE(GatePass."Document Type", "Document Type");
        GatePass.SETRANGE(GatePass.Posted, FALSE);
        GatePass.SETFILTER(GatePass."Sequence No.", '<%1', "Sequence No.");
        IF GatePass.FIND('-') THEN
            ERROR('please post the previous Document No.');
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF Rec."No." <> '' THEN
            MODIFY;
    end;
}