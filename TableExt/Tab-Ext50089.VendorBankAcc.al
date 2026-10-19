tableextension 50089 VendorBankAcc extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "IFSC Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}