tableextension 50005 GenJournalBatchExt extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; "Shortcut Dimension 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }
}