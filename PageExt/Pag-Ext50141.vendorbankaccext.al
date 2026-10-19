pageextension 50141 vendorbankaccext extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;
            }

        }
    }
}