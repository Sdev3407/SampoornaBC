table 50040 "SFPL_Security Group"
{
    DataClassification = ToBeClassified;
    Caption = 'Security Group';
    LookupPageId = "Security Group";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '0';
        }
        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group".Code;

            // WHERE("Global Dimension No." = CONST(2),
            //Blocked = CONST(false));
        }
        field(4; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
    }
    keys
    {
        key(Key1; Code, "Vendor No.", "Posting Group")
        {
            Clustered = true;
        }
    }
}