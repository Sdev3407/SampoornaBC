tableextension 50028 UnitOfMeausreExt extends "Unit of Measure"
{
    fields
    {
        field(50000; "E-Invoicing UOM Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "GST UOM"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}