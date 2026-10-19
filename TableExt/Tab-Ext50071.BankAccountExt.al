tableextension 50071 BankAccountExt extends "Bank Account"
{
    fields
    {
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Create Bank Account');

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Create Bank Account');
            end;
        }
        field(50000; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "IFSC Code1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create Bank Account');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Bank Account');

        UserSetup.GET(USERID);
        VALIDATE("Responsibility Center", UserSetup."Responsibility Center");
    end;
}