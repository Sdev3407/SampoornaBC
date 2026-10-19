pageextension 50054 "FA_Depreciation_BooksExt" extends "FA Depreciation Books"
{
    layout
    {
        addafter("Depreciation Method")
        {
            field("Book Value After Dispasal"; Rec."Book Value After Dispasal")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}