tableextension 50018 SalespersonPurchaserExt extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50001; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Location; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Password; Text[20])
        {
            DataClassification = ToBeClassified;

            ExtendedDatatype = Masked;
        }
        field(50004; "Password Reset in Next Login"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }
    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
    begin
        //PRU-VG
        UserSetup.GET(USERID);
        VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
        //PRU-VG
    end;
}