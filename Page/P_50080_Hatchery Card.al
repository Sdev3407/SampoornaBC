page 50080 "Hatchery Card"
{
    PageType = Card;
    SourceTable = "Hatchery Name";
    // ApplicationArea = All;
    //UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Hatchery No."; Rec."Hatchery No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Hatchery Name"; Rec."Hatchery Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

