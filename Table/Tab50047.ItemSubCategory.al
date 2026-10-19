table 50047 "Item Sub Category"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Item Sub Category";

    fields
    {
        field(50000; "Item Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Item Sub Category Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Item Category", "Code")
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