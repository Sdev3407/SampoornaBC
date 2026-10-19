tableextension 50008 GSTRegistrationNoExt extends "GST Registration Nos."
{
    fields
    {
        field(60001; "E-Invoicing User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "E-Invoicing User Password"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "E-Way Bill User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "E-Way User Password"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Login USER ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        UserSetup: Record 91;
}