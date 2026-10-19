xmlport 50002 "Sales Price Export1"
{
    Direction = Export;
    Format = VariableText;
    Caption = 'Sales Price Export';
    schema
    {
        textelement(ROOT)
        {
            tableelement("SalesPrice"; "Sales Price")
            {

                fieldelement(ItemNo; SalesPrice."Item No.")
                {
                }
                fieldelement(SalesCode; SalesPrice."Sales Code")
                {
                }
                fieldelement(LocationCOde; SalesPrice."Location Code")
                { }
                fieldelement(VarientCode; SalesPrice."Variant Code")
                { }
                fieldelement(StartingDate; SalesPrice."Starting Date")
                { }
                fieldelement(EndingDate; SalesPrice."Ending Date")
                { }
                fieldelement(UnitOfMeausre; SalesPrice."Unit of Measure Code")
                { }
                fieldelement(Quantity; SalesPrice."Minimum Quantity")
                { }
                fieldelement(UnitPrice; SalesPrice."Unit Price")
                { }

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

