page 50097 "Data Entry SubForm MobileApp"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = ListPart;
    SourceTable = "Data Entry Lines";
    SourceTableView = SORTING("Document No.", "Flock No.", "Line No.");
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Post Data Sheet Entries")
                {
                    Caption = 'Post Data Sheet Entries';
                    Ellipsis = true;
                    Image = "Action";
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        recDataEntryLines: Record "Data Entry Lines";
                        recDataEntryLines1: Record "Data Entry Lines";
                        recDataEntryLines2: Record "Data Entry Lines";
                        ItemJournalBatch: Record 233;
                        recItemJnlLine: Record 83;
                        recParameterMaster: Record "Parameter Master";
                        recItem: Record 27;
                        UserSetup: Record 91;
                        recRespCenter: Record 5714;
                        NoSeriesMgmt: Codeunit 396;
                        DocNo: Code[20];
                        BranchCode: Code[10];
                        Date1: Date;
                    begin
                        recDataEntryLines2.RESET;
                        Date1 := CALCDATE('-1D', Rec."Posting Date");
                        recDataEntryLines2.SETFILTER("Posting Date", '%1', Date1);
                        IF NOT recDataEntryLines2.FINDFIRST THEN
                            ERROR('Post Data Entries for Date ' + FORMAT(Date1) + ' first before posting Entries for Date' + FORMAT(Rec."Posting Date"));

                        ItemJournalBatch.RESET;
                        ItemJournalBatch.SETRANGE("Journal Template Name", 'ITEM');
                        ItemJournalBatch.SETRANGE(Name, 'HO');
                        ItemJournalBatch.FINDFIRST;
                        DocNo := NoSeriesMgmt.GetNextNo(ItemJournalBatch."No. Series", 0D, TRUE);

                        /*
                        UserSetup.GET(USERID);
                        IF recRespCenter.GET(UserSetup."Responsibility Center") THEN
                          BranchCode := recRespCenter."Global Dimension 1 Code";
                          */
                        recDataEntryLines.RESET;
                        recDataEntryLines.SETRANGE("Flock No.", Rec."Flock No.");
                        recDataEntryLines.SETRANGE("Location Code", Rec."Location Code");
                        recDataEntryLines.SETRANGE("Shed No.", Rec."Shed No.");
                        recDataEntryLines.SETRANGE("Item No.", Rec."Item No.");
                        recDataEntryLines.SETRANGE("Posting Date", Rec."Posting Date");
                        recDataEntryLines.SETFILTER("Sub Items", '<>%1', '');
                        recDataEntryLines.SETFILTER("Actual Value", '<>%1', 0);
                        IF recDataEntryLines.FINDSET THEN
                            REPEAT
                                recItemJnlLine.INIT;
                                recItemJnlLine."Journal Template Name" := 'ITEM';
                                recItemJnlLine."Journal Batch Name" := 'HO';
                                recItemJnlLine."Document No." := DocNo;
                                recItemJnlLine."Line No." := recItemJnlLine."Line No." + 10000;
                                recItemJnlLine."Posting Date" := recDataEntryLines."Posting Date";

                                recParameterMaster.RESET;
                                recParameterMaster.SETRANGE("No.", recDataEntryLines."Parameter No.");
                                IF recParameterMaster.FINDFIRST THEN
                                    IF recParameterMaster."Type of Parameter" = recParameterMaster."Type of Parameter"::Output THEN
                                        recItemJnlLine."Entry Type" := recItemJnlLine."Entry Type"::"Positive Adjmt."
                                    ELSE
                                        IF recParameterMaster."Type of Parameter" = recParameterMaster."Type of Parameter"::" " THEN
                                            recItemJnlLine."Entry Type" := recItemJnlLine."Entry Type"::"Negative Adjmt.";

                                ///recItemJnlLine."Flock No." := recDataEntryLines."Flock No.";//PRU-VG
                                recItemJnlLine."Location Code" := recDataEntryLines."Location Code";
                                recItemJnlLine.VALIDATE("Item No.", recDataEntryLines."Sub Items");
                                ///recItemJnlLine."Parent Item" := recDataEntryLines."Item No.";//PRU-VG
                                recItemJnlLine.VALIDATE(Quantity, recDataEntryLines."Actual Value");
                                IF recItem.GET(recDataEntryLines."Sub Items") THEN
                                    recItemJnlLine."Gen. Prod. Posting Group" := recItem."Gen. Prod. Posting Group";
                                recItemJnlLine.VALIDATE("Shortcut Dimension 1 Code", BranchCode);
                                recItemJnlLine."Bin Code" := recDataEntryLines."Bin Code";
                                recItemJnlLine.INSERT;
                            UNTIL recDataEntryLines.NEXT = 0;
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", recItemJnlLine);

                        recDataEntryLines1.RESET;
                        recDataEntryLines1.SETRANGE("Flock No.", Rec."Flock No.");
                        recDataEntryLines1.SETRANGE("Location Code", Rec."Location Code");
                        recDataEntryLines1.SETRANGE("Shed No.", Rec."Shed No.");
                        recDataEntryLines1.SETRANGE("Item No.", Rec."Item No.");
                        recDataEntryLines1.SETRANGE("Posting Date", Rec."Posting Date");
                        IF recDataEntryLines1.FINDSET THEN
                            recDataEntryLines1.MODIFYALL(Posted, TRUE);

                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item Tracking Lines';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.AssignLotNumber;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('you can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create data entry');
        //PRU_DD 1.10


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create data entry');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('you can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Posting Date" := WORKDATE;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Data entry sheet');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}

