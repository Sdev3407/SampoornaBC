pageextension 50184 "ProdBOMVersion" extends "Prod. BOM Version List"
{

    layout
    {
        addafter("Last Date Modified")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = all;
            }
        }
    }

}
