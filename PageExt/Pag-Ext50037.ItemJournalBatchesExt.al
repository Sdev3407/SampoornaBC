pageextension 50037 ItemJournalBatchesExt extends "Item Journal Batches"
{

    layout
    {
        addafter("Item Tracking on Lines")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
        }
    }
}