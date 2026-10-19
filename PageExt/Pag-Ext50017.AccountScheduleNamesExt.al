pageextension 50017 AccountScheduleNamesExt extends "Account Schedule Names"
{
    layout
    {

    }
    trigger OnOpenPage()
    begin

        IF NOT ((USERID = 'SAM1') OR (USERID = 'SAM1001') OR (USERID = 'JOBQUEUE')) THEN
            ERROR('You do not have permission To open Account Schedule');

        /*
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID",USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master" ,'%1',UserSetup."Access Vendor Master"::" ");
        IF UserSetup.FINDFIRST THEN
          ERROR('You do not have permission to open Vendor Card');
          */

    end;
}