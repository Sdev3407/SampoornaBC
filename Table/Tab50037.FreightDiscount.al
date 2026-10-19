table 50037 "Freight Discount"
{
    DataClassification = ToBeClassified;
    // LookupPageID = 50110;

    fields
    {
        field(1; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE("No." = FIELD("Customer Code"));
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE("No." = FIELD("Item No."));
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; UOM; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
        field(5; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer Code", "Item No.", "Starting Date", UOM, "Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

