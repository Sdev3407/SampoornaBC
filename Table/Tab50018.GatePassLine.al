table 50018 "Gate Pass Line"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionCaption = 'NRGP,RGP,RRGP';
            OptionMembers = NRGP,RGP,RRGP;
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Item No."; Code[20])
        {
            Editable = true;
            TableRelation = IF (Type = CONST(Others)) "Standard Text"
            else
            if (Type = const("Fixed Asset")) "Fixed Asset";

            Caption = 'No.';
            trigger OnValidate()
            var
                loc: Record Location;
                CustomerTab: Record Customer;
                RecFA: Record "Fixed Asset";
                RecStdText: Record "Standard Text";
            begin
                NRGPHeader.SETRANGE("No.", "Document No.");
                IF NRGPHeader.FIND('-') THEN BEGIN
                    "Gen. Bus. Posting Group" := '';
                    if NRGPHeader.Type = NRGPHeader.Type::Vendor then
                        IF VendorTab.GET(NRGPHeader."Code") THEN
                            "Gen. Bus. Posting Group" := VendorTab."Gen. Bus. Posting Group";
                    if NRGPHeader.Type = NRGPHeader.Type::Customer then
                        IF CustomerTab.GET(NRGPHeader."Code") THEN
                            "Gen. Bus. Posting Group" := CustomerTab."Gen. Bus. Posting Group";

                    "Shortcut Dimension 1 Code" := NRGPHeader."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := NRGPHeader."Shortcut Dimension 2 Code";
                    Location := NRGPHeader."Location Code";
                    if NRGPHeader.Type = NRGPHeader.Type::Location then
                        "TO Location" := NRGPHeader."Code";
                    "Document Date" := NRGPHeader."Posting Date";
                    "Dimension Set ID" := NRGPHeader."Dimension Set ID";
                END;

                // TestField(Type);
                if Rec.Type = Rec.Type::"Fixed Asset" then
                    if RecFA.Get("Item No.") then
                        Rec.Description := RecFA.Description;

                if Rec.Type = Rec.Type::Others then
                    if RecStdText.Get("Item No.") then
                        Rec.Description := RecStdText.Description;

                VALIDATE("Unit of Measure Code");
            end;
        }
        field(8; "Qty Per Unit of Measure"; Decimal)
        {
            Editable = false;
        }
        field(9; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;

            trigger OnValidate()
            var
                GPL: Record "Gate Pass Line";
                GPH: Record "Gate PASS Header";
                RGP: Code[20];
            begin

                IF "Document Type" = "Document Type"::RGP THEN
                    "Pending Qty" := Quantity;

                TESTFIELD(Quantity);
                Value := Quantity * "Unit Cost";
            end;
        }
        field(10; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Value := Quantity * "Unit Cost";
            end;
        }
        field(11; "Document Date"; Date)
        {
            Editable = false;
        }
        field(13; Value; Decimal)
        {
            Editable = false;
        }
        field(15; Type; Option)
        {
            OptionMembers = "Fixed Asset",Others;

            trigger OnValidate()
            begin

                IF Type <> xRec.Type THEN BEGIN
                    "Unit of Measure Code" := '';
                    VALIDATE("Item No.", '');
                END;
            end;
        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            begin
                "Qty Per Unit of Measure" := 1;
            end;
        }
        field(18; Description; Text[100])
        {
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(55; Location; Code[20])
        {
            TableRelation = Location.Code;
            Caption = 'From Location Code';
        }
        field(56; "TO Location"; Code[20])
        {
            TableRelation = Location.Code;
        }

        field(70; "Pending Qty"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(80; "RGP No."; Code[20])
        {
            Editable = false;
        }
        field(86; "RGP Line No."; Integer)
        {
            Editable = false;
        }

        field(50000; "Product Group Code"; Code[10])
        {
            // TableRelation = "Product Group".Code;
        }
        field(50001; "Ref. Gate Pass No."; Code[20])
        {
        }
        field(50002; "RGP Qty."; Decimal)
        {

            Caption = 'Qty. To Receive/Ship';
            // CaptionClass = Text50000;
            Editable = false;
            trigger OnValidate()
            begin
                if Rec."RGP Qty." > Rec.Quantity then
                    Error('Quantity to Ship/Receive %1 cannot be greater than Quantity %2', Rec."RGP Qty.", Rec.Quantity);
            end;
        }
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50004; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50005; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(50027; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(60098; "User ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = Integer;
            ValidateTableRelation = false;
        }
        field(60099; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(60100; Vendor; Code[20])
        {
        }
        field(60101; Posted; Boolean)
        {
        }
        field(60102; "Gen. Bus. Posting Group"; Code[10])
        {
        }

        field(60104; Remarks; Text[50])
        {
        }
        field(60105; "Total Line Qty"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity, "Pending Qty";
        }
        key(Key2; "Document No.")
        {
            SumIndexFields = Quantity, "Pending Qty";
        }
        key(Key3; "Document Type", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
    end;

    var

        NRGPHeader: Record "Gate Pass Header";
        VendorTab: Record "Vendor";
}

