table 50032 "Temporary Credit Limit"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                CLEAR(Cust);
                CLEAR("Customer Name");
                Cust.RESET;
                IF Cust.GET("Customer No") THEN
                    "Customer Name" := Cust.Name;
            end;
        }
        field(2; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Remark; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

