page 50122 "Posting Date Input"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Lists;



    layout
    {
        area(content)
        {
            field("Liquidation Date"; PostingDate)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        PostingDate: Date;
        GCStatement: Page "GC Statement";


    procedure GetFillterValue(var PostingD: Date)
    begin
        PostingD := PostingDate;
    end;
}

