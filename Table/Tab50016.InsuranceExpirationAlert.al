table 50016 "Insurance Expiration Alert"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Insurance No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fixed Asset,Location';
            OptionMembers = " ","Fixed Asset",Location;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = FILTER("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF (Type = FILTER(Location)) Location.Code;
        }
        field(4; "Ins. Policy Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Ins. Policy Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Ins. Policy Alert Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "E-Mail ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Premium Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Insured Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(11; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vendor Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(13; "Insurance Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Type".Code;
        }
        field(14; "Building"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Plant & Mach"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Furniture & Fixture"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Electricals"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Office Equipment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Vehicles"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Gen Set"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Boiler"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Transformer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Sold"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Renewed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Old Policy"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Expiration Alert"."Insurance No.";
        }

    }

    keys
    {
        key(Key1; "Insurance No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

