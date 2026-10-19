page 50145 "TransferPrice"
{
    ApplicationArea = All;
    Caption = 'Transfer Price';
    PageType = List;
    SourceTable = "Transfer Price";
    UsageCategory = Lists;



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = all;

                }
                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = all;


                }
                field("End Date"; rec."End Date")
                {
                    ApplicationArea = all;
                }
                field("From Branch"; rec."From Branch")
                {
                    ApplicationArea = all;
                }
                field("To Branch"; Rec."To Branch")
                {
                    ApplicationArea = all;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}
