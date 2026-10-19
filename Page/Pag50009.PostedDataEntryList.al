page 50009 "Posted Data Entry List"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    CardPageID = "Posted Data Entry Sheet Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Data Entry Sheet";
    SourceTableView = WHERE("Document Type" = CONST("Data Entry"),
                            Posted = FILTER(true));
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
                    Caption = 'Prod. Order No.';
                }
                field("Shed No."; Rec."Shed No.")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field("Line Type"; Rec."Line Type")
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
                field("Production Date"; Rec."Production Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
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
                field("Farmer No"; Rec."Farmer No")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*
        //TRI A.S 19.09.13 START
          FILTERGROUP(2);
          userset.GET(USERID);
          IF userset."Responsibility Center" <> 'HO' THEN BEGIN
            RespCntr.GET(userset."Responsibility Center");
            userset.TESTFIELD("Responsibility Center");
            SETFILTER("Responsibility Center",'%1|%2',userset."Responsibility Center",'');
            FILTERGROUP(0);
        END;
        //TRI A.S 19.09.13 STOP
        */
        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        IF NOT userset."HO Users" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

    end;

    var
        DimMgt: Codeunit 408;
        tgUserSetup: Record 91;
        RespCntr: Record 5714;
        userset: Record 91;
}

