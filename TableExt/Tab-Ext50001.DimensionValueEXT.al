tableextension 50001 DimensionValueEXT extends "Dimension Value"
{
    fields
    {
        field(50000; Email; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ';
        }
        field(50001; "Mobile No"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ';
        }
    }
}