 table 50057 "Power Data Master Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Power Data Master Setup';
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Table Designer               New Table Created.


    fields
    {
        field(1; "Power Type"; Option)
        {
            OptionMembers = " ","Electricity","Diesel";
        }
        field(2; "Location"; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = Location WHERE(Block = CONST(false));
        }
        field(3; "Efective From"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Effective From';
        }
        field(4; "Unit Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Power Type", Location, "Efective From")
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

    end;

    var
        NoSeriesMgt: Codeunit 396;
}