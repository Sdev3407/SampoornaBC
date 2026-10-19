table 50029 "Customer Scheme Detail"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                CLEAR(Cust);
                CLEAR(Name);
                Cust.RESET;
                IF Cust.GET("Customer Code") THEN
                    Name := Cust.Name;
            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "FREIGHT ON BROILER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "FREIGHT ON LAYER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "MONTHLY SCHEME ON BROILER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "MONTHLY SCHEME ON LAYER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "YEARLY SCHEME ON BROILER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "YEARLY SCHEME ON LAYER"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "FREIGHT AMOUNT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; OVERRDING; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "COMMISION ON SALE"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer Code")
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

