pageextension 50185 "Item Tracking Code ext" extends "Item Tracking Code Card"
{
    layout
    {
        addafter("Strict Expiration Posting")
        {
            field("Strict Mfg. Date Posting"; Rec."Strict Mfg. Date Posting")
            {
                ApplicationArea = all;
            }
        }
    }
}