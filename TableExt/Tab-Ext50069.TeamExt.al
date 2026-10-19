tableextension 50069 TeamExt extends Team
{
    fields
    {
        field(50000; "Team Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Cattle,Poultry,CBF,SWINE;
        }
        field(50001; "Team Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Managment Phone No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Delivery OTP"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50005; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}