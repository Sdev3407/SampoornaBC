page 50010 "Data Entry Sheet Card"
{
    // Version No.   UserID    Date        Where                        Description
    // -----------------------------------------------------------------------------------
    // PRU-HA-003    DEV02     22-08-14   Page Designer               New Page Created.

    Caption = 'Data Entry Sheet Card';
    CardPageID = "Data Entry Sheet Card";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Data Entry Sheet";
    SourceTableView = WHERE("Document Type" = CONST("Data Entry"),
                            Posted = FILTER(false));
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
                field("Line Code"; Rec."Line Code")
                {
                    ApplicationArea = All;
                    Editable = LineEdit;
                }
                field("Line Name"; Rec."Line Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farm/Location"; Rec."Farm/Location")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Order No.';

                    trigger OnValidate()
                    begin
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

                                DEL."Stock Available" := RemQty;
                                DEL.MODIFY;
                            UNTIL DEL.NEXT = 0;
                        //PruRaj_RQ_0.01
                    end;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Age (Week)"; Rec."Age (Week)")
                {
                    ApplicationArea = All;
                }
                field("PS DOC Placing Date"; Rec."PS DOC Placing Date")
                {
                    ApplicationArea = All;
                }
            }
            part("Data entry Subform"; "Data Entry SubForm")
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
                action("Enter Details")
                {
                    Caption = 'Enter Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.RequiredValidation(Rec."Document Type"::"Data Entry");
                    end;
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
                        ParameterMaster: Record 50001;
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
                        //PruRaj_RQ_0.01
                        /*
                        DEL.RESET;
                        DEL.SETRANGE("Document No.", Rec."No.");
                        DEL.SETFILTER("Item No.", '<>%1', '');
                        DEL.SetFilter("Actual Value", '<>%1', 0);
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

                                    IF RemQty <= DEL."Actual Value" THEN
                                        ERROR('Stock Not Available of Item No %1 of %2 Location', DEL."Item No.", DEL."Location Code");
                                END;
                            UNTIL DEL.NEXT = 0;
                            */
                        //PruRaj_RQ_0.01



                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Data Entry');
                        //PRU_DD 1.10
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Create);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Data Entry');
                        //PRU_DD 1.10

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::" ");
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Data Entry');
                        //PRU_DD 1.10

                        //PRU-VG 02072019
                        IF Rec."Document Type" = Rec."Document Type"::"Data Entry" THEN BEGIN
                            GCStat_Loc.RESET;
                            GCStat_Loc.SETRANGE("Flock No.", Rec."Flock No.");
                            GCStat_Loc.SETRANGE(Posted, TRUE);
                            IF GCStat_Loc.FINDFIRST THEN
                                ERROR('GC Statement is already Posted for Flock No. %1', Rec."Flock No.");
                        END;
                        //PRU-VG 02072019


                        Rec.TESTFIELD(Quantity);
                        ///TESTFIELD("Running Cost");
                        RecDataEntryLines3.RESET;
                        RecDataEntryLines3.SETRANGE("Document No.", Rec."No.");
                        IF RecDataEntryLines3.FINDSET THEN
                            REPEAT
                                IF ParameterMaster.GET(RecDataEntryLines3."Parameter No.") THEN BEGIN
                                    IF ParameterMaster."Make Mandatory In a Week" THEN BEGIN
                                        IF Rec.Age MOD 7 = 0 THEN
                                            RecDataEntryLines3.TESTFIELD("Actual Value");
                                    END;
                                    //>>PRU_RPG RSE_0.1
                                    IF (ParameterMaster."Mortality Type" <> ParameterMaster."Mortality Type"::" ") THEN BEGIN
                                        IF (RecDataEntryLines3."Actual Value" <> 0) THEN
                                            RecDataEntryLines3.TESTFIELD(Diseases);
                                    END;

                                    IF (ParameterMaster."Reversal Entry" = TRUE) THEN BEGIN

                                        IF (RecDataEntryLines3."Actual Value" < 0) THEN
                                            IF (RecDataEntryLines3."Applies From Entry No." = 0) THEN
                                                ERROR(STRSUBSTNO('Document No. = %1, line No. = %2, must have value of Applies from entry No. in data entry lines .',
                                                  RecDataEntryLines3."Document No.", RecDataEntryLines3."Line No."));
                                    END;
                                    //<<PRU_RPG RSE_0.1
                                    IF ParameterMaster."Make Mandatory In Daily" THEN
                                        RecDataEntryLines3.TESTFIELD("Actual Value");
                                END;
                            UNTIL RecDataEntryLines3.NEXT = 0;
                        C50001.PostDataEntry(Rec);
                        /*
                        //PRUSB 200315 BEGIN
                        TESTFIELD("Dimension Set ID");
                        //TESTFIELD("Journal Template Name");
                        //TESTFIELD("Journal Batch Name");
                        MfgSetup.GET;
                        MfgSetup.TESTFIELD("Consumption Batch Name");
                        MfgSetup.TESTFIELD("Output Batch Name");
                          //IJLLineNo := ItmJnlLine2."Line No.";
                        {
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
                        }
                        ItmJnlLine1.RESET;
                        ItmJnlLine1.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Line No.");
                        ItmJnlLine1.SETFILTER("Journal Template Name",'CONSUMP');
                        ItmJnlLine1.SETFILTER("Journal Batch Name",MfgSetup."Consumption Batch Name");
                        IF ItmJnlLine1.FINDLAST THEN
                          IJLLineNo := ItmJnlLine1."Line No.";
                        ItmJnlLine2.RESET;
                        ItmJnlLine2.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Line No.");
                        ItmJnlLine2.SETFILTER("Journal Template Name",'OUTPUT');
                        ItmJnlLine2.SETFILTER("Journal Batch Name",MfgSetup."Output Batch Name");
                        IF ItmJnlLine2.FINDLAST THEN;
                        
                        RecDataEntryLines2.RESET;
                        RecDataEntryLines2.SETRANGE("Document No.","No.");
                        RecDataEntryLines2.SETRANGE(Posted,FALSE);
                        IF RecDataEntryLines2.FINDFIRST THEN
                        
                        REPEAT
                        
                          IF (RecDataEntryLines2."Actual Value" > 0) AND (RecDataEntryLines2."Item No." <> '') THEN BEGIN
                            ParameterMaster.SETRANGE("No.",RecDataEntryLines2."Parameter No.");
                            IF ParameterMaster.FINDFIRST THEN
                              ParameterType:=FORMAT(ParameterMaster."Type of Parameter");
                        
                            IF ParameterType='Consumption' THEN
                            BEGIN
                              ItmJnlLine.INIT;
                              ItmJnlLine.VALIDATE("Journal Template Name",'CONSUMP');
                              ItmJnlLine.VALIDATE("Journal Batch Name",MfgSetup."Consumption Batch Name");
                              ItmJnlLine.VALIDATE("Line No.",GetLineNo('CONSUMP',MfgSetup."Consumption Batch Name"));
                              ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                              ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Consumption);
                              ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                              ItmJnlLine.VALIDATE("Order No.","Flock No.");
                              ItmJnlLine.VALIDATE("Order Line No.",10000);
                              ItmJnlLine.VALIDATE("Document No.","Flock No.");
                              ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                              ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                              ItmJnlLine.VALIDATE("Location Code","Farm/Location");
                              ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                              ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                              ItmJnlLine.VALIDATE("Data Entry Sheet No.","No.");//PRU-VG
                              //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                              ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                              ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                              ItmJnlLine.VALIDATE("Dimension Set ID","Dimension Set ID");
                              TrackingSpecification.RESET;
                              TrackingSpecification.SETRANGE("Location Code","Farm/Location");
                              TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                              TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                              IF TrackingSpecification.FINDLAST THEN
                                ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                          //MESSAGE('%1',ItemJournalLine."Serial No.")
                        
                              ItmJnlLine.INSERT;
                              ReservationEntry.RESET;
                              ReservationEntry.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                              ReservationEntry.SETRANGE("Location Code","Farm/Location");
                              ReservationEntry.SETRANGE("Source ID",'CONSUMP');
                              ReservationEntry.SETRANGE("Source Batch Name",MfgSetup."Consumption Batch Name");
                              ReservationEntry.SETRANGE("Source Ref. No.",RecDataEntryLines2."Line No.");
                              IF ReservationEntry.FINDFIRST THEN REPEAT
                                ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                ReservationEntry.MODIFY;
                              UNTIL ReservationEntry.NEXT =0;
                              {
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
                              }
                              //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                            END
                            ELSE IF ParameterType='Production' THEN
                            BEGIN
                              ItmJnlLine.INIT;
                              ItmJnlLine.VALIDATE("Journal Template Name",'OUTPUT');
                              ItmJnlLine.VALIDATE("Journal Batch Name",MfgSetup."Output Batch Name");
                              ItmJnlLine.VALIDATE("Line No.",RecDataEntryLines2."Line No." + ItmJnlLine2."Line No.");
                              ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                              ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Output);
                              ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                              ItmJnlLine.VALIDATE("Order No.","Flock No.");
                              ItmJnlLine.VALIDATE("Order Line No.",10000);
                              ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Output);
                              ItmJnlLine.VALIDATE("Document No.","Flock No.");
                              ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                              ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                              ItmJnlLine.VALIDATE("Location Code","Farm/Location");
                              ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                              ItmJnlLine.VALIDATE("Output Quantity",RecDataEntryLines2."Actual Value");
                              ItmJnlLine.VALIDATE("Data Entry Sheet No.","No.");//PRU-VG
                              ItmJnlLine.VALIDATE("Unit Cost","Running Cost");
                              //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                              ItmJnlLine.VALIDATE("Dimension Set ID","Dimension Set ID");
                              ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                              ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                              ItmJnlLine.INSERT;
                        
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
                              RecReservtnEntry.INSERT;
                              T5407.RESET;
                              T5407.SETRANGE("Prod. Order No.","Flock No.");
                              IF T5407.FINDFIRST THEN
                                CompItemNo := T5407."Item No.";
                              //PRU-VG
                              {ItmJnlLine.INIT;
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
                              ItmJnlLine.VALIDATE("Unit Cost","Running Cost");
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
                              RecReservtnEntry.INSERT;
                              }
                              //PRU-VG
                              //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                            END;
                        
                            RecDataEntryLines3.RESET;
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.",RecDataEntryLines2."Document No.");
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.",RecDataEntryLines2."Line No.");
                            IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                              RecDataEntryLines3.INIT;
                              RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                              RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                              RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                              RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                              RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                              RecDataEntryLines3.VALIDATE("Actual Value",RecDataEntryLines2."Actual Value");
                              RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                              RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                              RecDataEntryLines3.Posted:=TRUE;
                              RecDataEntryLines3.MODIFY;
                            END;
                          END ELSE IF (RecDataEntryLines2."Actual Value" = 0) AND (RecDataEntryLines2."Item No." <> '') THEN BEGIN
                            RecDataEntryLines2.DELETE;
                          END ELSE BEGIN
                            RecDataEntryLines3.RESET;
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.",RecDataEntryLines2."Document No.");
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.",RecDataEntryLines2."Line No.");
                            IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                              RecDataEntryLines3.INIT;
                              RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                              RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                              RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                              RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                              RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                              RecDataEntryLines3.VALIDATE("Actual Value",RecDataEntryLines2."Actual Value");
                              RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                              RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                              RecDataEntryLines3.Posted:=TRUE;
                              RecDataEntryLines3.MODIFY;
                            END;
                          END;
                        UNTIL RecDataEntryLines2.NEXT=0;
                        
                        ItmJnlLineRec.RESET;
                        ItmJnlLineRec.SETRANGE("Journal Template Name",'CONSUMP');
                        ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Consumption Batch Name");
                        ItmJnlLineRec.SETRANGE("Document No.","Flock No.");
                        IF ItmJnlLineRec.FINDFIRST THEN
                          CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                        ItmJnlLineRec.RESET;
                        ItmJnlLineRec.SETRANGE("Journal Template Name",'OUTPUT');
                        ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Output Batch Name");
                        ItmJnlLineRec.SETRANGE("Document No.","Flock No.");
                        IF ItmJnlLineRec.FINDFIRST THEN
                          CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                        
                         {
                        IF RecDataEntryLines2.COUNT > 0 THEN
                          CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
                         }
                        "Last Modified Date" := WORKDATE;
                        MODIFY;
                        //PRUSB 200315 END
                        */

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
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Data Entry');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have  Permission to Change Data Entry Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Data Entry Sheet", '%1', UserSetup."Access Data Entry Sheet"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Data Entry');
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

        IF Rec.Posted THEN
            PageEditable := FALSE
        ELSE
            PageEditable := TRUE;


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

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE(UserSetup."CBF Line No.", '');
        IF UserSetup.FINDFIRST THEN
            LineEdit := TRUE
        ELSE
            LineEdit := FALSE;

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
}

