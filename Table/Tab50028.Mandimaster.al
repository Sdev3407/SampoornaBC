table 50028 "Mandi master"
{
    DataClassification = ToBeClassified;
    Caption = 'Mandi master';
    DataCaptionFields = "Code", Description, Blocked;
    LookupPageID = 50100;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Blocked)
        {
        }
    }
}

