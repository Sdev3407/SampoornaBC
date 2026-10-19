table 50033 "Line Name (CBF)"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = filter('BRANCH'),
                                                          "Dimension Value Type" = FILTER(Standard));
        }
        field(2; "Line Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line Discription"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Line Discription", "Line Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

