tableextension 50087 MachineCenterExt extends "Machine Center"
{
    fields
    {
        field(50000; "Responsibility Center"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Run Time Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}