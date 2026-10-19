page 50095 "Prod Jn"
{
    CardPageID = "Production Journal";
    DeleteAllowed = true;
    Editable = true;
    PageType = API;
    DelayedInsert = True;
    EntityName = 'Production_Journal';
    EntitySetName = 'Production_Journal';
    SourceTable = "Item Journal Line";
    //SourceTableView = WHERE("Order Type" = FIlter('Production'), "Flushing Method" = Filter('Manual'));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No_"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Journal_Batch_Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Order_No"; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order_Line_No_"; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Entry_Type"; rec."Entry Type")
                {
                    ApplicationArea = All;

                }
                field("Item_No_"; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location_Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Output_Quantity"; Rec."Output Quantity")
                {
                    ApplicationArea = All;
                }
                field(SFPLUserID; Rec.SFPLUserID)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    // trigger OnDeleteRecord(): Boolean
    // begin
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
    //     IF UserSetup.FINDFIRST THEN
    //         ERROR('You can not delete the record');
    //     //PRU_DD 1.10
    // end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
    //     IF UserSetup.FINDFIRST THEN
    //         CurrPage.EDITABLE(FALSE);
    //     //PRU_DD 1.10

    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
    //     IF UserSetup.FINDFIRST THEN
    //         ERROR('You do not have permission to create Data Entry');
    //     //PRU_DD 1.10
    // end;

    // trigger OnModifyRecord(): Boolean
    // begin
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
    //     IF UserSetup.FINDFIRST THEN
    //         ERROR('You can not Modify the record');
    //     //PRU_DD 1.10
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
    //     IF UserSetup.FINDFIRST THEN
    //         CurrPage.EDITABLE(FALSE);
    //     //PRU_DD 1.10


    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
    //     IF UserSetup.FINDFIRST THEN
    //         ERROR('You do not have permission to create Data Entry');
    //     //PRU_DD 1.10
    // end;

    // trigger OnOpenPage()
    // begin
    //     /*
    //     //TRI A.S 19.09.13 START
    //       FILTERGROUP(2);
    //       userset.GET(USERID);
    //       IF userset."Responsibility Center" <> 'HO' THEN BEGIN
    //         RespCntr.GET(userset."Responsibility Center");
    //         userset.TESTFIELD("Responsibility Center");
    //         SETFILTER("Responsibility Center",'%1|%2',userset."Responsibility Center",'');
    //         FILTERGROUP(0);
    //     END;
    //     //TRI A.S 19.09.13 STOP
    //     */
    //     userset.GET(USERID);
    //     Rec.FILTERGROUP(2);
    //     Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
    //     Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
    //     IF NOT userset."HO Users" THEN
    //         Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
    //     Rec.FILTERGROUP(0);


    //     //PRU_DD 1.10
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::" ");
    //     IF UserSetup.FINDFIRST THEN
    //         ERROR('You do not have permission to open Data entry sheet');

    //     UserSetup.RESET;
    //     UserSetup.SETRANGE("User ID", USERID);
    //     UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
    //     IF UserSetup.FINDFIRST THEN
    //         CurrPage.EDITABLE(FALSE);
    //     //PRU_DD 1.10

    // end;

    var
        DimMgt: Codeunit 408;
        tgUserSetup: Record 91;
        RespCntr: Record 5714;
        userset: Record 91;
        UserSetup: Record 91;
}

