table 50052 "Section"
{
    DataClassification = ToBeClassified;
    LookupPageID = Section;

    fields
    {
        field(50000; "Sub Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub Location"."Sub Location Code";
        }
        field(50001; "Section Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Section Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Sub Location Code", "Section Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}