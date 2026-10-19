tableextension 50024 TransferReceiptHeaderExt extends "Transfer Receipt Header"
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
            CaptionClass = '1,2,1';
            Caption = 'New Shortcut Dimension 1 Code';
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
            CaptionClass = '1,2,2';
            Caption = 'New Shortcut Dimension 2 Code';
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
        field(50008; "New LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New LOB';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateCustomShortcutDimCode(1,"New LOB");
            end;
        }
        field(50009; "New Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Branch';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateCustomShortcutDimCode(2,"New Branch");
            end;
        }
        field(50010; "New Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'New Dimension Set ID';
            Description = 'PRU_RPG NDF 0.1';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin

                //ShowDocDim;
            end;
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
        }
        //SIM-----------Code Added-------------

        field(50052; "Freight Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}