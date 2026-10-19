table 50053 "Legal Case Detail"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Legal Case Detail Card";
    Permissions = tabledata "Legal Case Detail" = imrd;

    fields
    {
        field(50000; "Serial No."; Integer)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Sub Location"."Sub Location Code";
        }
        field(50001; "Case Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Head"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Phone No."; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Dispute"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Date Of Registration"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Stage Of the Case"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Next Date Of Hearing"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "State"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Distt."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Case No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Customer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50013; "Line Of Business"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50014; "Hearing Distt."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Case Amount;"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Case Type"; Option)
        {
            OptionMembers = " ","Civil","Criminal";

        }


    }

    keys
    {
        key(Key1; "Serial No.")
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