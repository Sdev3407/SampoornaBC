pageextension 50035 GeneralJournalBatchesExt extends "General Journal Batches"
{
    layout
    {
        addafter(Name)
        {
            field("Shortcut Dimension 2"; Rec."Shortcut Dimension 2")
            {
                ApplicationArea = All;

            }
        }
    }
}