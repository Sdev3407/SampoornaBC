tableextension 50099 CompanyinfoExt extends "Company Information"
{
    fields
    {
        field(50000; "SFPL_C.I.N No."; Text[50])
        {
            Caption = 'C.I.N No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "SFPL_FSSAI No."; Text[20])
        {
            Caption = 'FSSAI No.';
            DataClassification = ToBeClassified;
        }
        field(50002; "SFPLCompany"; Option)
        {
            Caption = 'Company';
            OptionCaption = 'Sampoorna,Star Foods,Vetadd';
            OptionMembers = "Sampoorna","Star Foods","Vetadd";
        }
        field(50003; "API Key"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Project ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Watermark; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50006; "Disable PAN Varification API"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Password"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }

    }
}