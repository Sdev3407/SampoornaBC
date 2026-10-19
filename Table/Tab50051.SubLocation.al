table 50051 "Sub Location"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Sub Location List";

    fields
    {
        field(50000; "Project Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Project."Project Code";
        }
        field(50001; "Sub Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sub Location Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Project Code", "Sub Location Code")
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