pageextension 50042 NoSeriesExt extends "No. Series"
{
    layout
    {

    }

    actions
    {

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //if UserSetup."User ID" <> 'JOBQUEUE' then
        //  ERROR('You do not have Permission to Insert the No. Series');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //if UserSetup."User ID" <> 'JOBQUEUE' then
        //  ERROR('You do not have Permission to Modify the No. Series');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if UserSetup."User ID" <> 'JOBQUEUE' then
            ERROR('You do not have Permission to Delete No. Series');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}