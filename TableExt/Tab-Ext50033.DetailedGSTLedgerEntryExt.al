
tableextension 50033 DetailedGSTLedgerEntryExt extends "Detailed GST Ledger Entry"
{
    fields
    {
        field(50000; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Item Category Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
