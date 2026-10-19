table 50020 "GC Rate Calculation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,Other Suppliment';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(2; "State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code; //S.M

            trigger OnValidate()
            begin
                IF "Item Type" IN ["Item Type"::Medicine, "Item Type"::Vaccination] THEN
                    TESTFIELD("Item No.");
            end;
        }
        field(3; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Item Type" = FILTER(Medicine | Vaccination)) Item WHERE("Item Type" = FILTER(Medicine | Vaccination));
        }
        field(5; "Shed Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,EC,Super Deluxe';
            OptionMembers = " ",Normal,EC,"Super Deluxe";
        }
        field(50000; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item Type", "State Code", "Item No.", "Shed Type", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

