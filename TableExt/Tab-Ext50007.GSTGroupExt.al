tableextension 50007 GSTGroupExt extends "GST Group"
{
    fields
    {
        field(50000; Block; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }
    trigger OnInsert()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Acccess GST Group Code", '%1', UserSetup."Acccess GST Group Code"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new GST Group');
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}