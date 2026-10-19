table 50048 "OTP Ledger Entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Entry No"; Integer)
        {

        }
        field(50001; "User ID"; Code[100])
        {

        }
        field(50002; "Document No."; Text[50])
        {

        }
        field(50003; "Date and Time"; DateTime)
        {

        }
        field(50004; "OTP"; Integer)
        {

        }
        field(50005; "Phone No."; Text[50])
        {

        }
        field(50006; "Lob Code"; Code[50])
        {

        }
        field(50007; "Branch Code"; Code[50])
        {

        }
        field(50008; "Confirmation Date &Time"; DateTime)
        {

        }
        field(50009; "SFPL User ID"; Code[10])
        {

        }
        field(50010; "Deliverd SMS"; Text[170])
        {

        }
        field(50011; "Logout Date"; Date)
        {

        }
        field(50012; "Loc Code"; Code[50])
        {

        }


    }

    keys
    {
        key(Key1; "Entry No")
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