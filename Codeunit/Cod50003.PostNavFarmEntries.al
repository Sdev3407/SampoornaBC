codeunit 50003 "Post Nav Farm Entries"
{

    trigger OnRun()
    begin
    end;

    var
        Text50000: Label 'Do you want to Post the Hatchery Entry';
        Text50001: Label 'Do you want to Post the Data Entry';
        POR: Record 5409;
        MC: Record 99000758;
        DimensionMaster: Record 50030;
        Companyinfo: Record "Company Information";



    procedure PostHatcheryEntry(RecDataEntry: Record 50003)
    var
        ParameterMaster: Record 50001;
        ParameterType: Text[30];
        ItmJnlLine: Record 83;
        ItmJnlLine1: Record 83;
        IJLLineNo: Integer;
        CurrentJnlBatchName: Code[30];
        RecDataEntryLines3: Record 50005;
        ItmJnlLineRec: Record 83;
        T5407: Record 5407;
        CompItemNo: Code[20];
        ItmJnlLine2: Record 83;
        TrackingSpecification: Record 336;
        T83: Record 83;
        MfgSetup: Record 99000765;
        RecDataEntryLines2: Record 50005;
        ReservationEntry: Record 337;
        C22: Codeunit 22;
        T5405: Record 5405;
        ProdOrderStatus: Codeunit 5407;
        NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished;
        ILE: Record 32;
        RecILE: Record 32;
        T5406: Record 5406;
        T5409: Record 5409;
        T5410: Record 5410;
        T5411: Record 5411;
        T5412: Record 5412;
        T5413: Record 5413;
        T5414: Record 5414;
        T5415: Record 5415;
        T5416: Record 5416;
        UserSetup: Record 91;
        ConsumptionBatch_Loc: Code[10];
        CapacityBatch_Loc: Code[10];
        OutputBatch_Loc: Code[10];
        ProdOrderLine: Record 5406;
        DataEntryLines_123: Record 50005;
        DimensionSetEntry_123: Record 480;
        ProRouLine: Record "Prod. Order Routing Line";
        C23: Codeunit 23;
        RemQty: Decimal;
    begin
        Companyinfo.Get;
        IF CONFIRM(Text50000, TRUE) THEN BEGIN
            RecDataEntry.TESTFIELD("Dimension Set ID");
            //>>PRU_RPG DM_0.1
            If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then begin
                DimensionMaster.RESET;
                DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", RecDataEntry."Shortcut Dimension 1 Code");
                DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", RecDataEntry."Shortcut Dimension 2 Code");
                DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code");
                IF NOT DimensionMaster.FINDFIRST THEN
                    ERROR('Dimension Master Does not exist');
            end;
            //<<PRU_RPG DM_0.1
            ///Pru_gk DMV_.01
            DimensionSetEntry_123.RESET;
            DimensionSetEntry_123.SETRANGE("Dimension Set ID", RecDataEntry."Dimension Set ID");
            IF DimensionSetEntry_123.FINDSET THEN
                REPEAT
                    IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                        IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 2 Code" THEN
                            ERROR('Dimension Set entry Branch code is not match of Hatchery sheet header Branch');
                    END;
                    IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                        IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 1 Code" THEN
                            ERROR('Dimension Set entry LOB Code is not match of Hatchery sheet LOB Code');
                    END;
                    If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 3 Code" THEN
                                ERROR('Dimension Set entry LOC Code is not match of Hatchery sheet LOC Code');
                        END;
                UNTIL DimensionSetEntry_123.NEXT = 0;
            ///Pru_gk DMV_.01

            MfgSetup.GET;

            //>>PRU_RPG MNF_0.1

            CLEAR(ConsumptionBatch_Loc);
            CLEAR(CapacityBatch_Loc);
            CLEAR(OutputBatch_Loc);
            UserSetup.GET(USERID);
            IF (UserSetup."Global Dimension 1 Code" = 'BREEDER') THEN BEGIN
                MfgSetup.TESTFIELD("Breeder Consumption Batch");
                MfgSetup.TESTFIELD("Breeder Capacity Batch Name");
                MfgSetup.TESTFIELD("Breeder Output Batch");
                ConsumptionBatch_Loc := MfgSetup."Breeder Consumption Batch";
                CapacityBatch_Loc := MfgSetup."Breeder Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."Breeder Output Batch";
            END;
            IF (UserSetup."Global Dimension 1 Code" = 'CBF') THEN BEGIN
                MfgSetup.TESTFIELD("CBF Consumption Batch");
                MfgSetup.TESTFIELD("CBF Capacity Batch Name");
                MfgSetup.TESTFIELD("CBF Output Batch");
                ConsumptionBatch_Loc := MfgSetup."CBF Consumption Batch";
                CapacityBatch_Loc := MfgSetup."CBF Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."CBF Output Batch";
            END;
            IF (UserSetup."Global Dimension 1 Code" = 'HATCH') THEN BEGIN
                MfgSetup.TESTFIELD("Hatch Consumption Batch");
                MfgSetup.TESTFIELD("Hatch Capacity Batch Name");
                MfgSetup.TESTFIELD("Hatch Output Batch");
                ConsumptionBatch_Loc := MfgSetup."Hatch Consumption Batch";
                CapacityBatch_Loc := MfgSetup."Hatch Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."Hatch Output Batch";
            END;
            //<<PRU_RPG MNF_0.1

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
            RecDataEntryLines2.SETRANGE("Document No.", RecDataEntry."No.");
            RecDataEntryLines2.SETRANGE(Posted, FALSE);
            IF RecDataEntryLines2.FINDFIRST THEN BEGIN
                REPEAT
                    IF (RecDataEntryLines2."Actual Value" <> 0) THEN BEGIN
                        ParameterMaster.SETRANGE("No.", RecDataEntryLines2."Parameter No.");
                        IF ParameterMaster.FINDFIRST THEN
                            ParameterType := FORMAT(ParameterMaster."Type of Parameter");

                        IF ParameterType = 'Consumption' THEN BEGIN
                            CLEAR(RemQty);
                            RecILE.RESET;
                            RecILE.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            RecILE.SETRANGE("Posting Date", 0D, RecDataEntry."Entry Date");
                            RecILE.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            IF RecILE.FINDSET THEN BEGIN
                                RecILE.CALCSUMS("Remaining Quantity");
                                RemQty := RecILE."Remaining Quantity";
                            END;
                            IF RemQty < RecDataEntryLines2."Actual Value" THEN
                                ERROR('Stock not available of Item No %1 of %2 Location', RecDataEntryLines2."Item No.", RecDataEntry."Farm/Location");
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'CONSUMP');
                            ItmJnlLine.VALIDATE("Journal Batch Name", ConsumptionBatch_Loc);
                            ItmJnlLine.VALIDATE("Line No.", GetLineNo('CONSUMP', ConsumptionBatch_Loc));
                            ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Consumption);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");
                            //>>PRU_RPG MNF_0.1
                            ProdOrderLine.RESET;
                            ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Output Item No.");
                            IF ProdOrderLine.FINDFIRST THEN begin
                                ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                            END;
                            //ItmJnlLine.VALIDATE("Order Line No.",10000);
                            //<<PRU_RPG MNF_0.1
                            ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                            ItmJnlLine.VALIDATE("Unit of Measure Code", RecDataEntryLines2."Unit of Measure Code");
                            ItmJnlLine.VALIDATE("Location Code", RecDataEntry."Farm/Location");
                            ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                            ItmJnlLine.VALIDATE("Source No.", RecDataEntryLines2."Output Item No.");  //Pru_gk
                                                                                                      //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                            ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); //Pru_gk
                            ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                            ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                            ItmJnlLine.VALIDATE("Applies-from Entry", RecDataEntryLines2."Applies From Entry No."); //PRU_RPG RSE_0.1
                                                                                                                    //>>PRU_RPG MNF_0.1
                            ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                            ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                            ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                            ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";

                            //<<PRU_RPG MNF_0.1

                            TrackingSpecification.RESET;
                            TrackingSpecification.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            TrackingSpecification.SETRANGE("Quantity (Base)", RecDataEntryLines2."Actual Value");
                            TrackingSpecification.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            IF TrackingSpecification.FINDLAST THEN;
                            //    ItmJnlLine.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                            // ItmJnlLine.VALIDATE("Lot No.",GetLotNo(RecDataEntryLines2."Item No.",RecDataEntry."Farm/Location",83,5,RecDataEntryLines2."Actual Value",RecDataEntry."No.",RecDataEntryLines2."Line No."));
                            //ItmJnlLine.INSERT;
                            ReservationEntry.RESET;
                            ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            ReservationEntry.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            // ReservationEntry.SETRANGE("Source ID", 'CONSUMP');
                            ReservationEntry.SETRANGE("Source ID", DelChr(CopyStr(RecDataEntry."No.", 5, 12), '=', '/'));

                            //ReservationEntry.SetRange("Source ID", 'PROD.ORDER');
                            ReservationEntry.SETRANGE("Source Batch Name", 'DEFAULT');
                            //ReservationEntry.SETRANGE("Source Batch Name", UserId);
                            ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                            IF ReservationEntry.FINDFIRST THEN
                                REPEAT
                                    // ItmJnlLine.VALIDATE("Lot No.", ReservationEntry."Lot No.");
                                    //  MESSAGE('%1..%2..%3..%4..%5', RecDataEntryLines2."Line No.", ItmJnlLine."Item No.", ItmJnlLine."Journal Batch Name", ReservationEntry."Lot No.", ItmJnlLine."Line No.");
                                    //  ReservationEntry."Source ID" := 'CONSUMP';
                                    ReservationEntry."Source ID" := ItmJnlLine."Journal Template Name";
                                    //ReservationEntry."Source Batch Name" := ItmJnlLine."Journal Batch Name";
                                    //ReservationEntry."Source Batch Name" := 'USER';
                                    ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                    ReservationEntry.MODIFY;
                                UNTIL ReservationEntry.NEXT = 0;
                            //C23.RUN(ItmJnlLine);
                            //ItmJnlLine.Insert();
                            C22.RunWithCheck(ItmJnlLine);
                        END;
                        IF ParameterMaster."Machine No." <> '' THEN BEGIN
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'CAPACITY');
                            ItmJnlLine.VALIDATE("Journal Batch Name", CapacityBatch_Loc);
                            ItmJnlLine.VALIDATE("Line No.", RecDataEntryLines2."Line No." + 10000);
                            ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");
                            //>>PRU_RPG MNF_0.1
                            ProdOrderLine.RESET;
                            ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Output Item No.");
                            IF ProdOrderLine.FINDFIRST THEN Begin
                                ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                            END;
                            //ItmJnlLine.VALIDATE("Order Line No.",10000);
                            //<<PRU_RPG MNF_0.1
                            ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                            ItmJnlLine.VALIDATE(Type, ItmJnlLine.Type::"Machine Center");
                            //ItmJnlLine.VALIDATE("Item No.",RecDataEntry."Item No.");

                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Output Item No.");
                            ItmJnlLine.VALIDATE("Qty. per Cap. Unit of Measure", 1);
                            ItmJnlLine.VALIDATE("Source No.", RecDataEntryLines2."Output Item No.");
                            /*
                            IF RecDataEntry.Stage = RecDataEntry.Stage::Setter THEN
                              ItmJnlLine.VALIDATE("Operation No.",'10')
                            ELSE IF RecDataEntry.Stage = RecDataEntry.Stage::Hatcher THEN
                              ItmJnlLine.VALIDATE("Operation No.",'20');
                            ItmJnlLine.VALIDATE("No.",RecDataEntryLines2."Machine No.");
                            IF RecDataEntry.Stage = RecDataEntry.Stage::Setter THEN
                              ItmJnlLine.VALIDATE("Run Time",18)
                            ELSE IF RecDataEntry.Stage = RecDataEntry.Stage::Hatcher THEN
                              ItmJnlLine.VALIDATE("Run Time",3);
                            */
                            POR.RESET;
                            POR.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            POR.SETRANGE(Type, POR.Type::"Machine Center");
                            POR.SETRANGE("No.", ParameterMaster."Machine No.");
                            IF POR.FINDFIRST THEN;
                            ItmJnlLine.VALIDATE("Operation No.", POR."Operation No.");
                            ItmJnlLine.VALIDATE("No.", RecDataEntryLines2."Machine No.");
                            MC.GET(RecDataEntryLines2."Machine No.");
                            // ItmJnlLine.VALIDATE("Run Time", MC."Run Time Value");  // PRU SH 250822
                            //ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                            //ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                            //ItmJnlLine.VALIDATE("Location Code","Farm Location");
                            //ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                            ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                            //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                            //ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                            ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); //Pru_gk
                                                                                                                        //>>PRU_RPG MNF_0.1
                            ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                            ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                            ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                            ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                            //<<PRU_RPG MNF_0.1
                            //ItmJnlLine.INSERT;
                            C22.RunWithCheck(ItmJnlLine);
                        END;

                        IF ParameterType = 'Output' THEN BEGIN
                            IF ParameterMaster."Machine No." = '' THEN BEGIN
                                ItmJnlLine.INIT;
                                ItmJnlLine.VALIDATE("Journal Template Name", 'OUTPUT');
                                ItmJnlLine.VALIDATE("Journal Batch Name", OutputBatch_Loc);
                                ItmJnlLine.VALIDATE("Line No.", GetLineNoOutput('OUTPUT', OutputBatch_Loc));
                                ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                                ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                                ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                                ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");

                                //>>PRU_RPG MNF_0.1
                                ProdOrderLine.RESET;
                                ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                                ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                                IF ProdOrderLine.FINDFIRST THEN begin
                                    ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                    ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                                END;
                                //ItmJnlLine.VALIDATE("Order Line No.",10000);
                                //<<PRU_RPG MNF_0.1
                                ItmJnlLine.VALIDATE("Source No.", RecDataEntryLines2."Output Item No.");
                                ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                                ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                                ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                                ItmJnlLine.VALIDATE("Unit of Measure Code", RecDataEntryLines2."Unit of Measure Code");
                                ItmJnlLine.VALIDATE("Location Code", RecDataEntry."Farm/Location");
                                ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Output Quantity", RecDataEntryLines2."Actual Value");
                                ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                                ItmJnlLine."Source No." := RecDataEntryLines2."Item No.";
                                ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                                //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                                ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                                ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                                ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                                ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); //Pru_gk
                                                                                                                            //>>PRU_RPG MNF_0.1
                                ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                                ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                                ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                                ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                                ProRouLine.Reset();
                                ProRouLine.SetRange("Prod. Order No.", RecDataEntry."Flock No.");
                                //    ProRouLine.SetRange(ProRouLine."Routing Reference No.", ProdOrderLine."Line No.");
                                ProRouLine.SetRange(Type, ProRouLine.Type::"Machine Center");
                                if ProRouLine.FindFirst() then begin
                                    //  Message('%1', ProRouLine."Operation No.");
                                    ItmJnlLine.Validate("Operation No.", ProRouLine."Operation No.");
                                END;
                                //<<PRU_RPG MNF_0.1
                                //ItmJnlLine.INSERT;
                                ReservationEntry.RESET;
                                ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                                ReservationEntry.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                                ReservationEntry.SETRANGE("Source ID", 'OUTPUT');
                                ReservationEntry.SETRANGE("Source Batch Name", MfgSetup."Output Batch Name");
                                ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                                IF ReservationEntry.FINDFIRST THEN
                                    REPEAT
                                        ReservationEntry."Source ID" := 'OUTPUT';
                                        ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                        ReservationEntry.MODIFY;
                                    UNTIL ReservationEntry.NEXT = 0;
                                C22.RunWithCheck(ItmJnlLine);
                            END;
                        END;
                        /* ELSE
                       IF ParameterMaster."Machine No." <> '' THEN BEGIN
                         ItmJnlLine.INIT;
                         ItmJnlLine.VALIDATE("Journal Template Name",'CAPACITY');
                         ItmJnlLine.VALIDATE("Journal Batch Name",MfgSetup."Capacity Batch Name");
                         ItmJnlLine.VALIDATE("Line No.",RecDataEntryLines2."Line No." + 10000);
                         ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                         ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Output);
                         ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                         ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                         ItmJnlLine.VALIDATE("Order Line No.",10000);
                         ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                         ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                         ItmJnlLine.VALIDATE(Type,ItmJnlLine.Type::"Machine Center");
                         ItmJnlLine.VALIDATE("Item No.",RecDataEntry."Item No.");
                         IF RecDataEntry.Stage = RecDataEntry.Stage::Setter THEN
                           ItmJnlLine.VALIDATE("Operation No.",'10')
                         ELSE IF RecDataEntry.Stage = RecDataEntry.Stage::Hatcher THEN
                           ItmJnlLine.VALIDATE("Operation No.",'20');
                         ItmJnlLine.VALIDATE("No.",RecDataEntryLines2."Machine No.");
                         IF RecDataEntry.Stage = RecDataEntry.Stage::Setter THEN
                           ItmJnlLine.VALIDATE("Run Time",18)
                         ELSE IF RecDataEntry.Stage = RecDataEntry.Stage::Hatcher THEN
                           ItmJnlLine.VALIDATE("Run Time",3);

                         //ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                         //ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                         //ItmJnlLine.VALIDATE("Location Code","Farm Location");
                         //ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                         ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                         //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                         ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                         //ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                         ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                         ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                         //ItmJnlLine.INSERT;
                         C22.RunWithCheck(ItmJnlLine);
                         END;
                         ////vidit09042018
                         ELSE
                         */
                        /*
                        IF ParameterType='Output' THEN BEGIN
                          ItmJnlLine.INIT;
                          ItmJnlLine.VALIDATE("Journal Template Name",'ITEM');
                          ItmJnlLine.VALIDATE("Journal Batch Name",OutputBatch_Loc);
                          ItmJnlLine.VALIDATE("Line No.",GetLineNo('ITEM',OutputBatch_Loc));
                          ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                          ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::"Positive Adjmt.");
                          //ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                          //ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                          //ItmJnlLine.VALIDATE("Order Line No.",10000);
                          ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                          ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                          ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                          ItmJnlLine.VALIDATE("Location Code",RecDataEntry."Farm/Location");
                          ItmJnlLine.VALIDATE(Quantity,ABS(RecDataEntryLines2."Actual Value"));
                          ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                          ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                          //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                          ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                          ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                          ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                          ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                          //>>PRU_RPG MNF_0.1
                          ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                          ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                          ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                          ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                          //<<PRU_RPG MNF_0.1
                          TrackingSpecification.RESET;
                          TrackingSpecification.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                          TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          IF TrackingSpecification.FINDLAST THEN
                            ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                      //MESSAGE('%1',ItemJournalLine."Serial No.")

                          //ItmJnlLine.INSERT;
                          ReservationEntry.RESET;
                          ReservationEntry.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          ReservationEntry.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          ReservationEntry.SETRANGE("Source ID",RecDataEntry."No.");
                          ReservationEntry.SETRANGE("Source Batch Name",'DEFAULT');
                          ReservationEntry.SETRANGE("Source Ref. No.",RecDataEntryLines2."Line No.");
                          IF ReservationEntry.FINDFIRST THEN REPEAT
                            ReservationEntry."Source ID" := 'ITEM';
                            ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                            ReservationEntry.MODIFY;
                          UNTIL ReservationEntry.NEXT =0;
                          C22.RunWithCheck(ItmJnlLine);
                        END;
                        */
                        /*
                      ELSE IF ParameterType='Utilization' THEN
                      BEGIN
                        ItmJnlLine.INIT;
                        ItmJnlLine.VALIDATE("Journal Template Name",'ITEM');
                        ItmJnlLine.VALIDATE("Journal Batch Name",'DEFAULT');
                        ItmJnlLine.VALIDATE("Line No.",GetLineNo('ITEM','DEFAULT'));
                        ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                        ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::"Negative Adjmt.");
                        //ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                        //ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                        //ItmJnlLine.VALIDATE("Order Line No.",10000);
                        ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                        ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                        ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                        ItmJnlLine.VALIDATE("Location Code",RecDataEntry."Farm/Location");
                        ItmJnlLine.VALIDATE(Quantity,ABS(RecDataEntryLines2."Actual Value"));
                        ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                        ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                        //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                        ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                        ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                        ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                        ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                        TrackingSpecification.RESET;
                        TrackingSpecification.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                        TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                        TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                        IF TrackingSpecification.FINDLAST THEN
                          ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                    //MESSAGE('%1',ItemJournalLine."Serial No.")

                        //ItmJnlLine.INSERT;
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                        ReservationEntry.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                        ReservationEntry.SETRANGE("Source ID",RecDataEntry."No.");
                        ReservationEntry.SETRANGE("Source Batch Name",'DEFAULT');
                        ReservationEntry.SETRANGE("Source Ref. No.",RecDataEntryLines2."Line No.");
                        IF ReservationEntry.FINDFIRST THEN REPEAT
                          ReservationEntry."Source ID" := 'ITEM';
                          ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                          ReservationEntry.MODIFY;
                        UNTIL ReservationEntry.NEXT =0;
                        C22.RunWithCheck(ItmJnlLine);
                      END;
                      */
                        ////vidit09042018
                        //END;
                        RecDataEntryLines3.RESET;
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                        IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                            //RecDataEntryLines3.INIT;
                            //RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                            //RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                            //RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                            //RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                            //RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                            //RecDataEntryLines3."Actual Value":=RecDataEntryLines2."Actual Value";
                            //RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                            //RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                            RecDataEntryLines3.Posted := TRUE;
                            RecDataEntryLines3.MODIFY;
                        END;
                    END ELSE
                        IF (RecDataEntryLines2."Actual Value" = 0) THEN BEGIN
                            RecDataEntryLines2.DELETE;
                        END ELSE BEGIN
                            RecDataEntryLines3.RESET;
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                            RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                            IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                                //RecDataEntryLines3.INIT;
                                //RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                                //RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                                //RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                                //RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                                //RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                                //RecDataEntryLines3.VALIDATE("Actual Value",RecDataEntryLines2."Actual Value");
                                //RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                                //RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                                RecDataEntryLines3.Posted := TRUE;
                                RecDataEntryLines3.MODIFY;
                            END;
                        END;
                UNTIL RecDataEntryLines2.NEXT = 0;
            END;
            IF RecDataEntry.Stage = RecDataEntry.Stage::Production THEN BEGIN
                IF T5405.GET(T5405.Status::Released, RecDataEntry."Flock No.") THEN;
                ////vidit
                ILE.RESET;
                ILE.SETRANGE("Document No.", RecDataEntry."Flock No.");
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Output);
                IF NOT ILE.FINDFIRST THEN BEGIN
                    //>>PRU_RPG MNF_0.1
                    /*
                      RecDataEntry.TESTFIELD("Reason Code");
                      UserSetup.GET(USERID);
                      IF UserSetup."Short Close on Prod. Order" THEN BEGIN
                        //PRU_RPG
                        {
                        T5405.RESET;
                        T5405.SETRANGE("No.",RecDataEntry."Flock No.");
                        IF T5405.FINDFIRST THEN BEGIN
                          T5405."Short Close" := TRUE;
                          T5405.MODIFY;;
                        END;
                        }
                        T5406.RESET;
                        T5406.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5406.FINDFIRST THEN REPEAT
                          T5406."Short Close" := TRUE;
                          T5406.MODIFY;
                        UNTIL T5406.NEXT=0;
                        T5407.RESET;
                        T5407.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5407.FINDFIRST THEN REPEAT
                          T5407."Short Close" := TRUE;
                          T5407.MODIFY;
                        UNTIL T5407.NEXT=0;
                        T5409.RESET;
                        T5409.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5409.FINDFIRST THEN REPEAT
                          T5409."Short Close" := TRUE;
                          T5409.MODIFY;
                        UNTIL T5409.NEXT=0;
                        T5410.RESET;
                        T5410.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5410.FINDFIRST THEN REPEAT
                          T5410."Short Close" := TRUE;
                          T5410.MODIFY;
                        UNTIL T5410.NEXT=0;
                        T5411.RESET;
                        T5411.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5411.FINDFIRST THEN REPEAT
                          T5411."Short Close" := TRUE;
                          T5411.MODIFY;
                        UNTIL T5411.NEXT=0;
                        T5412.RESET;
                        T5412.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5412.FINDFIRST THEN REPEAT
                          T5412."Short Close" := TRUE;
                          ///T5412.Status := T5412.Status::"Short Close";
                          T5412.MODIFY;
                        UNTIL T5412.NEXT=0;
                        T5413.RESET;
                        T5413.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5413.FINDFIRST THEN REPEAT
                          T5413."Short Close" := TRUE;
                          ///T5413.Status := T5413.Status::"Short Close";
                          T5413.MODIFY;
                        UNTIL T5413.NEXT=0;
                        T5414.RESET;
                        T5414.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5414.FINDFIRST THEN REPEAT
                          T5414."Short Close" := TRUE;
                          T5414.MODIFY;
                        UNTIL T5414.NEXT=0;
                        T5415.RESET;
                        T5415.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5415.FINDFIRST THEN REPEAT
                          T5415."Short Close" := TRUE;
                          T5415.MODIFY;
                        UNTIL T5415.NEXT=0;
                        T5416.RESET;
                        T5416.SETRANGE("Prod. Order No.",RecDataEntry."Flock No.");
                        IF T5416.FINDFIRST THEN REPEAT
                          T5416."Short Close" := TRUE;
                          T5416.MODIFY;
                        UNTIL T5416.NEXT=0;
                        MESSAGE('Document No. %1 Short Closed',RecDataEntry."Flock No.");
                      END ELSE
                        ERROR('The User ID %1, does not have permission to Short Close',USERID);
                        *///<<PRU_RPG MNF_0.1
                END;
                //ELSE
                ////vidit
                //ProdOrderStatus.ChangeStatusOnProdOrder(T5405,NewStatus::Finished,WORKDATE,TRUE);  ////PRU_RPG
            END;
            /*
            ItmJnlLineRec.RESET;
            ItmJnlLineRec.SETRANGE("Journal Template Name",'CONSUMP');
            ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Consumption Batch Name");
            ItmJnlLineRec.SETRANGE("Document No.",RecDataEntry."Flock No.");
            IF ItmJnlLineRec.FINDFIRST THEN
              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLineRec);
            COMMIT;
            ItmJnlLineRec.RESET;
            ItmJnlLineRec.SETRANGE("Journal Template Name",'OUTPUT');
            ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Output Batch Name");
            ItmJnlLineRec.SETRANGE("Document No.",RecDataEntry."Flock No.");
            IF ItmJnlLineRec.FINDFIRST THEN
              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLineRec);
            COMMIT;

            ItmJnlLineRec.RESET;
            ItmJnlLineRec.SETRANGE("Journal Template Name",'CAPACITY');
            ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Capacity Batch Name");
            ItmJnlLineRec.SETRANGE("Document No.",RecDataEntry."Flock No.");
            IF ItmJnlLineRec.FINDFIRST THEN
              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLineRec);
              */
            /*
           IF RecDataEntryLines2.COUNT > 0 THEN
             CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
            */
            RecDataEntry."Last Modified Date" := WORKDATE;
            RecDataEntry.Posted := TRUE;
            RecDataEntry.MODIFY;
            //PRUSB 200315 END
            MESSAGE('Hatchery Entry Posted Successfully')
        END;

    end;


    procedure GetLineNo(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;


    procedure GetLineNoOutput(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
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


    procedure PostDataEntry(var RecDataEntry: Record 50003)
    var
        ParameterMaster: Record 50001;
        ParameterType: Text[30];
        ItmJnlLine: Record 83;
        ItmJnlLine1: Record 83;
        IJLLineNo: Integer;
        CurrentJnlBatchName: Code[30];
        RecDataEntryLines3: Record 50005;
        ItmJnlLineRec: Record 83;
        T5407: Record 5407;
        CompItemNo: Code[20];
        ItmJnlLine2: Record 83;
        TrackingSpecification: Record 336;
        T83: Record 83;
        MfgSetup: Record 99000765;
        RecDataEntryLines2: Record 50005;
        ReservationEntry: Record 337;
        C22: Codeunit 22;
        RecReservtnEntry: Record 337;
        LastEntryNo: Integer;
        MachineMaster: Record 99000758;
        POR: Record 5409;
        MC: Record 99000758;
        UserSetup: Record 91;
        ConsumptionBatch_Loc: Code[10];
        CapacityBatch_Loc: Code[10];
        OutputBatch_Loc: Code[10];
        ProdOrderLine: Record 5406;
        ProRouLine: Record "Prod. Order Routing Line";
        DimensionSetEntry_123: Record 480;
        RecILE: Record "Item Ledger Entry";
        RemQty: Decimal;
    begin
        Companyinfo.Get;
        IF CONFIRM(Text50001, TRUE) THEN BEGIN
            RecDataEntry.TESTFIELD("Dimension Set ID");
            //>>PRU_RPG DM_0.1
            If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then begin
                DimensionMaster.RESET;
                DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", RecDataEntry."Shortcut Dimension 1 Code");
                DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", RecDataEntry."Shortcut Dimension 2 Code");
                DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code");
                IF NOT DimensionMaster.FINDFIRST THEN
                    ERROR('Dimension Master Does not exist');
            end;
            //<<PRU_RPG DM_0.1
            MfgSetup.GET;
            ///Pru_gk DMV_.01
            DimensionSetEntry_123.RESET;
            DimensionSetEntry_123.SETRANGE("Dimension Set ID", RecDataEntry."Dimension Set ID");
            IF DimensionSetEntry_123.FINDSET THEN
                REPEAT
                    IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                        IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 2 Code" THEN
                            ERROR('Dimension Set entry Branch code is not match of Data entry sheet header Branch');
                    END;
                    IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                        IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 1 Code" THEN
                            ERROR('Dimension Set entry LOB Code is not match of Data entry sheet LOB Code');
                    END;
                    If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> RecDataEntry."Shortcut Dimension 3 Code" THEN
                                ERROR('Dimension Set entry LOC Code is not match of Data entry sheet LOC Code');
                        END;
                UNTIL DimensionSetEntry_123.NEXT = 0;
            ///Pru_gk DMV_.01
            //>>PRU_RPG MNF_0.1

            CLEAR(ConsumptionBatch_Loc);
            CLEAR(CapacityBatch_Loc);
            CLEAR(OutputBatch_Loc);
            UserSetup.GET(USERID);
            IF (UserSetup."Global Dimension 1 Code" = 'BREEDER') THEN BEGIN
                MfgSetup.TESTFIELD("Breeder Consumption Batch");
                MfgSetup.TESTFIELD("Breeder Capacity Batch Name");
                MfgSetup.TESTFIELD("Breeder Output Batch");
                ConsumptionBatch_Loc := MfgSetup."Breeder Consumption Batch";
                CapacityBatch_Loc := MfgSetup."Breeder Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."Breeder Output Batch";
            END;
            IF (UserSetup."Global Dimension 1 Code" = 'CBF') THEN BEGIN
                MfgSetup.TESTFIELD("CBF Consumption Batch");
                MfgSetup.TESTFIELD("CBF Capacity Batch Name");
                MfgSetup.TESTFIELD("CBF Output Batch");
                ConsumptionBatch_Loc := MfgSetup."CBF Consumption Batch";
                CapacityBatch_Loc := MfgSetup."CBF Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."CBF Output Batch";
            END;
            IF (UserSetup."Global Dimension 1 Code" = 'HATCH') THEN BEGIN
                MfgSetup.TESTFIELD("Hatch Consumption Batch");
                MfgSetup.TESTFIELD("Hatch Capacity Batch Name");
                MfgSetup.TESTFIELD("Hatch Output Batch");
                ConsumptionBatch_Loc := MfgSetup."Hatch Consumption Batch";
                CapacityBatch_Loc := MfgSetup."Hatch Capacity Batch Name";
                OutputBatch_Loc := MfgSetup."Hatch Output Batch";
            END;
            //<<PRU_RPG MNF_0.1

            ItmJnlLine1.RESET;
            ItmJnlLine1.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
            ItmJnlLine1.SETFILTER("Journal Template Name", 'CONSUMP');
            ItmJnlLine1.SETFILTER("Journal Batch Name", ConsumptionBatch_Loc);
            IF ItmJnlLine1.FINDLAST THEN
                IJLLineNo := ItmJnlLine1."Line No.";

            ItmJnlLine2.RESET;
            ItmJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
            ItmJnlLine2.SETFILTER("Journal Template Name", 'OUTPUT');
            ItmJnlLine2.SETFILTER("Journal Batch Name", OutputBatch_Loc);
            IF ItmJnlLine2.FINDLAST THEN;

            RecDataEntryLines2.RESET;
            RecDataEntryLines2.SETRANGE("Document No.", RecDataEntry."No.");
            RecDataEntryLines2.SETRANGE(Posted, FALSE);
            IF RecDataEntryLines2.FINDFIRST THEN BEGIN
                REPEAT
                    IF (RecDataEntryLines2."Actual Value" <> 0) THEN BEGIN
                        ParameterMaster.SETRANGE("No.", RecDataEntryLines2."Parameter No.");
                        IF ParameterMaster.FINDFIRST THEN;
                        ParameterType := FORMAT(ParameterMaster."Type of Parameter");
                        ///080317

                        IF (ParameterMaster."Machine No." <> '') AND (ParameterMaster."Type of Parameter" = ParameterMaster."Type of Parameter"::"Direct/Indirect Cost") THEN BEGIN
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'CAPACITY');
                            ItmJnlLine.VALIDATE("Journal Batch Name", CapacityBatch_Loc);
                            ItmJnlLine.VALIDATE("Line No.", RecDataEntryLines2."Line No." + 10000);
                            ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");
                            //>>PRU_RPG MNF_0.1
                            ProdOrderLine.RESET;
                            ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Output Item No.");
                            IF ProdOrderLine.FINDFIRST THEN begin
                                ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                            END;
                            //ItmJnlLine.VALIDATE("Order Line No.",10000);
                            //<<PRU_RPG MNF_0.1
                            ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                            ItmJnlLine.VALIDATE(Type, ItmJnlLine.Type::"Machine Center");
                            //>>PRU_RPG MNF_0.1
                            //ItmJnlLine.VALIDATE("Item No.",RecDataEntry."Item No.");
                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Output Item No.");
                            ItmJnlLine.VALIDATE("Qty. per Cap. Unit of Measure", 1);
                            ItmJnlLine.VALIDATE("Source No.", RecDataEntryLines2."Output Item No.");
                            ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); ///Pru_gk
                                                                                                                        //<<PRU_RPG MNF_0.1
                            ItmJnlLine."In-transit Mortality" := ParameterMaster."In-transit Mortality";//PRU-VG

                            POR.RESET;
                            POR.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            POR.SETRANGE(Type, POR.Type::"Machine Center");
                            POR.SETRANGE("No.", ParameterMaster."Machine No.");
                            IF POR.FINDFIRST THEN;
                            ItmJnlLine.VALIDATE("Operation No.", POR."Operation No.");
                            ItmJnlLine.VALIDATE("No.", RecDataEntryLines2."Machine No.");
                            MC.GET(RecDataEntryLines2."Machine No.");
                            ItmJnlLine.VALIDATE("Run Time", MC."Run Time Value");   // PRU SH 250822

                            //ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                            //ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                            //ItmJnlLine.VALIDATE("Location Code","Farm Location");
                            //ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                            ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                            //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                            //ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                            //>>PRU_RPG MNF_0.1
                            ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                            ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                            ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                            ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                            //<<PRU_RPG MNF_0.1
                            //ItmJnlLine.INSERT;
                            C22.RunWithCheck(ItmJnlLine);
                            //END;
                            //END;
                        END;
                        ///080317
                        /*
                        IF ParameterType='Output' THEN BEGIN
                          ItmJnlLine.INIT;
                          ItmJnlLine.VALIDATE("Journal Template Name",'ITEM');
                          ItmJnlLine.VALIDATE("Journal Batch Name",OutputBatch_Loc);
                          ItmJnlLine.VALIDATE("Line No.",GetLineNo('ITEM',OutputBatch_Loc));
                          ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                          ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::"Positive Adjmt.");
                          //ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                          //ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                          //ItmJnlLine.VALIDATE("Order Line No.",10000);
                          ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                          ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                          ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                          ItmJnlLine.VALIDATE("Location Code",RecDataEntry."Farm/Location");
                          ItmJnlLine.VALIDATE(Quantity,ABS(RecDataEntryLines2."Actual Value"));
                          ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                          ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                          //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                          ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                          ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                          ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                          ItmJnlLine."In-transit Mortality" := ParameterMaster."In-transit Mortality";//PRU-VG
                          ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                          //>>PRU_RPG MNF_0.1
                          ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                          ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                          ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                          ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                          //<<PRU_RPG MNF_0.1
                          TrackingSpecification.RESET;
                          TrackingSpecification.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                          TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          IF TrackingSpecification.FINDLAST THEN
                            ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                      //MESSAGE('%1',ItemJournalLine."Serial No.")

                          //ItmJnlLine.INSERT;
                          ReservationEntry.RESET;
                          ReservationEntry.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          ReservationEntry.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          ReservationEntry.SETRANGE("Source ID",RecDataEntry."No.");
                          ReservationEntry.SETRANGE("Source Batch Name",'DEFAULT');
                          ReservationEntry.SETRANGE("Source Ref. No.",RecDataEntryLines2."Line No.");
                          IF ReservationEntry.FINDFIRST THEN REPEAT
                            ReservationEntry."Source ID" := 'ITEM';
                            ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                            ReservationEntry.MODIFY;
                          UNTIL ReservationEntry.NEXT =0;
                          C22.RunWithCheck(ItmJnlLine);
                        END;
                        */
                        /*
                         ELSE IF ParameterType='Utilization' THEN BEGIN
                          ItmJnlLine.INIT;
                          ItmJnlLine.VALIDATE("Journal Template Name",'ITEM');
                          ItmJnlLine.VALIDATE("Journal Batch Name",'DEFAULT');
                          ItmJnlLine.VALIDATE("Line No.",GetLineNo('ITEM','DEFAULT'));
                          ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                          ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::"Negative Adjmt.");
                          //ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                          //ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                          //ItmJnlLine.VALIDATE("Order Line No.",10000);
                          ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                          ItmJnlLine.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                          ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                          ItmJnlLine.VALIDATE("Location Code",RecDataEntry."Farm/Location");
                          ItmJnlLine.VALIDATE(Quantity,ABS(RecDataEntryLines2."Actual Value"));
                          ItmJnlLine.VALIDATE("Unit Cost",RecDataEntryLines2."Unit Cost");
                          ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                          ItmJnlLine."In-transit Mortality" := ParameterMaster."In-transit Mortality";//PRU-VG
                          //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                          ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                          ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                          ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                          ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                          TrackingSpecification.RESET;
                          TrackingSpecification.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          TrackingSpecification.SETRANGE("Quantity (Base)",RecDataEntryLines2."Actual Value");
                          TrackingSpecification.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          IF TrackingSpecification.FINDLAST THEN
                            ItmJnlLine.VALIDATE("Lot No.",TrackingSpecification."Lot No.");
                      //MESSAGE('%1',ItemJournalLine."Serial No.")

                          //ItmJnlLine.INSERT;
                          ReservationEntry.RESET;
                          ReservationEntry.SETRANGE("Item No.",RecDataEntryLines2."Item No.");
                          ReservationEntry.SETRANGE("Location Code",RecDataEntry."Farm/Location");
                          ReservationEntry.SETRANGE("Source ID",RecDataEntry."No.");
                          ReservationEntry.SETRANGE("Source Batch Name",'DEFAULT');
                          ReservationEntry.SETRANGE("Source Ref. No.",RecDataEntryLines2."Line No.");
                          IF ReservationEntry.FINDFIRST THEN REPEAT
                            ReservationEntry."Source ID" := 'ITEM';
                            ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                            ReservationEntry.MODIFY;
                          UNTIL ReservationEntry.NEXT =0;
                          C22.RunWithCheck(ItmJnlLine);
                        END ELSE*/
                        IF ParameterType = 'Consumption' THEN BEGIN
                            CLEAR(RemQty);
                            RecILE.RESET;
                            RecILE.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            RecILE.SETRANGE("Posting Date", 0D, RecDataEntry."Entry Date");
                            RecILE.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            IF RecILE.FINDSET THEN BEGIN
                                RecILE.CALCSUMS("Remaining Quantity");
                                RemQty := RecILE."Remaining Quantity";
                            END;
                            IF RemQty < RecDataEntryLines2."Actual Value" THEN
                                ERROR('Stock not available of Item No %1 of %2 Location', RecDataEntryLines2."Item No.", RecDataEntry."Farm/Location");
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'CONSUMP');
                            ItmJnlLine.VALIDATE("Journal Batch Name", ConsumptionBatch_Loc);
                            ItmJnlLine.VALIDATE("Line No.", GetLineNo('CONSUMP', ConsumptionBatch_Loc));
                            ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Consumption);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");
                            //>>PRU_RPG MNF_0.1
                            ProdOrderLine.RESET;
                            ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Output Item No.");
                            IF ProdOrderLine.FINDFIRST THEN begin
                                ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                            END;
                            //ItmJnlLine.VALIDATE("Order Line No.",10000);
                            //<<PRU_RPG MNF_0.1

                            ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                            ItmJnlLine.VALIDATE("Unit of Measure Code", RecDataEntryLines2."Unit of Measure Code");
                            ItmJnlLine.VALIDATE("Location Code", RecDataEntry."Farm/Location");
                            ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                                                                                            //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."In-transit Mortality" := ParameterMaster."In-transit Mortality";//PRU-VG
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";
                            ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                            ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                            ItmJnlLine.VALIDATE("Source No.", RecDataEntryLines2."Output Item No.");
                            ItmJnlLine.VALIDATE("Applies-from Entry", RecDataEntryLines2."Applies From Entry No."); //PRU_RPG RSE_0.1
                                                                                                                    //>>PRU_RPG MNF_0.1
                            ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                            ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                            ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                            ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                            ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); //Pru_gk
                                                                                                                        //<<PRU_RPG MNF_0.1
                            TrackingSpecification.RESET;
                            TrackingSpecification.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            TrackingSpecification.SETRANGE("Quantity (Base)", RecDataEntryLines2."Actual Value");
                            TrackingSpecification.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            IF TrackingSpecification.FINDLAST THEN;
                            //  ItmJnlLine.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                            //MESSAGE('%1',ItemJournalLine."Serial No.")

                            //ItmJnlLine.INSERT;
                            ReservationEntry.RESET;
                            ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            ReservationEntry.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            // if StrLen(RecDataEntry."No.") = 14 Then
                            //     ReservationEntry.SETRANGE("Source ID", CopyStr(RecDataEntry."No.", 5, 11));
                            // if StrLen(RecDataEntry."No.") = 16 Then
                            ReservationEntry.SETRANGE("Source ID", DelChr(CopyStr(RecDataEntry."No.", 5, 12), '=', '/'));
                            //ReservationEntry.SETRANGE("Source ID", 'PROD.ORDER');

                            ReservationEntry.SETRANGE("Source Batch Name", 'DEFAULT');
                            ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                            IF ReservationEntry.FINDFIRST THEN
                                REPEAT
                                    // ItmJnlLine.VALIDATE("Lot No.", ReservationEntry."Lot No.");
                                    //  MESSAGE('%1..%2..%3..%4..%5', RecDataEntryLines2."Line No.", ItmJnlLine."Item No.", ItmJnlLine."Journal Batch Name", ReservationEntry."Lot No.", ItmJnlLine."Line No.");
                                    //  ReservationEntry."Source ID" := 'CONSUMP';
                                    ReservationEntry."Source ID" := ItmJnlLine."Journal Template Name";
                                    //        ReservationEntry."Source Batch Name" := ItmJnlLine."Journal Batch Name";
                                    ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                    ReservationEntry.MODIFY;
                                UNTIL ReservationEntry.NEXT = 0;
                            C22.RunWithCheck(ItmJnlLine);
                        END;

                        IF ParameterType = 'Output' THEN BEGIN
                            ItmJnlLine.INIT;
                            ItmJnlLine.VALIDATE("Journal Template Name", 'OUTPUT');
                            ItmJnlLine.VALIDATE("Journal Batch Name", OutputBatch_Loc);
                            ItmJnlLine.VALIDATE("Line No.", GetLineNoOutput('OUTPUT', OutputBatch_Loc));
                            ItmJnlLine.VALIDATE("Posting Date", RecDataEntry."Entry Date");
                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                            ItmJnlLine.VALIDATE("Order Type", ItmJnlLine."Order Type"::Production);
                            ItmJnlLine.VALIDATE("Order No.", RecDataEntry."Flock No.");
                            //>>PRU_RPG MNF_0.1
                            ProdOrderLine.RESET;
                            ProdOrderLine.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            ProdOrderLine.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            IF ProdOrderLine.FINDFIRST THEN begin
                                ItmJnlLine.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
                                ItmJnlLine.Validate("Routing No.", ProdOrderLine."Routing No.");
                            END;
                            //ItmJnlLine.VALIDATE("Order Line No.",10000);
                            //<<PRU_RPG MNF_0.1
                            //   Message('%1..%2', RecDataEntry."Flock No.", RecDataEntryLines2."Item No.");

                            ItmJnlLine.VALIDATE("Entry Type", ItmJnlLine."Entry Type"::Output);
                            ItmJnlLine.VALIDATE("Document No.", RecDataEntry."Flock No.");
                            ItmJnlLine.VALIDATE("Item No.", RecDataEntryLines2."Item No.");
                            // ItmJnlLine."Unit of Measure Code" := RecDataEntryLines2."Unit of Measure Code";
                            ItmJnlLine.VALIDATE("Unit of Measure Code", RecDataEntryLines2."Unit of Measure Code");
                            ItmJnlLine.VALIDATE("Location Code", RecDataEntry."Farm/Location");
                            ItmJnlLine.VALIDATE(Quantity, RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Output Quantity", RecDataEntryLines2."Actual Value");
                            ItmJnlLine.VALIDATE("Data Entry Sheet No.", RecDataEntry."No.");//PRU-VG
                                                                                            //ItmJnlLine.VALIDATE("Unit Cost",RecDataEntry."Running Cost");
                            ItmJnlLine.VALIDATE("Unit Cost", RecDataEntryLines2."Unit Cost");
                            //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                            ItmJnlLine."Source No." := RecDataEntryLines2."Output Item No.";
                            ItmJnlLine."Flock No." := RecDataEntry."Flock No.";
                            //>>PRU_RPG MNF_0.1
                            ItmJnlLine."Data Entry Type" := RecDataEntryLines2."Data Entry Type";
                            ItmJnlLine."Laying Entry Type" := RecDataEntryLines2."Laying Entry Type";
                            ItmJnlLine."Hatching Entry Type" := RecDataEntryLines2."Hatching Entry Type";
                            ItmJnlLine."Descriptive Entry Type" := RecDataEntryLines2."Descriptive Entry Type";
                            //<<PRU_RPG MNF_0.1
                            ItmJnlLine.VALIDATE("Dimension Set ID", RecDataEntry."Dimension Set ID");
                            ItmJnlLine."In-transit Mortality" := ParameterMaster."In-transit Mortality";//PRU-VG
                            ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                            ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";


                            ProRouLine.Reset();
                            ProRouLine.SetRange("Prod. Order No.", RecDataEntry."Flock No.");
                            //    ProRouLine.SetRange(ProRouLine."Routing Reference No.", ProdOrderLine."Line No.");
                            ProRouLine.SetRange(Type, ProRouLine.Type::"Machine Center");
                            if ProRouLine.FindFirst() then begin
                                //Message('%1', ProRouLine."Operation No.");
                                ItmJnlLine.Validate("Operation No.", ProRouLine."Operation No.");
                            END;
                            //Message('%1 Hellp %2', RecDataEntry."Flock No.", ProdOrderLine."Line No."); 
                            ItmJnlLine.VALIDATE("Shortcut Dimension 3 Code", RecDataEntry."Shortcut Dimension 3 Code"); //Pru_gk                                                                                           //ItmJnlLine.INSERT;
                            ReservationEntry.RESET;
                            ReservationEntry.SETRANGE("Item No.", RecDataEntryLines2."Item No.");
                            ReservationEntry.SETRANGE("Location Code", RecDataEntry."Farm/Location");
                            ReservationEntry.SETRANGE("Source ID", RecDataEntry."No.");
                            ReservationEntry.SETRANGE("Source Batch Name", MfgSetup."Output Batch Name");
                            ReservationEntry.SETRANGE("Source Ref. No.", RecDataEntryLines2."Line No.");
                            IF ReservationEntry.FINDFIRST THEN
                                REPEAT
                                    ReservationEntry."Source ID" := 'OUTPUT';
                                    ReservationEntry."Source Ref. No." := ItmJnlLine."Line No.";
                                    ReservationEntry.MODIFY;
                                UNTIL ReservationEntry.NEXT = 0;
                            ItmJnlLine."Source No." := RecDataEntryLines2."Output Item No.";
                            // ItmJnlLine.Insert();
                            C22.RunWithCheck(ItmJnlLine);
                            T5407.RESET;
                            T5407.SETRANGE("Prod. Order No.", RecDataEntry."Flock No.");
                            IF T5407.FINDFIRST THEN
                                CompItemNo := T5407."Item No.";
                        END;
                        /*
                        IF RecReservtnEntry.FINDLAST THEN
                          LastEntryNo := RecReservtnEntry."Entry No.";

                        RecReservtnEntry.INIT;
                        IF LastEntryNo <> 0 THEN
                          RecReservtnEntry."Entry No." := LastEntryNo + 1
                        ELSE
                          RecReservtnEntry."Entry No." := 1;

                        RecReservtnEntry.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                        RecReservtnEntry.VALIDATE("Location Code",RecDataEntry."Farm/Location");
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
                        RecReservtnEntry.VALIDATE("Lot No.",RecDataEntry."Lot No.");
                        RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                        RecReservtnEntry.INSERT;
                        */

                        /*
                         //PRU-VG
                         ItmJnlLine.INIT;
                         ItmJnlLine.VALIDATE("Journal Template Name",'CONSUMP');
                         ItmJnlLine.VALIDATE("Journal Batch Name",MfgSetup."Consumption Batch Name");
                         ItmJnlLine.VALIDATE("Line No.",RecDataEntryLines2."Line No." + 10000);
                         ItmJnlLine.VALIDATE("Posting Date",WORKDATE);
                         ItmJnlLine.VALIDATE("Entry Type",ItmJnlLine."Entry Type"::Consumption);
                         ItmJnlLine.VALIDATE("Order Type",ItmJnlLine."Order Type"::Production);
                         ItmJnlLine.VALIDATE("Order No.",RecDataEntry."Flock No.");
                         ItmJnlLine.VALIDATE("Order Line No.",10000);
                         ItmJnlLine.VALIDATE("Document No.",RecDataEntry."Flock No.");
                         ItmJnlLine.VALIDATE("Item No.",CompItemNo);
                         ItmJnlLine.VALIDATE("Unit of Measure Code",ParameterMaster."Data Entry UOM");
                         ItmJnlLine.VALIDATE("Location Code",RecDataEntry."Farm/Location");
                         ItmJnlLine.VALIDATE(Quantity,RecDataEntryLines2."Actual Value");
                         ItmJnlLine.VALIDATE("Data Entry Sheet No.",RecDataEntry."No.");//PRU-VG
                         //ItmJnlLine.VALIDATE("Data Entry Line No.",RecDataEntryLines2."Line No.");//PRU-VG
                         ItmJnlLine.VALIDATE("Dimension Set ID",RecDataEntry."Dimension Set ID");
                         ItmJnlLine.VALIDATE("Unit Cost",RecDataEntry."Running Cost");
                         ItmJnlLine."Additional Unit of Measure" := RecDataEntryLines2."Additional Unit of Measure";
                         ItmJnlLine."Additional Unit Quantity" := RecDataEntryLines2."Additional Unit Quantity";

                         //ItmJnlLine.INSERT;

                         //PRUSB 020415 >>
                         IF RecReservtnEntry.FINDLAST THEN
                           LastEntryNo := RecReservtnEntry."Entry No.";

                         RecReservtnEntry.INIT;
                         IF LastEntryNo <> 0 THEN
                           RecReservtnEntry."Entry No." := LastEntryNo + 1
                         ELSE
                           RecReservtnEntry."Entry No." := 1;

                         RecReservtnEntry.VALIDATE("Item No.",CompItemNo);
                         RecReservtnEntry.VALIDATE("Location Code",RecDataEntry."Farm/Location");
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
                         RecReservtnEntry.VALIDATE("Lot No.",RecDataEntry."Lot No.");
                         RecReservtnEntry.VALIDATE("Item Tracking",RecReservtnEntry."Item Tracking"::"Lot No.");
                         RecReservtnEntry.INSERT;
                         C22.RunWithCheck(ItmJnlLine);*/
                        //PRU-VG
                        //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);


                        RecDataEntryLines3.RESET;
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                        IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                            //RecDataEntryLines3.INIT;
                            //RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                            //RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                            //RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                            //RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                            //RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                            //RecDataEntryLines3.VALIDATE("Actual Value",RecDataEntryLines2."Actual Value");
                            //RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                            //RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                            RecDataEntryLines3.Posted := TRUE;
                            RecDataEntryLines3.MODIFY;
                        END;
                    END;
                    //  END ELSE IF (RecDataEntryLines2."Actual Value" = 0) THEN BEGIN
                    IF (RecDataEntryLines2."Actual Value" = 0) THEN BEGIN
                        RecDataEntryLines2.DELETE;
                    END ELSE BEGIN
                        RecDataEntryLines3.RESET;
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Document No.", RecDataEntryLines2."Document No.");
                        RecDataEntryLines3.SETRANGE(RecDataEntryLines3."Line No.", RecDataEntryLines2."Line No.");
                        IF RecDataEntryLines3.FINDFIRST THEN BEGIN
                            //RecDataEntryLines3.INIT;
                            //RecDataEntryLines3.VALIDATE("Document No.",RecDataEntryLines2."Document No.");
                            //RecDataEntryLines3.VALIDATE("Posting Date",RecDataEntryLines2."Posting Date");
                            //RecDataEntryLines3.VALIDATE("Parameter No.",RecDataEntryLines2."Parameter No.");
                            //RecDataEntryLines3.VALIDATE("Item No.",RecDataEntryLines2."Item No.");
                            //RecDataEntryLines3.VALIDATE("Std Value",RecDataEntryLines2."Std Value");
                            //RecDataEntryLines3.VALIDATE("Actual Value",RecDataEntryLines2."Actual Value");
                            //RecDataEntryLines3.VALIDATE("Template No",RecDataEntryLines2."Template No");
                            //RecDataEntryLines3.VALIDATE(Remarks,RecDataEntryLines2.Remarks);
                            RecDataEntryLines3.Posted := TRUE;
                            RecDataEntryLines3.MODIFY;
                        END;
                    END;

                UNTIL RecDataEntryLines2.NEXT = 0;
            END;
            /*
            ItmJnlLineRec.RESET;
            ItmJnlLineRec.SETRANGE("Journal Template Name",'CONSUMP');
            ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Consumption Batch Name");
            ItmJnlLineRec.SETRANGE("Document No.",RecDataEntry."Flock No.");
            IF ItmJnlLineRec.FINDFIRST THEN
              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
            ItmJnlLineRec.RESET;
            ItmJnlLineRec.SETRANGE("Journal Template Name",'OUTPUT');
            ItmJnlLineRec.SETRANGE("Journal Batch Name",MfgSetup."Output Batch Name");
            ItmJnlLineRec.SETRANGE("Document No.",RecDataEntry."Flock No.");
            IF ItmJnlLineRec.FINDFIRST THEN
              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
              */
            /*
           IF RecDataEntryLines2.COUNT > 0 THEN
             CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItmJnlLine);
            */
            RecDataEntry."Last Modified Date" := WORKDATE;
            RecDataEntry.Posted := TRUE;
            RecDataEntry.MODIFY;
            //PRUSB 200315 END
            MESSAGE('Data Entry Posted Successfully');
        END;

    end;

    local procedure GetLotNo(ItemNo: Code[20]; LocationCode: Code[20]; SourceType: Integer; SourceSubType: Integer; Qty: Decimal; SourceNo: Code[20]; LineNo: Integer): Code[20]
    var
        ReservationEntry: Record 337;
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE(ReservationEntry."Item No.", ItemNo);
        ReservationEntry.SETRANGE(ReservationEntry."Location Code", LocationCode);
        ReservationEntry.SETRANGE(ReservationEntry."Source Type", 83);
        ReservationEntry.SETRANGE(ReservationEntry."Source Subtype", 5);
        ReservationEntry.SETRANGE(ReservationEntry."Source ID", SourceNo);
        ReservationEntry.SETRANGE(ReservationEntry.Quantity, (Qty * -1));
        ReservationEntry.SETRANGE(ReservationEntry."Source Ref. No.", LineNo);
        IF ReservationEntry.FINDFIRST THEN
            EXIT(ReservationEntry."Lot No.");
    end;
}

