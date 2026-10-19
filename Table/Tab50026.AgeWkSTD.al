table 50026 "Age Wk & STD %"
{
    DataClassification = ToBeClassified;
    DrillDownPageID = 50088;
    LookupPageID = 50088;

    fields
    {
        field(1; "AGE WK"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "CHICKS PRODUCTION %"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "AGE WK")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

