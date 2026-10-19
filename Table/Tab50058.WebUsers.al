table 50058 "WebUsers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "User Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Password"; Text[20])
        {
            DataClassification = ToBeClassified;

            ExtendedDatatype = Masked;
        }
        field(50002; "Password Reset in Next Login"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Status"; Option)
        {
            OptionMembers = Active,Inactive;
        }
        field(50004; "Full Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Department; Option)
        {
            OptionMembers = "Cattle Sales","Poultry Sales","Swine Sales","CBF Accounts";
        }
        field(50006; "Modile No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Sales Person Code"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Sales Team Code"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Location Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Sales Person"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Sales Team"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "Allow Posting From"; Date)
        {
            Caption = 'Allow Posting From';
        }
        field(3; "Allow Posting To"; Date)
        {
            Caption = 'Allow Posting To';

        }
        field(50013; "Access Purchase Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50014; "Access Purchase Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Receive,Invoice,Receive & Invoice';
            OptionMembers = " ",Edit,View,Receive,Invoice,"Receive & Invoice";
        }
        field(50015; "Access Sales Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Ship,Invoice,Ship & Invoice';
            OptionMembers = " ",Edit,View,Ship,Invoice,"Ship & Invoice";
        }
        field(50016; "Access Sales Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Receive,Invoice,Receive & Invoice';
            OptionMembers = " ",Edit,View,Receive,Invoice,"Receive & Invoice";
        }
        field(50017; "Access Sales Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50018; "Access Sales Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50019; "Access Purchase Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50020; "Access Purchase Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Ship,Invoice,Ship & Invoice';
            OptionMembers = " ",Edit,View,Ship,Invoice,"Ship & Invoice";
        }
        field(50021; "Days Access"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Date Freeze"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Access Consume Inventory"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Post';
            OptionMembers = " ",Post;
        }



    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}