pageextension 50038 BankAccountListExt extends "Bank Account List"
{
    layout
    {

    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            ERROR('You do not have permission to Delete Bank Account');
        END;
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('you do not have permission to create Bank account');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN
            //CurrPage.EDITABLE(FALSE);
            ERROR('you do not have permission to create Bank account');

        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            ERROR('you do not have permission to Change Bank Account Details');
        END;
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('you do not have permission to create Bank account');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN
            //CurrPage.EDITABLE(FALSE);
            ERROR('you do not have permission to create Bank account');

        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //TRI A.S 19.09.13 START
        Rec.FILTERGROUP(2);
        UserSetup.GET(USERID);
        Rec.SETFILTER("Responsibility Center", '%1|%2', UserSetup."Responsibility Center", '');
        Rec.FILTERGROUP(0);
        //TRI A.S 19.09.13 STOP


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Account');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Bank Account", '%1', UserSetup."Access Bank Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}