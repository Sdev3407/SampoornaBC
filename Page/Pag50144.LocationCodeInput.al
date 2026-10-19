page 50144 "Location Code Input"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Lists;



    layout
    {
        area(content)
        {
            field("Location Code"; LocationCode)
            {
                ApplicationArea = All;
            }
            field("Quantity(KG) "; Quantity)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        LocationCode: Code[10];
        Quantity: Decimal;
    //GCStatement: Page "GC Statement";


    procedure GetFillterValue(var LocationCodeD: Code[10]; QtyD: Decimal)
    begin
        LocationCodeD := LocationCode;
        QtyD := Quantity;
    end;
}

