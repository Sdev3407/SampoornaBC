table 50021 "GC Standard Cost"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Shed Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,EC,Super Deluxe';
            OptionMembers = " ",Normal,EC,"Super Deluxe";
        }
        field(2; "State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Std. Production Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Std. Sales Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Std. Admin Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Std. GC Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Shed Type", "State Code", "Starting Date", "Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

