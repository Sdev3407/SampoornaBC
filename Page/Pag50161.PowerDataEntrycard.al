Page 50161 "Power Data Entry card"
{

    Caption = 'Power Data Entry card';
    CardPageID = "Power Data Entry card";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Power Data Entry";
    SourceTableView = WHERE(Posted = FILTER(false));
    //  ApplicationArea = All;
    // UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                }
                field("Power Units Consumed"; Rec."Power Units Consumed")
                {
                    ApplicationArea = all;
                }
                field("Diesel Quantity Consumed"; Rec."Diesel Quantity Consumed")
                {
                    ApplicationArea = all;
                }
                field("Production Details in MT "; Rec."Production Details in MT ")
                {
                    ApplicationArea = all;
                }
                field("Cost of Power and Diesel"; Rec."Cost of Power and Diesel")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Per Ton Power Cost "; Rec."Per Ton Power Cost ")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                action("Enter Details")
                {
                    Caption = 'Enter Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                }
                action(Post)
                {
                    Caption = 'Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var

                    begin

                        Rec.Posted := True;

                        Message('The Entry has been Posted');

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin


                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Posted THEN
            PageEditable := FALSE
        ELSE
            PageEditable := TRUE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have  Permission to Change Data Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        LineNo := 0;
        CLEAR(PostingDate);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        if UserSetup.FindFirst() Then begin
            Rec."Shortcut Dimension 1 Code" := UserSetup."Responsibility Center";
            rec."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

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
        // UserSet.GET(USERID);
        // Rec.FILTERGROUP(2);
        // Rec.SETFILTER("Shortcut Dimension 1 Code", UserSet."Global Dimension 1 Code");
        // Rec.SETFILTER("Shortcut Dimension 2 Code", UserSet."Global Dimension 2 Code");
        // IF NOT UserSet."HO Users" THEN
        //     Rec.SETFILTER("Shortcut Dimension 3 Code", UserSet."Shortcut Dimension 3 Code");
        // Rec.FILTERGROUP(0);

        // IF Rec.Posted THEN
        //     PageEditable := FALSE
        // ELSE
        //     PageEditable := TRUE;


        //PRU_DD 1.10

    end;

    var
        recTemplateMasterLines: Record "Template Master Line";
        TemplateNo: Code[20];
        RecDataEntryLines: Record "Data Entry Lines";
        LineNo: Integer;
        DateDiff: Integer;
        HatchngDate: Date;
        WeekDiff: Decimal;
        MonthDiff: Decimal;
        YearDiff: Decimal;
        RecDataEntryLines1: Record "Data Entry Lines";
        PostingDate: Date;
        RecDataEntryLines2: Record "Data Entry Lines";
        RecReservtnEntry: Record 337;
        LastEntryNo: Integer;
        TempReservationEntry: Record 337 temporary;
        ReservationEntry: Record 337;
        ReservationEntryRec: Record 337;
        UserSet: Record 91;
        RespCntr: Record 5714;
        MfgSetup: Record 99000765;
        C50001: Codeunit 50003;
        PageEditable: Boolean;
        UserSetup: Record 91;
        GCStat_Loc: Record "GC Statement";
        DEL: Record "Data Entry Lines";
        ILE: Record 32;
        RemQty: Decimal;
        ParameterMaster: Record "Parameter Master";
        LineEdit: Boolean;


}

