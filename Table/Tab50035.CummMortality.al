table 50035 "Cumm Mortality"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bread Code"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Age; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Daily Intake (Gms)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(4; "Cum.Intake (Gms)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(5; "Weight (Gms)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(6; FCR; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(7; "Cumm. Mortality"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(8; "Daily Gain (Gms)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(9; "Avg Daily Gain/Week (Gms)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
    }

    keys
    {
        key(Key1; "Bread Code", Age)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

