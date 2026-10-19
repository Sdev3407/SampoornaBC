Page 50133 EditVLE
{
    ApplicationArea = All;
    Caption = 'Edit VLE';
    EntityName = 'SalesHeader';
    EntitySetName = 'SalesHeader';
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No"; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date of this entry.';
                }
                field("DocumentType"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date of this entry.';
                }
                field("PostingDate"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date of this entry.';
                }

            }
        }
    }

    actions
    {

    }

}