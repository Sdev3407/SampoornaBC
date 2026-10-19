table 50012 "Indent Line"
{
    DataClassification = ToBeClassified;
    // Version No.   UserID    Date        Where                        Description
    // ---------------------------------------------------------------------------------------------------------------
    // PRU-VR1.00              031115      Table Desinger               Stock In Hand
    // PRU-VR1.00              031115                                   Function- CalculateStockInv()
    // 
    // PRU-VG 1.1  10122016  Merge Indent Functionality
    // PRU-AM 1.0            221116      Qty Validate                 Validate Remaining Qty
    // PRU-ASH1.0 191216 : Fields Added


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = filter("Item")) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin

                IF Type = Type::" " THEN
                    ERROR('First select type');

                IF Type = Type::Item THEN BEGIN
                    Item.GET("No.");
                    Description := Item.Description;
                    "Item Category Code" := Item."Item Category Code";
                    "Unit of Measure Code" := Item."Base Unit of Measure";//PRU-AM 9.0
                    "Approx Cost" := Item."Last Direct Cost";
                    "Chicks Item" := Item."Chicks Item"; //PRU-RK
                END ELSE
                    IF Type = Type::"Fixed Asset" THEN BEGIN
                        FA.GET("No.");
                        Description := FA.Description;
                    END;
                TESTFIELD(Status, Status::Open);

                IndentHeader1.GET("Document No.");
                Location := IndentHeader1."Required Location";

                ////////////TESTFIELD("Multi Vendor Status","Multi Vendor Status"::Open);
                CalculateStockInv;

            end;
        }
        field(4; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Description 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                //PRU-AM 1.0
                CALCFIELDS("PO Approve Qty","PO Received Qty");
                "Remaining Qty":=Quantity-("PO Approve Qty"+"PO Received Qty");
                //PRU-AM 1.0
                */

            end;
        }
        field(7; UOM; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Expected Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;
        }
        field(11; "Technical Specification"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "PO Approve Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Qty. to Receive" WHERE("Document Type" = FILTER(Order),
                                                                       "Indent No." = FIELD("Document No."),
                                                                       "Indent Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "PO Received Qty"; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE("Indent No." = FIELD("Document No."),
                                                                  "Indent Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Approved,Closed,Rejected,Pending Approval,Issued';
            OptionMembers = Open,Approved,Closed,Rejected,"Pending Approval",Issued;
        }
        field(15; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            var
                Indentheader: Record 50011;
            begin
                TESTFIELD(Status, Status::Open);
                //////////////////////TESTFIELD("Multi Vendor Status","Multi Vendor Status"::Open);
                TESTFIELD("No.");
                Indentheader.GET("Document No.");
                Indentheader.TESTFIELD(Indentheader.Status, Indentheader.Status::Open);
            end;
        }
        field(16; "Vendor Exist"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Multi Vendor Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Approved';
            OptionMembers = Open,Approved;
        }
        field(18; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record 5402;
                ResUnitofMeasure: Record 205;
            begin
            end;
        }
        field(19; "Variant Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(20; "Approval User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Indent Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "No. of PO"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Stock In Hand"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VR1.00';
            Editable = false;
        }
        field(24; Type; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
            OptionCaption = ' ,Item,Fixed Asset';
            OptionMembers = " ",Item,"Fixed Asset";
        }
        field(25; "Remaining Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-AM 1.0';
            Editable = true;
        }
        field(26; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-ASH1.0';

            trigger OnValidate()
            begin
                IndentHeader.RESET;
                IndentHeader.SETRANGE("Indent No.", "Document No.");
                IF IndentHeader.FINDFIRST THEN BEGIN
                    IF "Due Date" < IndentHeader."Indent Date" THEN
                        ERROR('Due Date cannot be less than Indent Date');
                END;
            end;
        }
        field(27; "Approx Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-ASH1.0';
        }
        field(28; "Internal Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-ASH1.0';
        }
        field(29; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-ASH1.0';
        }
        field(30; "Batch Creation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(31; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(32; "Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(33; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 7.0';
            Editable = false;
        }
        field(34; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "From Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            var
                Indentheader: Record 50011;
            begin
                TESTFIELD(Status, Status::Open);
                //////////////////////TESTFIELD("Multi Vendor Status","Multi Vendor Status"::Open);
                TESTFIELD("No.");
                Indentheader.GET("Document No.");
                Indentheader.TESTFIELD(Indentheader.Status, Indentheader.Status::Open);
            end;
        }
        field(36; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CALCFIELDS("PO Received Qty");
        IF Status = Status::Open THEN BEGIN
            IF ("PO Received Qty" <> 0) THEN
                ERROR(Text50003)
        END
        ELSE
            ERROR(Text50003);
        IF "Approval Status" = "Approval Status"::Approved THEN
            ERROR(Text50003);
        ///MultiVendor1.RESET;
        ///MultiVendor1.SETRANGE("Indent No.","Document No.");
        ///MultiVendor1.SETRANGE("Indent Line No.","Line No.");
        ///MultiVendor1.DELETEALL;
    end;

    trigger OnInsert()
    begin
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        Usersetup.SETFILTER(Usersetup."Access Indent", '%1', Usersetup."Access Indent"::View);
        IF Usersetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new indent');

        VALIDATE("Indent Date", WORKDATE);
        userset.GET(USERID);
        RespCntr.GET(userset."Responsibility Center");//PRU-VG
        //PRU-RC <<
        //"Dept. Code":=userset."Shortcut Dimension 1 Code";
        "Responsibility Center" := userset."Responsibility Center";
    end;

    trigger OnRename()
    begin
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        Usersetup.SETFILTER(Usersetup."Access Indent", '%1', Usersetup."Access Indent"::View);
        IF Usersetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new indent');
    end;

    var
        Item: Record 27;
        Vendor: Record 23;
        Usersetup: Record 91;
        IndentHeader: Record 50011;
        ILE: Record 32;
        SafetyStock: Decimal;
        QtyonPurchOrder: Decimal;
        QtyOnProdOrder: Decimal;
        "Lead Time": DateFormula;
        FA: Record 5600;
        IndentLine: Record 50012;
        IndentHeader1: Record 50011;
        userset: Record 91;
        RespCntr: Record 5714;
        Text50001: Label 'You do not have permission to approve the requisition line.';
        Text50000: Label 'You cannot approve more then %1 quantity';
        Text50002: Label 'PO quantity cannot be less then quantity %1';
        Text50003: Label 'You cannot delete the Indent Line.';


    procedure OpenMultiVendor()
    begin
        /*TESTFIELD("PO Approve Qty");
        MultiVendor.SETRANGE("Indent No.","Document No.");
        MultiVendor.SETRANGE("Item No.","No.");
        MultiVendor.SETRANGE("Indent Line No.","Line No.");
        PageMultiVendor.SETTABLEVIEW(MultiVendor);
        PageMultiVendor.RUNMODAL;
        CLEAR(PageMultiVendor);
        */

    end;

    procedure CalculateStockInv()
    begin
        //PRU-VR1.00
        "Stock In Hand" := 0;
        IF ("No." <> '') THEN BEGIN
            Item.RESET;
            Item.SETRANGE("No.", "No.");
            IF Location <> '' THEN
                IndentHeader.RESET;
            IndentHeader.SETRANGE("Indent No.", "Document No.");
            IF IndentHeader.FINDFIRST THEN
                //Item.SETFILTER("Minimum Quantity",'%1',IndentHeader."Responsibility Center");//PRU-VG
                //IF Item.FINDFIRST THEN                                   //PRU-VG
                //BEGIN
                ILE.RESET;
            ILE.SETRANGE("Item No.", Item."No.");
            ILE.SETRANGE("Location Code", Location); //RK-PRU
                                                     //        ILE.SETFILTER("Rejected Location",'%1',FALSE);      //PRU-VG
            IF ILE.FINDSET THEN BEGIN
                REPEAT
                    "Stock In Hand" += ILE.Quantity;
                UNTIL ILE.NEXT = 0;
            END;
            //END;                        //PRU-VG
        END;
        //PRU-VR1.00
    end;


    procedure AssignlotNumber()
    begin
        TESTFIELD("No.");
        TESTFIELD(Quantity);
        //TESTFIELD("Posting Date");
        //TESTFIELD("From Location");
        CallItemTracking(Rec);
    end;


    procedure CallItemTracking(var RecIssueLine: Record 50012)
    var
        TrackingSpecification: Record 336;
        ItemTrackingPage: Page 6510;
        ItemJnlLine: Record 83;
    begin
        /*ItemTracking(RecIssueLine,TrackingSpecification);
        ItemTrackingPage.SetFormRunMode(1);
        ItemTrackingPage.SetSourceSpec(TrackingSpecification,WORKDATE);
        ItemTrackingPage.SetInbound(ItemJnlLine.IsInbound);
        ItemTrackingPage.RUNMODAL;
        */

    end;


    procedure ItemTracking(var LocIssueLine: Record 50012; var TrackingSpecification: Record 336)
    var
        InvSetup: Record 312;
    begin
        /*
        "Farm Location" := recDataEntry."Farm Location";
        JournalTamplate := recDataEntry."Journal Template Name";
        "Batch Name" := recDataEntry."Journal Batch Name";
        END;
        */
        InvSetup.GET;
        IF LocIssueLine.Quantity > 0 THEN BEGIN
            TrackingSpecification.INIT;
            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
            //WITH ItemJnlLine DO BEGIN
            TrackingSpecification."Item No." := LocIssueLine."No.";
            TrackingSpecification."Location Code" := LocIssueLine."From Location";
            //TrackingSpecification.Description := Description;
            //TrackingSpecification."Variant Code" := LocIssueLine."Variant Code";
            TrackingSpecification."Source Subtype" := TrackingSpecification."Source Subtype"::"4";
            TrackingSpecification."Source ID" := 'RECLASS';
            TrackingSpecification."Source Batch Name" := InvSetup."Indent Batch Name";
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := LocIssueLine."Line No.";
            TrackingSpecification."Quantity (Base)" := LocIssueLine.Quantity;
            TrackingSpecification."Qty. to Handle" := LocIssueLine.Quantity;
            TrackingSpecification."Qty. to Handle (Base)" := LocIssueLine.Quantity;
            TrackingSpecification."Qty. to Invoice" := LocIssueLine.Quantity;
            TrackingSpecification."Qty. to Invoice (Base)" := LocIssueLine.Quantity;
            TrackingSpecification."Quantity Handled (Base)" := 0;
            TrackingSpecification."Quantity Invoiced (Base)" := 0;
            TrackingSpecification."Qty. per Unit of Measure" := 1;
            //TrackingSpecification."Bin Code" := "Bin Code";
            //END;
            //END;
            /*ParameterMaster.SETRANGE("No.",RecDataEntryLines."Parameter No.");
            IF ParameterMaster.FINDFIRST THEN;
              ParameterType:=FORMAT(ParameterMaster."Type of Parameter");
            InvSetup
            IF ParameterType='Consumption' THEN
              BEGIN*/
            /*TrackingSpecification.INIT;
            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
            TrackingSpecification."Entry No." += 1;
            TrackingSpecification."Item No." := LocIssueLine."Item Code";
            TrackingSpecification."Location Code" := LocIssueLine."From Location";
            TrackingSpecification."Source Subtype" := 4;
            TrackingSpecification."Source ID" := 'RECLASS';
            TrackingSpecification."Source Batch Name" := InvSetup."Issue Location Batch";
            /////TrackingSpecification.Description := "Parameter Description";
            TrackingSpecification."Creation Date" := LocIssueLine."Posting Date";
            TrackingSpecification."Quantity (Base)" := LocIssueLine."Issue Qty";
            //TrackingSpecification."Source Prod. Order Line" := 0;
            //TrackingSpecification."Source Ref. No." := "Line No.";
            TrackingSpecification."Qty. to Handle (Base)" := LocIssueLine."Issue Qty";
            TrackingSpecification."Qty. per Unit of Measure" := 1;
            TrackingSpecification."Qty. to Invoice (Base)" := LocIssueLine."Issue Qty";
            TrackingSpecification."Quantity Invoiced (Base)" := 0;
            TrackingSpecification."Qty. to Invoice" := LocIssueLine."Issue Qty";*/
            /*END;
            IF ParameterType='Production' THEN
            BEGIN
                TrackingSpecification.INIT;
                TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
                TrackingSpecification."Entry No." += 1;
                TrackingSpecification."Item No." := "Item No.";
                TrackingSpecification."Location Code" := "Farm Location";
                TrackingSpecification."Source Subtype" := 2;
                TrackingSpecification."Source ID" := JournalTamplate;
                TrackingSpecification."Source Batch Name" := "Batch Name";
                TrackingSpecification.Description := "Parameter Description";
                TrackingSpecification."Creation Date" := "Posting Date";
                TrackingSpecification."Quantity (Base)" := "Actual Value";
                TrackingSpecification."Source Prod. Order Line" := 0;
                TrackingSpecification."Source Ref. No." := "Line No.";
                TrackingSpecification."Qty. per Unit of Measure" := 1;
                TrackingSpecification."Qty. to Invoice (Base)" := "Actual Value";
                TrackingSpecification."Quantity Invoiced (Base)" := "Actual Value";
                TrackingSpecification."Qty. to Invoice" := "Actual Value";
            END;*/
        END;

    end;
}

