tableextension 50057 SalesPriceExt extends "Sales Price"
{
    fields
    {
        modify("Starting Date")
        {
            trigger OnAfterValidate()
            var
                T7002: Record 7002;
            begin
                IF "Location Code" <> '' THEN BEGIN
                    //PRU-VG
                    T7002.RESET;
                    T7002.SETRANGE("Sales Type", "Sales Type");
                    T7002.SETRANGE("Sales Code", "Sales Code");
                    T7002.SETRANGE("Item No.", "Item No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Location Code", '%1', "Location Code");
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        IF T7002."Starting Date" < "Starting Date" THEN BEGIN
                            T7002."Ending Date" := CALCDATE('-1D', "Starting Date");
                            T7002.MODIFY;
                        END;
                    END;
                END ELSE BEGIN
                    //PRU-VG
                    T7002.RESET;
                    T7002.SETRANGE("Sales Type", "Sales Type");
                    T7002.SETRANGE("Sales Code", "Sales Code");
                    T7002.SETRANGE("Item No.", "Item No.");
                    T7002.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                    T7002.SETFILTER("Location Code", '%1', '');
                    T7002.SETRANGE("Ending Date", 0D);
                    IF T7002.FINDFIRST THEN BEGIN
                        REPEAT
                            IF T7002."Starting Date" <= "Starting Date" THEN BEGIN
                                T7002."Ending Date" := CALCDATE('-1D', "Starting Date");
                                T7002.MODIFY;
                            END;
                        UNTIL T7002.NEXT = 0;
                    END;
                    //PRU-VG
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
                //S.M

            end;
        }
        field(50002; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
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
        field(50005; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
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
        // field(50009; "From Location"; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = Location where("Use As In-Transit" = filter(False));
        // }
        // field(50010; "to Location"; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = Location where("Use As In-Transit" = filter(False));
        // }
    }

    keys
    {
        key(MyKey; "Location Code")
        {
            //   Clustered = true;
        }
        // key(MyKey2; "From Location", "to Location")
        // {

        // }
    }
    var
        IsApprovalFlag: Boolean;

    trigger OnAfterModify()
    begin
        Rec."Approval Required" := TRUE;
    end;

    trigger OnAfterRename()
    begin
        Rec."Approval Required" := TRUE;
    end;

    procedure SetFromApprovalFlag(ApprovalFlag: Boolean)
    begin
        IsApprovalFlag := ApprovalFlag;
    end;


    procedure ReleaseSalePrice()
    var
        TransferLine: Record 5741;
    begin
        VALIDATE(Status, Status::Released);
    end;


    procedure ReopenSalesPrice(SalesCode: Code[30]; ItemNo: Code[30]; DocStatus: Option Open,Released,"Pending Approval")
    var
        Text000: Label 'Indent Status must be ''Indent'' in the Indent Lines';
        Text007: Label 'Can not Reopen the indent if status is Cancel/Closed.';
        Text008: Label 'Sales Price Must be Released.';
        SalesPrice: Record 7002;
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