tableextension 50026 TransferShipmentHeaderExt extends "Transfer Shipment Header"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Responsibility Center";
        }
        field(50002; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
            end;
        }
        field(50003; "New Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            Caption = 'New LOB';
            Description = 'PRU-VG';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50004; "New Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Branch';
            Description = 'PRU-VG';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50005; "Debit Note Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk';
            OptionCaption = ' ,Debit Note';
            OptionMembers = " ","Debit Note";
        }
        field(50012; "From State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "To State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //SIM-----------Code Added-------------
        field(50050; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where(Transporter = const(true));
            trigger OnValidate()
            var
                Transporter: Record Vendor;
            begin
                if Transporter.get("Transporter Code") then
                    "Transporter Name" := Transporter.Name;
            end;
        }
        field(50051; "Transporter Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Transporter Code", '');
            end;
        }
        field(50052; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "E-Way Cancelled Date"; DateTime)
        {
            Caption = 'E-Way Cancelled Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50061; "Eway Cancel Remarks"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50060; "Eway Cancel Reason"; Enum "Eway Cancel Reason")
        {
            DataClassification = CustomerContent;
        }
        field(50062; "E-Way Generated Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        //SIM-----------Code Added-------------
        field(60000; "E-Invoice Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Generated,Cancelled';
            OptionMembers = Open,Generated,Cancelled;
        }
        field(60001; "E-Invoice No."; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "E-Invoice Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "E-Invoice QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "E-Invoice Cancel Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
}