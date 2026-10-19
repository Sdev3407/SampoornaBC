table 50050 "Project"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Project List";

    fields
    {
        field(50000; "Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50001; "Project Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; Location, "Project Code")
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