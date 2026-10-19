table 50054 "Consumable Setup"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Consumption Posting Setup";

    fields
    {
        field(50000; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50001; "Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GENgroup: Record "Gen. Product Posting Group";
            begin
                GENgroup.Get(Rec."Posting Group");
                Rec.validate(Name, GENgroup.Description);

            end;
        }
        field(50002; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }


    }

    keys
    {
        key(Key1; "Item No.", "Posting Group")
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