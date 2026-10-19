table 50007 "Sales Person Target"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sales Person Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Qty In MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Sales Person Code", "Start Date", "End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

