pageextension 50056 FixedAssetJournalExt extends "Fixed Asset Journal"
{
    layout
    {

    }


    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post the Fixed Assets Journal');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have Permission to Post the Fixed Assets Journal');
                //PRU_DD 1.10

                CheckDimension; //Pru_gk DMV_0.1
            end;
        }


    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Fixed Asset G/L Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access FA Journals", '%1', UserSetup."Access FA Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    local procedure CheckDimension()
    var
        DimensionSetEntry_123: Record 480;
    begin
        IF Rec.FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Fixed Asset Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Fixed Asset Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;

                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;

}