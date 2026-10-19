table 50045 ResponseGstRegistration
{
    Caption = 'ResponseGstRegistration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; hash; Code[100])
        {
            Caption = 'hash';
        }
        field(2; val; Decimal)
        {
            Caption = 'val';
        }
        field(3; samt; Decimal)
        {
            Caption = 'samt';
        }
        field(4; txval; Decimal)
        {
            Caption = 'txval';
        }
        field(5; rtnprd; Text[20])
        {
            Caption = 'rtnprd';
        }
        field(6; camt; Decimal)
        {
            Caption = 'camt';
        }
        field(7; inum; Text[30])
        {
            Caption = 'inum';
        }
        field(8; cess; Decimal)
        {
            Caption = 'cess';
        }
        field(9; srcfilstatus; Text[50])
        {
            Caption = 'srcfilstatus';
        }
        field(10; iamt; Decimal)
        {
            Caption = 'iamt';
        }
        field(11; stin; Code[30])
        {
            Caption = 'stin';
        }
        field(12; srcform; Text[10])
        {
            Caption = 'srcform';
        }
        field(13; inv_typ; Text[10])
        {
            Caption = 'inv_typ';
        }
        field(14; pos; Text[10])
        {
            Caption = 'pos';
        }
        field(15; idt; Text[50])
        {
            Caption = 'idt';
        }
        field(16; "action"; Text[10])
        {
            Caption = 'action';
        }
        field(17; ispendactblocked; Text[10])
        {
            Caption = 'ispendactblocked';
        }
        field(18; "ERP Status"; Option)
        {
            OptionMembers = " ","Accepted","Pending";
        }
        field(19; Sync; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "GST Registation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Tran Ref No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Reposne Message"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Section; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "oinum"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "oidt"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; hash)
        {
            Clustered = true;
        }
    }
}
