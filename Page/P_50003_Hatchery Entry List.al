page 50003 "Hatchery Entry List"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    CardPageID = "Hatchery Data Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Data Entry Sheet";
    SourceTableView = WHERE("Document Type" = CONST(Hatchery),
                            Posted = FILTER(false));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Farm/Location"; Rec."Farm/Location")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field("Shed No."; Rec."Shed No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Hatching Date"; Rec."Hatching Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Hatchery Entry Sheet');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create Hatchery Sheet');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Hatchery Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create Hatchery Entry Sheet');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        /*
        //TRI A.S 19.09.13 START
          FILTERGROUP(2);
          UserSet.GET(USERID);
          IF UserSet."Responsibility Center" <> 'HO' THEN BEGIN
            RespCntr.GET(UserSet."Responsibility Center");
            UserSet.TESTFIELD("Responsibility Center");
            SETFILTER("Responsibility Center",'%1|%2',UserSet."Responsibility Center",'');
            FILTERGROUP(0);
        END;
        //TRI A.S 19.09.13 STOP
        */
        UserSet.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSet."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSet."Global Dimension 2 Code");
        IF NOT UserSet."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSet."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Hatchery Entry List ');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    var
        UserSet: Record 91;
        RespCntr: Record 5714;
        UserSetup: Record 91;
}

