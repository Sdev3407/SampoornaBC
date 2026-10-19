pageextension 50157 SalesPerExt extends "Salesperson/Purchaser Card"
{
    layout
    {

        addafter("Privacy Blocked")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
            }


        }

        addafter(Invoicing)
        {
            group(SFPL)
            {

                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Visible = false;
                }


            }
        }
    }


}
