pageextension 50186 VendorLookupExt extends "Vendor Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
