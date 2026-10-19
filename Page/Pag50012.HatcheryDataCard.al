page 50012 "Hatchery Data Card"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    Caption = 'Hatchery Sheet Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Data Entry Sheet";
    SourceTableView = WHERE("Document Type" = FILTER(Hatchery));
    //  ApplicationArea = All;
    // UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Farm/Location"; Rec."Farm/Location")
                {
                    ApplicationArea = All;
                    Caption = 'From Location';
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Order No.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.RequiredValidation(Rec.Stage);
                        //PruRaj_RQ_0.01
                        DEL.RESET;
                        DEL.SETRANGE("Document No.", Rec."No.");
                        DEL.SETFILTER("Item No.", '<>%1', '');
                        IF DEL.FINDSET THEN
                            REPEAT

                                CLEAR(RemQty);
                                ILE.RESET;
                                ILE.SETRANGE("Item No.", DEL."Item No.");
                                ILE.SETRANGE("Posting Date", 0D, Rec."Entry Date");
                                ILE.SETRANGE("Location Code", DEL."Location Code");
                                IF ILE.FINDSET THEN BEGIN
                                    ILE.CALCSUMS("Remaining Quantity");
                                    RemQty := ILE."Remaining Quantity";
                                END;
                                //MESSAGE('%1',DEL."Item No.");
                                //MESSAGE('Remqty%1',RemQty);

                                DEL."Stock Available" := RemQty;
                                DEL.MODIFY;
                            UNTIL DEL.NEXT = 0;
                        //PruRaj_RQ_0.01
                    end;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Egg Set Date"; Rec."Egg Set Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Setter/Hatcher"; Rec."Setter/Hatcher")
                {
                    ApplicationArea = All;
                }
                field("Remaining Eggs"; Rec."Remaining Eggs")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("PS DOC Placing Date"; Rec."PS DOC Placing Date")
                {
                    ApplicationArea = All;
                }
            }
            part("Hatchery Data SubForm"; 50013)
            {
                ApplicationArea = All;
                Editable = PageEditable;
                SubPageLink = "Document No." = FIELD("No."),
                              "Flock No." = FIELD("Flock No.");
                SubPageView = SORTING("Document No.", "Flock No.", "Line No.")
                              ORDER(Ascending);
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
                action(Post)
                {
                    Caption = '&Post';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ParameterMaster: Record "Parameter Master";
                        ParameterType: Text[30];
                        ItmJnlLine: Record 83;
                        ItmJnlLine1: Record 83;
                        IJLLineNo: Integer;
                        CurrentJnlBatchName: Code[30];
                        RecDataEntryLines3: Record "Data Entry Lines";
                        ItmJnlLine2: Record 83;
                        ReservationEntryRec: Record 337;
                        ItmJnlLineRec: Record 83;
                        C50001: Codeunit 50003;
                    begin
                        //PruRaj_RQ_0.01
                        DEL.RESET;
                        DEL.SETRANGE("Document No.", Rec."No.");
                        DEL.SETFILTER("Item No.", '<>%1', '');
                        IF DEL.FINDSET THEN
                            REPEAT
                                ParameterMaster.GET(DEL."Parameter No.");
                                IF ParameterMaster."Type of Parameter" = ParameterMaster."Type of Parameter"::Consumption THEN BEGIN
                                    CLEAR(RemQty);
                                    ILE.RESET;
                                    //ILE.SETRANGE("Entry Type",ILE."Entry Type"::Consumption);
                                    ILE.SETRANGE("Item No.", DEL."Item No.");
                                    ILE.SETRANGE("Posting Date", 0D, Rec."Entry Date");
                                    ILE.SETRANGE("Location Code", DEL."Location Code");
                                    IF ILE.FINDSET THEN BEGIN
                                        ILE.CALCSUMS("Remaining Quantity");
                                        RemQty := ILE."Remaining Quantity";
                                    END;

                                    IF RemQty < DEL."Actual Value" THEN
                                        ERROR('Stock Not Available of Item No %1 of %2 Location', DEL."Item No.", DEL."Location Code");
                                END;
                            UNTIL DEL.NEXT = 0;
                        //PruRaj_RQ_0.01


                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Edit);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have Permission to Post Hatchery Entry Sheet');
                        //PRU_DD 1.10

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Create);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have Permission to Post Hatchery Entry Sheet');
                        //PRU_DD 1.10

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::" ");
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have Permission to Post Hatchery Entry Sheet');
                        //PRU_DD 1.10

                        //PostHatcheryEntry;
                        /*RecDataEntryLines2.RESET;
                        RecDataEntryLines2.SETRANGE("Document No.","No.");
                        RecDataEntryLines2.SETRANGE(Posted,FALSE);
                        IF RecDataEntryLines2.FINDFIRST THEN
                        
                        REPEAT
                          RecDataEntryLines2.Posted := TRUE;
                          RecDataEntryLines2.MODIFY;
                        UNTIL RecDataEntryLines2.NEXT=0;
                        */
                        C50001.PostHatcheryEntry(Rec);

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
                        Rec.ShowDimensions;
                        CurrPage.SAVERECORD;
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
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
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
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create hatchery entry');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Hatchry Entry Sheet", '%1', UserSetup."Access Hatchry Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
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
            ERROR('You can not create hatchery entry');
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
        IF Rec.Posted THEN
            PageEditable := FALSE
        ELSE
            PageEditable := TRUE;
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
        recTemplateMasterLines: Record "Template Master Line";
        TemplateNo: Code[10];
        RecDataEntryLines: Record "Data Entry Lines";
        LineNo: Integer;
        DateDiff: Integer;
        recFlockMaster: Record 5405;
        HatchngDate: Date;
        WeekDiff: Decimal;
        MonthDiff: Decimal;
        YearDiff: Decimal;
        RecDataEntryLines1: Record "Data Entry Lines";
        PostingDate: Date;
        RecDataEntryLines2: Record "Data Entry Lines";
        RecReservtnEntry: Record 337;
        BreedMasterRec: Record "Breed Master";
        LastEntryNo: Integer;
        StageList: Option " ",Setter,Hatcher,Production;
        Text50001: Label '&Hatcher,&Setter,&Production';
        Selection: Integer;
        TempReservationEntry: Record 337 temporary;
        ReservationEntry: Record 337;
        RecDataEntrySheet: Record "Data Entry Sheet";
        UserSet: Record 91;
        RespCntr: Record 5714;
        MfgSetup: Record 99000765;
        DataEntry: Record "Data Entry Sheet";
        PageEditable: Boolean;
        UserSetup: Record 91;
        DEL: Record "Data Entry Lines";
        RemQty: Decimal;
        ILE: Record 32;
        ParameterMaster: Record "Parameter Master";

    local procedure PostHatcheryEntry()
    var
        ParameterMaster: Record "Parameter Master";
        ParameterType: Text[30];
        ItmJnlLine: Record 83;
        ItmJnlLine1: Record 83;
        IJLLineNo: Integer;
        CurrentJnlBatchName: Code[30];
        RecDataEntryLines3: Record "Data Entry Lines";
        ItmJnlLineRec: Record 83;
        T5407: Record 5407;
        CompItemNo: Code[20];
        ItmJnlLine2: Record 83;
        TrackingSpecification: Record 336;
        T83: Record 83;
    begin
        //PRUSB 200315 BEGIN
        Rec.TESTFIELD("Dimension Set ID");
        //TESTFIELD("Journal Template Name");
        //TESTFIELD("Journal Batch Name");
        MfgSetup.GET;
        MfgSetup.TESTFIELD("Consumption Batch Name");
        MfgSetup.TESTFIELD("Output Batch Name");
        //IJLLineNo := ItmJnlLine2."Line No.";
        /*
        T83.RESET;
        T83.SETRANGE("Journal Template Name",'CONSUMP');
        T83.SETRANGE("Journal Batch Name",MfgSetup."Consumption Batch Name");
        IF T83.FINDFIRST THEN
          T83.DELETEALL;
        T83.RESET;
        T83.SETRANGE("Journal Template Name",'OUTPUT');
        T83.SETRANGE("Journal Batch Name",MfgSetup."Output Batch Name");
        IF T83.FINDFIRST THEN
          T83.DELETEALL;
        */
        ItmJnlLine1.RESET;
        ItmJnlLine1.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        ItmJnlLine1.SETFILTER("Journal Template Name", 'CONSUMP');
        ItmJnlLine1.SETFILTER("Journal Batch Name", MfgSetup."Consumption Batch Name");
        IF ItmJnlLine1.FINDLAST THEN
            IJLLineNo := ItmJnlLine1."Line No.";
        ItmJnlLine2.RESET;
        ItmJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        ItmJnlLine2.SETFILTER("Journal Template Name", 'OUTPUT');
        ItmJnlLine2.SETFILTER("Journal Batch Name", MfgSetup."Output Batch Name");
        IF ItmJnlLine2.FINDLAST THEN;

        RecDataEntryLines2.RESET;
        RecDataEntryLines2.SETRANGE("Document No.", Rec."No.");
        RecDataEntryLines2.SETRANGE(Posted, FALSE);
        IF RecDataEntryLines2.FINDFIRST THEN
            REPEAT

                IF (RecDataEntryLines2."Actual Value" > 0) AND (RecDataEntryLines2."Item No." <> '') THEN BEGIN
                    ParameterMaster.SETRANGE("No.", RecDataEntryLines2."Parameter No.");
                    IF ParameterMaster.FINDFIRST THEN
                        ParameterType := FORMAT(ParameterMaster."Type of Parameter");

                    IF ParameterType = 'Consumption' THEN BEGIN
                        IF ParameterMaster."Machine No." = '' THEN BEGIN
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'CONSUMP');
                            ItmJnlLine.VALIDATE("Journal Batch Name", MfgSetup."Consumption Batch Name");
                            ItmJnlLine.VALIDATE("Line No.", GetLineNo('CONSUMP', MfgSetup."Consumption Batch Name"));
                            ItmJnlLine.VALIDATE("Posting Date", WORKDATE);
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Consumption);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", Rec."Flock No.");
                            ItmJnlLine.VALIDATE("Order Line No.", 10000);
                            ItmJnlLine.VALIDATE("Document No.", Rec."Flock No.");
                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                            ItmJnlLine.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                            ItmJnlLine.VALIDATE("Location Code", Rec."Farm/Location");
                            ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", Rec."No.");//PRU-VG
                                                                                   //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                            ItmJnlLine.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                            TrackingSpecification.RESET;
                            TrackingSpecification.SETRANGE("Location Code", Rec."Farm/Location");
                            TrackingSpecification.SETRANGE("Quantity (Base)", RecDataEntryLines2."Actual Value");
                            TrackingSpecification.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            IF TrackingSpecification.FINDLAST THEN
                                ItmJnlLine.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                            //MESSAGE('%1',ItemJournalLine."Serial No.")

                            ItmJnlLine.INSERT;
                            ReservationEntry.RESET;
                            ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            ReservationEntry.SETRANGE("Location Code", Rec."Farm/Location");
                            ReservationEntry.SETRANGE("Source ID", 'CONSUMP');
                            ReservationEntry.SETRANGE("Source Batch Name", MfgSetup."Consumption Batch Name");
                            ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                            IF ReservationEntry.FINDFIRST THEN
                                REPEAT
                                    ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                    ReservationEntry.MODIFY;
                                UNTIL ReservationEntry.NEXT = 0;
                            /*
                            //PRUSB 020415 >>
                            IF RecReservtnEntry.FINDLAST THEN
                              LastEntryNo := RecReservtnEntry."Entry No.";

                            RecReservtnEntry.INIT;
                            IF LastEntryNo <> 0 THEN
                              RecReservtnEntry."Entry No." := LastEntryNo + 1
                            ELSE
                              RecReservtnEntry."Entry No." := 1;

                            RecReservtnEntry.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                            RecReservtnEntry.VALIDATE("Location Code","Farm Location");
                            RecReservtnEntry.VALIDATE("Quantity (Base)",-RecDataEntryLines2."Actual Value");
                            RecReservtnEntry.VALIDATE("Reservation Status",RecReservtnEntry."Reservation Status"::Prospect);
                            RecReservtnEntry.VALIDATE("Source Type",83);
                            RecReservtnEntry.VALIDATE("Source Subtype",5);
                            RecReservtnEntry.VALIDATE("Source ID",'CONSUMP');
                            RecReservtnEntry.VALIDATE("Source Batch Name",MfgSetup."Consumption Batch Name");
                            RecReservtnEntry.VALIDATE("Source Ref. No.",RecDataEntryLines2."Line No." + ItmJnlLine1."Line No.");
                            RecReservtnEntry.VALIDATE(Positive,FALSE);
                            RecReservtnEntry.VALIDATE(Quantity,-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                            RecReservtnEntry.VALIDATE("Qty. to Handle (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                            RecReservtnEntry.VALIDATE("Qty. to Invoice (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                            RecReservtnEntry.VALIDATE("Quantity (Base)",-ItmJnlLine."Quantity (Base)");
                            RecReservtnEntry.VALIDATE("Qty. per Unit of Measure",ItmJnlLine."Qty. per Unit of Measure");
                            RecReservtnEntry.VALIDATE("Lot No.","Lot No.");
                            RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                            RecReservtnEntry.INSERT;
                            */
                            //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                        END;
                    END
                    ELSE
                        IF ParameterType = 'Production' THEN BEGIN
                            IF ParameterMaster."Machine No." = '' THEN BEGIN
                                ItmJnlLine.INIT;
                                ItmJnlLine.VALIDATE("Journal Template Name", 'OUTPUT');
                                ItmJnlLine.VALIDATE("Journal Batch Name", MfgSetup."Output Batch Name");
                                ItmJnlLine.VALIDATE("Line No.", GetLineNoOutput('OUTPUT', MfgSetup."Output Batch Name"));
                                ItmJnlLine.VALIDATE("Posting Date", WORKDATE);
                                ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                                ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                                ItmJnlLine.VALIDATE("Order No.", Rec."Flock No.");
                                ItmJnlLine.VALIDATE("Order Line No.", 10000);
                                ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                                ItmJnlLine.VALIDATE("Document No.", Rec."Flock No.");
                                ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                                ItmJnlLine.VALIDATE("Unit of Measure Code", ParameterMaster."Data Entry UOM");
                                ItmJnlLine.VALIDATE("Location Code", Rec."Farm/Location");
                                ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Output Quantity", RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Data Entry Sheet No.", Rec."No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                                //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                                ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                                ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                                ItmJnlLine.INSERT;
                                ReservationEntry.RESET;
                                ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                                ReservationEntry.SETRANGE("Location Code", Rec."Farm/Location");
                                ReservationEntry.SETRANGE("Source ID", 'OUTPUT');
                                ReservationEntry.SETRANGE("Source Batch Name", MfgSetup."Output Batch Name");
                                ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                                IF ReservationEntry.FINDFIRST THEN
                                    REPEAT
                                        ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                        ReservationEntry.MODIFY;
                                    UNTIL ReservationEntry.NEXT = 0;
                                /*
                                IF RecReservtnEntry.FINDLAST THEN
                                  LastEntryNo := RecReservtnEntry."Entry No.";

                                RecReservtnEntry.INIT;
                                IF LastEntryNo <> 0 THEN
                                  RecReservtnEntry."Entry No." := LastEntryNo + 1
                                ELSE
                                  RecReservtnEntry."Entry No." := 1;

                                RecReservtnEntry.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                                RecReservtnEntry.VALIDATE("Location Code","Farm/Location");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Reservation Status",RecReservtnEntry."Reservation Status"::Prospect);
                                RecReservtnEntry.VALIDATE("Source Type",83);
                                RecReservtnEntry.VALIDATE("Source Subtype",6);
                                RecReservtnEntry.VALIDATE("Source ID",'OUTPUT');
                                RecReservtnEntry.VALIDATE("Source Batch Name",'DEFAULT');
                                RecReservtnEntry.VALIDATE("Source Ref. No.",RecDataEntryLines2."Line No." + ItmJnlLine2."Line No.");
                                RecReservtnEntry.VALIDATE(Positive,TRUE);
                                RecReservtnEntry.VALIDATE(Quantity,ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Handle (Base)",ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Invoice (Base)",ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",ABS(ItmJnlLine."Quantity (Base)"));
                                RecReservtnEntry.VALIDATE("Qty. per Unit of Measure",ItmJnlLine."Qty. per Unit of Measure");
                                RecReservtnEntry.VALIDATE("Lot No.","Lot No.");
                                RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                                RecReservtnEntry.INSERT;*/
                                /*T5407.RESET;
                                T5407.SETRANGE("Prod. Order No.","Flock No.");
                                IF T5407.FINDFIRST THEN
                                  CompItemNo := T5407."Item No.";
                                //PRU-VG
                                ItmJnlLine.INIT;
                                ItmJnlLine.VALIDATE("Journal Template Name",'CONSUMP');
                                ItmJnlLine.VALIDATE("Journal Batch Name",MfgSetup."Consumption Batch Name");
                                ItmJnlLine.VALIDATE("Line No.",RecDataEntryLines2."Line No." + 10000);
                                ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                                ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Consumption);
                                ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                                ItmJnlLine.VALIDATE("Order No.","Flock No.");
                                ItmJnlLine.VALIDATE("Order Line No.",10000);
                                ItmJnlLine.VALIDATE("Document No.","Flock No.");
                                ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                                ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                                ItmJnlLine.VALIDATE("Location Code","Farm/Location");
                                ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Data Entry Sheet No.","No.");//PRU-VG
                                //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Dimension Set ID","Dimension Set ID");
                                ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                                ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                                ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                                {TrackingSpecification.RESET;
                                TrackingSpecification.SETRANGE("Location Code","Farm Location");
                                TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                                TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                                IF TrackingSpecification.FINDLAST THEN
                                  ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                                }
                                ItmJnlLine.INSERT;

                                //PRUSB 020415 >>
                                IF RecReservtnEntry.FINDLAST THEN
                                  LastEntryNo := RecReservtnEntry."Entry No.";

                                RecReservtnEntry.INIT;
                                IF LastEntryNo <> 0 THEN
                                  RecReservtnEntry."Entry No." := LastEntryNo + 1
                                ELSE
                                  RecReservtnEntry."Entry No." := 1;

                                RecReservtnEntry.VALIDATE("Item No.",CompItemNo);
                                RecReservtnEntry.VALIDATE("Location Code","Farm/Location");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Reservation Status",RecReservtnEntry."Reservation Status"::Prospect);
                                RecReservtnEntry.VALIDATE("Source Type",83);
                                RecReservtnEntry.VALIDATE("Source Subtype",5);
                                RecReservtnEntry.VALIDATE("Source ID",'CONSUMP');
                                RecReservtnEntry.VALIDATE("Source Batch Name",MfgSetup."Consumption Batch Name");
                                RecReservtnEntry.VALIDATE("Source Ref. No.",RecDataEntryLines2."Line No." + 10000);
                                RecReservtnEntry.VALIDATE(Positive,FALSE);
                                RecReservtnEntry.VALIDATE(Quantity,-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Handle (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Invoice (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",-ItmJnlLine."Quantity (Base)");
                                RecReservtnEntry.VALIDATE("Qty. per Unit of Measure",ItmJnlLine."Qty. per Unit of Measure");
                                RecReservtnEntry.VALIDATE("Lot No.","Lot No.");
                                RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                                RecReservtnEntry.INSERT;*/
                            END;

                            //PRU-VG
                            //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                        END ELSE
                            IF ParameterMaster."Machine No." <> '' THEN BEGIN
                                ItmJnlLine.INIT;
                                ItmJnlLine.VALIDATE("Journal Template Name", 'CAPACITY');
                                ItmJnlLine.VALIDATE("Journal Batch Name", MfgSetup."Capacity Batch Name");
                                ItmJnlLine.VALIDATE("Line No.", RecDataEntryLines2."Line No." + 10000);
                                ItmJnlLine.VALIDATE("Posting Date", WORKDATE);
                                ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                                ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                                ItmJnlLine.VALIDATE("Order No.", Rec."Flock No.");
                                ItmJnlLine.VALIDATE("Order Line No.", 10000);
                                ItmJnlLine.VALIDATE("Document No.", Rec."Flock No.");
                                ItmJnlLine.VALIDATE(Type, ItmJnlLine.Type::"Machine Center");
                                ItmJnlLine.VALIDATE("Item No.", Rec."Item No.");
                                IF Rec.Stage = Rec.Stage::Setter THEN
                                    ItmJnlLine.VALIDATE("Operation No.", '10')
                                ELSE
                                    IF Rec.Stage = Rec.Stage::Hatcher THEN
                                        ItmJnlLine.VALIDATE("Operation No.", '20');
                                ItmJnlLine.VALIDATE("No.", RecDataEntryLines2."Machine No.");
                                IF Rec.Stage = Rec.Stage::Setter THEN
                                    ItmJnlLine.VALIDATE("Run Time", 18)
                                ELSE
                                    IF Rec.Stage = Rec.Stage::Hatcher THEN
                                        ItmJnlLine.VALIDATE("Run Time", 3);

                                //ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                                //ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                                //ItmJnlLine.VALIDATE("Location Code","Farm Location");
                                //ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Data Entry Sheet No.", Rec."No.");//PRU-VG
                                                                                       //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                                //ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                                ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                                ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                                /*TrackingSpecification.RESET;
                                TrackingSpecification.SETRANGE("Location Code","Farm Location");
                                TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                                TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                                IF TrackingSpecification.FINDLAST THEN
                                  ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                                */
                                ItmJnlLine.INSERT;
                                /*
                                //PRUSB 020415 >>
                                IF RecReservtnEntry.FINDLAST THEN
                                  LastEntryNo := RecReservtnEntry."Entry No.";

                                RecReservtnEntry.INIT;
                                IF LastEntryNo <> 0 THEN
                                  RecReservtnEntry."Entry No." := LastEntryNo + 1
                                ELSE
                                  RecReservtnEntry."Entry No." := 1;

                                RecReservtnEntry.VALIDATE("Item No.",CompItemNo);
                                RecReservtnEntry.VALIDATE("Location Code","Farm Location");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Reservation Status",RecReservtnEntry."Reservation Status"::Prospect);
                                RecReservtnEntry.VALIDATE("Source Type",83);
                                RecReservtnEntry.VALIDATE("Source Subtype",5);
                                RecReservtnEntry.VALIDATE("Source ID",'CONSUMP');
                                RecReservtnEntry.VALIDATE("Source Batch Name",MfgSetup."Consumption Batch Name");
                                RecReservtnEntry.VALIDATE("Source Ref. No.",RecDataEntryLines2."Line No." + 10000);
                                RecReservtnEntry.VALIDATE(Positive,FALSE);
                                RecReservtnEntry.VALIDATE(Quantity,-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Handle (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Qty. to Invoice (Base)",-ItmJnlLine.Quantity); //-RecDataEntryLines2."Actual Value");
                                RecReservtnEntry.VALIDATE("Quantity (Base)",-ItmJnlLine."Quantity (Base)");
                                RecReservtnEntry.VALIDATE("Qty. per Unit of Measure",ItmJnlLine."Qty. per Unit of Measure");
                                RecReservtnEntry.VALIDATE("Lot No.","Lot No.");
                                RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                                RecReservtnEntry.INSERT;
                                */
                            END;
                    //END;
                    RecDataEntryLines3.RESET;
                    RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                    RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                    IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                        RecDataEntryLines3.INIT;
                        RecDataEntryLines3.VALIDATE("Document No.", RecDataEntryLines2."Document No.");
                        RecDataEntryLines3.VALIDATE("Posting Date", RecDataEntryLines2."Posting Date");
                        RecDataEntryLines3.VALIDATE("Parameter No.", RecDataEntryLines2."Parameter No.");
                        RecDataEntryLines3.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                        RecDataEntryLines3.VALIDATE("Std Value", RecDataEntryLines2."Std Value");
                        RecDataEntryLines3.VALIDATE("Actual Value", RecDataEntryLines2."Actual Value");
                        RecDataEntryLines3.VALIDATE("Template No", RecDataEntryLines2."Template No");
                        RecDataEntryLines3.VALIDATE(Remarks, RecDataEntryLines2.Remarks);
                        RecDataEntryLines3.Posted := TRUE;
                        RecDataEntryLines3.MODIFY;
                    END;
                END ELSE
                    IF (RecDataEntryLines2."Actual Value" = 0) AND (RecDataEntryLines2."Item No." <> '') THEN BEGIN
                        RecDataEntryLines2.DELETE;
                    END ELSE BEGIN
                        RecDataEntryLines3.RESET;
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                        IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                            RecDataEntryLines3.INIT;
                            RecDataEntryLines3.VALIDATE("Document No.", RecDataEntryLines2."Document No.");
                            RecDataEntryLines3.VALIDATE("Posting Date", RecDataEntryLines2."Posting Date");
                            RecDataEntryLines3.VALIDATE("Parameter No.", RecDataEntryLines2."Parameter No.");
                            RecDataEntryLines3.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                            RecDataEntryLines3.VALIDATE("Std Value", RecDataEntryLines2."Std Value");
                            RecDataEntryLines3.VALIDATE("Actual Value", RecDataEntryLines2."Actual Value");
                            RecDataEntryLines3.VALIDATE("Template No", RecDataEntryLines2."Template No");
                            RecDataEntryLines3.VALIDATE(Remarks, RecDataEntryLines2.Remarks);
                            RecDataEntryLines3.Posted := TRUE;
                            RecDataEntryLines3.MODIFY;
                        END;
                    END;
            UNTIL RecDataEntryLines2.NEXT = 0;

        ItmJnlLineRec.RESET;
        ItmJnlLineRec.SETRANGE("Journal Template Name", 'CONSUMP');
        ItmJnlLineRec.SETRANGE("Journal Batch Name", MfgSetup."Consumption Batch Name");
        ItmJnlLineRec.SETRANGE("Document No.", Rec."Flock No.");
        IF ItmJnlLineRec.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItmJnlLineRec);
        COMMIT;
        ItmJnlLineRec.RESET;
        ItmJnlLineRec.SETRANGE("Journal Template Name", 'OUTPUT');
        ItmJnlLineRec.SETRANGE("Journal Batch Name", MfgSetup."Output Batch Name");
        ItmJnlLineRec.SETRANGE("Document No.", Rec."Flock No.");
        IF ItmJnlLineRec.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItmJnlLineRec);
        COMMIT;

        ItmJnlLineRec.RESET;
        ItmJnlLineRec.SETRANGE("Journal Template Name", 'CAPACITY');
        ItmJnlLineRec.SETRANGE("Journal Batch Name", MfgSetup."Capacity Batch Name");
        ItmJnlLineRec.SETRANGE("Document No.", Rec."Flock No.");
        IF ItmJnlLineRec.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItmJnlLineRec);

        /*
       IF RecDataEntryLines2.COUNT > 0 THEN
         CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
        */
        Rec."Last Modified Date" := WORKDATE;
        Rec.MODIFY;
        //PRUSB 200315 END

    end;

    local procedure GetLineNo(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10)
        ELSE
            EXIT(10);
    end;

    local procedure GetLineNoOutput(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
       
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10)
        ELSE
            EXIT(10);
    end;
}

