table 50056 "Power Data Entry"
{
    DataClassification = ToBeClassified;
    Caption = 'Data Entry Sheet';
   

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN

                    NoSeriesMgt.TestManual('Power');
                    "No. Series" := '';
                END;

            end;
        }
        field(2; "Location"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = Location WHERE("Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                                                          Block = CONST(false));
        }
        field(3; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "Power Units Consumed"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PowerMater: Record "Power Data Master Setup";
            begin
                DiesalCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Diesel);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    DiesalCost := PowerMater."Unit Rate" * Rec."Diesel Quantity Consumed";
                PowerCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Electricity);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    PowerCost := PowerMater."Unit Rate" * Rec."Power Units Consumed";

                Rec."Cost of Power and Diesel" := (PowerCost + DiesalCost);
                Rec."Per Ton Power Cost " := ((PowerCost + DiesalCost) / Rec."Production Details in MT ");


            end;
        }
        field(5; "Diesel Quantity Consumed"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PowerMater: Record "Power Data Master Setup";
            begin
                DiesalCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Diesel);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    DiesalCost := PowerMater."Unit Rate" * Rec."Diesel Quantity Consumed";
                PowerCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Electricity);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    PowerCost := PowerMater."Unit Rate" * Rec."Power Units Consumed";

                Rec."Cost of Power and Diesel" := (PowerCost + DiesalCost);
                Rec."Per Ton Power Cost " := ((PowerCost + DiesalCost) / Rec."Production Details in MT ");


            end;
        }
        field(6; "Production Details in MT "; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PowerMater: Record "Power Data Master Setup";
            begin

                DiesalCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Diesel);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    DiesalCost := PowerMater."Unit Rate" * Rec."Diesel Quantity Consumed";

                PowerCost := 0;
                PowerMater.Reset();
                PowerMater.SetRange("Power Type", PowerMater."Power Type"::Electricity);
                PowerMater.SetRange(Location, Rec.Location);
                PowerMater.Setrange("Efective From", 0D, Rec."Posting Date");
                if PowerMater.FindFirst() then
                    PowerCost := PowerMater."Unit Rate" * Rec."Power Units Consumed";

                Rec."Cost of Power and Diesel" := (PowerCost + DiesalCost);

                Rec."Per Ton Power Cost " := ((PowerCost + DiesalCost) / Rec."Production Details in MT ");

            end;
        }
        field(7; "Cost of Power and Diesel"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Per Ton Power Cost "; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
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
        field(12; "Shortcut Dimension 2 Code"; Code[20])
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
        field(13; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    begin

    end;

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            //GeneralLedgerSetup.TESTFIELD(GeneralLedgerSetup."Data Sheet Nos");

            NoSeriesMgt.InitSeries('Power', xRec."No. Series", 0D, "No.", "No. Series");
        END;

    end;

    var
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit 408;
        DiesalCost: Decimal;
        PowerCost: Decimal;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}