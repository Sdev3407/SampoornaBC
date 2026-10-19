table 50009 "Web User Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "LOB"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('LOB'), "Global Dimension No." = filter(1));
        }

        field(3; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('BRANCH'), "Global Dimension No." = filter(2));

            trigger OnValidate()
            var
                Dimensionvalue: Record "Dimension Value";
            begin
                If rec."Branch Code" <> '' Then
                    Dimensionvalue.Get('BRANCH', rec."Branch Code");
                rec."Branch Name" := Dimensionvalue.Name;
            end;
        }
        field(4; "LOC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('LOC'), "Global Dimension No." = filter(3));
        }
        field(5; "Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "User Name", LOB, "Branch Code", "LOC Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

