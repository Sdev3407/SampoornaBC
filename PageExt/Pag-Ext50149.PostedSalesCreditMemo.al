pageextension 50149 PostedSalesCreditMemo extends "Posted Sales Credit Memo"

{
    layout
    {
        addafter("No. Printed")
        {
            field("Driver Mobile No."; rec."Driver Mobile No.")
            {
                ApplicationArea = all;
            }
            field("Return Order No."; rec."Return Order No.")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Tax Info")
        {
            group("Foreign Trade")
            {

            }
        }
        movefirst("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "EU 3-Party Trade")
    }

    actions
    {

    }


}