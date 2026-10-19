table 50011 "Indent Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Indent No." <> xRec."Indent No." THEN BEGIN
                    //  GeneralLedgerSetup.GET;
                    //PRU-RC >>
                    userset.GET(USERID);
                    RespCntr.GET(userset."Responsibility Center");
                    //PRU-RC <<
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                    "Indent Date" := WORKDATE;
                END;
            end;
        }
        field(2; "Indent Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Approved," Rejected";
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Indent Created from Planning"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. of PO"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            FieldClass = Normal;
        }
        field(13; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Indent Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(15; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(17; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Approved,Closed,Pending Approval,Issued';
            OptionMembers = Open,Approved,Closed,"Pending Approval",Issued;
        }
        field(18; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(19; "From Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                //RK-PRU +
                IndentLineRec1.RESET;
                IndentLineRec1.SETRANGE("Document No.", "Indent No.");
                IF IndentLineRec1.FINDFIRST THEN
                    REPEAT
                        IndentLineRec1."From Location" := "Required Location";
                        IndentLineRec1.MODIFY;
                    UNTIL IndentLineRec1.NEXT = 0;
                //RK-PRU -
            end;
        }
        field(20; "Requested Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(481; "Required Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                //RK-PRU +
                IndentLineRec1.RESET;
                IndentLineRec1.SETRANGE("Document No.", "Indent No.");
                IF IndentLineRec1.FINDFIRST THEN
                    REPEAT
                        IndentLineRec1.Location := "Required Location";
                        IndentLineRec1.MODIFY;
                    UNTIL IndentLineRec1.NEXT = 0;

                Location.GET("Required Location");
                "Required Location Name" := Location.Name;
                //RK-PRU -
            end;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                /*IF NOT UserSetupMgt.CheckRespCenter2(0,"Responsibility Center","Assigned User ID") THEN
                  ERROR(
                    Text061,"Assigned User ID",
                    RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter2("Assigned User ID"));
                    */

            end;
        }
        field(9001; "Approval User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9002; "Required Location Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Indent No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IndentLineRec.RESET;
        IndentLineRec.SETRANGE("Document No.", "Indent No.");
        IF IndentLineRec.FINDSET THEN BEGIN
            CALCFIELDS("No. of PO");
            TESTFIELD("No. of PO", 0);
            IndentLineRec.DELETEALL;
        END;
    end;

    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Create Indent');

        //GeneralLedgerSetup.GET;
        //PRU-RC >>
        /*userset.GET(USERID);
        RespCntr.GET(userset."Responsibility Center");//PRU-VG
        //PRU-RC <<
        "Shortcut Dimension 1 Code":=userset."Shortcut Dimension 3 Code";
        "Responsibility Center":=userset."Responsibility Center";
        */
        IF "Indent No." = '' THEN BEGIN
            // TestNoSeries;
            //GeneralLedgerSetup.GET;//PRU-AM 1.0
            userset.GET(USERID);
            userset.TESTFIELD("Responsibility Center");
            GeneralLedgerSetup.GET(userset."Responsibility Center");
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "Indent No.", GeneralLedgerSetup."Indent No. Series");
            //  NoSeriesMgt.InitSeries(GeneralLedgerSetup."Indent No. Series", xRec."No. Series", 0D, "Indent No.", "No. Series");
        END;
        "User ID" := USERID; //PRU-VG 2.0
        //"Responsibility Center" := USERMGT.GetRespCentre(); //PRU-VG
        "Indent Date" := WORKDATE;

    end;

    var
        GeneralLedgerSetup: Record 5714;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IndentLineRec: Record 50012;
        userset: Record 91;
        USERMGT: Codeunit 5700;
        DimMgt: Codeunit DimensionManagement;
        RespCntr: Record 5714;
        IndentLineRec1: Record 50012;
        Cu22: Codeunit 22;
        Location: Record 14;
        UserSetup: Record 91;


    procedure GetNoSeriesCode(): Code[10]
    begin
        /*
        GeneralLedgerSetup.GET;
        GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Indent Nos.");
        EXIT(GeneralLedgerSetup."Indent Nos.");
        */
        //PRU-RC >>
        userset.GET(USERID);

        RespCntr.GET(userset."Responsibility Center");     //PRU-VG
        RespCntr.TESTFIELD("Indent No. Series");           //PRU-VG
        EXIT(RespCntr."Indent No. Series");
        //PRU-VG
        //PRU-RC >>

    end;


    procedure TestNoSeries(): Boolean
    begin
        //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Indent Nos.");
        RespCntr.TESTFIELD("Indent No. Series");//PRU-VG
    end;


    procedure AssistEdit(OldIndentHeader: Record 50001): Boolean
    begin
        userset.GET(USERID);
        //RespCntr.GET(userset."Responsibility Center");

        GeneralLedgerSetup.GET;
        userset.GET(USERID);
        userset.TESTFIELD("Responsibility Center");
        GeneralLedgerSetup.GET(userset."Responsibility Center");


        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldIndentHeader."No. Series", "No. Series") THEN BEGIN
            // GeneralLedgerSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("Indent No.");
            EXIT(TRUE);
        END;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "Indent No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            //IF PurchLinesExist THEN
            //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        END;
    end;


    procedure PostItemReclassJnl(var IndentLineLoc: Record 50012)
    var
        ItemJournalLine: Record 83;
        ILE: Record 32;
        ReservationEntry: Record 337;
        InvSetup: Record 312;
        ItemJnlPost: Codeunit 241;
        TrackingSpecification: Record 336;
        ItemLoc: Record 27;
        InventorySetup: Record 313;
        ConsIJL: Record 83;
    begin
        InvSetup.GET;
        //PRU-VG 4.0
        InvSetup.TESTFIELD("Indent Batch Name");
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'RECLASS';
        ItemJournalLine."Journal Batch Name" := InvSetup."Indent Batch Name";
        ItemJournalLine."Line No." := GetLineNoIssue('RECLASS', InvSetup."Indent Batch Name");
        ItemJournalLine."Document No." := "Indent No.";
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
        ItemJournalLine.VALIDATE("Item No.", IndentLineLoc."No.");
        //ItemJournalLine.VALIDATE("Variant Code",IndentLine."Variant Code");
        ItemJournalLine."Posting Date" := WORKDATE;
        ItemJournalLine.VALIDATE("Location Code", "From Location");
        ItemJournalLine.VALIDATE(Quantity, IndentLineLoc.Quantity);
        ItemJournalLine.VALIDATE("Unit of Measure Code", IndentLineLoc."Unit of Measure Code");
        ItemJournalLine.VALIDATE("New Location Code", "Required Location");
        ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        ItemJournalLine.VALIDATE("New Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        /*TrackingSpecification.RESET;
        TrackingSpecification.SETRANGE("Item No.",IssueLine."Item Code");
        TrackingSpecification.SETRANGE("Location Code",IssueLine."From Location");
        TrackingSpecification.SETRANGE("Quantity (Base)",IssueLine."Issue Qty");
        IF TrackingSpecification.FINDLAST THEN BEGIN
          ItemJournalLine.VALIDATE("Serial No.",TrackingSpecification."Serial No.");
          //MESSAGE('%1',ItemJournalLine."Serial No.")
        END;*/
        //PRU_RPG ItemJournalLine.INSERT;
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Item No.", IndentLineLoc."No.");
        ReservationEntry.SETRANGE("Location Code", "From Location");
        ReservationEntry.SETRANGE("Source ID", 'RECLASS');
        ReservationEntry.SETRANGE("Source Batch Name", InvSetup."Indent Batch Name");
        IF ReservationEntry.FINDFIRST THEN
            REPEAT
                ItemJournalLine.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
                ReservationEntry.MODIFY;
            UNTIL ReservationEntry.NEXT = 0;

        /*
        ILE.RESET;
        ILE.SETRANGE("Document No.",RcptLinePurch."Document No.");
        ILE.SETRANGE(ILE."Rejected For Item Tracking",TRUE);
        ILE.SETRANGE(ILE."Item No.",RcptLinePurch."No.");
        ILE.SETFILTER("Serial No.",'<>%1','');
        IF ILE.FINDFIRST THEN
        REPEAT
          ReservationEntry.INIT;
          ReservationEntry."Entry No." := GetLastEntryNo;
          ReservationEntry."Item No." := ILE."Item No.";
          ReservationEntry."Location Code" := ILE."Location Code";
          ReservationEntry."Quantity (Base)" := -1;
          ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
          ReservationEntry."Creation Date" := WORKDATE;
          ReservationEntry."Source Type" := 83;
          ReservationEntry."Source Subtype" := 4;
          ReservationEntry."Source ID" := 'RECLASS';
          ReservationEntry."Source Batch Name" := InvSetup."Rejected Location Batch";
          ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
          ReservationEntry."Serial No." := ILE."Serial No.";
          ReservationEntry."Created By" := USERID;
          ReservationEntry."Qty. per Unit of Measure" := 1;
          ReservationEntry.Quantity := -1;
          ReservationEntry.Positive := FALSE;
          ReservationEntry."Qty. to Handle (Base)" := -1;
          ReservationEntry."Qty. to Invoice (Base)" := -1;
          ReservationEntry."New Serial No." := ILE."Serial No.";
          ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking" ::"Serial No.";
          ReservationEntry.INSERT;
        UNTIL ILE.NEXT=0;
        */
        //PRU-VG 4.0
        //ItemJnlPost.RunDirectly(ItemJournalLine);
        Cu22.RunWithCheck(ItemJournalLine);
        //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Line",ItemJournalLine);
        IF ItemLoc.GET(IndentLineLoc."No.") THEN;
        IF ItemLoc."Consumption Item" THEN BEGIN
            ConsIJL.INIT;
            ConsIJL."Journal Template Name" := 'Item';
            ConsIJL."Journal Batch Name" := InventorySetup."Auto Consumption Batch Name";
            ConsIJL."Line No." := GetLineNo('Item', InventorySetup."Auto Consumption Batch Name");
            ConsIJL."Posting Date" := WORKDATE;
            ConsIJL.VALIDATE("Document No.", "Indent No.");
            ConsIJL.VALIDATE("Item No.", IndentLineLoc."No.");
            ConsIJL.VALIDATE("Entry Type", ConsIJL."Entry Type"::"Negative Adjmt.");
            ConsIJL.VALIDATE(Quantity, IndentLineLoc.Quantity);
            ConsIJL.VALIDATE("Location Code", "Required Location");
            ConsIJL.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
            Cu22.RunWithCheck(ConsIJL);
        END;

    end;


    procedure GetLineNoIssue(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10)
        ELSE
            EXIT(10);
    end;


    procedure GetLineNo(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10)
        ELSE
            EXIT(10);
    end;
}

