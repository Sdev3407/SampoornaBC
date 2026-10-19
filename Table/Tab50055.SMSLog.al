table 50055 "SMS Log"
{
    DataClassification = ToBeClassified;
    //LookupPageID = "Consumption Posting Setup";

    fields
    {
        field(50001; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50002; "Type"; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50003; "Mobile No."; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50004; "Account No."; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50005; "SMS Body"; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50006; "Transaction ID"; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50007; "Status"; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50008; "Error Code"; Text[1024])
        { DataClassification = ToBeClassified; }
        field(50009; "Sent Date & Time"; DateTime)
        { DataClassification = ToBeClassified; }
        field(50010; "Delivered Date & Time"; DateTime)
        { DataClassification = ToBeClassified; }
        field(50011; "Description"; Text[1024])
        { DataClassification = ToBeClassified; }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    // trigger OnInsert()
    // var
    //     SMSLog: Record "SMS Log";
    // begin
    //     Rec."Entry No." := 1;
    //     SMSLog.Reset();
    //     if SMSLog.FindLast() then
    //         Rec."Entry No." := SMSLog."Entry No." + 1;
    // end;
}
