pageextension 50145 VendorBankAccListExt extends "Vendor Bank Account List"
{
    layout
    {
        addafter(Contact)
        {
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = all;
            }
        }
    }
}