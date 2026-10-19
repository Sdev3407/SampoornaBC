table 50044 "FA Assign"
{
    DataClassification = ToBeClassified;
    LookupPageId = "FA Assign";
    DrillDownPageId = "FA Assign";
    //Caption = 'IT Assets Register';
    fields
    {
        field(1; "FA No."; Code[10])
        {
            TableRelation = ITAssetsRegister;

        }
        field(2; "Employee Code"; Code[10])
        {
            TableRelation = Employee;

        }
        field(3; "Effective Date"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "Employee Code", "Effective Date")
        {
            Clustered = true;
        }
    }
}
