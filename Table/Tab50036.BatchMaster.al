table 50036 "Batch Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Batch Master';

    fields
    {
        field(1; "Batch Type"; Option)
        {
            OptionCaption = ' ,LB,TP,RP';
            OptionMembers = ,LB,TP,RP;

        }
        field(2; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Batch Date';
            //Editable = false;
            //FieldClass = FlowFilter;
        }
        field(3; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //Caption = 'Overdue Date Filter';

        }
    }

    keys
    {
        key(Key1; "Batch Type", "Batch Date", "Batch No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

