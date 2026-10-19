codeunit 50021 "Update Feed Intake Master"
{

    trigger OnRun()
    var
        ProductionOrder: Record 5405;
    begin
        Code('');
    end;

    var
        CompanyInfo: Record "Company Information";
        EntryCounter: Integer;
        ConsumPrestarter: Decimal;
        ConsumStarter: Decimal;
        ConsumFinisher: Decimal;
        ItemLedgerEntry: Record 32;
        FlockWiseMaster: Record 50038;
        RemoveDuplicate: Date;
        ItemLedgerEntryMort: Record 32;
        TodyValue: Decimal;
        CumValue: Decimal;
        CumPerValue: Decimal;
        RecdValue: Decimal;
        ConsValue: Decimal;
        TransferValue: Decimal;
        BailStockValue: Decimal;
        FeedIntakeActual: Decimal;
        KillogramValue: Decimal;
        CumFeedActual: Decimal;
        FlockWiseMasterUpdate: Record 50038;
        Test: Decimal;
        CummMortality: Record 50035;
        CumIntakeStd: Decimal;
        DataEntryLines: Record 50005;
        BodyActual: Decimal;
        Text000: Label 'Processing items  #1##########';
        Window: Dialog;
        Text001: Label '%1 Flock Wise Age Data Updated Updated ';
        ILE: Record 32;
        StartDate: Date;
        EndDate: Date;
        Date: Record 2000000007;
        I: Integer;
        J: Integer;
        InitFlock: Record 50038;
        ItemLedger: record "Item Ledger Entry";



    procedure "Code"(RPONo: Code[20])
    var
        ProductionOrder: Record 5405;
    begin
        CompanyInfo.Get;
        Window.OPEN(Text000);
        ProductionOrder.RESET;
        ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE(ProductionOrder."Short Close", FALSE);
        ProductionOrder.SETRANGE(ProductionOrder."Shortcut Dimension 1 Code", 'CBF');
        ProductionOrder.SetFilter(ProductionOrder."Shortcut Dimension 2 Code", '<>%1', '');
        ProductionOrder.SETFILTER(ProductionOrder.Quantity, '<>%1', 0);
        //ProductionOrder.SETRANGE(ProductionOrder."No.", 'RPO/2324/019811');
        //ProductionOrder.SETRANGE(ProductionOrder."Due Date",010421D,150421D);
        IF RPONo <> '' THEN
            ProductionOrder.SETFILTER(ProductionOrder."No.", RPONo);
        IF ProductionOrder.FINDSET THEN BEGIN
            REPEAT
                ItemLedger.Reset();
                ItemLedger.SetRange("Document No.", ProductionOrder."No.");
                if ItemLedger.FindFirst() Then begin
                    CumFeedActual := 0;
                    CumIntakeStd := 0;
                    KillogramValue := 0;
                    CumFeedActual := 0;
                    CumValue := 0;
                    ConsumFinisher := 0;
                    ConsumPrestarter := 0;
                    ConsumStarter := 0;
                    //MESSAGE('%1',CumValue);
                    Window.UPDATE(1, ProductionOrder."No.");
                    EntryCounter := ProductionOrder.COUNT;
                    ILE.RESET;
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Order Type", ILE."Order Type"::Production);
                    ILE.SETRANGE(ILE."Order No.", ProductionOrder."No.");
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                    ILE.SETCURRENTKEY("Posting Date");
                    ILE.SETASCENDING("Posting Date", TRUE);
                    IF ILE.FINDSET THEN
                        StartDate := ILE."Posting Date";
                    IF ILE.FINDLAST THEN
                        EndDate := ILE."Posting Date";




                    //InitFlockMaster(StartDate,EndDate,ILE."Flock No.",ProductionOrder.Quantity,ProductionOrder."Hatching Date");  // Insert for All Duaration
                    J := EndDate - StartDate;
                    FOR I := 0 TO J DO BEGIN
                        FlockWiseMaster.RESET;
                        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", ILE."Flock No.");
                        FlockWiseMaster.SETRANGE(FlockWiseMaster.Date, CALCDATE(FORMAT(I) + 'D', StartDate));
                        IF NOT FlockWiseMaster.FINDFIRST THEN BEGIN
                            InitFlock.RESET;
                            InitFlock.INIT;
                            InitFlock."Flock No." := ILE."Flock No.";
                            InitFlock.Date := CALCDATE(FORMAT(I) + 'D', StartDate);
                            InitFlock."Chick Housed" := ProductionOrder.Quantity;
                            InitFlock.Age := InitFlock.Date - ProductionOrder."Hatching Date";
                            InitFlock.INSERT(TRUE);
                            //MESSAGE('%1',CALCDATE(FORMAT(I)+'D',StartDate));
                        END;
                        BodyActual := 0;
                        FeedIntakeActual := 0;
                        CumPerValue := 0;
                        //CumIntakeStd  :=0;
                        //KillogramValue :=0;
                        //CumFeedActual :=0;
                        FlockWiseMasterUpdate.RESET;
                        FlockWiseMasterUpdate.SETRANGE(FlockWiseMasterUpdate.Date, CALCDATE(FORMAT(I) + 'D', StartDate));
                        FlockWiseMasterUpdate.SETRANGE(FlockWiseMasterUpdate."Flock No.", ILE."Flock No.");
                        IF FlockWiseMasterUpdate.FINDFIRST THEN BEGIN
                            //MESSAGE('Updated');
                            UpdateLineData(ILE."Flock No.", CALCDATE(FORMAT(I) + 'D', StartDate));
                            FlockWiseMasterUpdate.Age := CALCDATE(FORMAT(I) + 'D', StartDate) - ProductionOrder."Hatching Date";
                            FlockWiseMasterUpdate."Chick Housed" := ProductionOrder.Quantity;
                            FlockWiseMasterUpdate.Today := TodyValue;
                            TodyValue := 0;
                            FlockWiseMasterUpdate.Cum := CumValue;
                            IF ProductionOrder.Quantity <> 0 THEN
                                if CumValue <> 0 then
                                    CumPerValue := ROUND(CumValue / ProductionOrder.Quantity * 100, 0.01, '=');
                            FlockWiseMasterUpdate."Cum %" := CumPerValue;
                            FlockWiseMasterUpdate.Recieved := RecdValue;
                            FlockWiseMasterUpdate.Consumed := ConsValue;
                            FlockWiseMasterUpdate.Transfer := TransferValue;
                            FlockWiseMasterUpdate."Bal. Stock" := BailStockValue;
                            if ((ProductionOrder.Quantity - CumValue)) <> 0 then
                                if ConsValue <> 0 then
                                    FeedIntakeActual := ROUND(ConsValue / (ProductionOrder.Quantity - CumValue) * 1000, 0.00001, '=')
                                else
                                    FeedIntakeActual := 0;
                            //MESSAGE('%1,%2,%3,%4',ConsValue,ProductionOrder.Quantity,CumValue,FeedIntakeActual);
                            FlockWiseMasterUpdate."Feed Intake Actual" := FeedIntakeActual;
                            CumFeedActual += FeedIntakeActual;
                            FlockWiseMasterUpdate.Killogram := KillogramValue;
                            FlockWiseMasterUpdate."CUMFEED Actual" := CumFeedActual;
                            CummMortality.RESET;
                            CummMortality.SETRANGE(CummMortality.Age, FlockWiseMasterUpdate.Age);
                            IF CummMortality.FINDFIRST THEN;
                            CumIntakeStd += CummMortality."Daily Intake (Gms)" * 1000;
                            FlockWiseMasterUpdate."Feed Intake Std." := CummMortality."Daily Intake (Gms)";    //Chnaged
                            FlockWiseMasterUpdate."CUMFEED Std." := CumIntakeStd;
                            //FlockWiseMasterUpdate."CUMFEED Std." := CummMortality."Daily Intake (Gms)"*1000;  //Chnages
                            FlockWiseMasterUpdate."Body Weight Std." := CummMortality."Weight (Gms)";    //Chnages
                            DataEntryLines.RESET;
                            //if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                            DataEntryLines.SETRANGE(DataEntryLines."Parameter No.", 'PARA-449');
                            DataEntryLines.SETRANGE(DataEntryLines.Posted, TRUE);
                            DataEntryLines.SETRANGE(DataEntryLines."Flock No.", ProductionOrder."No.");
                            DataEntryLines.SETRANGE(DataEntryLines."Posting Date", CALCDATE(FORMAT(I) + 'D', StartDate));
                            IF DataEntryLines.FINDFIRST THEN
                                BodyActual := DataEntryLines."Actual Value";
                            FlockWiseMasterUpdate."Body Weight Actual" := BodyActual;
                            FlockWiseMasterUpdate."Consumed Prestarter" := ConsumPrestarter;
                            FlockWiseMasterUpdate."Consumed Starter" := ConsumStarter;
                            FlockWiseMasterUpdate."Consumed Finisher" := ConsumFinisher;
                            FlockWiseMasterUpdate.MODIFY(TRUE);
                        END;
                    END;
                end;
            UNTIL ProductionOrder.NEXT = 0;
        END;
        // MESSAGE(Text000,EntryCounter);
    end;

    local procedure UpdateLineData(FlockNo: Code[30]; AgeDate: Date)
    var
        ItemLedgerEntry: Record 32;
        IL: Record 32;
    begin
        CompanyInfo.Get;
        IL.RESET;
        IL.SETRANGE(IL."Order Type", ILE."Order Type"::Production);
        IL.SETRANGE(IL."Order No.", FlockNo);
        IL.SETRANGE(IL."Entry Type", ILE."Entry Type"::Consumption);
        IL.SETRANGE(IL."Posting Date", AgeDate);
        IF IL.FINDFIRST THEN BEGIN
            TodyValue := 0;
            RecdValue := 0;
            RecdValue := 0;
            TransferValue := 0;
            BailStockValue := 0;
            ConsValue := 0;
            ConsValue := 0;
            ConsumFinisher := 0;
            ConsumPrestarter := 0;
            ConsumStarter := 0;

            //CumValue :=0;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Data Entry Type", ItemLedgerEntry."Data Entry Type"::"Mortality - Chicks");
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Order Type", ItemLedgerEntry."Order Type"::Production);
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    TodyValue += ItemLedgerEntry.Quantity;
                //TodyValue := ABS(TodyValue);
                //CumValue += ABS(ItemLedgerEntry.Quantity);
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            TodyValue := ABS(TodyValue);
            CumValue += TodyValue;
            //    IF TodyValue <> 0 THEN
            //    MESSAGE('%1',CumValue);

            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            // ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", '<>%1', 'IN-TRANSIT');
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    RecdValue += ABS(ItemLedgerEntry.Quantity);
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", '<>%1', 'IN-TRANSIT');
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    ConsValue += ItemLedgerEntry.Quantity * -1;
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            KillogramValue += ConsValue;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment");
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", '<>%1', 'IN-TRANSIT');
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    TransferValue += ABS(ItemLedgerEntry.Quantity);
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;

            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            //ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Transfer Shipment");
            ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", '<>%1', 'IN-TRANSIT');
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    BailStockValue += ItemLedgerEntry.Quantity;
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            ItemLedgerEntry.SetFilter(ItemLedgerEntry."Item No.", 'FDP002V|FDP002P|FDP002R|FDP001J|FDP002J');
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    ConsumPrestarter += ItemLedgerEntry.Quantity * -1;
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            ItemLedgerEntry.SetFilter(ItemLedgerEntry."Item No.", 'FDP014V|FDP014|FDP014R|FDP022|FDP021J|FDP019J|FDP017G|FDP022KT|FDP017Y|FDP022P');
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    ConsumFinisher += ItemLedgerEntry.Quantity * -1;
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Flock No.", FlockNo);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, AgeDate);
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
            ItemLedgerEntry.SetFilter(ItemLedgerEntry."Item No.", 'FDP005V|FDP005R|FDP005P|FDP005CJ|FDP012|FDP011J|FDP012KT|FDP005J|FDP009J|FDP012P');
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
            IF ItemLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    Consumstarter += ItemLedgerEntry.Quantity * -1;
                UNTIL ItemLedgerEntry.NEXT = 0;
            END;
        END;
    end;

    local procedure InitFlockMaster(SDate: Date; EDate: Date; FlockN: Code[20]; QTy: Decimal; HatchDate: Date)
    var
        FlockWiseMaster: Record 50038;
        InitFlock: Record 50038;
    begin
        J := EDate - StartDate;
        FOR I := 0 TO J DO BEGIN
            FlockWiseMaster.RESET;
            FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", FlockN);
            FlockWiseMaster.SETRANGE(FlockWiseMaster.Date, CALCDATE(FORMAT(I) + 'D', StartDate));
            IF NOT FlockWiseMaster.FINDFIRST THEN BEGIN
                InitFlock.RESET;
                InitFlock.INIT;
                InitFlock."Flock No." := FlockN;
                InitFlock.Date := CALCDATE(FORMAT(I) + 'D', StartDate);
                InitFlock."Chick Housed" := QTy;
                InitFlock.Age := InitFlock.Date - HatchDate;
                InitFlock.INSERT(TRUE);
                //MESSAGE('%1',CALCDATE(FORMAT(I)+'D',StartDate));
            END;
        END;
    end;
}

