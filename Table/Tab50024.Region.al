table 50024 "Region"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Region Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Email ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "MobileNo."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Region Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
}

