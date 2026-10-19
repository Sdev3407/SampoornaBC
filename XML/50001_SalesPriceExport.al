xmlport 50001 "Sales Price Export"
{
    Caption = 'Item Varient Export';

    Format = VariableText;

    schema
    {
        textelement(ROOT)
        {
            tableelement(ItemVariant; "Item Variant")
            {

                fieldelement(Code; ItemVariant.Code)
                {
                }
                fieldelement(ItemNo; ItemVariant."Item No.")
                {
                }

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

