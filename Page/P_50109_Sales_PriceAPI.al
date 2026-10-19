
page 50109 "Sales Price"
{
    PageType = API;
    EntityName = 'SalesPrice';
    EntitySetName = 'SalesPrice';
    EntityCaption = 'Sales Price';
    SourceTable = "Sales Price";
    DelayedInsert = True;
    // ApplicationArea = All;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SalesType"; Rec."Sales Type")
                {
                    ApplicationArea = all;
                }
                field("SalesCode"; Rec."Sales Code")
                {
                    ApplicationArea = all;
                }
                field("StartingDate"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("EndingDate"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("ItemNo"; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("LocationCode"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("UnitofMeasureCode"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("MRPPRICE"; Rec."MRP PRICE")
                {
                    ApplicationArea = all;
                }
                field("UnitPrice"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }
}


