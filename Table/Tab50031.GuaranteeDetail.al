table 50031 "Guarantee Detail"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                //GK26042021-
                CLEAR(Cust);
                CLEAR("Customer Name");
                Cust.RESET;
                IF Cust.GET("Customer Code") THEN
                    "Customer Name" := Cust.Name;
                //GK26042021+
            end;
        }
        field(2; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Bank Guarantee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Bank Guarantee Document No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Bank Guarantee Durration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Check1; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Check2; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Check3; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Check4; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Check Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Pan Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Adhar Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Remark; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "By Legal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Profile"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Photo"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bank passbook"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer Code", "Bank Name", "Bank Guarantee Amount", "Bank Guarantee Document No.", "Bank Guarantee Durration", "Expiry Date", Check1, Check2, Check3, Check4, "Check Amount")
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

