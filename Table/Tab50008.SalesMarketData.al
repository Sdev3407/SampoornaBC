Table 50008 "Sales Market Data"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Mobile No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Father Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Village"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Tehsil"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Distt."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PIN Code"; Text[6])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "State"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Type Of Consumer"; Option)
        {
            OptionMembers = " ","Trader","Farmer","Milk Collector";
        }
        field(10; "Sales Person"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Team Leader"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Name, "Mobile No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

