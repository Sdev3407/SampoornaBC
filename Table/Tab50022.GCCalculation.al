table 50022 "GC Calculation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; State; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = State;//S.M
        }
        field(2; Type1; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal,EC,Deluxe';
            OptionMembers = " ",Normal,EC,Deluxe;
        }
        field(3; Type2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Incentive,Deduction';
            OptionMembers = " ",Incentive,Deduction;
        }
        field(4; "Parameter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "GC Parameter Master";

            trigger OnValidate()
            begin
                IF Rec_parameter.GET("Parameter Code") THEN
                    "Parameter Description" := Rec_parameter.Description
                ELSE
                    "Parameter Description" := '';
            end;
        }
        field(5; "Parameter Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(6; Value1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Value2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Value3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Value4; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Value5; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; State, Type1, Type2, "Parameter Code", "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Rec_parameter: Record 50023;
}

