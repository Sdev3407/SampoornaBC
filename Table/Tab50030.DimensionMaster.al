table 50030 "Dimension Master"
{
    DataClassification = ToBeClassified;
    //  DrillDownPageID = 50105;
    //LookupPageID = 50105;

    fields
    {
        field(1; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'PRU_RPG DM_0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(2; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'PRU_RPG DM_0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(3; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'PRU_RPG DM_0.1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
    }

    keys
    {
        key(Key1; "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

