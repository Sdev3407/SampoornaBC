pageextension 50002 CustomerPriceGroupsExt extends "Customer Price Groups"
{
    layout
    {
        addafter("Allow Line Disc.")
        {
            field(Block; Rec.Block)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Cust. &Price Group")
        {
            action("Import Sales Price line")
            {
                ApplicationArea = All;
                Caption = 'Import Sales Price Line';
                Image = SalesPrices;
                ToolTip = 'Define how to set up sales price agreements. These sales prices can be for individual customers, for a group of customers, for all customers, or for a campaign.';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = xmlport "SalesPrice ImportData";
            }
        }
    }

    var
        myInt: Integer;

}