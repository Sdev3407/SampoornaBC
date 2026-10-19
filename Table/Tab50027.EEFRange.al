table 50027 "EEF Range"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Shed Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,EC,Super Deluxe';
            OptionMembers = " ",Normal,EC,"Super Deluxe";
        }
        field(4; "EEF Range From"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "EEF Range To"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "RS/KG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "GC Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,EEF Incentive,Min Growing Charge';
            OptionMembers = " ","EEF Incentive","Min Growing Charge";
        }
        field(8; "State"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State;
        }
    }

    keys
    {
        key(Key1; "Starting Date", "Shed Type", "EEF Range From", "EEF Range To", "RS/KG", State)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

